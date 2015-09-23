OBJS	= main.o MipsCPU.o MemoryManageUnit.o
EFILE	= MipsSimulator.exe
RM		= del
GCC		= g++

MipsSimulator : $(OBJS)
	$(GCC) $(OBJS) -o $(EFILE)

main.o: MipsCPU.h main.cpp
	$(GCC) main.cpp -c -Wall
MipsCPU.o: MipsCPU.h MipsCPU.cpp
	$(GCC) MipsCPU.cpp -c -Wall
MemoryManageUnit.o: MemoryManageUnit.h MemoryManageUnit.cpp
	$(GCC) MemoryManageUnit.cpp -c -Wall

.PHONY : clean
clean:
	$(RM) $(OBJS) $(EFILE)
