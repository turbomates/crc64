MIX = mix
CFLAGS = -g -O3 -Wall

ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS += -I$(ERLANG_PATH)
CFLAGS += -Ic_src
CC ?= $(CROSSCOMPILER)gcc
MIX ?= mix

ifneq ($(OS),Windows_NT)
	CFLAGS += -fPIC

	ifeq ($(shell uname),Darwin)
		LDFLAGS += -dynamiclib -undefined dynamic_lookup
	endif
endif

NIF_SRC=\
	src/crc64_iso.c\
	src/crc64_nif.c

.PHONY: all crc clean

priv/crc64_nif.so: $(NIF_SRC)
	$(CC) $(CFLAGS) -shared $(LDFLAGS) -o $@ $(NIF_SRC)

clean:
	$(MIX) clean
	rm -f priv/crc64.so src/*.o
