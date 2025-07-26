# Hash Forge

A fast, privacy-focused file hashing tool built with Go WebAssembly and React. Calculate XXH3 hashes of your files directly in your browser - no files ever leave your device.

🌐 **[Live Demo](https://achintya-7.github.io/hash-forge/)**

![Hash Forge](https://img.shields.io/badge/Hash-Forge-blue?style=for-the-badge)
![Go](https://img.shields.io/badge/Go-1.24-00ADD8?style=flat&logo=go)
![React](https://img.shields.io/badge/React-19.1-61DAFB?style=flat&logo=react)
![WebAssembly](https://img.shields.io/badge/WebAssembly-654FF0?style=flat&logo=webassembly)

## ✨ Features

- **🔒 100% Private**: All processing happens locally in your browser - files never leave your device
- **⚡ Lightning Fast**: Powered by Go WebAssembly for optimal performance
- **📁 Multiple Files**: Process multiple files at once with sequential processing
- **🎨 Modern UI**: Clean, responsive interface built with React and Tailwind CSS
- **🌐 Cross-Platform**: Works on any device with a modern web browser
- **📦 Easy Deployment**: Docker support for easy hosting

## 🚀 Quick Start

### Prerequisites

- [Go](https://golang.org/dl/) 1.24 or later
- [Node.js](https://nodejs.org/) 18 or later
- [Docker](https://www.docker.com/) (optional, for containerized deployment)

### Local Development

1. **Clone the repository**

   ```bash
   git clone https://github.com/achintya-7/hash-forge.git
   cd hash-forge
   ```

2. **Install Node.js dependencies**

   ```bash
   npm install
   ```

3. **Build the WebAssembly module**

   ```bash
   npm run build:wasm
   ```

4. **Start the development server**

   ```bash
   npm run dev
   ```

5. **Open your browser**
   Navigate to `http://localhost:5173` to use the application.

### Production Build

1. **Build the WebAssembly module**

   ```bash
   npm run build:wasm
   ```

2. **Build the React application**

   ```bash
   npm run build
   ```

3. **Serve the built files**
   ```bash
   npm run preview
   ```

## 🐳 Docker Deployment

### Using Docker (Recommended for Self-Hosting)

1. **Build and run with Docker**
   ```bash
   ./docker-build.sh
   ```

## 🚀 GitHub Pages Deployment

### Automatic Deployment (Recommended)

This project is configured for automatic deployment to GitHub Pages using GitHub Actions.

1. **Fork or clone this repository to your GitHub account**

2. **Enable GitHub Pages in your repository:**

   - Go to your repository settings
   - Navigate to "Pages" section
   - Under "Source", select "GitHub Actions"

3. **Push to the master branch:**

   ```bash
   git add .
   git commit -m "Deploy to GitHub Pages"
   git push origin master
   ```

4. **Access your deployed app:**
   Your app will be available at: `https://yourusername.github.io/hash-forge/`

### Manual Deployment

If you prefer to deploy manually:

1. **Build the project locally:**

   ```bash
   npm run deploy
   ```

2. **Deploy using GitHub CLI (if installed):**
   ```bash
   gh workflow run deploy.yml
   ```

### Manual Docker Commands

1. **Build the Docker image**

   ```bash
   docker build -t hash-forge .
   ```

2. **Run the container**

   ```bash
   docker run -p 3000:80 --name hash-forge-container hash-forge
   ```

3. **Access the application**
   Open `http://localhost:3000` in your browser.

### Docker Management

```bash
# Stop the container
docker stop hash-forge-container

# Remove the container
docker rm hash-forge-container

# View logs
docker logs hash-forge-container
```

## 🏗️ Project Structure

```
hash-forge/
├── go/                     # Go WebAssembly source
│   ├── main.go            # Main WASM entry point
│   ├── go.mod             # Go module definition
│   └── go.sum             # Go module checksums
├── src/                   # React source code
│   ├── App.tsx            # Main React component
│   ├── components/        # UI components
│   └── lib/               # Utility functions
├── public/                # Static files
│   ├── main.wasm          # Compiled WebAssembly binary
│   └── wasm_exec.js       # Go WebAssembly runtime
├── Dockerfile             # Multi-stage Docker build
├── docker-build.sh        # Docker build script
└── package.json           # Node.js dependencies
```

## 🛠️ Available Scripts

### Development

- `npm run dev` - Start development server
- `npm run build:wasm` - Build Go WebAssembly module
- `npm run build` - Build production React app
- `npm run preview` - Preview production build

### Docker

- `./docker-build.sh` - Build and run Docker container
- `npm run docker-build-and-run` - Same as above

### Code Quality

- `npm run lint` - Run ESLint

## 🔧 Technology Stack

### Backend (WebAssembly)

- **Go 1.24**: Core language for WebAssembly compilation
- **XXH3**: Fast, high-quality hash algorithm via [zeebo/xxh3](https://github.com/zeebo/xxh3)
- **syscall/js**: Go's WebAssembly browser interface

### Frontend

- **React 19.1**: Modern UI framework with hooks
- **TypeScript**: Type-safe JavaScript development
- **Vite**: Fast build tool and development server
- **Tailwind CSS**: Utility-first CSS framework
- **shadcn/ui**: Beautiful, accessible UI components

### Development & Deployment

- **Docker**: Multi-stage containerized deployment
- **nginx**: Production web server
- **ESLint**: Code linting and formatting

## 📖 How It Works

1. **File Selection**: Choose one or more files using the file input
2. **WebAssembly Loading**: Go WASM module loads in the browser
3. **Hash Calculation**: Files are processed locally using the XXH3 algorithm
4. **Results Display**: Hash results are shown with copy functionality

### WebAssembly Integration

The Go code is compiled to WebAssembly and exposes a `hashFile` function:

```go
func hashFile(this js.Value, args []js.Value) interface{} {
    // File processing logic
    fileData := args[0]
    buffer := make([]byte, fileData.Get("length").Int())
    js.CopyBytesToGo(buffer, fileData)

    // Calculate hash
    finalHash := xxh3.Hash(buffer)
    return fmt.Sprintf("%d", finalHash)
}
```

The React frontend calls this function:

```typescript
const hash = window.hashFile(uint8Array);
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [XXH3](https://github.com/Cyan4973/xxHash) - The fast hashing algorithm
- [zeebo/xxh3](https://github.com/zeebo/xxh3) - Go implementation of XXH3
- [shadcn/ui](https://ui.shadcn.com/) - Beautiful UI components
- [Go WebAssembly](https://github.com/golang/go/wiki/WebAssembly) - Go's WebAssembly support

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/achintya-7/hash-forge/issues) page
2. Create a new issue with detailed information
3. Contact the maintainer: [@achintya-7](https://github.com/achintya-7)

---

---

Made with ❤️ by [Achintya](https://github.com/achintya-7)

You can also install [eslint-plugin-react-x](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-x) and [eslint-plugin-react-dom](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-dom) for React-specific lint rules:

```js
// eslint.config.js
import reactX from "eslint-plugin-react-x";
import reactDom from "eslint-plugin-react-dom";

export default tseslint.config([
  globalIgnores(["dist"]),
  {
    files: ["**/*.{ts,tsx}"],
    extends: [
      // Other configs...
      // Enable lint rules for React
      reactX.configs["recommended-typescript"],
      // Enable lint rules for React DOM
      reactDom.configs.recommended,
    ],
    languageOptions: {
      parserOptions: {
        project: ["./tsconfig.node.json", "./tsconfig.app.json"],
        tsconfigRootDir: import.meta.dirname,
      },
      // other options...
    },
  },
]);
```
