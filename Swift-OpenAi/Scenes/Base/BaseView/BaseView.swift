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
        NavigationStack {
            ZStack {
                VStack {
                    Text("This app is used to prompt various OPENAI models.")
                        .padding()
                    Text("You can sign up [here](https://beta.openai.com/signup/)")
                    Text("You may obtain your api key from [here](https://beta.openai.com/account/api-keys)")
                    SecureField("Input API Key...", text: $viewModel.apiKey)
                        .onSubmit {
                            viewModel.setApiKey()
                        }
                    if !viewModel.availableModels.isEmpty {
                        Menu(viewModel.selectedModel) {
                            ForEach(viewModel.availableModels, id: \.self) { model in
                                Button {
                                    viewModel.selectedModel = model
                                } label: {
                                    Text(model)
                                }
                            }
                        }
                    }
                    if !viewModel.answer.isEmpty {
                        Divider()
                        Text(viewModel.answer)
                            .fixedSize(horizontal: false, vertical: false)
                            .padding()
                        Divider()
                    }
                    Spacer()
                    if !viewModel.selectedModel.isEmpty {
                        VStack {
                            Text("Prompt")
                            TextField("Ask Something...", text: $viewModel.question)
                                .onSubmit {
                                    viewModel.getCompletion(For: viewModel.question)
                                }
                        }
                        .padding()
                    }
                }
                .padding()
                
                if viewModel.isLoading {
                    LoadingView(message: viewModel.loadingMessage)
                }
            }
            .navigationTitle("Swift-OPENAI")
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
