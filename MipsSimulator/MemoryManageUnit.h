#ifndef __MEMORY_MANAGE_UNIT__
#define __MEMORY_MANAGE_UNIT__
#include <windows.h>
#define WIDTH 40
#define HEIGHT 25
#define REFRESH_FREQUENCE 10
class MemoryManageUnit
{
public:
	MemoryManageUnit(int m,int crtadr): size(m),CRTadr(crtadr),memory(new short[m]), time(0){
		QueryPerformanceCounter(&start_time);
		QueryPerformanceFrequency(&frequency);/*获取CPU内部时钟频率*/
		for (int i = CRTadr; i < size; ++i)
		{
			memory[i]=' ';
		}
	};
	~MemoryManageUnit(){
		delete[] memory;
	}
	int lw(int adr);
	void sw(int adr, int dat);
	int lh(int adr);
	void sh(int adr, int dat);
	void print();
	bool refresh;
private:
	int size;
	int CRTadr;
	short* memory;
	LARGE_INTEGER start_time,stop_time,frequency;
	double time;
};
#endif