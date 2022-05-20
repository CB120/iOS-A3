//
//  HomeController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//


import UIKit
//var newMedicationScheduleController = MedicationScheduleController();

struct medArray: Codable{
    let title: String
    let click: Bool
}

class HomeController: UIViewController, UITableViewDataSource {

    // IBOutlet Variables

    @IBOutlet weak var welcomeTitle: UILabel!
    @IBOutlet weak var table:UITableView!
    
    // Global variables
    var name: String = "User"
    var scheduleVar: String = "";
    
    let KEY_HIGH_SCORE = "highScore"
    
    var medlist:[medArray] = [
        medArray(title: "panadol", click: false),
        medArray(title: "vitamin D", click: false),
        medArray(title: "omega 3", click: false),
        medArray(title: "vitamin C", click: false)
]

    

    override func viewDidLoad() {
        super.viewDidLoad();
        self.medlist = readMedSchedule()
        table.dataSource = self
        welcomeTitle.text = "Welcome " + name;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEditSchedule" {
            let VC = segue.destination as! editScheduleViewController;
            VC.scheduleDate = scheduleVar;
        }
    }
    
    func writeMedSchedule(tempMed: medArray){
        let defaults = UserDefaults.standard
        
        //read from UserDefaults
        medlist = readMedSchedule()
        
        //add data from game
        medlist.append(tempMed)
        
        //adds to UserDefaults
        defaults.set(try? PropertyListEncoder().encode(medlist), forKey: KEY_HIGH_SCORE)
        
    }
    
    func readMedSchedule() -> [medArray]{
        let defaults = UserDefaults.standard
        //return schedule array from UserDefaults
        if let savedArraryData = defaults.value(forKey: KEY_HIGH_SCORE) as? Data{
            if let array = try? PropertyListDecoder().decode(Array<medArray>.self, from: savedArraryData){
                return array
                
            }else{
                 return []
            }
            }
            else{
                return []
                
            }

    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let node = medlist[indexPath.row]
        cell.label.text = node.title
        //cell.clickme.isOn = node.click
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            medlist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let defaults = UserDefaults.standard
            defaults.set(try? PropertyListEncoder().encode(medlist), forKey: KEY_HIGH_SCORE)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}
