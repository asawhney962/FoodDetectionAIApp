import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var email: String = ""
    @Published var age: String = ""
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var goals: String = ""

    let db = Firestore.firestore()

    init() {
        fetchUserData()
    }

    func fetchUserData() {
        guard let user = Auth.auth().currentUser else { return }
        let userID = user.uid
        self.email = user.email ?? "No Email"

        db.collection("users").document(userID).getDocument { document, error in
            if let document = document, document.exists {
                if let data = document.data() {
                    self.firstName = data["firstName"] as? String ?? ""
                    self.age = data["age"] as? String ?? ""
                    self.height = data["height"] as? String ?? ""
                    self.weight = data["weight"] as? String ?? ""
                    self.goals = data["goals"] as? String ?? ""
                }
            } else {
                print("User document not found")
            }
        }
    }

    func saveUserData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }

        let userData: [String: Any] = [
            "firstName": self.firstName,
            "age": self.age,
            "height": self.height,
            "weight": self.weight,
            "goals": self.goals
        ]

        db.collection("users").document(userID).setData(userData, merge: true) { error in
            if let error = error {
                print("Error saving user data: \(error)")
            } else {
                print("User data successfully saved")
            }
        }
    }
}
