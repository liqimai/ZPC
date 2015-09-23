OBJS	= main.o MipsCPU.o MemoryManageUnit.o
EFILE	= MipsSimulator.exe
RM		= del
GCC		= g++

MipsSimulator : $(OBJS)
	$(GCC) $(OBJS) -o $(EFILE)

main.o: MipsCPU.h
MipsCPU.o: MipsCPU.h
MemoryManageUnit.o: MemoryManageUnit.h

.PHONY : clean
clean:
	$(RM) $(OBJS) $(EFILE)
