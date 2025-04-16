import SwiftUI

struct NutritionResults: View {
    
    @Binding var image: UIImage?
    @ObservedObject var userViewModel: UserViewModel
    @State private var foodName: String = ""
    @State private var servingSize: String = ""
    @State private var calories: String = ""
    @State private var protein: String = ""
    @State private var carbohydrates: String = ""
    @State private var fats: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Display the image
                Image(uiImage: image ?? UIImage(named: "fitnessApp")!)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .scaledToFit()
                    .cornerRadius(15)
                    .clipped()

                // Nutritional Info
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Food:")
                        TextField("Enter food name", text: $foodName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }

                    HStack {
                        Text("Serving Size:")
                        TextField("Enter serving size", text: $servingSize)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }

                    HStack {
                        Text("Calories:")
                        TextField("Enter calories", text: $calories)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }

                    HStack {
                        Text("Protein:")
                        TextField("Enter protein content", text: $protein)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }

                    HStack {
                        Text("Carbohydrates:")
                        TextField("Enter carbohydrates", text: $carbohydrates)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }

                    HStack {
                        Text("Fats:")
                        TextField("Enter fats content", text: $fats)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Nutrition Results")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "chevron.left")
                        .foregroundColor(.yellow)
                        .font(.system(size: 24, weight: .bold))
                }
            }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor(named: "darkGreen")
            
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().tintColor = .white
        }
    }
}

#Preview {
    let mockUserViewModel = UserViewModel()
    mockUserViewModel.firstName = "John"
    
    return NavigationStack {
        NutritionResults(
            image: .constant(UIImage(named: "fitnessApp")!),
            userViewModel: mockUserViewModel
        )
    }
}
