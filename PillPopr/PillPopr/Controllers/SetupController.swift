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
//    @IBOutlet weak var StartGame: UIButton!
    
//    var newName = "error_name"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // This is to make sure that the player inputs a name :)
//    @IBAction func naming(_ sender: UITextField){
//        newName = sender.text!
//        if sender.text != "" {
//            StartGame.isEnabled = true
//        } else {
//            StartGame.isEnabled = false
//        }
//    }
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHome" {
            let VC = segue.destination as! HomeController;
            
            if (nameTextField.text == ""){
                VC.name = "User";
            } else {
                VC.name = nameTextField.text ?? "User";
            }
        }
    }
}
