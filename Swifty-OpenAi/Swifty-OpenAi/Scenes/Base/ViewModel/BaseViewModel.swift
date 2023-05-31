//
//  BaseViewModel.swift
//  Swifty-OpenAi
//
//  Created by Vince Carlo Santos on 5/30/23.
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
    @Published var answer = ""
    
    func setApiKey() {
        loadingMessage = "Loading OPENAI Models..."
        isLoading = true
        Task {
            await APIService.shared.setApiKey(key: apiKey)
            let response = await APIService.shared.getAvailableModels()
            isLoading = false
            switch response {
            case .success(let modelList):
                print(modelList)
                isConnected = true
                availableModels = modelList
            case .failure(_):
                isConnected = false
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
            case .success(let answerValue):
                answer = answerValue
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
