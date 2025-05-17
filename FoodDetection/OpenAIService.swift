//
//  OpenAIService.swift
//  FoodDetection
//
//  Created by Hetal Halani on 5/12/25.
//

import Foundation

class OpenAIService {
    static let shared = OpenAIService()
    private let apiKey: String = {
        if let key = Bundle.main.infoDictionary?["OpenAI_API_Key"] as? String {
            return key
        } else {
            print("OpenAI API key not found in Info.plist")
            return ""
        }
    }()


    func sendMessage(_ message: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completion("Invalid URL.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "user", "content": message]
            ],
            "max_tokens": 500,
            "temperature": 0.7
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion("Failed to encode request.")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = json["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                completion("Please input your API key for meal plan or nutrition suggestions.")
                return
            }

            completion(content.trimmingCharacters(in: .whitespacesAndNewlines))
        }.resume()
    }
}

