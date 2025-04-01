//
//  Profile.swift
//  FoodDetection
//
//  Created by Hetal Halani on 3/31/25.
//

import SwiftUI

struct Profile: View {
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
