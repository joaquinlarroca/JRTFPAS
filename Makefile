FPC = fpc
FLAGS = -Co -Cr -Miso -gl
TARGET = $(F)
SRC = $(F).pas

.PHONY: all

all: $(TARGET)

$(TARGET): $(SRC)
	$(FPC) $(FLAGS) $(SRC)

clean:
	rm -f $(TARGET) *.o

run: all
	./$(TARGET)
