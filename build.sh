#!/bin/bash

# Build script for MathLib with Protobuf
# Version: 1.0.0
# Date: 2025-10-22

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Default values
BUILD_TYPE="Release"
BUILD_DIR="build"
CLEAN_BUILD=false
RUN_TESTS=false
INSTALL_DEPS=false

# Help function
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  -h, --help           Show this help message"
    echo "  -d, --debug          Build in Debug mode (default: Release)"
    echo "  -c, --clean          Clean build directory before building"
    echo "  -t, --test           Run tests after building"
    echo "  -i, --install-deps   Install system dependencies (protobuf)"
    echo "  --build-dir DIR      Specify build directory (default: build)"
    echo ""
    echo "EXAMPLES:"
    echo "  $0                   # Basic release build"
    echo "  $0 -d -t             # Debug build with tests"
    echo "  $0 -c -i             # Clean build with dependency installation"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -d|--debug)
            BUILD_TYPE="Debug"
            shift
            ;;
        -c|--clean)
            CLEAN_BUILD=true
            shift
            ;;
        -t|--test)
            RUN_TESTS=true
            shift
            ;;
        -i|--install-deps)
            INSTALL_DEPS=true
            shift
            ;;
        --build-dir)
            BUILD_DIR="$2"
            shift 2
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

print_status "Starting MathLib with Protobuf build process..."
print_status "Build type: $BUILD_TYPE"
print_status "Build directory: $BUILD_DIR"

# Check if we're in the right directory
if [[ ! -f "CMakeLists.txt" ]]; then
    print_error "CMakeLists.txt not found. Please run this script from the cpp-math-lib directory."
    exit 1
fi

# Install dependencies if requested
if [[ "$INSTALL_DEPS" == true ]]; then
    print_status "Installing system dependencies..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew >/dev/null 2>&1; then
            brew install protobuf cmake
            print_success "Installed protobuf and cmake via Homebrew"
        else
            print_warning "Homebrew not found. Please install protobuf manually."
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v apt-get >/dev/null 2>&1; then
            sudo apt-get update
            sudo apt-get install -y protobuf-compiler libprotobuf-dev cmake build-essential
            print_success "Installed protobuf and cmake via apt"
        elif command -v yum >/dev/null 2>&1; then
            sudo yum install -y protobuf-compiler protobuf-devel cmake gcc-c++
            print_success "Installed protobuf and cmake via yum"
        else
            print_warning "Unknown package manager. Please install protobuf manually."
        fi
    else
        print_warning "Unknown OS. Please install protobuf manually."
    fi
fi

# Check for required tools
print_status "Checking for required tools..."

if ! command -v cmake >/dev/null 2>&1; then
    print_error "CMake not found. Please install CMake."
    exit 1
fi

if ! command -v protoc >/dev/null 2>&1; then
    print_warning "protoc not found. CMake will try to fetch protobuf automatically."
else
    PROTOC_VERSION=$(protoc --version)
    print_success "Found protoc: $PROTOC_VERSION"
fi

# Clean build directory if requested
if [[ "$CLEAN_BUILD" == true ]]; then
    print_status "Cleaning build directory..."
    rm -rf "$BUILD_DIR"
    print_success "Build directory cleaned"
fi

# Create build directory
print_status "Creating build directory..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Configure with CMake
print_status "Configuring with CMake..."
cmake .. -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
         -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

if [[ $? -ne 0 ]]; then
    print_error "CMake configuration failed"
    exit 1
fi

print_success "CMake configuration completed"

# Build the project
print_status "Building the project..."
cmake --build . --parallel $(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)

if [[ $? -ne 0 ]]; then
    print_error "Build failed"
    exit 1
fi

print_success "Build completed successfully"

# Run tests if requested
if [[ "$RUN_TESTS" == true ]]; then
    print_status "Running tests..."
    
    if ctest --output-on-failure; then
        print_success "All tests passed!"
    else
        print_error "Some tests failed"
        exit 1
    fi
fi

# Show build artifacts
print_status "Build artifacts:"
echo "  - Libraries:"
find . -name "*.a" -o -name "*.so" -o -name "*.dylib" | sed 's/^/    /'
echo "  - Executables:"
find . -name "example" -o -name "proto_example" -o -name "test_*" | sed 's/^/    /'
echo "  - Generated proto files:"
find . -name "*.pb.h" -o -name "*.pb.cc" | sed 's/^/    /'

print_success "Build process completed!"
print_status "You can now run:"
print_status "  ./example                 # Basic math example"
print_status "  ./proto_example           # Protobuf example"
print_status "  ctest                     # Run all tests"