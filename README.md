# MathLib - C++ Mathematical Operations Library

A simple C++ static library providing basic mathematical operations with support for both integer and floating-point arithmetic.

## Features

- **Addition**: Supports both integer and double precision floating-point addition
- **Subtraction**: Supports both integer and double precision floating-point subtraction
- **Static Library**: Compiled as `.a` static library for easy linking
- **Header Files**: Clean `.h` header files for easy integration
- **Cross-platform**: Works on macOS, Linux, and Windows

## Project Structure

```
cpp-math-lib/
├── include/
│   └── math_operations.h      # Public header file
├── src/
│   └── math_operations.cpp    # Implementation source
├── lib/                       # Generated static library (.a)
├── build/                     # Compiled object files (.o)
├── examples/
│   └── main.cpp              # Example usage program
├── Makefile                  # Build system
└── README.md                 # This file
```

## Prerequisites

- **C++ Compiler**: g++ with C++17 support
- **Make**: GNU Make utility
- **ar**: Archive utility (usually included with build tools)

### Installing Prerequisites

**macOS:**
```bash
# Install Xcode Command Line Tools
xcode-select --install

# Or install via Homebrew
brew install gcc make
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install build-essential make
```

**CentOS/RHEL:**
```bash
sudo yum groupinstall "Development Tools"
# or on newer versions:
sudo dnf groupinstall "Development Tools"
```

## Building the Library

### Quick Start
```bash
# Clone or navigate to the project directory
cd cpp-math-lib

# Build the static library
make

# Build and run the example
make run-example
```

### Available Make Targets

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

After building, you'll find:
- **Static Library**: `lib/libmathlib.a`
- **Object Files**: `build/*.o`
- **Example Program**: `examples/example`

## Using the Library

### Include in Your Project

**Method 1: Direct Integration**
```cpp
#include "math_operations.h"

int main() {
    int result = MathLib::Addition(5, 3);
    double result_d = MathLib::Subtraction(10.5, 2.3);
    return 0;
}
```

**Method 2: System-wide Installation**
```bash
# Install library and headers
sudo make install

# In your code
#include <mathlib/math_operations.h>

// Compile your program
g++ -std=c++17 your_program.cpp -lmathlib -o your_program
```

**Method 3: Manual Linking**
```bash
g++ -std=c++17 -I./include your_program.cpp -L./lib -lmathlib -o your_program
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

### Example Usage

```cpp
#include <iostream>
#include "math_operations.h"

int main() {
    // Integer operations
    int sum_int = MathLib::Addition(15, 7);        // Returns 22
    int diff_int = MathLib::Subtraction(15, 7);    // Returns 8
    
    // Floating-point operations
    double sum_double = MathLib::Addition(25.75, 12.25);     // Returns 38.00
    double diff_double = MathLib::Subtraction(25.75, 12.25); // Returns 13.50
    
    std::cout << "Integer: " << sum_int << ", " << diff_int << std::endl;
    std::cout << "Double: " << sum_double << ", " << diff_double << std::endl;
    
    return 0;
}
```

## Development

### Adding New Functions

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
make clean && make
```

### Testing Your Changes

```bash
# Compile test
make test

# Run example to verify
make run-example
```

## Troubleshooting

### Common Issues

**Build fails with "command not found":**
- Ensure g++ and make are installed
- Check if they're in your PATH

**Linking errors when using the library:**
- Verify the library path: `-L./lib`
- Ensure library name is correct: `-lmathlib`
- Check header include path: `-I./include`

**Permission denied during installation:**
- Use `sudo make install` for system-wide installation
- Or install to user directory instead

### Compiler Flags Explanation

- `-std=c++17`: Use C++17 standard
- `-Wall -Wextra`: Enable most warning messages
- `-O2`: Optimization level 2
- `-fPIC`: Generate position-independent code

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
