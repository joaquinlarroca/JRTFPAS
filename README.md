# JustRunTheFuckingPAS

A tiny wrapper that compiles a Free Pascal `.pas` file, runs the resulting binary, and cleans up afterwards. Ships with a bash script for Linux and a batch script for Windows.

## Requirements

- [Free Pascal Compiler](https://www.freepascal.org/) (`fpc`) available on your `PATH`.
  - **Linux:** install it natively (e.g. `sudo apt install fpc`).
  - **Windows:** `run.bat` uses [WSL](https://learn.microsoft.com/en-us/windows/wsl/install), so install fpc *inside* your WSL distribution.

## Usage

Put the runner script (`run.sh` or `run.bat`) in the same directory as your `.pas` files, then pass the base name of a Pascal source file (without the `.pas` extension):

```
my-project/
├── run.sh          # Linux runner
├── run.bat         # Windows runner
├── main.pas        # your Pascal file
└── hello.pas
```

### Linux

```bash
./run.sh main
```

### Windows

```bat
run.bat main
```

> Tip: you can call it without the extension/path too, e.g. `run.bat main` works from the folder where your files live.

## What the script does

1. Creates an `output/` directory.
2. Compiles `main.pas` with the flags `-FEoutput -Co -Cr -Miso -gl`.
3. Runs the generated binary `output/main`.
4. Deletes the `output/` directory afterwards.

### Example (Linux)

```bash
$ ./run.sh main
> fpc -FEoutput -Co -Cr -Miso -gl main.pas
Free Pascal Compiler version 3.2.2 [2024/07/26] for x86_64
...
Running main.pas...

Output:
hi
```

## Notes

- The `<filename>` argument is not optional. Running the script with no argument prints an error and the usage line.
- Compilation errors produce `Compilation failed.` on stderr and exit with status `1`.
- Only base names are used; paths and extension are inferred/implicit. Files are expected to be named `<filename>.pas` in the same directory as the runner.
- On Windows, the batch file delegates to WSL, so your `.pas` files and `run.bat` must be accessible from inside your WSL distribution.
