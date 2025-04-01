//
//  FoodDetectionApp.swift
//  FoodDetection
//
//  Created by Hetal Halani on 2/20/25.
//

import SwiftUI
import FirebaseCore

@main

struct FoodDetectionApp: App {
    
    init() {
        FirebaseApp.configure() // Initialize Firebase
    }
    
    var body: some Scene {
        WindowGroup {
            LogIn()
        }
    }
}


