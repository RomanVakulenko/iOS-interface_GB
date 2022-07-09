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
    @IBOutlet weak var loadingFirstView: UIView!
    @IBOutlet weak var loadingSecondView: UIView!
    @IBOutlet weak var loadingThirdView: UIView!
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var passwordTitle: UILabel!
    @IBOutlet weak var appLabel: UIImageView!
    
    let toTabBarController = "toTabBarController" //делать константу не строкой, чтобы если дальше ошибемся, то Xcode нам подскажет где ошиблись, а в строке в кавычках он не распознает опечатку
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//7урок:сделаем перемигающие точки загрузки:
        loadingFirstView.alpha = 0
        loadingSecondView.alpha = 0
        loadingThirdView.alpha = 0
        // подготовим и закруглим углы Вьбшным квардратам
        loadingFirstView.layer.cornerRadius = 5
        loadingSecondView.layer.cornerRadius = 5
        loadingThirdView.layer.cornerRadius = 5
    
        let recognizerTwo = UILongPressGestureRecognizer(target: self, action: #selector(onPush))
        self.view.addGestureRecognizer(recognizerTwo)
    }

    @objc func onPush () { //По долгому нажатию поле Name заполнится текстом "longPressGestureWorks"
        userNameTextField.text = "longPressGestureWorks"
    }
    
// 7урок:сделаем перемигающие точки загрузки. Aнимация 3ех квадратных Вью (используем рекурсию) - перемигающие точки загрузки
    func loadingViewAnimation () {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.loadingThirdView.alpha = 0
            self?.loadingFirstView.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.4) { [weak self] in
                    self?.loadingFirstView.alpha = 0
                    self?.loadingSecondView.alpha = 1
                    } completion: { _ in
                        UIView.animate(withDuration: 0.4) { [weak self] in
                            self?.loadingSecondView.alpha = 0
                            self?.loadingThirdView.alpha = 1
                            } completion: { [weak self] _ in
                                self?.loadingViewAnimation()
                            }
                    }
            }
    }

    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        //    if let login = userNameTextField.text,
//        login == "root" {
//            userNameTextField.backgroundColor = UIColor.green
//        }
//        else {
//            userNameTextField.backgroundColor = UIColor.magenta
//        }
//    if let password = passwordtextField.text,
//        password == "123" {
//        passwordtextField.backgroundColor = UIColor.green
//        }
//        else {
//            passwordtextField.backgroundColor = UIColor.magenta
//        }
        //анимация разлетания полей и Заглавия
        UIView.animate(withDuration: 2) {
            let translationAppLabel = CGAffineTransform(translationX: 0, y: -140)
            
            let translationNameTitle = CGAffineTransform(translationX: -400, y: 0)
            let translationUserNameTextField = CGAffineTransform(translationX: -400, y: 0) //сместитьОтноcИсхТ.(origin)
            let translationPasswordtextField = CGAffineTransform(translationX: 500, y: 0)
            let translationPasswordTitle = CGAffineTransform(translationX: 500, y: 0)
            let translationTitleLabelView = CGAffineTransform(translationX: 0, y: -140)
            
            self.userNameTextField.transform = translationUserNameTextField //анимация перемещения
            self.passwordtextField.transform = translationPasswordtextField
            self.titleLabelView.transform = translationTitleLabelView
            self.nameTitle.transform = translationNameTitle
            self.passwordTitle.transform = translationPasswordTitle
            self.appLabel.transform = translationAppLabel
        }
        
        //Анимация слоя СALayer; пружиной (the spring effect) падает кнопка "Login"
        let springEffectToLoginButton = CASpringAnimation.init(keyPath: "position.y")
        springEffectToLoginButton.toValue  = 370 // финишная позицию
        springEffectToLoginButton.duration = 2.4 // сек
        springEffectToLoginButton.mass = 4
        springEffectToLoginButton.stiffness = 90 //
        springEffectToLoginButton.damping = 15 //затухание
        springEffectToLoginButton.initialVelocity = 5
        loginButton.layer.add(springEffectToLoginButton, forKey: nil)
  
        
//        Storage.shared.friends = fillData() //8L1h50m в Storage записали Friendов
        
        loadingViewAnimation() //вызывается анимация перемигающих точек
        
        //задержка выполнения какого то кода
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) { [weak self] in
            self?.performSegue(withIdentifier: self?.toTabBarController ?? "", sender: nil)
        }
    }
}

