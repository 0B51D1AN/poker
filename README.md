Compilation Instructions:


Julia
 
Enter Juila IDE by typing "juila" inside the terminal. Install the CSV packages by typing in the command: import pkg; Pkg.add("CSV")
-Library should now be updated.
-Run program now by writing "julia poker.jl" (include any testhand you would like by including the file path after the program call)

Go
- Run program by running the executable: "./go" (include any testhand you would like by including the file path after the program call)

Perl
Installing dependencies:
    -If CPAN is installed, run "cpan Text::CSV" to install neede dependencies
        -NOTE You can find perl modules in the CPAN website: https://metacpan.org
    -If CPAN is not provided, dependencies have been manually included within dependencies/ folder.
        - Within ExtUtils folder, run the following commands: 
        perl Makefile.PL
        make
        make test
        make install
        -Then do the same in the Text-CSV folder (Text-CSV requires some items from ExtUtils)
        - You will need read/write permissions to '/usr/local/bin' in order to install
Once dependencies are installed, simply run executable ./main.pl (include any testhand you would like by including the file path after the program call)


Rust

- Simply enter the src folder, and type "cargo run" in the terminal (include any testhand you would like by including the file path after the program call)