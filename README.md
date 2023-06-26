# Code and App Sandboxes

This is a small effort to create an isolated development environment which only 
has access to minimum possible directories and files with as less permissions as possible.

It also sandboxes Mullvad Browser and Tor Browser from the rest of your system in an attempt
to mitigate a browser sandbox vulnerability

There is also a `build-sandbox` which can be used to isolate the entirety of your various compilers
and build systems from the rest of your system

It uses bubblewrap underneath for isolating your shell from the rest of the system.

# Credits

Thanks to bubblewrap for making a good security tool

Thanks a lot to [Manmeet Singh](https://github.com/maan2003) who did almost all the legwork
to think of the best way to break out of this sandbox and patch up holes he found.

The script has been slightly modified from his hard work with my tweaks and packaged as a Nix flake
