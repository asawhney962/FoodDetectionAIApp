//
//  FoodChat.swift
//  FoodDetection
//
//  Created by Hetal Halani on 3/31/25.
//

import SwiftUI

struct FoodChat: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            }
            .navigationTitle("Food AI")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Food AI")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Divider()
                            .background(Color.black)
                            .frame(height: 1)
                            .padding(.top, 5)
                    }
                }
            }
        }
    }
}

#Preview {
    FoodChat()
}
