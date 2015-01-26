#ifndef LIB1_H
#define LIB1_H
//#define _WIN


#ifdef _WIN
	#if defined(__MINGW32__) /* required for MinGW to link in getaddrinfo() */ 
		#define WINVER 0x0501 
	#endif 
	#define WIN32_LEAN_AND_MEAN
	#include <windows.h>  // HINSTANCE, LPSTR
	#include <winsock2.h> // SOCKET
	#include <ws2tcpip.h> // struct addrinfo
#endif
#include <iostream>   // cin/cout
#include <string>     // string
#include <sstream>    // stringstream
#include <iomanip>    // setfill, setw

#ifdef _WIN
#else
	#define SOCKET int
	#define INVALID_SOCKET 0
#endif

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




/*******************************
 * Fn declarations
 * Non-class specific
 */
// Encoding Helpers
string   _itos       (uint32_t i);
uint32_t _stoi       (string s);
string toHex         (const char* s, uint len, bool upper_case = false);
string toHex         (const string s, bool upper_case = false);
void   doSomething   ();

#endif