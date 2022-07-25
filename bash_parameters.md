# Bash parameters every developer/data scientist should know

In the Bash world, a parameter refers to an element that programmers can use to store data during the script execution. Bash has three parameter types: variables, positional, and special parameters. Let’s discuss those parameter types with some practical examples — then, you can use them in your upcoming automation script!

## Using positional parameters in the script scope and function scope

There are several ways to get additional inputs to a particular Bash script. If we are writing a Shell script for humans, we can use the read built-in command to capture user inputs from the keyboard in a user-friendly way. We can use command-line arguments if we create DevOps or utility scripts that don’t require friendly user interactions during script execution. Positional parameters help us access the process arguments list in an indexed approach like argc in C.

```bash

#! /bin/bash

sum=$(($1 + $))
echo "sum = $sum"
```


The above code snippet uses arithmetic expansion for the first two positional arguments to get the summation. Similarly, the $n parameter refers to the nth command-line argument value. Inside a function, these positional parameters map with the function arguments, as shown in the following example code:

```bash

#! /bin/bash

function sum() {
    echo $(($1 + $2))
}

read -p "Enter num1: " n1
read -p "Enter num2: " n2

echo "sum = $(sum $n1 $n2)"

```
