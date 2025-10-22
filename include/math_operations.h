#ifndef MATH_OPERATIONS_H
#define MATH_OPERATIONS_H

/**
 * @file math_operations.h
 * @brief Mathematical operations library
 * @version 1.0.0
 * @date 2025-10-21
 */

namespace MathLib {
    
    /**
     * @brief Performs addition of two integers
     * @param a First operand
     * @param b Second operand
     * @return Sum of a and b
     */
    int Addition(int a, int b);
    
    /**
     * @brief Performs addition of two floating-point numbers
     * @param a First operand
     * @param b Second operand
     * @return Sum of a and b
     */
    double Addition(double a, double b);
    
    /**
     * @brief Performs subtraction of two integers
     * @param a First operand (minuend)
     * @param b Second operand (subtrahend)
     * @return Difference of a and b (a - b)
     */
    int Subtraction(int a, int b);
    
    /**
     * @brief Performs subtraction of two floating-point numbers
     * @param a First operand (minuend)
     * @param b Second operand (subtrahend)
     * @return Difference of a and b (a - b)
     */
    double Subtraction(double a, double b);
    
} // namespace MathLib

#endif // MATH_OPERATIONS_H