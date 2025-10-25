# Makefile for Mimik C++ Static Library
# Version: 1.0.0
# Date: 2025-10-24

# Compiler settings
CXX = g++
CXXFLAGS = -std=c++23 -Wall -Wextra -O2 -fPIC
AR = ar
ARFLAGS = rcs

# Directory structure
SRC_DIR = src
INCLUDE_DIR = include
BUILD_DIR = build
LIB_DIR = lib
EXAMPLES_DIR = examples
PROTO_DIR = $(SRC_DIR)/models/proto
PROTO_GEN_DIR = $(BUILD_DIR)/proto_generated

# Library settings
LIB_NAME = libmimik
STATIC_LIB = $(LIB_DIR)/$(LIB_NAME).a

# Source files
SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS = $(SOURCES:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)
HEADERS = $(wildcard $(INCLUDE_DIR)/*.h)

# Example program
EXAMPLE_SRC = $(EXAMPLES_DIR)/main.cpp
EXAMPLE_BIN = $(EXAMPLES_DIR)/example

# Default target
.PHONY: all clean install test example help gen-proto debug

all: gen-proto $(STATIC_LIB)

# Generate C++ files from proto
gen-proto:
	@echo "Generating C++ source files from proto definitions..."
	@mkdir -p $(PROTO_GEN_DIR)
	protoc --cpp_out=$(PROTO_GEN_DIR) --proto_path=$(PROTO_DIR) $(PROTO_DIR)/*.proto
	@echo "Proto files generated successfully!"

# Create static library
$(STATIC_LIB): $(OBJECTS) | $(LIB_DIR)
	@echo "Creating static library: $@"
	$(AR) $(ARFLAGS) $@ $^
	@echo "Static library created successfully!"

# Compile source files to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp $(HEADERS) | $(BUILD_DIR)
	@echo "Compiling: $<"
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -I$(PROTO_GEN_DIR) -c $< -o $@

# Create build directory
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Create lib directory
$(LIB_DIR):
	@mkdir -p $(LIB_DIR)

# Build example program
example: $(STATIC_LIB) $(EXAMPLE_SRC)
	@echo "Building example program..."
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -I$(PROTO_GEN_DIR) $(EXAMPLE_SRC) -L$(LIB_DIR) -lmimik -o $(EXAMPLE_BIN)
	@echo "Example program built: $(EXAMPLE_BIN)"

# Run example program
run-example: example
	@echo "Running example program..."
	@./$(EXAMPLE_BIN)

# Install headers and library
install: $(STATIC_LIB)
	@echo "Installing library and headers..."
	sudo cp $(STATIC_LIB) /usr/local/lib/
	sudo mkdir -p /usr/local/include/mimik
	sudo cp $(HEADERS) /usr/local/include/mimik/
	@echo "Installation complete!"

# Uninstall
uninstall:
	@echo "Uninstalling library and headers..."
	sudo rm -f /usr/local/lib/$(LIB_NAME).a
	sudo rm -rf /usr/local/include/mimik
	@echo "Uninstallation complete!"

# Test the library (basic compilation test)
test: $(STATIC_LIB)
	@echo "Running basic tests..."
	@$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) $(SRC_DIR)/math_operations.cpp -c -o $(BUILD_DIR)/test_compile.o
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
	@echo "  gen-proto    - Generate C++ files from proto definitions"
	@echo "  example      - Build the example program"
	@echo "  run-example  - Build and run the example program"
	@echo "  test         - Run basic compilation tests"
	@echo "  install      - Install library and headers system-wide"
	@echo "  uninstall    - Remove installed library and headers"
	@echo "  clean        - Remove all build artifacts"
	@echo "  help         - Display this help message"

# Debug information
debug:
	@echo "Debug Information:"
	@echo "Sources: $(SOURCES)"
	@echo "Objects: $(OBJECTS)"
	@echo "Headers: $(HEADERS)"
	@echo "Static Library: $(STATIC_LIB)"
	@echo "Proto generated dir: $(PROTO_GEN_DIR)"
