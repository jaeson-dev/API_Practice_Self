//
//  ContentView.swift
//  Api_Practice_self
//
//  Created by Jaeson.dev on 2022/03/10.
//

import SwiftUI

extension Color {
    static let bitcoinGreen: Color = Color.green.opacity(0.9)
}

struct BitcoinPriceView: View {
    
    @ObservedObject var viewModel: BitcoinViewModel
    @State private var selectedCurrency: Currency = .usd
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Updated \(viewModel.lastUpdated)")
                .padding([.top, .bottom])
                .foregroundColor(.bitcoinGreen)
            
            TabView(selection: $selectedCurrency, content: {
                ForEach(viewModel.priceDetails.indices, id: \.self) { index in
                    let details = viewModel.priceDetails[index]
                    PriceDetailsView(priceDetails: details)
                        .tag(details.currency)
                }
            }).tabViewStyle(PageTabViewStyle())
            
            VStack(spacing:0) {
                HStack(alignment: .center) {
//                    Menu(content: {
//                        Picker("Currency", selection: $selectedCurrency, content: {
//                            Text("\(Currency.usd.icon) \(Currency.usd.code)").tag(Currency.usd)
//                            Text("\(Currency.gbp.icon) \(Currency.gbp.code)").tag(Currency.gbp)
//                            Text("\(Currency.eur.icon) \(Currency.eur.code)").tag(Currency.eur)
//                        })
//                    }, label: {
//                        Text("Currency")
//                    })
                    Picker(selection: $selectedCurrency, content: {
                        Text("\(Currency.usd.icon) \(Currency.usd.code)").tag(Currency.usd)
                        Text("\(Currency.gbp.icon) \(Currency.gbp.code)").tag(Currency.gbp)
                        Text("\(Currency.eur.icon) \(Currency.eur.code)").tag(Currency.eur)
                    }, label: {
                        Text("Currency")
                    })
                        .padding(.leading)
                    Spacer()
                    
                    Button(action: {
                        viewModel.onAppear()
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.largeTitle)
                        
                    })
                        .padding(.trailing)
                }
                .padding(.top)
                
                Link(
                    "Powered by Coindesk",
                    destination: URL(string: "https://coindesk.com/price/bitcoin")!
                )
                    .font(.caption)
            }
            .foregroundColor(.bitcoinGreen)
        }
        .onAppear(perform: viewModel.onAppear)
        .pickerStyle(MenuPickerStyle())
    }
}

struct PriceDetailsView: View {
    
    let priceDetails: PriceDetails
    
    var body: some View {
        ZStack {
            Color.bitcoinGreen
            VStack {
                Text(priceDetails.currency.icon)
                    .font(.largeTitle)
                Text("1 Bitcoin = ")
                    .bold()
                    .font(.title2)
                Text("\(priceDetails.rate) \(priceDetails.currency.code)")
                    .bold()
                    .font(.largeTitle)
            }
            .foregroundColor(.white)
        }
    }
}
