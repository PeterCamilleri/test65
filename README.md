# Test65

This is a simple program written to allow the testing of 65C02 code that
I am writing for the Commander X 16 neo-retro computer.

Note: This program has recently undergone a lot of upgrades and is now ready
to release as a Ruby gem.

## Installation

To install, first install the cc65 compiler and ensure that it is available at
the command line. You can test the required components with:

    ca65 --version
    ld65 --version
    sim65 --version
    set CC65_HOME

Then to install the gem, use:

    $ gem install test65

## Usage

    test65 - Run tests of 65c02 assembler code.

    Usage: test65 {options} {files}

    Options:
      --debug,   -d    Show (really) detailed debug info. Not normally required.
      --help, -h, -?   Display this message and exit.
      --list,    -l    Generate list files for each test.
      --map,     -m    Generate map files for each test.
      --keep,    -k    Keep object and output files. Do not clean up.
      --path,    -p    Specify the path to the test files. (Only 1 allowed)
      --quiet,   -q    Hide messages. Used to keep the test65 tests clean.
      --verbose, -v    Display lots of useful progress info.
      --version        Display the program version and exit.

    Files: An optional list of test files.

    Notes:
    - By default, test files are located in a folder called "t65" in the current
      folder or one of its parent folders.
    - Wildcards are allowed for files but not the path.
    - If no files are specified, then all files matching "t65*.a65" or "t65*.rb"
      in the test folder are tested.
    - If files are specified, only the specified file(s) are tested.

## Test Files

The test65 utility finds test files in one of two ways:

1. The test files can be listed explicitly on the command line.
2. Test files, of the appropriate extension, located in the test folder, are
"batch" run.

The tests are located in a test folder. This can be:

1. Explicitly named using the --path option. (See above)
2. Located in the t65 folder, either off of the current folder, or one of
its parent folders.

Test files can be:

1. Assembly files with a suffix of ".a65".
2. Ruby script files with a suffix of ".rb".

Future versions may support alternate extension types for assembler (like
".asm" for example) and tests written in the "C" language with extensions
of ".c65" and maybe ".c".

## Test Scripts in Ruby

The test65 gem uses Ruby scripts to allow for cases not handled by the
conventional defaults. The basic form of these scripts is:

```
# Minimum script to pass a test.

Test65.script do
  ca65 "min_pass.a65"
  ld65
  sim65
end
```

The order matters and is:

    assembly and compiling then linking then simulation

If the order is wrong, there will be errors.

### Assembly

Code is assembled using the _ca65_ statement. It is supported by the
_ca65\_inc\_paths_ method. They are:

```
ca65_inc_paths <path>, <optional more paths>, <etc>, <etc>, <etc>
ca65 "source_file", "optional options"
```

Where _ca65\_inc\_paths_ is used to tell the assembler where to find included
files and _ca65_ does the work of converting the source file to an
object file.

### Linking

Code is linked using the _ld65_ statement. It is supported by the
_ld65\_lib\_paths_ and _ld65\_libraries_. Here they are:

```
ld65_lib_paths "path to libraries", <etc>, <etc>, <etc>
ld65_libraries "library", <etc>, <etc>, <etc>
ld65 "optional options"
```

Where _ld65\_lib\_paths_ tells the linker where to find library files and
_ld65\_libraries_ specifies those libraries. After any ld65 method, no further
ca65* methods are permitted. After _ld65_ no further ld65* methods are
permitted either.

### Simulation

Finally, the simulation phase runs the actual tests. This is simply:

```
sim65 "optional options"
```

When this is done, no further test statements are permitted. However it is
possible to perform multiple tests in one script file. Simply code
multiple Test65.script { ... } blocks in the one Ruby script file. They
will be run one after another, in order.

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

OR...

* Make a suggestion by raising an
 [issue](https://github.com/PeterCamilleri/test65/issues)
. All ideas and comments are welcome.

## License

The gem is available as open source under the terms of the
[MIT License](./LICENSE.txt).

## Code of Conduct

Everyone interacting in the test65project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](./CODE_OF_CONDUCT.md).
