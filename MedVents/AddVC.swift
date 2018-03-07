//
//  AddVC.swift
//  MedVents
//
//  Created by Alex de France on 3/6/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit

class AddVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var medBox: UITextField!
    @IBOutlet weak var timeBox: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var tableCount = 0
    var addedEvent = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelBtn.layer.cornerRadius = 5.0
        cancelBtn.layer.masksToBounds = true
        
        addBtn.layer.cornerRadius = 5.0
        addBtn.layer.masksToBounds = true
        
        medBox.layer.cornerRadius = 5.0
        medBox.layer.masksToBounds = true
        
        timeBox.layer.cornerRadius = 5.0
        timeBox.layer.masksToBounds = true
        
        self.backView.layer.cornerRadius = 5.0
        self.backView.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        let backTap = UITapGestureRecognizer(target: self, action: #selector(cancelTap))
        tap.cancelsTouchesInView = false
        backTap.cancelsTouchesInView = false
        backView.addGestureRecognizer(tap)
        view.addGestureRecognizer(backTap)
    }

    @IBAction func addTap(_ sender: UIButton) {
        addedEvent.id = tableCount + 1
        addedEvent.med = medBox.text!.lowercased()
        addedEvent.time = timeBox.text!
        if addedEvent.med == "symbicort" {
            addedEvent.type = "controller"
        } else {
            addedEvent.type = "rescue"
        }
        if medBox.text! == "" || timeBox.text! == "" {
            let alert = UIAlertController(title: "Error", message: "Please Insert Medication & Time", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            if let presenter = presentingViewController as? MainVC {
                presenter.elementToAdd = addedEvent
            }
            dismiss(animated: true) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateTable"), object: nil)
            }
        }
    }
    
    @IBAction func cancelTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

}
