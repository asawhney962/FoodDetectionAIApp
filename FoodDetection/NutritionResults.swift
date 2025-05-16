import SwiftUI

struct NutritionResults: View {
    @Binding var image: UIImage?
    var backendData: BackendResponse?
    @ObservedObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mealViewModel: MealViewModel

    @State private var navigateToHistory = false

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient

                ScrollView {
                    VStack(spacing: 20) {
                        mealImage
                        dishName
                        ingredientsList
                        nutritionStats
                        addToMealsButton
                    }
                    .padding()
                }
            }
            .navigationTitle("Nutrition Results")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.yellow)
                            .font(.system(size: 24, weight: .bold))
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToHistory) {
                History()
                    .environmentObject(mealViewModel)
            }
        }
    }

    private var backgroundGradient: some View {
        LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }

    private var mealImage: some View {
        Image(uiImage: image ?? UIImage(named: "fitnessApp")!)
            .resizable()
            .frame(width: 300, height: 300)
            .scaledToFit()
            .cornerRadius(15)
    }

    private var dishName: some View {
        Text(backendData?.dish_name ?? "Unknown Dish")
            .font(.title)
            .bold()
            .padding()
    }

    private var ingredientsList: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ingredients:")
                .font(.headline)
            ForEach(backendData?.ingredients ?? [], id: \.self) { item in
                HStack {
                    Text(item.name.capitalized)
                    Spacer()
                    Text("\(item.quantity_grams)g")
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }

    private var nutritionStats: some View {
        VStack(spacing: 10) {
            Text("Nutritional Info (Total)")
                .font(.headline)
            statRow(label: "Calories", value: backendData?.nutrition.calories, unit: "kcal")
            statRow(label: "Protein", value: backendData?.nutrition.protein_g, unit: "g")
            statRow(label: "Carbs", value: backendData?.nutrition.carbohydrates_g, unit: "g")
            statRow(label: "Fats", value: backendData?.nutrition.fats_g, unit: "g")
        }
        .padding()
    }

    private func statRow(label: String, value: Double?, unit: String) -> some View {
        HStack {
            Text(label + ":")
                .frame(width: 120, alignment: .leading)
            Spacer()
            Text("\(String(format: "%.1f", value ?? 0)) \(unit)")
                .bold()
        }
        .padding(.horizontal)
    }

    private var addToMealsButton: some View {
        Button("Add to Meals") {
            let info = """
            Calories: \(backendData?.nutrition.calories ?? 0),
            Protein: \(backendData?.nutrition.protein_g ?? 0),
            Carbs: \(backendData?.nutrition.carbohydrates_g ?? 0),
            Fats: \(backendData?.nutrition.fats_g ?? 0)
            """
            let newMeal = Meal(
                title: backendData?.dish_name ?? "Unnamed Meal",
                uiImage: image, // Store the actual image
                nutritionalInfo: info
            )
            mealViewModel.addMeal(newMeal)
            navigateToHistory = true
        }
        .frame(width: 300, height: 50)
        .background(Color.yellow)
        .foregroundColor(.black)
        .font(.system(size: 22, weight: .medium))
        .cornerRadius(10)
        .padding()
    }

}
#Preview {
    let sampleImage = UIImage(named: "fitnessApp")
    let sampleUserViewModel = UserViewModel() // Replace with real init if needed
    let sampleMealViewModel = MealViewModel() // Replace with real init if needed

    return NutritionResults(
        image: .constant(sampleImage),
        userViewModel: sampleUserViewModel
    )
    .environmentObject(sampleMealViewModel)
}



