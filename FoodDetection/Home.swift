//
//  Home.swift
//  FoodDetection
//
//  Created by Hetal Halani on 2/20/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct Home: View {
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    @StateObject var userViewModel = UserViewModel()
    @State private var isLoggedOut = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    
                    HStack {
                        Spacer()
                        Button("Logout") {
                            do {
                                try? Auth.auth().signOut()
                                isLoggedOut = true
                            } catch let signOutError as NSError {
                                print("Error signing out: %@", signOutError)
                            }
                        }
                        .foregroundColor(.yellow)
                        .font(.system(size: 22, weight: .medium))
                        .padding()
                    }
                    .padding(.top, -100)
                    .padding(.trailing, 20)
                    
                    // Greeting Text
                    Text("Hello \(userViewModel.firstName)!")
                        .font(.system(size: 36, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.leading, 40)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Image Display
                    Image(uiImage: image ?? UIImage(named: "fitnessApp")!)
                        .resizable()
                        .frame(width: 300, height: 300)
                        .scaledToFit()
                        .cornerRadius(15)
                    
                    // Choose Picture Button
                    Button("Scan Food") {
                        self.showSheet = true
                    }
                    .frame(width: 300, height: 80)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .font(.system(size: 22, weight: .medium))
                    .cornerRadius(10)
                    .padding()
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photo"),
                                    message: Text("Choose"), buttons: [
                                        .default(Text("Photo Library")) {
                                            self.showImagePicker = true
                                            self.sourceType = .photoLibrary
                                        },
                                        .default(Text("Camera")) {
                                            self.showImagePicker = true
                                            self.sourceType = .camera
                                        },
                                        .cancel()
                                    ])
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center) // Center the content
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
            }
            .onAppear() {
                userViewModel.fetchUserData()
            }
            .fullScreenCover(isPresented: $isLoggedOut) {
                ContentView()
            }
        }
    }
}

#Preview {
    Home()
}
