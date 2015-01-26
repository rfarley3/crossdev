#ifndef LIB1_CPP
#define LIB1_CPP

/***********************************************
 * lib1.cpp
 * see lib1.h for further doc 
 */




#include "lib1.h"




/*****************************************
 * Basic fns
 */
string _itos (uint32_t i) {
	char* i_ptr = (char *) &i;
	string s (i_ptr, sizeof (i) );
	return s;
} // end itos


// convert any length (up to 4) bytearray/string into a 4B uint
uint32_t _stoi (string s) {
	// make it 4B padded (but preserve value)
	while (s.length() < 4) {
		s += '\0';
	}
	return ((uint32_t*) s.c_str() )[0];
} // end itos


string toHex (const char* s, uint len, bool upper_case) {
	return toHex (string (s, len), upper_case);
} // end fn toHex


string toHex (string s, bool upper_case) {
    ostringstream ret;
    for (string::size_type i = 0; i < s.length(); i++) {
        ret << hex << setfill ('0') << setw (2) 
    	    << (upper_case ? uppercase : nouppercase) << (int) (s[i] & 0xff);
    	if (i < (s.length() - 1) ) {
			ret << " ";
		}
	}
    return ret.str();
} // end fn toHex


void doSomething () {
	cout << toHex ("Hello, world!") << endl;
	return;
} // end fn doSomething


#endif
