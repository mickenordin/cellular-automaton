# include <iostream>
# include <cmath>
# include <bitset>

using namespace std;

const int DIM = 11;
const int HALF = DIM / 2;
const int NUM_RULES = 256;
static const int BITS = floor(log(NUM_RULES)/log(2)) + 1;

string to_bin(int x) {
	char bits[BITS +1];
	for (int i = 0; i < BITS; i++) {
	
		bits[i] = char (x & (1 << i) ? 1 : 0);
	}
	const char* str = bits;
	string s = str;
	return s;
}

int main() {
	int initial[DIM][DIM];
	int rules[NUM_RULES];
	for(int i = 0; i < NUM_RULES; i++) {
		rules[i] = i;	
		cout << to_bin(i) << endl;
	}

	for(int i = 0; i < DIM; i++) {
		for(int j = 0; j < DIM; j++) {
			if(i == HALF && j == HALF) {
				initial[i][j] = 1;
			} else {
				initial[i][j] = 0;
			}
			
		}
	}
	
}
