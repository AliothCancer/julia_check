A terminal command that watches for "last modified date" for the module file in your julia project and run `report_packages()` function from JET analisys package.
![immagine](https://github.com/user-attachments/assets/b8c2c286-cf7b-4491-a99d-985498af1d26)

So JET analisys will be triggered every time the target file is saved.

## Installation
1. Put `julia_check.jl` in a dir that is inside PATH env (i.e. `$HOME/.local/bin`)
2. Make sure the first line of julia_check.jl is `#!{your julia binary location}`

## Usage
1. IMPORTANT: Goto the directory of a julia project
2. Run in a terminale run the command
```
julia_check.jl src/{pkg_name}.jl
```

NOTE: this script run `clear` to clear the terminal screen in order to display only the latest errors
