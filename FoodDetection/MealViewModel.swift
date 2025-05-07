//
//  MealViewModel.swift
//  FoodDetection
//
//  Created by Hetal Halani on 5/7/25.
//

import SwiftUI

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []  // Array to store the meals
    
    func addMeal(_ meal: Meal) {
        meals.append(meal)  // Method to add a new meal to the list
    }
}

