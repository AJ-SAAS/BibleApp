import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authState: AuthenticationState
    @StateObject private var viewModel = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isSignUp: Bool = true
    @State private var showingResetPassword: Bool = false
    @State private var resetEmail: String = ""
    @State private var isProcessing: Bool = false

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    VStack(spacing: geometry.size.width > 600 ? 24 : 20) {
                        LogoView(geometry: geometry)
                        FormView(
                            geometry: geometry,
                            email: $email,
                            password: $password,
                            confirmPassword: $confirmPassword,
                            isSignUp: isSignUp,
                            errorMessage: viewModel.errorMessage
                        )
                        ActionButtonsView(
                            geometry: geometry,
                            isSignUp: isSignUp,
                            isProcessing: isProcessing,
                            email: email,
                            password: password,
                            confirmPassword: confirmPassword,
                            onAction: {
                                isProcessing = true
                                if isSignUp {
                                    if password == confirmPassword {
                                        viewModel.signUp(email: email, password: password, authState: authState)
                                    } else {
                                        viewModel.errorMessage = "Passwords do not match"
                                        isProcessing = false
                                    }
                                } else {
                                    viewModel.login(email: email, password: password, authState: authState)
                                }
                            },
                            onToggleSignUp: {
                                isSignUp.toggle()
                                viewModel.resetFields()
                                isProcessing = false
                            },
                            onForgotPassword: { showingResetPassword = true }
                        )
                        DebugButtonView()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, geometry.size.width > 600 ? 40 : 24)
                }
                .background(Color.white.ignoresSafeArea())
                .sheet(isPresented: $showingResetPassword) {
                    ResetPasswordView(
                        geometry: geometry,
                        resetEmail: $resetEmail,
                        isProcessing: $isProcessing,
                        onSendReset: { viewModel.resetPassword(email: resetEmail) },
                        onCancel: {
                            showingResetPassword = false
                            resetEmail = ""
                            isProcessing = false
                        }
                    )
                }
                .onAppear {
                    print("AuthView: Appeared, authState isAuthenticated: \(authState.isAuthenticated)")
                }
                .onChange(of: email) { _ in
                    viewModel.errorMessage = nil
                    isProcessing = false
                }
                .onChange(of: isSignUp) { _ in
                    viewModel.errorMessage = nil
                    isProcessing = false
                }
                .onChange(of: viewModel.isAuthenticated) { newValue in
                    print("AuthView: isAuthenticated changed to \(newValue)")
                    if newValue {
                        authState.updateAuthenticationState(isAuthenticated: true)
                    }
                }
                .onChange(of: viewModel.errorMessage) { _ in
                    isProcessing = false
                }
            }
        }
    }
}

// Subview for logo
struct LogoView: View {
    let geometry: GeometryProxy
    var body: some View {
        Image("CloserToChristLogo")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: min(geometry.size.width * 0.4, 200))
            .padding(.top, geometry.size.width > 600 ? 40 : 24)
            .accessibilityLabel("Closer to Christ Logo")
    }
}

// Subview for form fields
struct FormView: View {
    let geometry: GeometryProxy
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    let isSignUp: Bool
    let errorMessage: String?

    var body: some View {
        VStack(spacing: geometry.size.width > 600 ? 24 : 20) {
            Text(isSignUp ? "Create Account" : "Sign In")
                .font(.system(.largeTitle, design: .default, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)

            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .font(.system(.body, design: .default, weight: .regular))
                .foregroundColor(.black)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(8)
                .frame(maxWidth: min(geometry.size.width * 0.9, 600))
                .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
                .accessibilityLabel("Email")

            SecureField("Password", text: $password)
                .textContentType(isSignUp ? .newPassword : .password)
                .disableAutocorrection(true)
                .font(.system(.body, design: .default, weight: .regular))
                .foregroundColor(.black)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(8)
                .frame(maxWidth: min(geometry.size.width * 0.9, 600))
                .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
                .accessibilityLabel("Password")

            if isSignUp {
                SecureField("Confirm Password", text: $confirmPassword)
                    .textContentType(.newPassword)
                    .disableAutocorrection(true)
                    .font(.system(.body, design: .default, weight: .regular))
                    .foregroundColor(.black)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(8)
                    .frame(maxWidth: min(geometry.size.width * 0.9, 600))
                    .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
                    .accessibilityLabel("Confirm Password")
            }

            if let error = errorMessage {
                Text(error)
                    .font(.system(.subheadline, design: .default, weight: .regular))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
                    .accessibilityLabel("Error: \(error)")
            }
        }
    }
}

// Subview for action buttons
struct ActionButtonsView: View {
    let geometry: GeometryProxy
    let isSignUp: Bool
    let isProcessing: Bool
    let email: String
    let password: String
    let confirmPassword: String
    let onAction: () -> Void
    let onToggleSignUp: () -> Void
    let onForgotPassword: () -> Void

    var body: some View {
        VStack(spacing: geometry.size.width > 600 ? 24 : 20) {
            Button(isSignUp ? "Sign Up" : "Sign In") {
                onAction()
            }
            .font(.system(.headline, design: .default, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: min(geometry.size.width * 0.8, 400))
            .padding()
            .background((email.isEmpty || password.isEmpty || (isSignUp && confirmPassword.isEmpty) || isProcessing) ? .gray : .blue)
            .cornerRadius(8)
            .disabled(email.isEmpty || password.isEmpty || (isSignUp && confirmPassword.isEmpty) || isProcessing)
            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
            .accessibilityLabel(isSignUp ? "Sign Up" : "Sign In")

            Button(isSignUp ? "Already have an account? Sign In" : "Need an account? Sign Up") {
                onToggleSignUp()
            }
            .font(.system(.body, design: .default, weight: .regular))
            .foregroundColor(.blue)
            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
            .accessibilityLabel(isSignUp ? "Switch to Sign In" : "Switch to Sign Up")

            Button("Forgot Password?") {
                onForgotPassword()
            }
            .font(.system(.body, design: .default, weight: .regular))
            .foregroundColor(.blue)
            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
            .padding(.bottom, geometry.size.width > 600 ? 60 : 40)
            .accessibilityLabel("Forgot Password")
        }
    }
}

// Subview for debug button
struct DebugButtonView: View {
    var body: some View {
        Button("Debug: Go to Home") {
            print("Debug: Manually setting isAuthenticated to true")
        }
        .padding()
        .foregroundColor(.blue)
        .accessibilityLabel("Debug: Go to Home")
    }
}

// Subview for reset password sheet
struct ResetPasswordView: View {
    let geometry: GeometryProxy
    @Binding var resetEmail: String
    @Binding var isProcessing: Bool
    let onSendReset: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: geometry.size.width > 600 ? 24 : 20) {
            Text("Reset Password")
                .font(.system(.largeTitle, design: .default, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)

            TextField("Email", text: $resetEmail)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.none)
                .disableAutocorrection(true)
                .font(.system(.body, design: .default, weight: .regular))
                .foregroundColor(.black)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(8)
                .frame(maxWidth: min(geometry.size.width * 0.9, 600))
                .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
                .accessibilityLabel("Reset Email")

            Button("Send Reset Email") {
                onSendReset()
            }
            .font(.system(.headline, design: .default, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: min(geometry.size.width * 0.8, 400))
            .padding()
            .background((resetEmail.isEmpty || isProcessing) ? .gray : .blue)
            .cornerRadius(8)
            .disabled(resetEmail.isEmpty || isProcessing)
            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
            .accessibilityLabel("Send Reset Email")

            Button("Cancel") {
                onCancel()
            }
            .font(.system(.body, design: .default, weight: .regular))
            .foregroundColor(.blue)
            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
            .padding(.bottom, geometry.size.width > 600 ? 60 : 40)
            .accessibilityLabel("Cancel")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, geometry.size.width > 600 ? 40 : 24)
        .background(Color.white.ignoresSafeArea())
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthView()
                .environmentObject(AuthenticationState())
                .previewDevice("iPhone 14")
                .previewDisplayName("iPhone 14")
            AuthView()
                .environmentObject(AuthenticationState())
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
                .previewDisplayName("iPad Pro")
        }
    }
}
