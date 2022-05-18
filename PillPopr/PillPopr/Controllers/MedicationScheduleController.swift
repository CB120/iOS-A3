//
//  MedicationScheduleController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//

import UIKit

class MedicationScheduleController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: date)
        dateTextField.textColor = .blue
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 250)
        dateTextField.inputView = datePicker
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToHome" {
            let VC = segue.destination as! HomeController;
            
            if (dateTextField.text == ""){
                VC.scheduleVar = "Date"
            } else{
                VC.scheduleVar = dateTextField.text ?? "Date"
            }
        }
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: sender.date)
    }
    

}

