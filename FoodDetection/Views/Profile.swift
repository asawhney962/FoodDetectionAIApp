import SwiftUI

struct Profile: View {
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                Image(systemName: "person.circle.fill") //replace with such that user can add photo?
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                
                Text("Email: ")
                Text("Name: ")
                Text("Age: ")
                Text("Height: ")
                Text("Weight: ")
                Text("Goals: ")
                Text("Notifications") //add a box to tick or not
                Text("Change Password")
            }
        }
    }
}

#Preview {
    Profile()
}
