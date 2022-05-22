//
//  SearchObjectController.swift
//  PillPopr
//
//  Created by Joanna Pritt on 19/5/2022.
//

import Foundation
import UIKit
struct drugs: Codable {
    //let last_updated : String
    let results : [Results]
}
struct Results: Codable {
    let products: [Products]
}
struct Products : Codable {
    let brand_name : String
    let active_ingredients : [ActiveIngredients]
}
struct ActiveIngredients : Codable {
    let name : String
    let strength : String
}


class SearchObjectController : ObservableObject{
    static let shared = SearchObjectController()
    public init() {}
    
    
    func search(){
        guard let url = URL(string: "https://api.fda.gov/drug/drugsfda.json") else {return}
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let results = try! JSONDecoder().decode(drugs.self, from: data!)
            print(results)
        }
        .resume()
        }
        }
