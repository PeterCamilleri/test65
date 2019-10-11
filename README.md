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
      --help, -h, -?   Display this message and exit.
      --version, -v    Display the program version and exit.
      --path, -p       Specify the path to the test files. (Only 1 allowed)
      --debug, -d      Display lots of useful progress info.

    Files: An optional list of test files.

    Notes:
    - By default, test files are located in a folder called "t65" in the current
      folder or one of its parent folders.
    - If no files are specified, then all files matching "t65*.a65" in the test
      folder are tested. Otherwise only the specified file(s) are tested.

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
