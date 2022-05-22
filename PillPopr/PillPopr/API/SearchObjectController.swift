//
//  SearchObjectController.swift
//  PillPopr
//
//  Created & Written by Christian Burgio on 19/5/2022.
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
    
    // Picker UI Variables
    @IBOutlet weak var searchPickerText: UITextField!
    @IBOutlet weak var filterPickerText: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var TestResultLabel: UILabel!
    
    var searchPickerView = UIPickerView()
    var filterPickerView = UIPickerView()
    
    // Global Variables
    
    var SearchTypes = ["Search All", "Search by Dosage Form", "Search by Brand"]
    var filter = ["All Applications", "Oral", "Injection", "Inhalation"]
    var resultsList:[Products] = [
        Products(brand_name: "FLUOXETINE HYDROCHLORIDE", active_ingredients: [ActiveIngredients(name: "FLUOXETINE HYDROCHLORIDE", strength: "EQ 20MG BASE")], dosage_form: "CAPSULE")]
    
    // Initializer
    override func viewDidLoad() {
        super.viewDidLoad();
        
        filterPickerText.isEnabled = false;     // Only activates if the Search by Dosage is selected
        
        searchPickerView.delegate = self
        searchPickerView.dataSource = self
        
        filterPickerView.delegate = self
        filterPickerView.dataSource = self
        
        searchPickerText.inputView = searchPickerView
        filterPickerText.inputView = filterPickerView
        
        searchTable.dataSource = self           // Set the tables datasource
    }
    
    // Setting up the picker view UI
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Returning the amount of entries in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows : Int = SearchTypes.count
        if pickerView == searchPickerView {
            countRows = SearchTypes.count
            } else if pickerView == filterPickerView{
                countRows = filter.count
            }
        return countRows
        }
    // Returning the data in the arrays to the pickerViews options
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
    
    // Setting the text of each row to match the array, then whatever the user lands on will be the selection
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
    
    // API Functionality ===== Was not able to complete in time =====
    func search(input : String){
        switch input {                      // Switch case depending on which filter was selected from the pickerView UI... not complete
        case "Search All":
            guard let url = URL(string: "https://api.fda.gov/drug/drugsfda.json?limit=3") else {return}
            URLSession.shared.dataTask(with: url) { data, _, _ in
                let result = try! JSONDecoder().decode(drugs.self, from: data!)
                print("=====================================================")
                print(result)           // Print the JSON Data to confirm it is getting the correct stuff
                print("=====================================================")
            }
            .resume()
            break;
            
            case "Search by Dosage Form":
            filterPickerText.isEnabled = true;
                // Only if the Dosage Form filter was selected would the next filter work. There would then be another switch statement to switch the URL's search option. Functionality not complete. Ran out of time
            
                guard let url = URL(string: "https://api.fda.gov/drug/drugsfda.json?search=products.dosage_form:LOTION&limit=3") else {return}
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    let results = try! JSONDecoder().decode(drugs.self, from: data!)
                    print("=====================================================")
                    print(results)
                    print("=====================================================")
                }
                .resume()
            break;
            
        case "Search by Brand":
            /*guard let url = URL(string: "https://api.fda.gov/drug/drugsfda.json?count=products.brand_name.exact") else {return}
            URLSession.shared.dataTask(with: url) { data, _, _ in
                let results = try! JSONDecoder().decode(drugs.self, from: data!)
                print(results)
            }
            .resume()*/
        print("New structs need to be created for this Query, priority is to finish the main Queries first (the two above). TODO Later")
            break;
        default:
            print("An error has occured, or you selected a filter from the other pickerView")
            // I wish my team members would contribute more
        }
    }
    
    // Table logic
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchTable.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableCell
        let node = resultsList[indexPath.row]
            
        
        cell.brandLabel.text = node.brand_name
        cell.nameLabel.text = "_notWorking" //node.active_ingredient      These are placeholders as I had trouble with the API's configuration.
            cell.strengthLabel.text = "_notWorking" //node.active_ingredients        These are placeholders as I had trouble with the API's configuration.
        cell.dosageFormLabel.text = node.dosage_form
    
        return cell
    }
}

// Class for the cells in the table.
class SearchTableCell: UITableViewCell {
    // Cell label variables
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var dosageFormLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// Sorry about this mess ~ Christian





