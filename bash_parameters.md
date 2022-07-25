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