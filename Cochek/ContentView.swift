//
//  ContentView.swift
//  Cochek
//
//  Created by hwikun on 2023/01/07.
//

import Foundation
import SwiftUI

struct ContentView: View {
//    @ObservedObject var network = Network()
    @ObservedObject var coinpaprika = CoinList()
    @State private var searchText: String = ""
    var body: some View {
        NavigationView {
            VStack {
                SearchView(text: $searchText)
                List {
                    Section("즐겨찾기") {
                        NavigationLink {} label: {
                            Text("Pi")
                        }
                    }

                    Section("Top 100") {
                        ForEach(coinpaprika.coinList.filter { $0.name.hasPrefix(searchText) || searchText == "" }, id: \.id) { item in
                            NavigationLink {
                                PaprikaDetailView(coinId: item.id)
                            } label: {
                                HStack {
                                    Text(item.name)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("코인 리스트")
                .onAppear {
                    coinpaprika.getCoinList()
                }
            }.background(Color(.systemGroupedBackground))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
