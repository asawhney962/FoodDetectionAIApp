//
//  FoodChat.swift
//  FoodDetection
//
//  Created by Hetal Halani on 3/31/25.
//

import SwiftUI

struct FoodChat: View {
    @State private var messageText = ""
    @State var messages: [String] = ["Welcome to FoodAI"]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScrollView {
                        ForEach(messages, id: \.self) { message in
                            if message.contains("[USER]") {
                                let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                                
                                HStack {
                                    Spacer()
                                    Text(newMessage)
                                        .padding()
                                        .foregroundColor(.black)
                                        .background(.yellow.opacity(1))
                                        .cornerRadius(10)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                }
                            } else {
                                HStack {
                                    Text(message)
                                        .padding()
                                        .foregroundColor(.black)
                                        .background(.white.opacity(1))
                                        .cornerRadius(10)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                    Spacer()
                                }
                            }
                        }.rotationEffect(.degrees(180))
                    }.rotationEffect(.degrees(180))
                        //.background(Color.gray.opacity(0.5))
                    
                    HStack {
                        TextField("Type Something", text: $messageText)
                            .padding()
                            .background(Color.yellow.opacity(1))
                            .cornerRadius(10)
                            .onSubmit {
                                sendMessage(message: messageText)
                            }
                        Button {
                            sendMessage(message: messageText)
                        } label: {
                            Image(systemName: "paperplane.fill")
                        }
                        .tint(.black)
                        .font(.system(size: 26))
                        .padding(.horizontal, 10)
                    }
                    .padding()
                }
                
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
                    }
                }
            }
        }
    }
    
    func sendMessage(message: String) {
        withAnimation {
            messages.append("[USER]" + message)
            self.messageText = ""
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation() {
                messages.append(getBotReponse(message: message))
            }
        }
    }
}

#Preview {
    FoodChat()
}
