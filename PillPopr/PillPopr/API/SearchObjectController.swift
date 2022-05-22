//
//  SearchObjectController.swift
//  PillPopr
//
//  Created by Christian Burgio on 19/5/2022.
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
    //let marketing_status : String
}
struct ActiveIngredients : Codable {
    let name : String
    let strength : String
}

class SearchObjectController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource{
   // public init() {}
    
    
    // Picker UI Variables
    @IBOutlet weak var searchPickerText: UITextField!
    @IBOutlet weak var filterPickerText: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    var searchPickerView = UIPickerView()
    var filterPickerView = UIPickerView()
    
    
    
    
    // Global Variables
    //static let shared = SearchObjectController()
    var SearchTypes = ["Search All", "Search by Dosage Form", "Search by Brand"]
    var filter = ["All Applications", "Oral", "Injection", "Inhalation"]
    //var drugName : String = "LOTION"
    //let urlString = "https://api.fda.gov/drug/drugsfda.json?"
    var resultsList:[Products] = [
        Products(brand_name: "SampleBrand", active_ingredients: [ActiveIngredients(name: "Panadol", strength: "30ml")], dosage_form: "Pill")]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //SearchObjectController().search(drugName: "lotion")
        filterPickerText.isEnabled = false;
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
            search(input: searchPickerText.text!)
            
        } else if pickerView == filterPickerView {
            filterPickerText.text = filter[row]
            filterPickerText.resignFirstResponder()
            if(filterPickerText.isEnabled == true){
                search(input: filterPickerText.text!)
            }
        }
        
    }
    
    func search(input : String){
        switch input {
        case "Search All":
            guard let url = URL(string: "https://api.fda.gov/drug/drugsfda.json?limit=5") else {return}
            URLSession.shared.dataTask(with: url) { data, _, _ in
                let results = try! JSONDecoder().decode(drugs.self, from: data!)
                print(results)
            }
            .resume()
            break;
            case "Search by Dosage Form":
            filterPickerText.isEnabled = true;
            
            
            
            
                guard let url = URL(string: "https://api.fda.gov/drug/drugsfda.json?search=products.dosage_form:LOTION&limit=5") else {return}
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    let results = try! JSONDecoder().decode(drugs.self, from: data!)
                    print(results)
                       
                }
        default:
            print("An error has occured")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableCell
        let node = resultsList[indexPath.row]
            
        
        cell.BrandLabel.text = node.brand_name
        //cell.NameLabel.text = node.active_ingredient
            //cell.DosageLabel.text = node.active_ingredients
        cell.FormLabel.text = node.dosage_form
    
        return cell
    }
class SearchTableCell: UITableViewCell {
    // Cell label variables
    @IBOutlet weak var BrandLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DosageLabel: UILabel!
    @IBOutlet weak var FormLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
}
}
}





