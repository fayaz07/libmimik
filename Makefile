# Makefile for Mimik C++ Static Library
# Version: 1.0.0
# Date: 2025-10-21

# Compiler settings
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2 -fPIC
AR = ar
ARFLAGS = rcs

# Directory structure
SRC_DIR = src
INCLUDE_DIR = include
BUILD_DIR = build
LIB_DIR = lib
EXAMPLES_DIR = examples

# Library settings
LIB_NAME = libmathlib
STATIC_LIB = $(LIB_DIR)/$(LIB_NAME).a

# Source files
SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS = $(SOURCES:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)
HEADERS = $(wildcard $(INCLUDE_DIR)/*.h)

# Example program
EXAMPLE_SRC = $(EXAMPLES_DIR)/main.cpp
EXAMPLE_BIN = $(EXAMPLES_DIR)/example

# Default target
.PHONY: all clean install test example help

all: $(STATIC_LIB)

# Create static library
$(STATIC_LIB): $(OBJECTS) | $(LIB_DIR)
	@echo "Creating static library: $@"
	$(AR) $(ARFLAGS) $@ $^
	@echo "Static library created successfully!"

# Compile source files to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp $(HEADERS) | $(BUILD_DIR)
	@echo "Compiling: $<"
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $< -o $@

# Create build directory
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Create lib directory
$(LIB_DIR):
	@mkdir -p $(LIB_DIR)

# Build example program
example: $(STATIC_LIB) $(EXAMPLE_SRC)
	@echo "Building example program..."
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) $(EXAMPLE_SRC) -L$(LIB_DIR) -lmathlib -o $(EXAMPLE_BIN)
	@echo "Example program built: $(EXAMPLE_BIN)"

# Run example program
run-example: example
	@echo "Running example program..."
	@./$(EXAMPLE_BIN)

# Install headers and library (requires sudo for system-wide installation)
install: $(STATIC_LIB)
	@echo "Installing library and headers..."
	sudo cp $(STATIC_LIB) /usr/local/lib/
	sudo mkdir -p /usr/local/include/mathlib
	sudo cp $(HEADERS) /usr/local/include/mathlib/
	@echo "Installation complete!"

# Uninstall
uninstall:
	@echo "Uninstalling library and headers..."
	sudo rm -f /usr/local/lib/$(LIB_NAME).a
	sudo rm -rf /usr/local/include/mathlib
	@echo "Uninstallation complete!"

# Test the library (basic compilation test)
test: $(STATIC_LIB)
	@echo "Running basic tests..."
	@$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -c $(SRC_DIR)/math_operations.cpp -o $(BUILD_DIR)/test_compile.o
	@echo "Compilation test passed!"
	@rm -f $(BUILD_DIR)/test_compile.o

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(BUILD_DIR)
	rm -rf $(LIB_DIR)
	rm -f $(EXAMPLE_BIN)
	@echo "Clean complete!"

# Display help
help:
	@echo "Available targets:"
	@echo "  all          - Build the static library (default)"
	@echo "  example      - Build the example program"
	@echo "  run-example  - Build and run the example program"
	@echo "  test         - Run basic compilation tests"
	@echo "  install      - Install library and headers system-wide"
	@echo "  uninstall    - Remove installed library and headers"
	@echo "  clean        - Remove all build artifacts"
	@echo "  help         - Display this help message"
	@echo ""
	@echo "Library will be created as: $(STATIC_LIB)"
	@echo "Headers are in: $(INCLUDE_DIR)/"

# Debug information
debug:
	@echo "Debug Information:"
	@echo "Sources: $(SOURCES)"
	@echo "Objects: $(OBJECTS)"
	@echo "Headers: $(HEADERS)"
	@echo "Static Library: $(STATIC_LIB)"
	