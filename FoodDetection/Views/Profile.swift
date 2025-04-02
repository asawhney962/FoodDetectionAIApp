import SwiftUI

struct Profile: View {
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    Profile()
}
