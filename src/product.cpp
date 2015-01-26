#ifndef PRODUCT_CPP
#define PRODUCT_CPP
//#define _WIN

#ifdef _WIN
	#if defined(__MINGW32__) /* required for MinGW to link in getaddrinfo() */ 
		#define WINVER 0x0501 
	#endif 
	#define WIN32_LEAN_AND_MEAN
	#include <windows.h>  // HINSTANCE, LPSTR
#endif
//#include <thread>     // thread
#include <iostream>   // cin/cout
//#include <string>     // string
//#include <fstream>    // ofstream, ifstream
//#include <vector>     // vector<char>

#ifdef _WIN
#else
	#define LPDWORD long unsigned int*
	#define DWORD   long unsigned int
	#define BOOL    bool
	#define TRUE    1
	#define FALSE   0
#endif
#define uint unsigned int

using namespace std;




#include "lib1.h"




/*******************************
 * Fn declarations
 * Non-class specific
 */
#ifdef _WIN
int main ();
#endif




/*******************************
 * Main code
 */
// win32 wrapper
#ifdef _WIN
int WinMain (HINSTANCE hInstance,
             HINSTANCE hPrevInstance,
	         LPSTR     lpCmdLine,
	         int       cmdShow) {

	return main ();
} // end fn WinMain
#endif


int main () {
	doSomething ();
	return 0;
} // end fn main


#endif
