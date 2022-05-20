//
//  HomeController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//


import UIKit
//var newMedicationScheduleController = MedicationScheduleController();

struct idk: Codable{
    let title: String
    let click: Bool
}

class HomeController: UIViewController, UITableViewDataSource {

    

    @IBOutlet weak var scheduleDate: UILabel!
    @IBOutlet weak var welcomeTitle: UILabel!
    @IBOutlet weak var userScheduleDate: UILabel!
    @IBOutlet weak var table:UITableView!
    
   
    
    let KEY_HIGH_SCORE = "highScore"
    
    var medlist:[idk] = [
        idk(title: "panadol", click: false),
        idk(title: "vitamin D", click: false),
        idk(title: "omega 3", click: false),
        idk(title: "vitamin C", click: false)
]

    
    var name: String = "User";
    var scheduleVar: String = "";

    override func viewDidLoad() {
        super.viewDidLoad();
        self.medlist = readHighScore()
        table.dataSource = self
        welcomeTitle.text = "Welcome " + name;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEditSchedule" {
            let VC = segue.destination as! editScheduleViewController;
            VC.scheduleDate = scheduleVar;
        }
    }
    
    func writeHighScore(tempMed: idk){
        let defaults = UserDefaults.standard
        
        //read from UserDefaults
        medlist = readHighScore()
        
        //add data from game
        medlist.append(tempMed)
        
        //adds to UserDefaults
        defaults.set(try? PropertyListEncoder().encode(medlist), forKey: KEY_HIGH_SCORE)
        
    }
    
    func readHighScore() -> [idk]{
        let defaults = UserDefaults.standard
        //return highscore array from UserDefaults
        if let savedArraryData = defaults.value(forKey: KEY_HIGH_SCORE) as? Data{
            if let array = try? PropertyListDecoder().decode(Array<idk>.self, from: savedArraryData){
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
        cell.clickme.isOn = node.click
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
