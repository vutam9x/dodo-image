#!/bin/zsh
set -e

echo "=================================================="
echo "  DODO IMAGE — TRÌNH CÀI ĐẶT TỰ ĐỘNG CHO MACOS"
echo "=================================================="

DMG_URL="https://vutam9x.github.io/dodo-image/Dodo_Image_Installer.dmg"
TMP_DMG="/tmp/Dodo_Image_Installer.dmg"
MOUNT_DIR="/Volumes/Dodo Image Installer"

echo "1. Đang tải bộ cài Dodo_Image_Installer.dmg..."
curl -fL --progress-bar "$DMG_URL" -o "$TMP_DMG"

echo "2. Đang mở bộ cài..."
hdiutil detach "$MOUNT_DIR" -quiet 2>/dev/null || true
hdiutil attach "$TMP_DMG" -nobrowse -quiet

echo "3. Đang cài đặt Dodo Image vào /Applications..."
rm -rf "/Applications/Dodo Image.app"
cp -R "$MOUNT_DIR/Dodo Image.app" "/Applications/Dodo Image.app"

echo "4. Đang gỡ khóa Gatekeeper (xattr -cr) & cấp quyền USB-C Canon..."
xattr -cr "/Applications/Dodo Image.app"
chmod +x "/Applications/Dodo Image.app/Contents/MacOS/DodoImage"
chmod +x "/Applications/Dodo Image.app/Contents/Resources/gphoto2_bundle/bin/gphoto2" 2>/dev/null || true

hdiutil detach "$MOUNT_DIR" -quiet 2>/dev/null || true
rm -f "$TMP_DMG"

echo "✅ Cài đặt hoàn tất! Đang mở Dodo Image..."
open "/Applications/Dodo Image.app"
