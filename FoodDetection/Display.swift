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
    init() {
        let appearance = UITabBarAppearance()
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
        .onAppear() {
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.black)
        }
    }
}

#Preview {
    Display()
}
