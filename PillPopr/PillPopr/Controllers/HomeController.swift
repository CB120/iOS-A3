//
//  HomeController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//


import UIKit
//var newMedicationScheduleController = MedicationScheduleController();

class HomeController: UIViewController, UITableViewDataSource {

    

    @IBOutlet weak var scheduleDate: UILabel!
    @IBOutlet weak var welcomeTitle: UILabel!
    @IBOutlet weak var userScheduleDate: UILabel!
    @IBOutlet weak var table:UITableView!
    
    struct node{
        let title: String
        let click: Bool
    }
    
    let data:[node] = [
        node(title: "panadol", click: false),
        node(title: "vitamin D", click: false),
        node(title: "omega 3", click: false),
        node(title: "vitamin C", click: false)
    ]
    
    var name: String = "User";
    var scheduleVar: String = "";

    override func viewDidLoad() {
        super.viewDidLoad();
        table.dataSource = self
        welcomeTitle.text = "Welcome " + name;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEditSchedule" {
            let VC = segue.destination as! editScheduleViewController;
            VC.scheduleDate = scheduleVar;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let node = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = node.title
        cell.clickme.isOn = node.click
        return cell
    }
    
}
