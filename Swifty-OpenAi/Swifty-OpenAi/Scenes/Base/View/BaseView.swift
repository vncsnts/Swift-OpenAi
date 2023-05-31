//
//  BaseView.swift
//  Swifty-OpenAi
//
//  Created by Vince Carlo Santos on 5/30/23.
//

import SwiftUI

struct BaseView: View {
    @StateObject var viewModel = BaseViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Swifty OPEN AI")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .padding(.bottom)
            
            Text("This app is used to prompt various OPENAI models.")
                .font(.headline)
                .fontWeight(.thin)
                .fontDesign(.rounded)
                .padding(.bottom)
            
            Text("You can sign up [here](https://beta.openai.com/signup/)")
                .font(.headline)
                .fontWeight(.medium)
                .fontDesign(.rounded)
            Text("You may obtain your api key from [here](https://beta.openai.com/account/api-keys)")
                .font(.headline)
                .fontWeight(.medium)
                .fontDesign(.rounded)
            
            if !viewModel.isConnected {
                SecureField("Input API Key...", text: $viewModel.apiKey)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.webSearch)
                    .onSubmit {
                        viewModel.setApiKey()
                    }
            }
            
            if !viewModel.availableModels.isEmpty && viewModel.selectedModel.isEmpty {
                VStack {
                    Text("Select an AI Model to use")
                        .font(.headline)
                        .fontWeight(.ultraLight)
                        .fontDesign(.rounded)
                        .padding()
                    List {
                        ForEach($viewModel.availableModels, id: \.self) { aiModel in
                            Text(aiModel.wrappedValue)
                                .onTapGesture {
                                    viewModel.selectedModel = aiModel.wrappedValue
                                }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            
            
            if !viewModel.answer.isEmpty {
                Divider()
                Text(viewModel.answer)
                    .fixedSize(horizontal: false, vertical: false)
                    .padding()
                Divider()
            }
            
            if !viewModel.selectedModel.isEmpty {
                VStack {
                    Text("Prompt")
                        .font(.headline)
                        .fontWeight(.ultraLight)
                        .fontDesign(.rounded)
                        .padding()
                    
                    TextField("Ask Something...", text: $viewModel.question)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.webSearch)
                        .onSubmit {
                            viewModel.getCompletion(For: viewModel.question)
                        }
                }
            }
            
            Spacer()
        }
        .padding()
        .loadingView(isLoading: $viewModel.isLoading, message: $viewModel.loadingMessage)
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
