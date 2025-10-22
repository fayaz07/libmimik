#include <iostream>
#include <iomanip>
#include "math_operations.h"

/**
 * @file main.cpp
 * @brief Example program demonstrating MathLib usage
 * @version 1.0.0
 * @date 2025-10-21
 */

int main() {
    std::cout << "=== MathLib Example Program ===" << std::endl;
    std::cout << std::fixed << std::setprecision(2);
    
    // Test integer operations
    std::cout << "\n--- Integer Operations ---" << std::endl;
    int a = 15, b = 7;
    
    int sum_int = MathLib::Addition(a, b);
    int diff_int = MathLib::Subtraction(a, b);
    
    std::cout << "Addition: " << a << " + " << b << " = " << sum_int << std::endl;
    std::cout << "Subtraction: " << a << " - " << b << " = " << diff_int << std::endl;
    
    // Test floating-point operations
    std::cout << "\n--- Floating-Point Operations ---" << std::endl;
    double x = 25.75, y = 12.25;
    
    double sum_double = MathLib::Addition(x, y);
    double diff_double = MathLib::Subtraction(x, y);
    
    std::cout << "Addition: " << x << " + " << y << " = " << sum_double << std::endl;
    std::cout << "Subtraction: " << x << " - " << y << " = " << diff_double << std::endl;
    
    // Additional test cases
    std::cout << "\n--- Additional Test Cases ---" << std::endl;
    
    // Negative numbers
    int neg_a = -10, neg_b = 5;
    std::cout << "Addition (negative): " << neg_a << " + " << neg_b << " = " 
              << MathLib::Addition(neg_a, neg_b) << std::endl;
    std::cout << "Subtraction (negative): " << neg_a << " - " << neg_b << " = " 
              << MathLib::Subtraction(neg_a, neg_b) << std::endl;
    
    // Zero operations
    std::cout << "Addition with zero: " << a << " + 0 = " 
              << MathLib::Addition(a, 0) << std::endl;
    std::cout << "Subtraction with zero: " << a << " - 0 = " 
              << MathLib::Subtraction(a, 0) << std::endl;
    
    // Large numbers
    double large_x = 1000000.50, large_y = 999999.25;
    std::cout << "Large number addition: " << large_x << " + " << large_y << " = " 
              << MathLib::Addition(large_x, large_y) << std::endl;
    
    std::cout << "\n=== Example completed successfully! ===" << std::endl;
    
    return 0;
}
