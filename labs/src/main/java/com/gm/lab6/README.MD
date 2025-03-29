# Lab 6: Creating a Registration Module

In this lab, we created a registration module using the `javax.security.auth` library. We explored the capabilities of the library, focusing on the `LoginModule` and `CallbackHandler` interfaces.

## 1. Ensure the Passwords File Exists

Before running the lab, you need to create the passwords file at `/tmp/lab6/passwords.txt`. Use the following command to create the directory and populate the file with sample credentials:

```bash
echo -e "bonch|bonch\nstudent|student" > /tmp/passwords.txt
```

## How to Run This Lab

### Option 1: Using the Run Script

1. Make the run script executable:

   ```bash
   sudo chmod +x run.sh
   ```

2. Execute the run script:

   ```bash
   ./run.sh
   ```

### Option 2: Manual Compilation and Execution

1. **Compile the Program**: Compile the Java files using the following command:

   ```bash
   javac -d labs/target/classes labs/src/main/java/com/gm/lab6/*.java
   ```

2. **Load Policies and Configuration**: Run the program with the necessary security policies and configuration:

   ```bash
   java -Djava.security.manager -Djava.security.policy=labs/target/classes/com/gm/lab6/.policy -Djava.security.auth.login.config=labs/src/main/java/com/gm/lab6/jaas.login.config -cp labs/target/classes com.gm.lab6.Main
   ```

## Conclusion

This lab provided hands-on experience with the `javax.security.auth` library, focusing on the implementation of a registration module. Ensure that you have the necessary permissions and configurations set up before running the lab.
