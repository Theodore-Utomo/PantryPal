//
//  RecipeViewModel.swift
//  PantryPal
//
//  Created by Theodore Utomo on 11/12/24.
//

import Foundation

@Observable
class RecipeViewModel {
    private let apiKey = "78TjuTUcugi4mUfazdmsMQ==TSWQ5aF7IEHjXFkq"
    var recipes: [Recipe] = []
    var urlString = "https://api.api-ninjas.com/v1/recipe"
    
    func getData() async {
        let query = "italian wedding soup".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "italian wedding soup"
        urlString = "https://api.api-ninjas.com/v1/recipe?query=\(query)"
        
        guard let url = URL(string: urlString) else {
            print("Could not create a URL from \(urlString)\n")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            recipes = try JSONDecoder().decode([Recipe].self, from: data)
            print("JSON has loaded")
            print(recipes)
        } catch {
            print("Could not decode JSON: \(error)")
        }
    }
}
