//
//  BaseViewModel.swift
//  Swift-OpenAi
//
//  Created by Vince Carlo Santos on 12/24/22.
//

import Foundation

@MainActor
final class BaseViewModel: ObservableObject {
    @Published var apiKey = ""
    @Published var question = ""
    @Published var isLoading = false {
        didSet {
            if !isLoading {
                loadingMessage = ""
            }
        }
    }
    @Published var loadingMessage = ""
    @Published var isConnected = false
    @Published var availableModels = [String]()
    @Published var selectedModel = ""
    
    func setApiKey() {
        loadingMessage = "Loading OPENAI Models..."
        isLoading = true
        Task {
            APIService.shared.setApiKey(key: apiKey)
            let response = await APIService.shared.getAvailableModels()
            isLoading = false
            switch response {
            case .success(let modelList):
                availableModels = modelList
            case .failure(_):
                break
            }
        }
    }
    
    func getCompletion(For prompt: String) {
        loadingMessage = "Sending Prompt..."
        isLoading = true
        Task {
            let response = await APIService.shared.getModelCompletion(model: selectedModel, prompt: prompt)
            isLoading = false
            switch response {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
}
