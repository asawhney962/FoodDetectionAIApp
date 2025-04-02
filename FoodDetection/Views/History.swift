//
//  History.swift
//  FoodDetection
//
//  Created by Hetal Halani on 3/31/25.
//

import SwiftUI

struct History: View {
    var meals: [Meal] = [
        Meal(title: "Salad", imageName: "carrot", nutritionalInfo: "Calories: 200, Protein: 5g, Carbs: 15g"),
        Meal(title: "Pasta", imageName: "birthday.cake", nutritionalInfo: "Calories: 350, Protein: 12g, Carbs: 40g"),
        Meal(title: "Burger", imageName: "birthday.cake.fill", nutritionalInfo: "Calories: 500, Protein: 25g, Carbs: 40g")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    ForEach(meals) { meal in
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
                            
                            Divider()
                                .background(Color.white)

                        }
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                VStack {
                                    Text("Your Meals")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        
                    }
                    .listRowBackground(Color.yellow)
                    //.padding()
                    .cornerRadius(20)
                }
                .background(Color.green)
                .scrollContentBackground(.hidden)
                .listRowSpacing(20)
            }
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
    History()
}

