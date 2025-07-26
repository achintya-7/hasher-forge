#!/bin/bash

echo "🚀 Building for GitHub Pages deployment..."

# Build WebAssembly
echo "📦 Building WebAssembly module..."
npm run build:wasm

# Build React app
echo "⚛️ Building React application..."
npm run build

echo "✅ Build complete! The 'dist' folder contains your GitHub Pages ready files."
echo "🌐 You can test locally by running: npm run preview"
echo "📤 Push to GitHub to trigger automatic deployment!"
