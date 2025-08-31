import FirebaseAuth
import Foundation

class FirebaseService {
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        print("Attempting to sign up with email: \(email)")
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Sign-up error: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Sign-up successful for user: \(authResult?.user.email ?? "Unknown")")
                completion(.success(()))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        print("Attempting to log in with email: \(email)")
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Login successful for user: \(authResult?.user.email ?? "Unknown")")
                completion(.success(()))
            }
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        print("Attempting to reset password for email: \(email)")
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Reset password error: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Reset password email sent successfully")
                completion(.success(()))
            }
        }
    }
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            print("Delete account error: No user is currently signed in")
            completion(.failure(NSError(domain: "NoUser", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is signed in."])))
            return
        }

        print("Attempting to delete account for user: \(user.email ?? "Unknown")")
        user.delete { error in
            if let error = error {
                print("Delete account error: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Account deleted successfully")
                completion(.success(()))
            }
        }
    }
}
