# Test65

This is a simple program written to allow the testing of 65C02 code that
I am writing for the Commander X 16 neo-retro computer.

## Installation

This gem is too specialized to place in a Ruby Gem repository so the normal
use cases for installing and using this gem do not apply. To install, first
install the cc65 compiler and ensure that it is available at the command line.
You can test the required components with:

    ca65 --version
    ld65 --version
    sim65 --version
    set CC65_HOME

The last test should show the variable is set to the cc65 program folder.

Then download the Test65 repo (or at least the one file you will need) and
then install the gem directly from the pkg folder like this:

    $ gem install pkg/test65-0.1.0.gem

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
2. Test files, of the appropriate extension, located in the test folder are
"batch" run.

The tests are located in a test folder. This can be:

1. Explicitly named using the --path option. (See above)
2. Located in the t65 folder, either off of the current folder, or one of
its parent folders.

Test files can be:

1. Assembly files with a suffix of ".a65".
2. Ruby script files with a suffix of ".rb".

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
