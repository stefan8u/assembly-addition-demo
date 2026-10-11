CC := gcc
CFLAGS := -Wall -Wextra -Werror
TARGET := build/add
SOURCE := src/add.s

.PHONY: all test clean

all: $(TARGET)

$(TARGET): $(SOURCE)
	mkdir -p build
	$(CC) $(CFLAGS) -o $@ $<

test: $(TARGET)
	python3 -m unittest discover -s tests -v

clean:
	rm -rf build
