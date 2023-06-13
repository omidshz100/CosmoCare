//
//  JsonReader.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 13/06/23.
//

import Foundation


class ProductReaderFromFile: ObservableObject{
    @Published var products:[ProductDetails]
    @Published var name:String = "O"
    
    init(products: [ProductDetails] = [] ) {
        self.products = products
    }
    struct ProductDetails:  Codable {
        let name: String
        let type: String
        let properties: String
        let instructions: String
        let ingredients: String
    }
    
    func readProductDetailsFromJSON(){
        name = "K"
        if let path = Bundle.main.path(forResource: "productDetails", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                let productDetails = try JSONDecoder().decode([ProductDetails].self, from: data)
                products = productDetails
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
