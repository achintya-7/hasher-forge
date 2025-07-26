#!/bin/bash

echo "🚀 Building for GitHub Pages deployment..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf dist/

# Build WebAssembly
echo "📦 Building WebAssembly module..."
npm run build:wasm

# Verify WASM files exist
if [ ! -f "public/main.wasm" ]; then
    echo "❌ Error: main.wasm not found in public folder!"
    exit 1
fi

if [ ! -f "public/wasm_exec.js" ]; then
    echo "❌ Error: wasm_exec.js not found in public folder!"
    exit 1
fi

echo "✅ WASM files verified"

# Build React app
echo "⚛️ Building React application..."
npm run build

echo "✅ Build complete! The 'dist' folder contains your GitHub Pages ready files."
echo "🌐 You can test locally by running: npm run preview"
echo "📤 Push to GitHub to trigger automatic deployment!"
