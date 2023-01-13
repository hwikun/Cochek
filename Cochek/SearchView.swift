//
//  SearchView.swift
//  Cochek
//
//  Created by hwikun on 2023/01/13.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
     
        var body: some View {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
     
                    TextField("Search", text: $text)
                        .foregroundColor(.primary)
     
                    if !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                        }
                    } else {
                        EmptyView()
                    }
                }
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .foregroundColor(.secondary)
                .background(Color(.systemFill))
                .cornerRadius(10.0)
            }
            .padding(.horizontal)
        }
}


