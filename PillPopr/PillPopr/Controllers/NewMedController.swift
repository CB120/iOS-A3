//
//  NewMedController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//

import UIKit

class NewMedController: UIViewController {
    
    // IBOutlet Variables
    @IBOutlet weak var medName: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var ScheduleTextPick: UITextField! // Set this to be just numbers.
    @IBOutlet weak var IntakeText: UITextField!
    
    // Global Variables
    let Schedules = ["Twice Daily", "Daily", "Alternate Days", "Weekly", "Fortnightly", "Monthly"]
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        ScheduleTextPick.inputView = pickerView
    }
    
    
    @IBAction func returnPressed(_ sender: UIButton){
        let homeController = HomeController()
        homeController.writeMedSchedule(tempMed: medArray(title:medName.text!, intake: IntakeText.text!, schedule: ScheduleTextPick.text!, click: false))
    }
}

    extension NewMedController: UIPickerViewDelegate, UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
            return Schedules.count
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return Schedules[row]
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            ScheduleTextPick.text = Schedules[row]
            ScheduleTextPick.resignFirstResponder()
        }
    }




