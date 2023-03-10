//
//  LoadingView.swift
//  Swift-OpenAi
//
//  Created by Vince Carlo Santos on 12/25/22.
//

import SwiftUI

struct LoadingView: View {
    @State var message: String = "Loading..."
    var body: some View {
        VStack {
            VStack {
                Text(message)
                ProgressView()
            }
            .padding()
        }
        .contentShape(Rectangle())
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
