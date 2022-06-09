//
//  AllGroupController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 03.06.2022.
//

import UIKit

class AllGroupController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pressSendButton(_ sender: Any) {
        if let text =   messageTextField.text {
            NotificationCenter.default.post(name: NSNotification.Name("sendMeaasageFromAllGroups"), object: text)
        }
    }
    
}
