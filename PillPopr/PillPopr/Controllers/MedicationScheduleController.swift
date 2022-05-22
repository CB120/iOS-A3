//
//  MedicationScheduleController.swift
//  PillPopr
//
//  Created by Christian Burgio on 14/5/2022.
//
import UserNotifications
import UIKit

class MedicationScheduleController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var scheduleNameTF: UITextField!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (permissionGranted, error) in
            if(!permissionGranted){
                print ("Permission Denied")
            }
        }
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: date)
        dateTextField.textColor = .link
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 200)
        dateTextField.inputView = datePicker
        
    }
    
    
    @IBAction func scheduleButton(_ sender: Any) {
        notificationCenter.getNotificationSettings{ (settings) in
            
            DispatchQueue.main.async{
            
            let title = self.scheduleNameTF.text!
            let message =  self.messageTF.text!
            let scheduleDate = self.datePicker.date
            
            if(settings.authorizationStatus == .authorized){
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = message
                
                let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: scheduleDate)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                self.notificationCenter.add(request) {(error) in
                    if(error != nil){
                        print("Error" + error.debugDescription)
                        return
                    }
                }
                
                let ac = UIAlertController(title: "Notifcation Schedulded ", message: "At ", preferredStyle: .alert)
                let goToSettings = UIAlertAction(title: "Settings", style: .default)
                { (_) in
                    guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
                    else{
                        return
                    }
                    if(UIApplication.shared.canOpenURL(settingsURL)){
                        UIApplication.shared.open(settingsURL){ (_) in}
                    }
                }
                ac.addAction(goToSettings)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in}))
                self.present(ac, animated: true)
            }
            else{
                
            }
        }
    }
    }
    
    func formatttedDate(date: Date) -> String{
        let formatter  = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
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

