//
//  Display.swift
//  FoodDetection
//
//  Created by Hetal Halani on 3/31/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct Display: View {
    @State private var newMeal: Meal? = nil
    @State private var userViewModel = UserViewModel()
    @StateObject private var mealViewModel = MealViewModel()
    
    init() {
        let appearance = UITabBarAppearance()
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                ScanFood()
            }
            Tab("Meals", systemImage: "fork.knife.circle") {
                History()
            }
            Tab("Food Chat", systemImage: "message") {
                FoodChat()
            }
            Tab("Profile", systemImage: "person") {
                Profile()
            }
        }
        .tint(.yellow)
        .environmentObject(mealViewModel)
        .onAppear() {
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.black)
        }
    }
}

#Preview {
    Display()
}
