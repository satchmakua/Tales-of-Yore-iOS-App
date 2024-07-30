//import Foundation
//
//class OpenAINetworkManager {
//    static let shared = OpenAINetworkManager()
//
//    private let apiKey = "YOUR_API_KEY_HERE" // Replace with actual API key
//    private let session = URLSession(configuration: .default)
//
//    func generatePortrait(for prompt: String, completion: @escaping (URL?) -> Void) {
//        let endpoint = "https://api.openai.com/v1/images/generations"
//// Ensure this is the correct endpoint for current API version!
//
//        guard let url = URL(string: endpoint) else {
//            completion(nil)
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//
//        let body: [String: Any] = [
//            "prompt": prompt,
//            "n": 1, // Number of images to generate
//            "size": "1024x1024" // Image size, adjust as needed
//        ]
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
//
//        let task = session.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                completion(nil)
//                return
//            }
//
//            do {
//                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
//                if let jsonObject = jsonResponse as? [String: Any], let data = jsonObject["data"] as? [[String: Any]], let firstImage = data.first, let urlStr = firstImage["url"] as? String, let url = URL(string: urlStr) {
//                    completion(url)
//                } else {
//                    completion(nil)
//                }
//            } catch {
//                completion(nil)
//            }
//        }
//
//        task.resume()
//    }
//}
