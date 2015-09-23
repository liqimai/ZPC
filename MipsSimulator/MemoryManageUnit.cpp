#include "MemoryManageUnit.h"
#include <windows.h>
using namespace std;
int MemoryManageUnit::lw(int adr)	//Big_Endian
	{
		return ((int)memory[adr]<<16)|((int)memory[adr+1]&0xFFFF); 
	}
void MemoryManageUnit::sw(int adr, int dat)
	{
		memory[adr+0]=(short)(dat>>16);
		memory[adr+1]=(short)(dat&0xFFFF);
		if(adr >= CRTadr-1)
			refresh=true;
	}
int MemoryManageUnit::lh(int adr)
	{
		return memory[adr];
	}
void MemoryManageUnit::sh(int adr, int dat)
	{
		memory[adr]=(short)(dat&0xFFFF);
		if(adr>=CRTadr)
			refresh=true;
	}
void MemoryManageUnit::print(){
	if(refresh){
		char c;
		COORD coord = {0, 0};
		HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
		char dis[3] = "  ";
		short ch;
		for (int i = 0; i < 999; ++i)
		{
			ch = memory[i + CRTadr];
			if ( ch & 0xFF00 ){
				int q,w;
				q = (ch - 0x2000)/94;
				w = (ch - 0x2000)%94;
				dis[0] = q + 0xA1;
				dis[1] = w + 0xA1;
			}
			else {
				dis[0] = ch;
			}
			coord.Y = i / 40;
			coord.X = (i % 40)*2;
		    WriteConsoleOutputCharacter(hOut, dis, 2, coord, NULL);
		}
	}
	refresh = false;
}