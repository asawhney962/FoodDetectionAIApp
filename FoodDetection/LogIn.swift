//
//  ContentView.swift
//  FoodDetection
//
//  Created by Hetal Halani on 2/20/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LogIn: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 25) {
                   
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)
                        .padding(.top, 50)

                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sign In")
                            .font(.system(size: 34, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)

                        Text("Email")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.leading, 20)

                        TextField("Enter your email", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(width: 350)
                            .padding(.horizontal, 20)

                      
                        Text("Password")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.leading, 20)

                        SecureField("Enter your password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(width: 350)
                            .padding(.horizontal, 20)
                    }

                   
                    Button {
                        // Add sign-up functionality here
                        guard !email.isEmpty else {return}
                        guard !password.isEmpty else {return}
                        
                        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
                            if let e = error {
                                print("Firebase Error: \(e.localizedDescription)")
                            }
                            else {
                                isLoggedIn = true
                            }
                        }
                    } label: {
                        Text("Sign In")
                            .frame(width: 280, height: 50)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .font(.system(size: 22, weight: .bold))
                            .cornerRadius(10)
                    }
                    .padding(.top, 15)

                   
                    HStack {
                        NavigationLink(destination: ForgotPassword()) {
                            Text("Forgot Password?")
                                .foregroundColor(.white)
                        }

                        Text("|")
                            .foregroundColor(.white.opacity(0.7))

                        NavigationLink(destination: SignUp()) {
                            Text("Sign Up")
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding(.bottom, 40)
                }
                .fullScreenCover(isPresented: $isLoggedIn) {
                    ScanFood()
                }
            }
        }
    }
}

#Preview {
    LogIn()
}
