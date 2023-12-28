# Flutter RSA Cryptography App

This is a Flutter application that allows users to encrypt short messages using the RSA algorithm. Additionally, it offers features to generate new keys and manually add public keys.

**Note: This application is built solely for practice and study purposes. It is not recommended to use this app to encrypt real sensitive data.**

## Features

1. **RSA Encryption:**
   - Users can enter a short message and encrypt it using the RSA algorithm.
   - Encryption is performed based on a pair of keys (public/private).

2. **Key Generation:**
   - The application allows the generation of new RSA key pairs.
   - Users can generate keys and store them within the app.

3. **Add Public Keys:**
   - Users have the option to manually add public keys for use in message encryption.
   - Public keys added manually are saved locally within the app.

## How to Use

1. **Encrypt Messages:**
   - Select the appropriate keys (public/private).
   - Enter the message you want to encrypt.
   - Press the "Encrypt" button to generate the encrypted message.

2. **Generate New Keys:**
   - Tap "Generate Keys" to obtain a new RSA key pair.

3. **Add Public Keys:**
   - Tap "Add Public Key" to store it in the app.

## How to run

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/repository-name.git
   ```

2. Navigate to the project directory:

   ```bash
   cd repository-name
   ```

3. Run the application:

   ```bash
   flutter run
   ```

## License

This project is licensed under the [MIT License](LICENSE).