//
//  ViewController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//
import UIKit

class editScheduleViewController: UIViewController {
    
    @IBOutlet weak var chosenDate: UILabel!
    
    var scheduleDate: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chosenDate.text = scheduleDate
        
    }
    
    


}

