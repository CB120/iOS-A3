//
//  HomeController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//


import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var welcomeTitle: UILabel!
    var name: String = "User";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        welcomeTitle.text = "Welcome " + name;
    }
}
