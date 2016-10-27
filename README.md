# cellular-automaton
This is an implementation of 256 elementary cellular automatons: http://mathworld.wolfram.com/ElementaryCellularAutomaton.html

Usage:
```
./cellaut.pl <number of generations> <width> <rule number (0-255)> [num rules]
```
Example usage and output for rule 30:
```
./cellaut.pl 10 30 30
              ■
             ■■■
            ■■  ■
           ■■ ■■■■
          ■■  ■   ■
         ■■ ■■■■ ■■■
        ■■  ■    ■  ■
       ■■ ■■■■  ■■■■■■
      ■■  ■   ■■■     ■
     ■■ ■■■■ ■■  ■   ■■■
    ■■  ■    ■ ■■■■ ■■  ■
```
Example usage and output for rule 110:
```
./cellaut.pl 10 30 110
              ■
             ■■
            ■■■
           ■■ ■
          ■■■■■
         ■■   ■
        ■■■  ■■
       ■■ ■ ■■■
      ■■■■■■■ ■
     ■■     ■■■
    ■■■    ■■ ■
```
