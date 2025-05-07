//
//  ForgotPassword.swift
//  FoodDetection
//
//  Created by Hetal Halani on 2/20/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct ForgotPassword: View {
    @State private var email = ""
    @State private var message = ""
    @State private var showAlert = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {

                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.system(size: 18, weight: .regular))
                        //.foregroundColor(.white)
                        .padding(.leading, 20)

                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .frame(width: 350)
                        .padding(.horizontal, 20)
                }

                
                Button {
                    resetPassword()
                } label: {
                    Text("Submit")
                        .frame(width: 280, height: 50)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .font(.system(size: 22, weight: .medium))
                        .cornerRadius(10)
                }
                .padding(.top, 15)
                
                Text(message)
                    .foregroundColor(.red)
                    .padding()

            }
    }
}
    func resetPassword() {
        guard !email.isEmpty else {
            message = "Please enter your email"
            showAlert = true
            return
        }
            
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                message = "Error: \(error.localizedDescription)"
            } else {
                message = "Password reset email sent. Check your inbox!"
            }
            showAlert = true
        }
    }
}

#Preview {
    ForgotPassword()
}

