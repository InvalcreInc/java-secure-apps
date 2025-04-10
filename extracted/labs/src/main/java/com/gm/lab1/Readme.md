# Lab 1: Java Basic Classes and Features"

Objective: To explore fundamental Java concepts, including the creation and utilization of basic classes, object-oriented principles, and exception handling.

## Task 1: Calculate Math Expressions

Objective: Develop a console-based program that takes a file name, reads mathematical expressions from the file, evaluates them, and saves the results.

### 1.1 Create a `math.txt`

```bash
echo "1+1\n2*2\n16*74\n100*100">>labs/src/main/java/com/gm/lab1/math.txt
```

![alt text](image.png)

### 1.2 Run main and and 1 to run Task 1

![alt text](image-1.png)

### 1.3 Results `labs/src/main/java/com/gm/lab1/calculations.txt`

![alt text](image-2.png)

## Task 2: Crack a Zip Archive

A console-based Java program designed to crack a local zip file created by the user. The program uses a dictionary search from GitHub's common credentials. The cracked password will be saved in the output folder.

### 1.1 First lets grab a password from github's [10k-most-common password](https://raw.githubusercontent.com/danielmiessler/SecLists/refs/heads/master/Passwords/Common-Credentials/10k-most-common.txt)

![alt text](image-3.png)

### 1.2 Create a protected file with password previous section

```bash
zip -e labs/src/main/java/com/gm/lab1/task2.zip labs/src/main/java/com/gm/lab1/Readme.md
```
