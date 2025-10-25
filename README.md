# MathLib with Protobuf - C++ Mathematical Operations Library

A comprehensive C++ library providing basic mathematical operations with Protocol Buffers (protobuf) integration for data serialization.

## Features

- **Mathematical Operations**: Addition and Subtraction for both integer and double precision floating-point
- **Protocol Buffers Integration**: Support for `Lang` and `Platform` message types
- **Multiple Build Systems**: Both CMake and Make support
- **Static Library**: Compiled as `.a` static library for easy linking
- **Header Files**: Clean `.h` header files for easy integration
- **Cross-platform**: Works on macOS, Linux, and Windows
- **Automatic Proto Generation**: Generates C++ bindings from `.proto` files
- **Comprehensive Testing**: Unit tests for both math and protobuf functionality

## Project Structure

```
cpp-math-lib/
├── include/
│   └── math_operations.h      # Public header file
├── src/
│   └── math_operations.cpp    # Implementation source
├── examples/
│   ├── main.cpp              # Basic math example
│   └── proto_example.cpp     # Protobuf integration example
├── tests/
│   ├── test_math.cpp         # Math operation tests
│   └── test_proto.cpp        # Protobuf functionality tests
├── build/                     # CMake build directory
│   └── generated/            # Auto-generated protobuf C++ files
├── lib/                       # Generated static library (.a) - Make only
├── CMakeLists.txt            # CMake build configuration
├── Makefile                  # Make build system (legacy)
├── build.sh                  # Automated build script
└── README.md                 # This file
```

## Proto Files Used

The library integrates with existing protobuf definitions:
- `../src/models/proto/lang.proto` - Language information
- `../src/models/proto/platform.proto` - Platform specifications

## Prerequisites

- **C++ Compiler**: g++ with C++17 support
- **CMake**: Version 3.15 or higher (recommended)
- **Protocol Buffers**: protoc compiler and libprotobuf
- **Make**: GNU Make utility (for legacy Makefile)

### Installing Prerequisites

**macOS:**
```bash
# Install via Homebrew (recommended)
brew install cmake protobuf

# Or install Xcode Command Line Tools
xcode-select --install
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install build-essential cmake protobuf-compiler libprotobuf-dev
```

**CentOS/RHEL:**
```bash
# CentOS/RHEL 8+
sudo dnf install cmake protobuf-compiler protobuf-devel gcc-c++

# CentOS/RHEL 7
sudo yum install cmake3 protobuf-compiler protobuf-devel gcc-c++
```

## Building the Library

### Quick Start (CMake - Recommended)

```bash
# Clone or navigate to the project directory
cd cpp-math-lib

# Option 1: Use automated build script
chmod +x build.sh
./build.sh --help                    # See all options
./build.sh -i -t                     # Install deps and run tests

# Option 2: Manual CMake build
mkdir build && cd build
cmake ..
cmake --build . --parallel
ctest                                # Run tests
```

### Legacy Make Build

```bash
cd cpp-math-lib

# Build the static library (math only)
make

# Build and run the basic example
make run-example
```

### Build Script Options

The `build.sh` script provides convenient options:

```bash
./build.sh -h                       # Show help
./build.sh                          # Basic release build
./build.sh -d -t                    # Debug build with tests
./build.sh -c -i                    # Clean build with dependency installation
./build.sh --build-dir custom_build # Use custom build directory
```

### CMake Targets

| Target | Description |
|--------|-------------|
| `mathlib` | Basic math library (no protobuf) |
| `mathlib_with_proto` | Math library with protobuf support |
| `example` | Basic math example program |
| `proto_example` | Protobuf integration example |
| `test_math` | Math operation tests |
| `test_proto` | Protobuf functionality tests |
| `generate_proto` | Generate C++ files from proto definitions |

### Legacy Make Targets

| Target | Description |
|--------|-------------|
| `make` or `make all` | Build the static library |
| `make example` | Build the example program |
| `make run-example` | Build and run the example program |
| `make test` | Run basic compilation tests |
| `make install` | Install library system-wide (requires sudo) |
| `make uninstall` | Remove installed library |
| `make clean` | Remove all build artifacts |
| `make help` | Display available targets |

### Build Output

After building with CMake, you'll find:
- **Libraries**: `build/libmathlib.a`, `build/libmathlib_with_proto.a`
- **Executables**: `build/example`, `build/proto_example`
- **Generated Proto Files**: `build/generated/lang.pb.h`, `build/generated/platform.pb.h`
- **Test Executables**: `build/test_math`, `build/test_proto`

## Using the Library

### Basic Math Operations

**Method 1: CMake Integration**
```cmake
# In your CMakeLists.txt
find_package(PkgConfig REQUIRED)
pkg_check_modules(MATHLIB REQUIRED mathlib)

target_link_libraries(your_target ${MATHLIB_LIBRARIES})
target_include_directories(your_target PRIVATE ${MATHLIB_INCLUDE_DIRS})
```

**Method 2: Direct Integration**
```cpp
#include "math_operations.h"

int main() {
    int result = MathLib::Addition(5, 3);
    double result_d = MathLib::Subtraction(10.5, 2.3);
    return 0;
}
```

**Method 3: Manual Linking**
```bash
# Basic math only
g++ -std=c++17 -I./include your_program.cpp -L./build -lmathlib -o your_program

# With protobuf support
g++ -std=c++17 -I./include -I./build/generated your_program.cpp \
    -L./build -lmathlib_with_proto -lprotobuf -o your_program
```

### Protobuf Integration

**Using Language Messages:**
```cpp
#include "lang.pb.h"

// Create a language message
core::Lang lang;
lang.set_id(1);
lang.set_i1("en");
lang.set_name("English");

// Serialize to binary
std::string serialized;
lang.SerializeToString(&serialized);

// Deserialize from binary
core::Lang deserialized;
deserialized.ParseFromString(serialized);
```

**Using Platform Messages:**
```cpp
#include "platform.pb.h"

// Create platform list
types::core::PlatformList platforms;

// Add iOS platform
auto* ios = platforms.add_platforms();
ios->set_name("iOS");
ios->set_min_version("14.0");
ios->set_max_version("17.0");

// Serialize and save
std::string data;
platforms.SerializeToString(&data);
std::ofstream file("platforms.bin", std::ios::binary);
file.write(data.data(), data.size());
```

**Combined Math + Protobuf Example:**
```cpp
#include "math_operations.h"
#include "lang.pb.h"

int main() {
    // Use math operations
    int computed_id = MathLib::Addition(10, 5);
    
    // Use result in protobuf message
    core::Lang lang;
    lang.set_id(computed_id);
    lang.set_name("Computed Language");
    
    return 0;
}
```

### API Reference

#### Namespace: `MathLib`

**Integer Operations:**
```cpp
int Addition(int a, int b);      // Returns a + b
int Subtraction(int a, int b);   // Returns a - b
```

**Floating-Point Operations:**
```cpp
double Addition(double a, double b);      // Returns a + b
double Subtraction(double a, double b);   // Returns a - b
```

#### Protobuf Messages

**Lang Message (`core::Lang`)**
```protobuf
message Lang {
  int32 id = 1;        // Language ID
  string i1 = 2;       // ISO 639-1 code
  string i2 = 3;       // ISO 639-2 code  
  string i3 = 4;       // ISO 639-3 code
  string name = 5;     // Language name
}
```

**Platform Message (`types.core.Platform`)**
```protobuf
message Platform {
  string name = 1;         // Platform name (e.g., "iOS", "Android")
  string min_version = 2;  // Minimum supported version
  string max_version = 3;  // Maximum supported version
  string icon_id = 4;      // Icon identifier
}

message PlatformList {
  repeated Platform platforms = 1;  // List of platforms
}
```

## Running Examples and Tests

### Example Programs

```bash
# Navigate to build directory
cd build

# Run basic math example
./example

# Run protobuf integration example
./proto_example
```

### Running Tests

```bash
# Run all tests with CMake/CTest
cd build
ctest --verbose

# Run individual tests
./test_math
./test_proto

# Run tests with build script
cd ..
./build.sh -t
```

### Expected Test Output

**Math Tests:**
```
✓ Integer addition tests passed
✓ Double addition tests passed  
✓ Integer subtraction tests passed
✓ Double subtraction tests passed
🎉 All MathLib tests passed!
```

**Protobuf Tests:**
```
✓ Protobuf version compatibility verified
✓ Lang protobuf tests passed
✓ Platform protobuf tests passed
✓ PlatformList protobuf tests passed
🎉 All Protobuf tests passed!
```

## Development

### Adding New Math Functions

1. **Add declaration** to `include/math_operations.h`:
```cpp
int Multiplication(int a, int b);
```

2. **Add implementation** to `src/math_operations.cpp`:
```cpp
int Multiplication(int a, int b) {
    return a * b;
}
```

3. **Rebuild** the library:
```bash
# With CMake
cd build && cmake --build .

# With Make (legacy)
make clean && make
```

### Adding New Proto Messages

1. **Modify proto files** in `../src/models/proto/`
2. **Regenerate C++ bindings**:
```bash
# CMake automatically regenerates on build
cd build && cmake --build . --target generate_proto

# Manual generation
protoc --cpp_out=build/generated \
       --proto_path=../src/models/proto \
       ../src/models/proto/*.proto
```

3. **Update your C++ code** to use new message types
4. **Rebuild** the library

### Testing Your Changes

```bash
# Test math changes
cd build && ./test_math

# Test protobuf changes  
./test_proto

# Run all tests
ctest

# Test with build script
cd .. && ./build.sh -t
```

## Troubleshooting

### Common Issues

**CMake configuration fails:**
- Ensure CMake 3.15+ is installed: `cmake --version`
- Check if protobuf is available: `protoc --version`
- Try installing dependencies: `./build.sh -i`

**Protobuf compilation errors:**
- Verify proto files exist in `../src/models/proto/`
- Check protoc version compatibility
- Try manual proto generation:
  ```bash
  protoc --cpp_out=build/generated --proto_path=../src/models/proto ../src/models/proto/*.proto
  ```

**Linking errors when using the library:**
- For math only: `-lmathlib`
- For protobuf support: `-lmathlib_with_proto -lprotobuf`
- Check library paths: `-L./build`
- Verify header paths: `-I./include -I./build/generated`

**Runtime protobuf errors:**
- Ensure `GOOGLE_PROTOBUF_VERIFY_VERSION` is called
- Call `google::protobuf::ShutdownProtobufLibrary()` before exit
- Check protobuf version compatibility

**Build fails with "command not found":**
- Install required tools: `./build.sh -i`
- Check PATH contains cmake, protoc, g++

**Permission denied during installation:**
- Use `sudo make install` for system-wide installation
- Or use local installation paths

### Build System Comparison

| Feature | CMake | Make (Legacy) |
|---------|-------|---------------|
| Protobuf Support | ✅ Full | ❌ No |
| Dependency Management | ✅ Automatic | ❌ Manual |
| Cross-platform | ✅ Yes | ⚠️ Limited |
| Testing Framework | ✅ CTest | ⚠️ Basic |
| Parallel Builds | ✅ Yes | ⚠️ Limited |
| **Recommendation** | **Use CMake** | Legacy only |

### Performance Notes

- **Build Time**: CMake builds are faster due to parallel compilation
- **Library Size**: Math-only library is ~10KB, with protobuf ~500KB+
- **Runtime**: Protobuf serialization adds minimal overhead
- **Memory**: Protobuf messages use dynamic allocation

## License

This project is licensed under the **Mimik Source-Available License**.

- ✅ Free for individual use
- ❌ Redistribution is not allowed
- 💼 Commercial/Enterprise use may require a separate license

See [LICENSE.md](./LICENSE.md) for full terms.  
For enterprise licensing, contact: [fayaz7@protonmail.com]

## Version

**Current Version**: 1.0.0  
**Release Date**: October 21, 2025

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add your improvements
4. Test thoroughly
5. Submit a pull request

---

**Note**: This is a sample mathematical operations library designed to demonstrate C++ static library creation and build processes.
