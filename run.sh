#!/bin/bash

##
# Color Variables
##
red='\e[31m'
green='\e[32m'
blue='\e[34m'
clear='\e[0m'
# alexander.branitskiy@gmail.com
##
#Labs Variables
##
LAB4_FILE="outputs/lab4/lab4.sh"
##
# Color Functions
##
ColorGreen() {
    echo -ne "${green}$1${clear}"
}

ColorBlue() {
    echo -ne "${blue}$1${clear}"
}

# Header
function printHeader() {
    echo ""
    ColorGreen '========================================'
    echo ""
    ColorGreen "$1"
    echo ""
    ColorGreen '========================================'
    echo ""
}

##
# Lab Functions
##
function lab1() {
    printHeader "Lab 1: Java basic classes and features"
    echo "Objective:"
}

function lab1_tasks_menu() {
    echo " "
    echo -ne "
$(ColorBlue 'Lab 1 Tasks')
$(ColorGreen '[1] Task 1 ')
$(ColorGreen '[2] Task 2')
$(ColorGreen '[0] Main Menu') 
$(ColorBlue 'Please choose an option: ') "

    read -r option
    case $option in
    1)
        lab1_task1
        lab1_tasks_menu
        ;;
    2)
        lab1_task1
        lab1_tasks_menu
        ;;
    0)
        menu
        ;;
    *)
        echo -e "$(ColorRed 'Invalid option. Please try again.')"
        lab1_tasks_menu
        ;;
    esac
}

function lab1_task1() {
    echo ""
    printHeader "Lab 1: A Program to calculate maths expressions from given file"
    echo "Objective: To develop a console based program to take a file name and read and evalutae maths expressions and save the results."
    echo ""

    # run program
    java -cp labs/target/classes com.gm.lab1.Main "1"
}
function lab1_task2() {
    echo ""
    printHeader "Lab 1: A console java program designed to crack a zip archive with
dictionary search"
    echo "Objective: The program to crack local zip file created by the user, the program uses dictionary search from Github common credentials. THE CRACKED PASSWORD IS SAVED IN THE OUTPUST FOLDER."
    echo ""
    java -cp labs/target/classes com.gm.lab1.Main "2"
}

function lab2() {
    printHeader "Lab 2:"
}

function lab3() {
    printHeader "Lab 3:"
}

# Function to handle Lab 4 operations, including permission checks and running the Java program
function lab4() {
    if [ ! -e "$LAB4_FILE" ]; then
        touch "$LAB4_FILE"
        echo "free -h" >>"$LAB4_FILE"
    fi
    echo ""
    printHeader "Lab 4: Using a File Access Policy"
    echo "Objective: Understanding the organization of protection in the Java platform through access rights files."
    echo ""

    # Prompt the user for permission
    echo "$(ColorBlue 'Do you want to allow permissions? (Y/n): ') "
    read -r allow

    # Convert input to "allow" or "not allow"
    if [[ "$allow" == "n" || "$allow" == "N" ]]; then
        result="not allow"
    else
        result="allow"
    fi

    # Run the Java program with the result
    java -cp labs/target/classes com.gm.lab4.Main "$result"
    lab4_menu
}

# Function to write user input to the LAB4_FILE
function lab4_write() {
    ColorGreen 'Please enter the text or command you want to write: '
    read -r content
    echo -e "\n$content" >>"$LAB4_FILE"
}

# Function to read and display the contents of the LAB4_FILE
function lab4_read() {
    ColorGreen "Contents of $LAB4_FILE: "
    cat "$LAB4_FILE"
}

# Function to execute commands from the LAB4_FILE
function lab4_ex() {
    ColorGreen "Executing commands from $LAB4_FILE: "
    if [ -s "$LAB4_FILE" ]; then
        $LAB4_FILE
    else
        ColorRed 'The file is empty. Nothing to execute.'
    fi
}

# Function to display the menu and handle user options
function lab4_menu() {
    echo " "
    echo -ne "
$(ColorBlue 'Testing Order')
$(ColorGreen '[1] Test Write Rights')
$(ColorGreen '[2] Test Read Rights')
$(ColorGreen '[3] Test Execution Rights')
$(ColorGreen '[4] Test All Supported Rights')
$(ColorGreen '[0] Change Rights') 
$(ColorBlue 'Please choose an option: ') "
    read -r option
    case $option in
    1)
        lab4_write
        lab4_menu
        ;;
    2)
        lab4_read
        lab4_menu
        ;;
    3)
        lab4_ex
        lab4_menu
        ;;
    4)
        lab4_read
        lab4_write
        lab4_ex
        lab4_menu
        ;;
    0)
        lab4
        ;;
    *)
        echo -e "$(ColorRed 'Invalid option. Please try again.')"
        lab4_menu
        ;;
    esac
}

function lab5() {
    printHeader "Lab 5:"
    echo "Objective: Understand security organization in Java and work with permissions."
    echo ""
    echo "Work Order:"
    echo "1. Read the material from 'The Java Library Professional' (pages 775-793)."
    echo "2. Implement a class for permissions."
    echo ""
    echo "Work Progress:"
    echo "- Check access rights using SecurityManager and FilePermission."
    echo "- Example .policy file:"
    echo "  grant {"
    echo "      permission java.io.FilePermission \"/tmp/lab5.txt\", \"write\";"
    echo "  };"
    echo ""

    # Check for file
    FILE="/tmp/lab5.txt"
    if [ ! -e "$FILE" ]; then
        touch "$FILE"
    fi
    # Compile
    javac -d labs/target/classes labs/src/main/java/com/gm/lab5/*.java

    # Load policies and config
    java -Djava.security.manager \
        -Djava.security.policy=labs/target/classes/com/gm/lab5/.policy \
        -cp labs/target/classes com.gm.lab5.Main
}

function lab6() {
    printHeader "Lab 6: Creating a Registration Module"
    echo "Overview:"
    echo "In this lab, we created a registration module using the javax.security.auth library."
    echo "We explored the capabilities of the library, focusing on the LoginModule and CallbackHandler interfaces."
    echo ""

    # Compile
    javac -d labs/target/classes labs/src/main/java/com/gm/lab6/*.java

    # Load policies and config
    java -Djava.security.manager \
        -Djava.security.policy=labs/target/classes/com/gm/lab6/.policy \
        -Djava.security.auth.login.config=labs/src/main/java/com/gm/lab6/jaas.login.config \
        -cp labs/target/classes com.gm.lab6.Main
}

##
# Menu Function
##
function menu() {
    echo ""
    echo -ne "
$(ColorBlue '========================================')
$(ColorBlue 'Security Applications Labs')
$(ColorBlue '========================================')
$(ColorGreen '[1] Lab 1: Java basic classes and features')
$(ColorGreen '[4] Lab 4: Using a file access policy')
$(ColorGreen '[5] Lab 5: Implementation of new permissions')
$(ColorGreen '[6] Lab 6: Creating a registration module')
$(ColorGreen '[0] Exit') 
$(ColorBlue 'Choose an option: ') "
    read -r option
    case $option in
    1)
        lab1
        menu
        ;;
    4)
        lab4
        menu
        ;;
    5)
        lab5
        menu
        ;;
    6)
        lab6
        menu
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "${red}Wrong option.${clear}"
        menu
        ;;
    esac
}

# Start the menu
menu
