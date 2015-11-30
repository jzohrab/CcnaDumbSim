# CCNA Simple Simulator

A dead-simple Ruby simulator for practicing CCNA configurations.
This is _by no means_ a complete simulation package.

The "simulation" runs by reading in a text file (in the questions subdirectory),
and, when a line matches a router/switch configuration prompt, it asks the
user to supply the command.  This input is compared with the text file content.
Note that this is _extremely simple_ and _opinionated_ - if your input doesn't
match the expected content, it is marked as incorrect.

While there is other simulation software available (Packet Tracer, GNS3, etc),
I often want to focus only on the configuration commands, and to run through them
very quickly.

Currently only tested on MacOSX.

## Installation

You should have Ruby installed.  Download this to a new directory, or clone the
repo.  This reads local text files only, so there's nothing to install or
configure.

## Usage

Type `$ ruby sim.rb`, choose a question, and then follow the prompts.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D
