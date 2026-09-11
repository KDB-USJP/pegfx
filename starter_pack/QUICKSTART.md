# PegFX Studio Pro — Commercial Starter Pack

Welcome to **PegFX Studio Pro**! This package contains turnkey assets, sample animations, and ready-to-run microcontroller firmware sketches to get your RGB LED dot-matrix display running in minutes.

---

## 📁 What's Included

### 1. Ready-to-Run Sample Projects (`starter_pack/projects/`)
- **`arcade_intro_64x32.pegfx`**: Classic 64×32 retro arcade marquee intro.
- **`cyberpunk_clock_64x32.pegfx`**: Cyberpunk 2069 neon HUD layout.
- **`fire_effect_32x32.pegfx`**: 3-frame animated campfire flame loop for 32×32 matrices.

*To load any project: In PegFX Studio, click **Load** or press **Ctrl+O**, then select the `.pegfx` file.*

---

### 2. Microcontroller Firmware Templates (`starter_pack/firmware/`)

#### A. CircuitPython Standalone Player (`circuitpython_code.py`)
- **Supported Boards**: Adafruit MatrixPortal M4, MatrixPortal S3, Raspberry Pi Pico / RP2040 Matrix Bonnet.
- **Quick Setup**:
  1. In PegFX, go to **Export** $\rightarrow$ **Windows Bitmap (.BMP)**.
  2. Save the file as `matrix.bmp`.
  3. Connect your board over USB (it mounts as `CIRCUITPY`).
  4. Copy `matrix.bmp` and `circuitpython_code.py` (rename it to `code.py`) directly onto the `CIRCUITPY` drive.
  5. The board reboots and immediately displays your animation!

#### B. Arduino USB Live-Stream Receiver (`pegfx_usb_stream_receiver.ino`)
- **Supported Boards**: Adafruit MatrixPortal M4 / S3, ESP32 HUB75 Shields.
- **Quick Setup**:
  1. Open `pegfx_usb_stream_receiver.ino` in the Arduino IDE.
  2. Install the **Adafruit Protomatter** library from the Library Manager.
  3. Upload the sketch to your board.
  4. In PegFX Studio, click **Connect USB Matrix** and choose your board's COM port (or `/dev/ttyACM*` / `/dev/ttyUSB*` on Linux).
  5. Your matrix mirrors PegFX in real time as you paint or scrub the timeline!

> [!TIP]
> **Linux USB Serial Permissions**: On Linux, add your user to the `dialout` group to access USB serial ports without root:
> ```bash
> sudo usermod -a -G dialout $USER
> ```
> Log out and back in for the permission change to take effect.

---

### 3. Virtual Hardware Simulator (`starter_pack/Launch_Simulator.bat` / `.sh`)
Don't have a physical RGB LED matrix panel plugged in yet? Test your exported animations directly on your computer:
- **Instant Launch on Windows**: Double-click `Launch_Simulator.bat` (or drag any `.bmp`, `.h`, or `.pegfx` file right onto it).
- **Instant Launch on macOS / Linux**: Open a terminal, make executable with `chmod +x Launch_Simulator.sh`, and run `./Launch_Simulator.sh [file]`.
- **Supported Formats**: Windows Bitmap (`.bmp`), Arduino RGB565 Headers (`.h` / `.ino`), and PegFX Blueprints (`.pegfx`).
- **Prerequisites**: Python 3 (uses standard built-in Tkinter; zero pip packages needed).
  - *Windows*: The launcher offers 1-click install via `winget install Python.Python.3.12` or Python.org.
  - *Linux*: Ensure `python3-tk` is installed (`sudo apt install python3 python3-tk` on Ubuntu/Debian).

---

### 4. Linux Desktop Installation (`.AppImage` & `.deb`)
- **Universal AppImage**: Make it executable and run:
  ```bash
  chmod +x PegFX-Studio-Pro_*.AppImage
  ./PegFX-Studio-Pro_*.AppImage
  ```
- **Debian / Ubuntu / Mint / Pop!_OS (.deb)**:
  ```bash
  sudo dpkg -i pegfx-studio-pro_*_amd64.deb
  ```

## 💡 Support & Updates
- Web Studio: [https://pegfx.trigr.am](https://pegfx.trigr.am) (or [https://ledout-19d28.web.app](https://ledout-19d28.web.app))
- For questions, feature requests, or firmware updates, visit your Gumroad library receipt.
