//
//  UserViewModel.swift
//  FoodDetection
//
//  Created by Hetal Halani on 3/23/25.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var firstName: String = ""

    let db = Firestore.firestore()

    func fetchUserData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }

        db.collection("users").document(userID).getDocument { document, error in
            if let document = document, document.exists {
                if let data = document.data() {
                    self.firstName = data["firstName"] as? String ?? ""
                }
            } else {
                print("User document not found")
            }
        }
    }
}

