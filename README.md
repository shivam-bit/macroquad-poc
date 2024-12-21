# macroquad-hello-world

## Building and Running the Project

### Prerequisites

- [Rust](https://www.rust-lang.org/tools/install)
- [Cargo Bundle](https://github.com/burtonageo/cargo-bundle)
- [Xcode](https://developer.apple.com/xcode/) (for iOS)

### Building and Running the macOS App
<img width="1635" alt="Screenshot 2024-12-22 at 1 58 49 AM" src="https://github.com/user-attachments/assets/c8e8d7d2-55c5-43df-987e-3b87c6ec4fe4" />

1. **Install Rust and Cargo Bundle:**
   ```sh
   rustup install stable
   cargo install cargo-bundle
   ```
2. **Build the macOS App:**
   ```sh
   cargo bundle --release
   ```
3. Run the macOS App: Open the generated macroquad-poc.app in the target/release/bundle/osx/ directory.

### Building and Running the iOS App
<img width="1804" alt="Screenshot 2024-12-22 at 1 41 30 AM" src="https://github.com/user-attachments/assets/18500be3-ce01-4fa1-9b62-34fd8744c09a" />
1. **Install Rust and iOS Toolchain:**

   ```sh
   rustup install stable
   rustup target add aarch64-apple-ios x86_64-apple-ios
   cargo install cargo-lipo
   ```

2. **Build the iOS App:**

   ```sh
   ./run-ios-simulator.sh
   ```

3. **Run the iOS App on Simulator**: The script run-ios-simulator.sh will build the app, copy the binary to the app bundle, and launch it on the iOS simulator.

4. **Show Logs**: The script will also show the logs of the running app. Press Ctrl+C to stop the logs.\*\*

## Available CI/CD Pipeline

The project includes a GitHub Actions pipeline to build the macOS app automatically.

### macOS Build 
Pipeline

The pipeline is defined in `.github/workflows/build.yml` and runs on every push and pull request to the main branch.

#### What the macOS Build Pipeline Does:

1. **Checkout Code:**

   - Uses `actions/checkout@v3` to checkout the code from the repository.

2. **Install Rust:**

   - Uses `actions-rs/toolchain@v1` to install the stable Rust toolchain.

3. **Install Cargo Bundle:**

   - Runs `cargo install cargo-bundle` to install the Cargo Bundle tool.

4. **Build macOS App:**

   - Runs `cargo bundle --release` to build the macOS app.

5. **Upload DMG:**
   - Uses `actions/upload-artifact@v3` to upload the generated DMG file as an artifact.

To trigger the pipeline manually, push a commit to the main branch.
