// ================================================================
// PegFX Studio Pro — USB Live-Stream Hardware Receiver
// Hardware: Adafruit MatrixPortal M4 / S3 or ESP32 with HUB75 Matrix
// Receives RGB565 matrix frame buffers over USB Serial and displays them
// ================================================================

#include <Adafruit_Protomatter.h>

// Matrix Configuration (Default: 64x32)
#define MATRIX_WIDTH  64
#define MATRIX_HEIGHT 32

#if defined(ARDUINO_ADAFRUIT_MATRIXPORTAL_M4) || defined(ARDUINO_ADAFRUIT_MATRIXPORTAL_ESP32S3)
  // Pin definitions for Adafruit MatrixPortal M4 / S3
  uint8_t rgbPins[]  = {7, 8, 9, 10, 11, 12};
  uint8_t addrPins[] = {17, 18, 19, 20};
  uint8_t clockPin   = 14;
  uint8_t latchPin   = 15;
  uint8_t oePin      = 16;
#else
  // Generic ESP32 HUB75 Pin Configuration (Adjust for your shield)
  uint8_t rgbPins[]  = {25, 26, 27, 14, 12, 13};
  uint8_t addrPins[] = {23, 19, 5, 17};
  uint8_t clockPin   = 16;
  uint8_t latchPin   = 4;
  uint8_t oePin      = 15;
#endif

Adafruit_Protomatter matrix(
  MATRIX_WIDTH, 4, 1, rgbPins, 4, addrPins, clockPin, latchPin, oePin, true
);

// Frame Header: [0xAA, 0x55, COLS, ROWS]
const uint8_t HEADER_BYTE_1 = 0xAA;
const uint8_t HEADER_BYTE_2 = 0x55;

void setup() {
  Serial.begin(115200);
  
  ProtomatterStatus status = matrix.begin();
  if (status != PROTOMATTER_OK) {
    for (;;); // Failed to initialize matrix
  }

  // Welcome splash
  matrix.fillScreen(0x0000);
  matrix.setTextSize(1);
  matrix.setTextColor(matrix.color565(0, 255, 200));
  matrix.setCursor(4, 12);
  matrix.print("PegFX Live");
  matrix.show();
}

void loop() {
  // Listen for incoming frame packet header
  if (Serial.available() >= 4) {
    if (Serial.read() == HEADER_BYTE_1) {
      if (Serial.read() == HEADER_BYTE_2) {
        uint8_t cols = Serial.read();
        uint8_t rows = Serial.read();

        // Validate dimensions
        if (cols == MATRIX_WIDTH && rows == MATRIX_HEIGHT) {
          uint16_t totalPixels = cols * rows;
          uint16_t bytesExpected = totalPixels * 2;
          uint8_t buffer[bytesExpected];

          // Read payload with timeout
          size_t bytesRead = Serial.readBytes((char*)buffer, bytesExpected);
          if (bytesRead == bytesExpected) {
            size_t idx = 0;
            for (int r = 0; r < rows; r++) {
              for (int c = 0; c < cols; c++) {
                uint16_t color = (buffer[idx] << 8) | buffer[idx + 1];
                matrix.drawPixel(c, r, color);
                idx += 2;
              }
            }
            matrix.show();
            // Send ACK back to PegFX Studio
            Serial.write(0x06); // ASCII ACK
          }
        }
      }
    }
  }
}
