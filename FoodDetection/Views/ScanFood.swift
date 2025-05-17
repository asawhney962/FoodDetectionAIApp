//
//  Home.swift
//  FoodDetection
//
//  Created by Hetal Halani on 2/20/25.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct ScanFood: View {
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var image: UIImage?
    @State private var isLoggedOut = false
    @State private var navigateToResults = false
    @State private var backendData: BackendResponse? = nil

    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var mealViewModel = MealViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    header

                    selectedImageView

                    chooseImageButton

                    scanFoodButton

                    NavigationLink(value: true) {
                        EmptyView()
                    }
                    .navigationDestination(isPresented: $navigateToResults) {
                        NutritionResults(
                            image: .constant(image),
                            backendData: backendData,
                            userViewModel: userViewModel
                        )
                        //.environmentObject(mealViewModel)
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image, isShown: $showImagePicker, sourceType: sourceType)
            }
            .onChange(of: image) { oldValue, newValue in
                print("Image selected: \(String(describing: newValue))")
            }

            .fullScreenCover(isPresented: $isLoggedOut) {
                LogIn()
            }
        }
    }

    // MARK: - UI Components

    private var header: some View {
        HStack {
            Text("Hello \(userViewModel.firstName)!")
                .font(.system(size: 30, weight: .medium))
                .foregroundColor(.black)

            Spacer()

            Button("Logout") {
                try? Auth.auth().signOut()
                isLoggedOut = true
            }
            .foregroundColor(.yellow)
            .font(.system(size: 18, weight: .medium))
        }
    }

    private var selectedImageView: some View {
        Image(uiImage: image ?? UIImage(named: "fitnessApp")!)
            .resizable()
            .frame(width: 300, height: 300)
            .scaledToFit()
            .cornerRadius(15)
    }

    private var chooseImageButton: some View {
        Button("Choose Image") {
            showImagePicker = true
            sourceType = .photoLibrary
        }
        .frame(width: 300, height: 60)
        .background(Color.yellow.opacity(0.8))
        .foregroundColor(.black)
        .cornerRadius(10)
    }

    private var scanFoodButton: some View {
        Button("Scan Food") {
            if let img = image {
                sendImageToBackend(img)
            }
        }
        .frame(width: 300, height: 60)
        .background(image == nil ? Color.gray : Color.yellow)
        .foregroundColor(.black)
        .cornerRadius(10)
        .disabled(image == nil)
    }

    // MARK: - Backend API Call

    private func sendImageToBackend(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }

        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8000/predict")!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        URLSession.shared.uploadTask(with: request, from: body) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(BackendResponse.self, from: data)
                    DispatchQueue.main.async {
                        backendData = decoded
                        navigateToResults = true
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }
}


struct BackendResponse: Codable {
    let dish_name: String
    let ingredients: [Ingredient]
    let nutrition: Nutrition
}

struct Ingredient: Codable, Hashable {
    let name: String
    let quantity_grams: Int
}

struct Nutrition: Codable {
    let calories: Double
    let protein_g: Double
    let carbohydrates_g: Double
    let fats_g: Double
}

#Preview {
    ScanFood()
}
