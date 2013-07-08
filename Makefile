CC?=		clang
AR?=		ar
INSTALL?=	install
PREFIX?=	/usr/local

all: mongoclient

mongoclient:
	mkdir build
	$(CC) -std=c99 -Wall -Werror -fPIC -Isrc -shared -o build/libbson.so src/bcon.c src/bson.c src/numbers.c src/encoding.c
	$(CC) -std=c99 -Wall -Werror -fPIC -Isrc -shared -o build/libmongocclient.so src/env.c src/bcon.c src/bson.c src/encoding.c src/gridfs.c src/md5.c src/mongo.c

clean:
	rm -Rf build

install:
	$(INSTALL) -m 755 -d $(PREFIX)/include/mongo-c
	$(INSTALL) -m 644 build/libbson.so $(PREFIX)/lib/
	$(INSTALL) -m 644 build/libmongocclient.so $(PREFIX)/lib/
	$(INSTALL) -m 644 src/bcon.h $(PREFIX)/include/mongo-c
	$(INSTALL) -m 644 src/bson.h $(PREFIX)/include/mongo-c
	$(INSTALL) -m 644 src/encoding.h $(PREFIX)/include/mongo-c
	$(INSTALL) -m 644 src/env.h $(PREFIX)/include/mongo-c
	$(INSTALL) -m 644 src/gridfs.h $(PREFIX)/include/mongo-c
	$(INSTALL) -m 644 src/md5.h $(PREFIX)/include/mongo-c
	$(INSTALL) -m 644 src/mongo.h $(PREFIX)/include/mongo-c

deinstall:
	rm -Rf $(PREFIX)/include/mongo-c
	rm -f $(PREFIX)/lib/libmongocclient.so
	rm -f $(PREFIX)/lib/libbson.so
