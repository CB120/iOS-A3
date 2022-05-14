//
//  SplashScreenController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//

import UIKit

class SplashScreen: UIViewController {
    @IBOutlet weak var GetStartedBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetStartedBtn.layer.cornerRadius = 12
        GetStartedBtn.layer.borderWidth = 1
        GetStartedBtn.layer.borderColor = UIColor.white.cgColor
    }
}
