import SwiftUI

struct Profile: View {
    @StateObject var userViewModel = UserViewModel()
    @State private var notificationsEnabled = false // Track the checkbox state
    @State private var showImagePicker = false
    @State private var showSheet = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var profileImage: UIImage?
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                //Title
                Text("Profile")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                VStack{
                    Button(action:{
                        showSheet.toggle()
                    }){
                        // Placeholder for the profile image
                        Image(uiImage: profileImage ?? UIImage(systemName: "person.circle.fill")!.withRenderingMode(.alwaysTemplate))
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(profileImage == nil ? .white : .clear)
                            .clipShape(Circle())
                    }
                }
                //Information
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Email:")
                            .font(.headline)
                        Spacer()
                        Text(userViewModel.email)
                            .font(.subheadline)
                    }
                    
                    HStack {
                        Text("Name:")
                            .font(.headline)
                        Spacer()
                        TextField("Enter Name", text: $userViewModel.firstName)
                            .multilineTextAlignment(.trailing)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                    }
                    
                    HStack {
                        Text("Age:")
                            .font(.headline)
                        Spacer()
                        TextField("Enter Age", text: $userViewModel.age)
                            .multilineTextAlignment(.trailing)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                    }
                    
                    HStack {
                        Text("Height:")
                            .font(.headline)
                        Spacer()
                        TextField("Enter Height", text: $userViewModel.height)
                            .multilineTextAlignment(.trailing)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                    }
                    
                    HStack {
                        Text("Weight:")
                            .font(.headline)
                        Spacer()
                        TextField("Enter Weight", text: $userViewModel.weight)
                            .multilineTextAlignment(.trailing)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                    }
                    
                    HStack {
                        Text("Goals:")
                            .font(.headline)
                        Spacer()
                        TextField("Enter Goals", text: $userViewModel.goals)
                            .multilineTextAlignment(.trailing)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .foregroundColor(.black)
                
                // Notifications Toggle (checkbox)
                HStack {
                    Text("Notifications")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enable Notifications")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .yellow))
                    .labelsHidden()
                }
                
                // Save User Data Button
                Button(action: {
                    userViewModel.saveUserData()
                }) {
                    Text("Save")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity)
            }
        }
        //Image Picker After Pressing Profile
        .sheet(isPresented: $showImagePicker){
            ImagePicker(image: $profileImage, isShown: $showImagePicker, sourceType: sourceType)
        }
        //Select Photo Library or camera 
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
}
#Preview {
    Profile()
}
