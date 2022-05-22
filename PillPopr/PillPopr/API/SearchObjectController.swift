//
//  SearchObjectController.swift
//  PillPopr
//
//  Created by Joanna Pritt on 19/5/2022.
//

import Foundation
import UIKit

struct drugs: Codable {
    let results : [Results]
}
struct Results: Codable {
    let products: [Products]
}
struct Products : Codable {
    let brand_name : String
    let active_ingredients : [ActiveIngredients]
    let dosage_form : String
    let marketing_status : String
}
struct ActiveIngredients : Codable {
    let name : String
    let strength : String
}

class SearchObjectController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    
    @IBOutlet weak var searchPickerText: UITextField!
    @IBOutlet weak var filterPickerText: UITextField!
    
    
    static let shared = SearchObjectController()
    // Global Variables
    var SearchTypes = ["Search All", "Search by Dosage Form", "Search by Brand"]
    var filter = ["All Applications", "Oral", "Injection", "Inhalation"]
    var drugName : String = "LOTION"
    let urlString = "https://api.fda.gov/drug/drugsfda.json?"

    var searchPickerView = UIPickerView()
    var filterPickerView = UIPickerView()
    
    
    //public init() {}
    override func viewDidLoad() {
        super.viewDidLoad();
        //SearchObjectController().search(drugName: "lotion")
        searchPickerView.delegate = self
        searchPickerView.dataSource = self
        
        filterPickerView.delegate = self
        filterPickerView.dataSource = self
        
        searchPickerText.inputView = searchPickerView
        filterPickerText.inputView = filterPickerView
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows : Int = SearchTypes.count
        if pickerView == searchPickerView {
            countRows = SearchTypes.count
            } else if pickerView == filterPickerView{
                countRows = filter.count
            }
        return countRows
        }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == searchPickerView{
            let text = SearchTypes[row]
            return text
        } else if pickerView == filterPickerView{
            let text = filter[row]
            return text
        }
        
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("SELECTING")
        if pickerView == searchPickerView {
            searchPickerText.text = SearchTypes[row]
            searchPickerText.resignFirstResponder()
            
        } else if pickerView == filterPickerView {
            filterPickerText.text = filter[row]
            filterPickerText.resignFirstResponder()
        }
    }
    
    func searchAll(){
        guard let url = URL(string: "https://api.fda.gov/drug/drugsfda.json?limit=5") else {return}
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let results = try! JSONDecoder().decode(drugs.self, from: data!)
            print(results)
        }
        .resume()
        }
    
    
    
}
        





