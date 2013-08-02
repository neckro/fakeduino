# Fakeduino

This is a pretty simple build script I wrote to test some Arduino library code.  All it really does is replace the Arduino library includes with dummy versions that (mostly) do nothing.

A replacement digitalWrite() function (in pins_arduino.cpp) prints out the data sent on a certain pin in 8-bit chunks.  You probably want to replace this with your own version as appropriate.  If you send digitalWrite(-1, n) it will set the chunk offset, so that you can ignore writes that aren't part of your data (e.g. when initially setting the pin states).

Do whatever you want with this.  No license, no warranty, no problem.

## Usage

    fakeduino.sh mytestfile.cpp

This will (hopefully) build your file and run it.

The Fakeduino script will automatically include any external libraries you reference in the build.

I've been careful to make the fakeduino.sh script path-agnostic, so you can symlink the script wherever you want and it will still find the fake include files.

## Caveats

* This only implements the methods I needed for my own purposes.  It is not at all comprehensive.

* Right now this only works on plain .cpp files.  It would be relatively simply to implement a preprocessor to make it work with standard Arduino .ino files as well.

* For this to work in OSX, you need to have Xcode or some other version of gcc/g++ installed.

* I'm not terribly experienced with C++ outside the Arduino environment.  This is probably a pretty horrible implementation, but it worked for my purposes so I'm sharing it.
