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
                                    Image(systemName: meal.imageName)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.white, lineWidth: 3)
                                        )
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
                Text("Insert here the page with calorie info and nutritional content")
            }
            .padding()
            .navigationTitle(meal.title)
        }
    }
}

struct Meal: Identifiable {
    var id = UUID()
    var title: String
    var imageName: String
    var nutritionalInfo: String
}

#Preview {
    NutritionResults(
        image: .constant(UIImage(named: "fitnessApp")!),
        userViewModel: UserViewModel()
    )
    .environmentObject(MealViewModel())
}


