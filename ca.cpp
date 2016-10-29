# include <iostream>
# include <cmath>
# include <cstdlib>
# include <cstring>
# include <unistd.h>
# include<ctime>

using namespace std;

const int DIM = 35;
const int HALF = DIM / 2;

// Get the number of bits needed to store an int
int get_bits (int x) {
	return floor(log(x)/log(2)) + 1;
}

// Convert an int to a string representation of a binary number
string to_bin(int x) {
	if(x == 0) {
		return "0";
	} else {
		int bits = get_bits(x);
		char buffer[bits];
		char* p = buffer + bits;
		do {
			*--p = '0' + (x & 1);
		} while (x >>= 1);

		return string(p, buffer + bits);
	}
}

// Convert a string representation of a binary number to an integer
long  to_int(string str) {

	char * ptr;
	return strtol(str.c_str(), & ptr, 2); 
} 

// Get the string representation of a rule 
string get_rule(int rule, int bits = 9) {
	int length = pow(2, bits);
	string str = to_bin(rule);
	int strl = strlen(str.c_str()); 
	string padding = "";
	if (strl < length) {
		for (int i = 0; i < (length - strl); i++) {
			padding += "0";
		}	
	}
	return string ( str.rbegin(), str.rend() ) +  padding;
}

// Get the bit that correspons to the int pos of the rule
int get_val_at_pos(int pos, int rule) {
	// Minus the ascii value of 0
	return get_rule(rule).c_str()[pos] - 48;
}

// Pretty pint a matrix of bits (represented by ints)
void print_arr(int arr[DIM][DIM]) {
	for(int i = 0; i < DIM; i++) {
		for( int j = 0; j < DIM; j++) {
			int value = arr[i][j];
			char c;
			if(value == 1) {
				c = '#';
			} else {
				c = ' ';
			}
			cout << c << " ";
		}
		cout << endl;
	}
	cout << endl;
} 


int main(int argc, char* argv[] ) {
	// Assume rule 30 and 200 generations if nothing else is stated
	int rule = 30;
	int gens = 200;
	if (argc > 1) {
		gens = atoi(argv[1]);
	}
	if (argc > 2) {
		rule = atoi(argv[2]);
	}
	// Seed the random number generator
	srand (time(0));
	
	// Set up the initial condition
	int initial[DIM][DIM];
	for(int i = 0; i < DIM; i++) {
		for(int j = 0; j < DIM; j++) {
			// Set up a random initial condition
			initial[i][j] = rand() % 1;
			
		}
	}
	
	// Loop all generations
	for(int i = 0; i < gens; i++) {
		// Print the current state
		print_arr(initial);
		// Sleep 0.5 seconds
		usleep(500000);
		// Clear the screen
		cout << "\033[2J";
		cout << "\033[0;0H";
		
		// The next state
		int next[DIM][DIM];
		// Loop the columns
		for(int j = 0; j < DIM; j++) {
			char state[10];
			// Loop the row
			for(int k = 0; k < DIM; k++) {
				state[0] = initial[ (j -1) % DIM ][ (k-1) % DIM ] + 48;
				state[1] = initial[ (j -1) % DIM ][k] + 48;
				state[2] = initial[ (j -1) % DIM ][ (k+1) % DIM ] + 48; 
				state[3] = initial[j][ (k-1) % DIM ] + 48;
				state[4] = initial[j][k] + 48 ;
				state[5] = initial[j][ (k+1) % DIM ] + 48; 
				state[6] = initial[ (j +1) % DIM ][ (k-1) % DIM ] + 48;
				state[7] = initial[ (j +1) % DIM ][k] + 48;
				state[8] = initial[ (j +1) % DIM ][ (k+1) % DIM ] + 48; 
				state[9] = '\0';
				next[j][k] = get_val_at_pos(to_int(state), rule);
			}
		}
		// Copy the matrix
		for(int j = 0; j < DIM; j++) {
			for(int k = 0; k < DIM; k++) {
				initial[j][k] = next[j][k];
			}
		}
	
	}
	
}
