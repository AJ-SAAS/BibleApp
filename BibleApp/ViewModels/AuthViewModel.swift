import Foundation
import Combine
import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isAuthenticated: Bool = false
    @Published var isGuest: Bool = false

    private let firebaseService: FirebaseService

    init(firebaseService: FirebaseService = FirebaseService()) {
        self.firebaseService = firebaseService
    }

    func signUp(email: String, password: String, authState: AuthenticationState) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            print("Validation failed: Empty email or password")
            return
        }
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters."
            print("Validation failed: Password too short")
            return
        }
        
        errorMessage = nil
        print("Starting sign-up process for email: \(email)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            guard self?.isAuthenticated == false else { return }
            self?.errorMessage = "Request timed out. Please check your network and try again."
            print("Sign-up timed out after 10 seconds")
        }
        
        firebaseService.signUp(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("AuthViewModel: Sign-up successful, updating isAuthenticated for navigation to OnboardingQuestionsView")
                    self?.isAuthenticated = true
                    authState.updateAuthenticationState(isAuthenticated: true, isGuest: false)
                    // Navigation to OnboardingQuestionsView is handled in AuthView
                case .failure(let error):
                    print("AuthViewModel: Sign-up failed with error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func login(email: String, password: String, authState: AuthenticationState) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            print("Validation failed: Empty email or password")
            return
        }
        
        errorMessage = nil
        print("Starting login process for email: \(email)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            guard self?.isAuthenticated == false else { return }
            self?.errorMessage = "Request timed out. Please check your network and try again."
            print("Login timed out after 10 seconds")
        }
        
        firebaseService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("AuthViewModel: Login successful, updating isAuthenticated")
                    self?.isAuthenticated = true
                    authState.updateAuthenticationState(isAuthenticated: true, isGuest: false)
                case .failure(let error):
                    print("AuthViewModel: Login failed with error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func continueAsGuest(authState: AuthenticationState) {
        errorMessage = nil
        isGuest = true
        authState.updateAuthenticationState(isAuthenticated: false, isGuest: true)
        print("AuthViewModel: Continuing as guest")
    }

    func resetPassword(email: String) {
        guard !email.isEmpty else {
            errorMessage = "Please enter an email address."
            print("Validation failed: Empty reset email")
            return
        }
        
        errorMessage = nil
        print("Starting reset password process for email: \(email)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            guard self?.errorMessage == nil else { return }
            self?.errorMessage = "Request timed out. Please check your network and try again."
            print("Reset password timed out after 10 seconds")
        }
        
        firebaseService.resetPassword(email: email) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("AuthViewModel: Reset password email sent")
                    self?.errorMessage = "Password reset email sent successfully."
                case .failure(let error):
                    print("AuthViewModel: Reset password failed with error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func resetFields() {
        errorMessage = nil
    }

    func deleteAccount(authState: AuthenticationState, completion: @escaping (Result<Void, Error>) -> Void) {
        guard !isGuest else {
            errorMessage = "Guest accounts cannot be deleted."
            print("Delete account failed: Attempted to delete guest account")
            completion(.failure(NSError(domain: "GuestAccount", code: -1, userInfo: [NSLocalizedDescriptionKey: "Guest accounts cannot be deleted."])))
            return
        }

        errorMessage = nil
        print("Starting account deletion process")

        firebaseService.deleteAccount { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("AuthViewModel: Account deletion successful, updating auth state")
                    authState.updateAuthenticationState(isAuthenticated: false, isGuest: false)
                    self?.resetFields()
                    completion(.success(()))
                case .failure(let error):
                    print("AuthViewModel: Account deletion failed with error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                    completion(.failure(error))
                }
            }
        }
    }
}
