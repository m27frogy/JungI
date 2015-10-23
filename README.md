# JungI (Yoong-ee)

```
JungI - A simple program for taking open source personality tests.
Copyright (C) 2015  Mfrogy Starmade

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```

> Disclaimer: I am not a psychologist!

## Goals
1.	Provide a cross-platform way to take standardized Public Domain personality tests.
2.	To reduce outside dependencies to a minimum.
3.	To provide both a CLI(Command Line Interface) and a GUI(Graphical User Interface) as usable interfaces.

## Supports
* Open Extended Jungian Types (OEJTS) 1.2
* IPIP Big-Five Broad Domain 50 Questions
* IPIP Big-Five Broad Domain 100 Questions
* Delroy L. Paulhus' Short Dark Triad (SD3)
* Delroy L. Paulhus' Spheres of Control Version 3 (SOC3)

## Usage
 ```
Usage: jungi-cli [options]

Tests:
    -b, --big                        Use IPIP Big Five Broad 50 test
    -B, --bigger                     Use IPIP Big Five Broad 100 test
    -c, --control                    Use Delroy L. Paulhus' SOC3
    -j, --jungian                    Use OEJTS 1.2 test
    -t, --triad                      Use Delroy L. Paulhus' SD3

Modifiers:
    -r, --randomize                  Automatically fills in random answers

Common options:
    -h, --help                       Display this help and exit
```
