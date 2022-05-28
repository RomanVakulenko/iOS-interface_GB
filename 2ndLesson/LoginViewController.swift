//
//  LoginViewController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 27.05.2022.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//Вариант с лекции:
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
//        self.view.addGestureRecognizer(recognizer)
        
        let recognizerTwo = UILongPressGestureRecognizer(target: self, action: #selector(onPush))
        self.view.addGestureRecognizer(recognizerTwo)
    }
//По долгому нажатию поле Name заполнится текстом "longPressGestureWorks" и добавил архив в Гит
    @objc func onPush () {
//        print("tap") - Варинат с лекции
        userNameTextField.text = "longPressGestureWorks"
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {

    if let login = userNameTextField.text,
        login == "root" {
            userNameTextField.backgroundColor = UIColor.green
        }
        else {
            userNameTextField.backgroundColor = UIColor.magenta
        }
    if let password = passwordtextField.text,
        password == "123" {
        passwordtextField.backgroundColor = UIColor.green
        }
        else {
            passwordtextField.backgroundColor = UIColor.magenta
        }
    }
}

