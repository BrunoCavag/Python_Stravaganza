# Bash parameters every developer/data scientist should know

In the Bash world, a parameter refers to an element that programmers can use to store data during the script execution. Bash has three parameter types: variables, positional, and special parameters. Let’s discuss those parameter types with some practical examples — then, you can use them in your upcoming automation script!

## Using positional parameters in the script scope and function scope

There are several ways to get additional inputs to a particular Bash script. If we are writing a Shell script for humans, we can use the read built-in command to capture user inputs from the keyboard in a user-friendly way. We can use command-line arguments if we create DevOps or utility scripts that don’t require friendly user interactions during script execution. Positional parameters help us access the process arguments list in an indexed approach like argc in C.

```bash

#!/bin/bash

sum=$(($1 + $))
echo "sum = $sum"
```


The above code snippet uses arithmetic expansion for the first two positional arguments to get the summation. Similarly, the $n parameter refers to the nth command-line argument value. Inside a function, these positional parameters map with the function arguments, as shown in the following example code:

```bash

#!/bin/bash

function sum() {
    echo $(($1 + $2))
}

read -p "Enter num1: " n1
read -p "Enter num2: " n2

echo "sum = $(sum $n1 $n2)"

```


What if we need to handle dynamically-indexed parameters? Then, we can parse the entire argument list, either iterating through $@ or accessing every parameter via indirect expansion, as shown below.

```bash
#!/bin/bash
function parse_with_for_in() {
    for arg in "$@"
    do
        echo $arg
    done
}
function parse_with_expansion() {
    for ((i = 1; i <= $#; i++))
    do
        echo ${!i} # Indirect expansion syntax
    done
}
parse_with_for_in "$@"
echo "---"
parse_with_expansion "$@"
```

## Handling child processes with special parameters

Bash is a Shell interpreter program and a command language — so you can write most of your script logic without spawning child processes. For example, you can do string manipulations, array handling, and basic arithmetic operations within Bash, thanks to the well-known parameter expansion feature. However, we usually use Bash for developing utility programs and DevOps scripts, so using child processes is inevitable.

We execute other binaries via Bash sequentially, so Bash offers the$? parameter to get the recently terminated process’s exit code.

Bash also lets you run processes in the background with the & notation. What if you need to terminate the background command you’ve spawned before? The $! parameter returns the previous background command’s process identifier (PID). The following script opens gedit for five seconds:


```bash

#!/bin/bash
gedit &
sleep 5
kill $!
```


If you work with multiple background tasks, save the$! value in temporary variables. The $$ parameter returns the process identifier of the current Bash process. Inside sub-shells, it always returns the parent Bash process’s identifier. Some old bash scripts use $$ for unique temporary file creation, but it creates predictable temporary files and makes a vulnerability for attackers, so use the mktemp command for creating secure temporary files.

## Pre-Defined Variables That Help Us Debug Bash Scripts Productively

Many programmers use the echo command to debug Bash scripts as they use console.log in JavaScript debugging. This approach is undoubtedly more comfortable and fast for developing simple Bash scripts. But, if you process more data and execute many commands in a particular Bash script, this approach becomes time-consuming.

As many DevOps engineers know, we can execute the Bash interpreter process with the -x or -xv (verbose) flags to display the current command and code snippet, respectively. By default, Bash will show the + prefix with the present command string, as shown in the following preview:

```bash
#!/bin/bash -x
```

```bash
#!/bin/bash
green='tput setaf 2'
reset='tput sgr0'
PS4='$($green)Line: $LINENO -> $($reset)'
set -x
a=10
b=15
echo "a = $a"
echo "b = $b"
```

## Splitting strings like pythoin with the IFS variable

We often have to work with string-splitting tasks in Bash scripts. For example, in some scenarios, we will have to process CSV files by splitting each line with the comma character. Also, sometimes, we need to capture keyboard inputs with the read command according to an input mask. We can handle these scenarios easily with IFS (Internal Field Separator). IFS is an internal variable that instructs Bash separate word segments from strings.


The default value of the IFS variable is <space><tab><newline>, but you can edit it according to your needs and reset it back to the original. Let’s begin with a simple example. Assume that you want to ask the user to enter a serial number in theNN-NNNN format and save both masked segments in separate variables. By default, the read command handles inputs based on the default IFS, but we can indeed modify it as follows:


```bash

#!/bin/bash
IFS=-
read -p "Serial number (i.e., 12-2222): " seg1 seg2
echo "Segment 1: $seg1"
echo "Segment 2: $seg2"

```

## Retrieving Bash History in Terminal to boost productivity

Earlier, we discussed writing Shell scripts productively with some built-in pre-defined parameters. Let’s discuss some Bash notations that help work with the terminal faster. As you already know, Bash stores the command history in the ~/.bash_history file, and we can browse history records with the history command.

Bash offers some shortcuts to access the history records. For example, you can use the following notation to access previously entered commands:

```bash
!-1   # Previous command. Alias: !!
!-2   # Second command in history records
!-3   # Third command in history records
```


These are not built-in parameters — but a special syntax known as the history expansion. You can configure the history file with HISTSIZE, HISTTIMEFORMAT — like variables.

The $_ parameter is also helpful to get the last option of the previous command, so we can skip re-typing lengthy command options as follows:

```bash
touch long_file_name.sh
chmod +x $_

```