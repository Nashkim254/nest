#!/bin/bash

# Script to encode keystore for GitHub Secrets
echo "Encoding Android keystore for GitHub Secrets..."

if [ ! -f "nest-release-key.keystore" ]; then
    echo "Error: nest-release-key.keystore not found in current directory"
    echo "Make sure you're in the project root directory"
    exit 1
fi

echo "Encoding keystore to base64..."
ENCODED=$(base64 -i nest-release-key.keystore)

echo ""
echo "============================================"
echo "ANDROID_KEYSTORE_BASE64 Secret Value:"
echo "============================================"
echo "$ENCODED"
echo ""
echo "Copy the above value and add it as ANDROID_KEYSTORE_BASE64 secret in GitHub"
echo ""
echo "Other required secrets:"
echo "KEY_ALIAS=nest-key"
echo "KEYSTORE_PASSWORD=nestapp2024"  
echo "KEY_PASSWORD=nestapp2024"
echo ""
echo "Don't forget to set up GOOGLE_PLAY_SERVICE_ACCOUNT_JSON for Play Store deployment!"