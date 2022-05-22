//
//  SetupController.swift
//  PillPopr
//
//  Created by Joanna Pritt on 14/5/2022.
//


import UIKit

class SetupController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var newName = "error_name"
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfirmBtn.isEnabled = false;
    }
     //This is to make sure that the player inputs a name :)
    @IBAction func naming(_ sender: UITextField){
        newName = sender.text!
        if sender.text != "" {
            ConfirmBtn.isEnabled = true
        } else {
            ConfirmBtn.isEnabled = false
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHome" {
            UserDefaults.standard.set(String(newName), forKey: "Name")
            
        }
    }
}
