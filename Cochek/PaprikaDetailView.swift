//
//  PaprikaDetailView.swift
//  Cochek
//
//  Created by hwikun on 2023/01/10.
//

import Coinpaprika
import SwiftUI

struct PaprikaDetailView: View {
    @ObservedObject var ohlcv = OHLCV()
    @State var coinId: String
    
    var body: some View {
        List {
            ForEach(ohlcv.ohlcvList, id: \.timeOpen) { item in
                ohlcvFormatter(item: item)
            }
        }
        .onAppear {
            ohlcv.getOhlcvList(coinId: coinId)
        }
    }
    
    private func ohlcvFormatter(item: Ohlcv) -> some View {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return Section {
            Text("Open: \(formatter.string(for: item.open)!)")
            Text("High : \(formatter.string(for: item.high)!)")
            Text("Low : \(formatter.string(for: item.low)!)")
            Text("close : \(formatter.string(for: item.close)!)")
            Text("Volume : \(item.volume ?? 0)" as String)
        }
    }
}

struct PaprikaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PaprikaDetailView(coinId: "bitcoin-btc")
    }
}
