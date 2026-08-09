# JustRunTheFuckingPAS

A tiny wrapper that compiles a Free Pascal `.pas` file, runs the resulting binary, and cleans up afterwards. Ships with a bash script for Linux, a batch script for Windows, and a unified `Makefile` that works on both platforms.

## Requirements

- [Free Pascal Compiler](https://www.freepascal.org/) (`fpc`) available on your `PATH`.
  - **Linux:** install it natively (e.g. `sudo apt install fpc`).
  - **Windows:** the wrappers use [WSL](https://learn.microsoft.com/en-us/windows/wsl/install), so install fpc *inside* your WSL distribution.
- [GNU Make](https://www.gnu.org/software/make/) for the `Makefile`.
  - **Linux:** install it natively (e.g. `sudo apt install make`).
  - **Windows:** no need to install it natively — run it through WSL (see below).

## Usage

Put the runner (`run.sh`, `run.bat`, or `Makefile`) in the same directory as your `.pas` files, then pass the base name of a Pascal source file (without the `.pas` extension):

```
my-project/
├── Makefile         # unified runner (Linux + Windows via WSL)
├── run.sh           # Linux runner
├── run.bat          # Windows runner
└── hello_world.pas  # your Pascal file
```

### Linux

```bash
./run.sh hello_world
```

### Windows

```bat
run.bat hello_world
```

> Tip: you can call it without the extension/path too, e.g. `run.bat hello_world` works from the folder where your files live.

### Makefile (Linux and Windows)

```bash
# Linux
make run F=hello_world

# Windows (runs inside your WSL distribution)
wsl make run F=hello_world
```

> The Makefile is a unified replacement for both scripts. On Windows it must run inside WSL because `fpc` and bash live there — GNU Make itself does not need to be installed on Windows.

## What the scripts do

1. Creates an `output/` directory.
2. Compiles `hello_world.pas` with the flags `-FEoutput -Co -Cr -Miso -gl`.
3. Runs the generated binary `output/hello_world`.
4. Deletes the `output/` directory afterwards.

The `Makefile` performs the same steps. Running `make run` without `F` prints an error and the usage line.

### Example (Linux)

```bash
$ ./run.sh hello_world
> fpc -FEoutput -Co -Cr -Miso -gl hello_world.pas
Free Pascal Compiler version 3.2.2 [2024/07/26] for x86_64
...
Running hello_world.pas...

Output:
Hello, World!
```

The Makefile output is identical (minus the echoed `fpc` command):

```bash
$ make run F=hello_world
Free Pascal Compiler version 3.2.2 [2024/07/26] for x86_64
...
Running hello_world.pas...

Output:
Hello, World!
```

## Notes

- The `<filename>` argument is not optional. Running the script with no argument prints an error and the usage line.
- Compilation errors produce `Compilation failed.` on stderr and exit with status `1`.
- Only base names are used; paths and extension are inferred/implicit. Files are expected to be named `<filename>.pas` in the same directory as the runner.
- The Makefile takes the filename via `make run F=<filename>` rather than a positional argument.
- GNU Make exits with status `2` when a recipe fails (the scripts exit with status `1` on compilation errors).
- On Windows, the batch file and the `wsl make` command delegate to WSL, so your `.pas` files and the runner must be accessible from inside your WSL distribution.
