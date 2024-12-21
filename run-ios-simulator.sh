#!/bin/bash
# Save as run-ios-simulator.sh

# Create the .app bundle if it doesn't exist
mkdir -p macroquad-poc.app

# Create Info.plist if it doesn't exist
if [ ! -f macroquad-poc.app/Info.plist ]; then
    cat > macroquad-poc.app/Info.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>macroquad-poc</string>
    <key>CFBundleIdentifier</key>
    <string>com.macroquad-poc</string>
    <key>CFBundleName</key>
    <string>macroquad-poc</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
</dict>
</plist>
EOF
fi

# Build for iOS simulator
echo "Building for iOS simulator..."
cargo build --target x86_64-apple-ios

# Copy the binary
echo "Copying binary to app bundle..."
cp target/x86_64-apple-ios/debug/macroquad-poc macroquad-poc.app/

# Copy assets if they exist
if [ -d "assets" ]; then
    echo "Copying assets..."
    cp -r assets macroquad-poc.app/
fi

# Get simulator ID
SIMULATOR_ID=$(xcrun simctl list devices available | grep -m 1 "iPhone" | grep -E -o -i "([0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12})")

if [ -z "$SIMULATOR_ID" ]; then
    echo "No simulator found. Please create one in Xcode first."
    exit 1
fi

# Boot simulator if needed
echo "Booting simulator..."
xcrun simctl boot "$SIMULATOR_ID"

# Install and launch the app
echo "Installing app..."
xcrun simctl install booted macroquad-poc.app/
echo "Launching app..."
xcrun simctl launch booted com.macroquad-poc

# Show logs
echo "Showing logs (Ctrl+C to stop)..."
xcrun simctl spawn booted log stream --predicate 'processImagePath endswith "macroquad-poc"'