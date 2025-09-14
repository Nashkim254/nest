#!/bin/bash

# Create Android Keystore for Release Signing
# Run this script to generate a keystore for your app

echo "Creating Android Release Keystore..."
echo "You'll need to provide:"
echo "1. Keystore password"
echo "2. Key alias (e.g., nest-key)" 
echo "3. Key password"
echo "4. Your name/company details"

# Create keystore
keytool -genkey -v -keystore nest-release-key.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias nest-key

echo ""
echo "Keystore created! Now set these environment variables for building:"
echo "export KEYSTORE_PATH=\$(pwd)/nest-release-key.keystore"
echo "export KEY_ALIAS=nest-key"
echo "export KEYSTORE_PASSWORD=<your_keystore_password>"
echo "export KEY_PASSWORD=<your_key_password>"
echo ""
echo "Or add them to your shell profile (.bashrc, .zshrc, etc.)"
echo ""
echo "⚠️  SECURITY NOTE:"
echo "- The keystore file is automatically excluded from git (.gitignore)"
echo "- NEVER commit keystores, certificates, or passwords to version control"
echo "- Keep your keystore file backed up safely - you need it for app updates"
echo "- For CI/CD, encode keystore as base64 and store as GitHub secret"