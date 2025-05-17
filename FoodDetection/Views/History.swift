//
//  History.swift
//  FoodDetection
//
//  Created by Hetal Halani on 3/31/25.
//

import SwiftUI

struct History: View {
    @EnvironmentObject var mealViewModel: MealViewModel

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                List {
                    ForEach(mealViewModel.meals) { meal in // Loop through the dynamic list of meals
                        NavigationLink(destination: MealDetailView(meal: meal)) {
                            HStack {
                                if let mealImage = meal.uiImage {
                                    Image(uiImage: mealImage)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                } else {
                                    Image(systemName: "fork.knife")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                }

                                Text(meal.title)
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                                                
                                                Divider().background(Color.white)
                                            }
                    }
                    .listRowBackground(Color.yellow)
                    .cornerRadius(20)
                }
                .background(Color.green)
                .scrollContentBackground(.hidden)
                .listRowSpacing(20)
            }
            .navigationTitle("Your Meals")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MealDetailView: View {
    var meal: Meal

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                if let image = meal.uiImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 3)
                        )
                }

                Text(meal.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                Text(meal.nutritionalInfo)
                    .font(.body)
                    .padding()
                    .multilineTextAlignment(.leading)

                Spacer()
            }
            .padding()
        }
        .navigationTitle(meal.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


import SwiftUI

struct Meal: Identifiable {
    var id = UUID()
    var title: String
    var uiImage: UIImage?
    var nutritionalInfo: String
}


#Preview {
    let sampleMeals: [Meal] = [
        Meal(title: "Spaghetti", uiImage: nil, nutritionalInfo: "Calories: 400, Protein: 15g"),
        Meal(title: "Salad", uiImage: nil, nutritionalInfo: "Calories: 200, Protein: 5g"),
        Meal(title: "Pizza", uiImage: nil, nutritionalInfo: "Calories: 500, Protein: 20g")
    ]

    let mealViewModel: MealViewModel = MealViewModel()
    mealViewModel.meals = sampleMeals

    return History()
        .environmentObject(mealViewModel)
}


