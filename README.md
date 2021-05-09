# FuzzBizz
Use your functional tests to find crashes you did not expect !

# Warning

This tool is using fuzzing.
You may have undesirable outcomes if you use it with a program having the ability to create/modify/delete files or acting with the OS in any way.

I strongly suggest you to run this in a docker container.
I decline any responsability for any damage caused by this tool.

# Install

You will need [Radamsa](https://gitlab.com/akihe/radamsa) to be installed.

```bash
git clone https://github.com/alexandrefresnais/FuzzBizz
cd FuzzBizz
chmod +x fuzzbizz.sh
```

# Usage

To use this tool, you need a program taking inputs from stdin and a corpus of tests (normally your functional tests).

Create a folder to store the crashes found by the program.

Then run:
```
./fuzzbizz.sh <program> <tests folder> <crashes folder>
```

Fuzzbizz will tell you if it finds crashes and store the input that made your program crash in the crashes folder.
