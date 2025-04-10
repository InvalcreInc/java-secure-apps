#!/bin/bash

##
# Color Variables
##
red='\e[31m'
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

##
#Labs Variables
##
LAB4_FILE="labs/src/main/java/com/gm/lab4/lab4.sh"

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
    printHeader "Lab 1: Java Basic Classes and Features"
    echo "Objective: To explore fundamental Java concepts, including the creation and utilization of basic classes, object-oriented principles, and exception handling."
    lab1_tasks_menu
}

function lab1_tasks_menu() {
    echo " "
    echo -ne "
$(ColorBlue 'Lab 1 Tasks')
$(ColorGreen '[1] Task 1: Calculate Math Expressions')
$(ColorGreen '[2] Task 2: Crack a Zip Archive')
$(ColorGreen '[0] Main Menu') 
$(ColorBlue 'Please choose an option: ') "

    read -r option
    case $option in
    1)
        lab1_task1
        lab1_tasks_menu
        ;;
    2)
        lab1_task2
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
    printHeader "Task 1: Calculate Math Expressions"
    echo "Objective: Develop a console-based program that takes a file name, reads mathematical expressions from the file, evaluates them, and saves the results."
    echo ""

    # Run the program for Task 1
    java -cp labs/target/classes com.gm.lab1.Main "1"
}

function lab1_task2() {
    echo ""
    printHeader "Task 2: Crack a Zip Archive"
    echo "Objective: Create a console-based Java program designed to crack a local zip file created by the user. The program uses a dictionary search from GitHub's common credentials. The cracked password will be saved in the output folder."
    echo ""

    # Run the program for Task 2
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

function lab7() {
    printHeader "Lab 7: Java File Signature"
    echo "Objective: To understand digital signatures and how to sign JAR files."

    lab7_tasks_menu
}

function lab7_tasks_menu() {
    echo " "
    echo -ne "
$(ColorBlue 'Lab 7 Tasks')
$(ColorGreen '[1] Create JAR file')
$(ColorGreen '[2] Generate key pair')
$(ColorGreen '[3] Sign JAR file')
$(ColorGreen '[0] Main Menu') 
$(ColorBlue 'Please choose an option: ') "

    read -r option
    case $option in
    1)
        lab7_create_jar
        lab7_tasks_menu
        ;;
    2)
        lab7_generate_keypair
        lab7_tasks_menu
        ;;
    3)
        lab7_sign_jar
        lab7_tasks_menu
        ;;
    0)
        menu
        ;;
    *)
        echo -e "$(ColorRed 'Invalid option. Please try again.')"
        lab7_tasks_menu
        ;;
    esac
}

function lab7_create_jar() {
    echo ""
    printHeader "Creating JAR File"
    echo "Compiling and creating the JAR file..."
    javac -d labs/target/classes labs/src/main/java/com/gm/lab7/Main.java
    jar cf labs/src/main/java/com/gm/lab7/Main.jar labs/target/classes/com/gm/lab7/Main.class
    echo "JAR file created successfully: labs/src/main/java/com/gm/lab7/Main.jar"
}

function lab7_generate_keypair() {
    echo ""
    printHeader "Generating Key Pair"
    echo "Generating a key pair for signing..."
    echo "Enter Alias: "
    read -r alias
    keytool -genkeypair -alias $alias -keyalg RSA -keysize 2048
    echo "Key pair generated successfully."
}

function lab7_sign_jar() {
    echo ""
    printHeader "Signing JAR File"
    echo "Enter Alias: "
    read -r alias
    echo "Signing the JAR file..."
    jarsigner -keystore /path/to/your/keystore -storepass your_storepass -keypass your_keypass labs/src/main/java/com/gm/lab7/Main.jar lab7
    echo "JAR file signed successfully."
}

function lab8() {
    echo ""
    printHeader "Lab 8: Java File Signature Verification"
    echo ""
    echo "To gain an understanding of the security organization in the Java platform by verifying the signatures of JAR files."

    # Task 1
    echo ""
    ColorGreen "[*] Running task 1:  Verify Unsigned JAR."
    echo ""
    jarsigner --verify labs/src/main/java/com/gm/lab7/Main.jar

    # Task 2
    echo ""
    ColorGreen "[*] Running task 2:  Verify Signed JAR."
    echo ""
    jarsigner --verify labs/src/main/java/com/gm/lab7/MainSigned.jar
    echo ""

}

function lab9() {
    echo ""
    printHeader "Lab 9: Request for a certificate"
    echo ""
    echo "In this lab, you will go through the process of generating a key pair, creating a Certificate Signing Request (CSR), exporting a self-signed certificate, importing a signed certificate (or root/intermediate certificate), and viewing certificate information using the keytool utility provided by the Java Development Kit (JDK). This hands-on experience will help you understand the steps involved in managing SSL/TLS certificates, which are crucial for securing web applications and services"

    # Task 1
    echo ""
    ColorGreen "[*] Running task 1:  Generating a key pair."
    echo ""
    keytool -genkeypair -alias lab9 -keyalg RSA -keysize 2048 -keystore labs/src/main/java/com/gm/lab9/labkeys.jks

    # Task 2
    echo ""
    ColorGreen "[*] Running task 2:  Generating a Request for an Existing Private Key."
    echo ""
    keytool -certreq -alias lab9 -file labs/src/main/java/com/gm/lab9/lab9.csr -keystore labs/src/main/java/com/gm/lab9/labkeys.jks
    echo ""

    # Task 3
    echo ""
    ColorGreen "[*] Running task 3: Export the Self-Signed Certificate."
    echo ""
    keytool -exportcert -alias lab9 -keystore labs/src/main/java/com/gm/lab9/labkeys.jks -file labs/src/main/java/com/gm/lab9/lab9.crt
    echo ""

    # Task 4
    echo ""
    ColorGreen "[*] Running task 4: Importing Signed/Root/Intermediate Certificate."
    echo ""
    keytool -importcert -trustcacerts -file labs/src/main/java/com/gm/lab9/lab9.crt -alias lab9_imported -keystore labs/src/main/java/com/gm/lab9/labkeys.jks
    echo ""

    # Task 5
    echo ""
    ColorGreen "[*] Running task 5:  Using Keytool to View Certificate Information."
    echo ""
    keytool -printcert -file labs/src/main/java/com/gm/lab9/lab9.crt
    echo ""
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
$(ColorGreen '[7] Lab 7: Java File Signature')
$(ColorGreen '[8] Lab 8: Java File Signature Verification')
$(ColorGreen '[9] Lab 9: Lab 9 Request for a certificate')
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
    7)
        lab7
        menu
        ;;
    8)
        lab8
        menu
        ;;
    9)
        lab9
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
