// Lab 11: Calculating the Quadratic Function
// Cole Cagle
// CPEN 3710
// April 10, 2022

// This is a program that will deal with the input/output of values that will be calculated using the quadratic function.
// The user will enter the values for a, b, and c respectively. The calculations will take place in assembly language
// source file: quadratic.asm. The answers will then be returned to the user after the ASM file has been executed and
// returns control to the C++ program.

#include <iostream>
#include <fstream>
using namespace std;

// Defining the ASM file parameters for when it is called to be executed.
extern "C" {int quadratic(float a, float b, float c, float * root1, float * root2);}

// Defining the main method.
int main() {
	// Defining the coefficients and result variables.
	float a, b, c, root1, root2;
	int error;

	// Printing lines of output for the user to fill with input.
	cout << "Enter the coefficients of the quadratic formula\n";
	cout << "where Ax^2 + Bx + C = 0 \n";

	//Obtain all values for A, B, and C if A != 0.
getRoots:
	cout << "Enter value for A: ";
	cin >> a;
	//Error message if A = 0 because denominator cannot be 0.
	if (a == 0) {
		cout << "Value A cannot equal 0. Please enter a nonzero value.\n";
		goto getRoots;
	}
	cout << "Enter value for B: ";
	cin >> b;
	cout << "Enter value for C: ";
	cin >> c;

	// Calling for the ASM file to calculate the equation.
	error = quadratic(a, b, c, &root1, &root2);

	//If the roots are imaginary, display imaginary message to user.
	if (error == -1) {
		cout << "The roots are imaginary.\n";
	}

	else {
		// Printing lines of output that display the calculated result.
		cout << "First root = ";
		cout << root1;
		cout << "\n";
		cout << "Second root = ";
		cout << root2;
		cout << "\n";
	}

	return (0);
}