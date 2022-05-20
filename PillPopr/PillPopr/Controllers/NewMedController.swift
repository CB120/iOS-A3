//
//  NewMedController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//

import UIKit

class NewMedController: UIViewController {
    
    @IBOutlet weak var medName: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        // Do any additional setup after loading the view.
    
    
    @IBAction func bubblePressed(_ sender: UIButton){
        print("working")
        let asd = HomeController()
        asd.writeHighScore(tempMed: idk(title:medName.text!, click:false))
    }



}

