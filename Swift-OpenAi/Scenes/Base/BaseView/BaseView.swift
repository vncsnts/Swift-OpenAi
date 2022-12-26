//
//  ContentView.swift
//  Swift-OpenAi
//
//  Created by Vince Carlo Santos on 12/24/22.
//

import SwiftUI

struct BaseView: View {
    @ObservedObject var viewModel = BaseViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Swift-OpenAI")
                    .font(.largeTitle)
                    .padding()
                Text("This app is used to prompt various OPENAI models.")
                    .padding()
                Text("API Key")
                SecureField("Input API Key from 'https://beta.openai.com/account/api-keys'", text: $viewModel.apiKey)
                    .onSubmit {
                        viewModel.setApiKey()
                    }
                if !viewModel.availableModels.isEmpty {
                    Picker("Select a model", selection: $viewModel.selectedModel) {
                        ForEach(viewModel.availableModels, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                if !viewModel.answer.isEmpty {
                    Divider()
                    Text(viewModel.answer)
                        .padding()
                    Divider()
                }
                Spacer()
                if !viewModel.selectedModel.isEmpty {
                    Text("Prompt")
                    TextField("Ask Something...", text: $viewModel.question)
                        .onSubmit {
                            viewModel.getCompletion(For: viewModel.question)
                        }
                }
            }
            .padding()
            
            if viewModel.isLoading {
                LoadingView(message: viewModel.loadingMessage)
            }
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
