# Lab 7: Java File Signature

A digital signature is a unique string of bits generated from specific data (referred to as "signed" data) and the private key of an entity (such as a person or organization). Similar to a handwritten signature, a digital signature possesses several important characteristics:

- **Authenticity Verification**: The authenticity of a digital signature can be verified using a computation that involves the public key corresponding to the private key used to create the signature.
- **Tamper Resistance**: The signature cannot be altered, provided that the private key is kept secure.
- **Data Integrity**: The signature is a function of the signed data, meaning it cannot be considered valid for any other data.
- **Immutable Signed Data**: If the signed data is modified in any way, the signature will no longer be valid.

A certificate is a digitally signed statement from one entity asserting that the public key of another entity has a specific meaning.

## Work

### 1. Create a JAR File

First, compile the Java source file into the target directory:

```bash
javac -d labs/target/classes labs/src/main/java/com/gm/lab7/Main.java
```

Next, create a JAR file containing the compiled class:

```bash
jar cf labs/src/main/java/com/gm/lab7/Main.jar labs/target/classes/com/gm/lab7/Main.class
```

### 2. Generate a Key Pair

Generate a key pair using the following command:

```bash
keytool -genkeypair -alias lab7 -keyalg RSA -keysize 2048
```

![Key Pair Generation](/screenshots/lab7/image-1.png)

List the keys in your keystore to verify:

```bash
keytool -list
```

![List of Keys](/screenshots/lab7/image.png)

Generate a certificate request for the key pair:

```bash
keytool -certreq -alias lab7
```

![Certificate Request](/screenshots/lab7/image-3.png)

### 3. Sign `Main.jar`

Sign the JAR file using the generated key pair:

```bash
jarsigner labs/src/main/java/com/gm/lab7/Main.jar lab7
```

![Signing Process](/screenshots/lab7/image-2.png)

### 4. Create a Signed JAR

To create a signed JAR file, use the following command:

```bash
jarsigner -signedjar labs/src/main/java/com/gm/lab7/MainSigned.jar labs/src/main/java/com/gm/lab7/Main.jar lab7
```

![Signed JAR File](/screenshots/lab7/image-4.png)

![JAR Files Overview](/screenshots/lab7/image-5.png)
