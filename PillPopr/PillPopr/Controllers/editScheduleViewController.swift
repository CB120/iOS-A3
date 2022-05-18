//
//  ViewController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//
import UIKit

class editScheduleViewController: UIViewController {
    
    
    @IBOutlet weak var scheduleDateTitle: UILabel!
    var scheduleDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleDateTitle.text = scheduleDate;
    }
}

