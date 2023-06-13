//
//  ShowingProducts.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 13/06/23.
//

import SwiftUI

struct ShowingProducts: View {
    
    @ObservedObject var viewModel:ProductReaderFromFile = ProductReaderFromFile()
    var body: some View {
        ScrollView(.vertical){
            VStack{
                ForEach(viewModel.products, id: \.name){item in
                    VStack(spacing: 10){
                        Text("Name: \(item.name)")
                        Text("type: \(item.type)")
                        Text("properties: \(item.properties)")
                        Text("instructions: \(item.instructions)")
                        Text("ingredients: \(item.ingredients)")
                        Text("--------------------------")
                    }
                }
            }
        }.onAppear(){
            viewModel.products = []
            
            viewModel.readProductDetailsFromJSON()
            
        }
    }
}

struct ShowingProducts_Previews: PreviewProvider {
    static var previews: some View {
        ShowingProducts()
    }
}
