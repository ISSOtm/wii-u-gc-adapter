CFLAGS  += -Wall -Wextra -pedantic -Wno-format -std=c99 $(shell pkg-config --cflags libusb-1.0) $(shell pkg-config --cflags udev)
LDFLAGS += -lpthread -ludev $(shell pkg-config --libs libusb-1.0) $(shell pkg-config --libs udev)

DESTDIR ?= /usr/local

ifeq ($(DEBUG), 1)
	CFLAGS += -O0 -g
	LDFLAGS += -g
else
	CFLAGS += -O2
	LDFLAGS += -s
endif

TARGET = wii-u-gc-adapter
OBJS = wii-u-gc-adapter.o

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)

all: $(TARGET)
.PHONY: all

clean:
	rm -f $(TARGET)
	rm -f $(OBJS)
.PHONY: clean

install: $(TARGET)
	install -Dm 755 -t $(DESTDIR)/usr/bin $<
	install -Dm 644 -t $(DESTDIR)/usr/lib/udev/rules.d 63-wii-u-gc-adapter.rules
	install -Dm 644 -t $(DESTDIR)/usr/lib/systemd/system wii-u-gc-adapter.service
	install -Dm 644 -t $(DESTDIR)/usr/share/X11/xorg.conf.d 51-ignore-gc-controllers.conf
.PHONY: install
