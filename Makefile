OS = LINUX
PKGS = \
    --pkg gio-2.0 \
    --pkg gee-1.0 \
    --pkg gl \
    --pkg glu \
    --pkg gsl \
    --pkg sdl \
    --pkg sdl-image \
    --pkg sdl-mixer
LIBS = \
    -X -lSDL_image \
    -X -lSDL_mixer
FLAGS = -g --vapidir=vapi
FILES = \
    src/darkcore/collision.vala \
    src/darkcore/engine.vala \
    src/darkcore/event.vala \
    src/darkcore/keystate.vala \
    src/darkcore/log.vala \
    src/darkcore/sprite/text.vala \
    src/darkcore/sprite.vala \
	src/darkcore/texture.vala \
    src/darkcore.vala \
    src/darkcore/vector.vala \
    src/main.vala \
    src/gamestat.vala \
    src/game.vala \
    src/ship.vala \
    src/plasma.vala \
    src/exp.vala
  



all: $(FILES)
	valac $(FLAGS) $(PKGS) $(LIBS) -o main $(FILES)
	./main

clean:
	find . -type f -name "*.so" -exec rm -f {} \;
	find . -type f -name "*.a" -exec rm -f {} \;
	find . -type f -name "*.o" -exec rm -f {} \;
	find . -type f -name "*.h" -exec rm -f {} \;
	find . -type f -name "*.c" -exec rm -f {} \;
	rm main

