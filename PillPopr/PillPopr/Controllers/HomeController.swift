//
//  HomeController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//


import UIKit
//var newMedicationScheduleController = MedicationScheduleController();

class HomeController: UIViewController {

    @IBOutlet weak var scheduleDate: UILabel!
    @IBOutlet weak var welcomeTitle: UILabel!
    @IBOutlet weak var userScheduleDate: UILabel!
    
    var name: String = "User";
    var scheduleVar: String = "";

    override func viewDidLoad() {
        super.viewDidLoad();
        welcomeTitle.text = "Welcome " + name;
        userScheduleDate.text = scheduleVar;
        SearchObjectController().search()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToEditSchedule" {
            let VC = segue.destination as! editScheduleViewController;
            VC.scheduleDate = scheduleVar;
        }
    }
    
}
