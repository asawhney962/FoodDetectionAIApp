//
//  SignUp.swift
//  FoodDetection
//
//  Created by Hetal Halani on 2/20/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct SignUp: View {
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var rePassword = ""
    @State private var isSignedUp = false
    
    let db = Firestore.firestore() //database

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 25) {
                    // First Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("First Name")
                            .font(.system(size: 20, weight: .light))
                        TextField("Enter your first name", text: $firstName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(width: 320, height: 50)
                            .multilineTextAlignment(.center)
                    }

                    // Last Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Last Name")
                            .font(.system(size: 20, weight: .light))
                            //.padding(.leading, 20)
                        TextField("Enter your last name", text: $lastName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(width: 320, height: 50)
                            .multilineTextAlignment(.center)
                    }

                    // Email
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.system(size: 20, weight: .light))
                            //.padding(.leading, 20)
                        TextField("Enter your email", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(width: 320, height: 50)
                            .multilineTextAlignment(.center)
                    }

                    // Password
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.system(size: 20, weight: .light))
                            //.padding(.leading, 20)
                        SecureField("Enter your password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(width: 320, height: 50)
                            .multilineTextAlignment(.center)
                    }

                    // Re-enter Password
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Re-enter Password")
                            .font(.system(size: 20, weight: .light))
                            //.padding(.leading, 20)
                        SecureField("Re-enter your password", text: $rePassword)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(width: 320, height: 50)
                            .multilineTextAlignment(.center)
                    }

                    // Submit Button
                    Button {
                        // Add sign-up functionality here
                        guard !email.isEmpty else {return}
                        guard !password.isEmpty else {return}
                        guard !firstName.isEmpty else {return}
                        guard !lastName.isEmpty else {return}
                        guard !rePassword.isEmpty else {return}
                        
                        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
                            if let e = error {
                                print("Firebase Error: \(e.localizedDescription)")
                            }
                            else if let user = firebaseResult?.user {
                                print("User created: \(user.uid)")
                                db.collection("users").document(user.uid).setData([
                                    "firstName": firstName,
                                    "lastName": lastName,
                                    "email": email
                                ]) { error in
                                    if let error = error {
                                        print("Error saving user data: \(error.localizedDescription)")
                                    } else {
                                        print("User data saved successfully")
                                        isSignedUp = true
                                    }
                                    
                                }
                            }
                        }
                    } label: {
                        Text("Submit")
                            .frame(width: 280, height: 50)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .font(.system(size: 22, weight: .medium))
                            .cornerRadius(10)
                    }
                }
                .frame(maxWidth: .infinity) // Centers everything horizontally
                .fullScreenCover(isPresented: $isSignedUp) {
                    ContentView()
                }
        }
        }
    }
}

#Preview {
    SignUp()
}
