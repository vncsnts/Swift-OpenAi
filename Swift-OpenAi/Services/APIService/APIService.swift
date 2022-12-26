//
//  APIService.swift
//  Swift-OpenAi
//
//  Created by Vince Carlo Santos on 12/24/22.
//

import Foundation

final class APIService {
    static let shared = APIService()
    private var apiKey: String?
    
    func setApiKey(key: String) {
        apiKey = key
    }
    
    func getAvailableModels() async -> Result<[String], StringError> {
        guard let apiKeyValue = apiKey else { return .failure(.init(message: "Invalid API Key."))}
        guard let url = URL(string: "https://api.openai.com/v1/models") else {
            return .failure(.init(message: "Invalid Url."))
        }
                
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(apiKeyValue)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return .failure(.init(message: "Invalid Response."))}
            print(json)
            guard let jsonData = json["data"] as? [[String : Any]] else { return .failure(.init(message: "Empty Data Response."))}
            guard let mappedId = jsonData.map({$0["id"]}) as? [String] else { return .failure(.init(message: "Failed to Map Model ID's."))}
            return .success(mappedId)
        } catch(let urlSessionError) {
            return .failure(.init(message: urlSessionError.localizedDescription))
        }
    }
    
    func getModelCompletion(model: String, prompt: String) async -> Result<String, StringError> {
        guard let apiKeyValue = apiKey else { return .failure(.init(message: "Invalid API Key."))}
        guard let url = URL(string: "https://api.openai.com/v1/completions") else {
            return .failure(.init(message: "Invalid Url."))
        }
        
        let payload = ["model" : model,
                       "prompt" : prompt]
                
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(apiKeyValue)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"
        guard let data = try? JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted) else { return .failure(.init(message: "Failed to Convert Dictionary to Data."))}
        urlRequest.httpBody = data
        print(urlRequest.debugDescription)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return .failure(.init(message: "Invalid Response."))}
            print(json)
            return .success("")
        } catch(let urlSessionError) {
            return .failure(.init(message: urlSessionError.localizedDescription))
        }
    }
}
