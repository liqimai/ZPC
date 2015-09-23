#ifndef __MEMORY_MANAGE_UNIT__
#define __MEMORY_MANAGE_UNIT__
class MemoryManageUnit
{
public:
	MemoryManageUnit(int m,int crtadr): size(m),CRTadr(crtadr),memory(new short[m]),refresh(false){
		for (int i = CRTadr; i < size; ++i)
		{
			memory[i]=0x20;
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
private:
	int size;
	int CRTadr;
	short* memory;
	bool refresh;
};
#endif