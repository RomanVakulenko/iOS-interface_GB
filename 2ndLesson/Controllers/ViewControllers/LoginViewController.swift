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
    @IBOutlet weak var yellowView: UIView!
    
    let toTabBarController = "toTabBarController" //делать константу не строкой, чтобы если дальше ошибемся, то Xcode нам подскажет где ошиблись, а в строке в кавычках он не распознает опечатку
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//Вариант с 3ей лекции:
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
//        self.view.addGestureRecognizer(recognizer)

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
    
//По долгому нажатию поле Name заполнится текстом "longPressGestureWorks" и добавил архив в Гит
    @objc func onPush () {
//        print("tap") - Варинат с лекции
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
// вырезали из другого контроллера и вставили тут, чтобы показать как работает Singleton (storage)
    func fillData() -> [Friend] {
        let myPhoto = MyFoto(url: "roman1")
        
        let friend1 = Friend(name: "Ivan", age: "34", avatar: "roman1", fotoAlbum: [myPhoto])
        let friend2 = Friend(name: "Roman", age: "27", avatar: "roman2", fotoAlbum: [myPhoto, myPhoto, myPhoto, myPhoto, myPhoto])
        let friend3 = Friend(name: "Petr", age: "23", avatar: "roman3", fotoAlbum: [myPhoto])
        let friend4 = Friend(name: "Egor", age: "14", avatar: "roman1", fotoAlbum: [myPhoto])
        let friend5 = Friend(name: "Alexey", age: "27", avatar: "roman2", fotoAlbum: [myPhoto,myPhoto,myPhoto])
        let friend6 = Friend(name: "Ignat", age: "23", avatar: "roman3", fotoAlbum: [myPhoto])
        var friendsArray = [Friend]()
        friendsArray.append(friend1)
        friendsArray.append(friend2)
        friendsArray.append(friend3)
        friendsArray.append(friend4)
        friendsArray.append(friend5)
        friendsArray.append(friend6)
        //8L57m добавим 30 друзей, чтобы проверить не перезаписываются ли лайки друзей scroll'oм
        for _ in 0...30 {
            friendsArray[1].fotoAlbum.append(myPhoto)
        }
        return friendsArray
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
/*               if let login = userNameTextField.text,
        login == "root" {
            userNameTextField.backgroundColor = UIColor.green
        }
        else {
            userNameTextField.backgroundColor = UIColor.magenta
        }
*/
        //анимация разлетания полей и Заглавия
        UIView.animate(withDuration: 2) {
            let translationUserNameTextField = CGAffineTransform(translationX: -400, y: 0) //сместитьОтносительноИсхТ.(origin)
            let translationPasswordtextField = CGAffineTransform(translationX: 400, y: 0)
            let translationTitleLabelView = CGAffineTransform(translationX: 0, y: -140)
            
            self.userNameTextField.transform = translationUserNameTextField //анимация перемещения
            self.passwordtextField.transform = translationPasswordtextField
            self.titleLabelView.transform = translationTitleLabelView
        }
        
        //Анимация слоя СALayer; пружиной (the spring effect) падает кнопка "Login"
        let springEffectToLoginButton = CASpringAnimation.init(keyPath: "position.y")
        springEffectToLoginButton.toValue  = 500 // финишная позицию
        springEffectToLoginButton.duration = 2.4 // сек
        springEffectToLoginButton.mass = 3
        springEffectToLoginButton.stiffness = 90 //
        springEffectToLoginButton.damping = 15 //затухание
        springEffectToLoginButton.initialVelocity = 10
        loginButton.layer.add(springEffectToLoginButton, forKey: nil)
  
        
        Storage.shared.friends = fillData() //8L1h50m в Storage записали Friendов
        
/*       loadingViewAnimation() //вызывается анимация перемигающих точек
        //задержка выполнения какого то кода
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) { [weak self] in
            self?.performSegue(withIdentifier: self?.toTabBarController ?? "", sender: nil)
        }
 */
        
//9.2.Animation.
//        UIView.animate(withDuration: 2) { [weak self] in
//            self?.yellowView.transform = CGAffineTransform(translationX: 150, y: 0)
//        } completion: { _ in
//            UIView.animate(withDuration: 2) { [weak self] in
//                self?.yellowView.transform = CGAffineTransform(translationX: 0, y: 100)
//            } completion: { _ in
//                UIView.animate(withDuration: 2) { [weak self] in
//                    self?.yellowView.transform = CGAffineTransform(translationX: -150, y: 0)
//                } completion: { [weak self] _ in
//                    guard let self = self else {return}
//                    self.performSegue(withIdentifier: self.toTabBarController, sender: nil)
//                }
//            }
//        }
        
//32m with Keyframes. Удобнее немного тем, что мы указываем долю времени (withRelativeStartTime) и не надо высчитывать сумму длительности анимации, чтобы была гладкой (но не факт что короче чем простая каскадная).
        UIView.animateKeyframes(withDuration: 9,
                                delay: 0,
                                options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) { //withRelativeStartTime - задержка
                [weak self] in
                    self?.yellowView.transform = CGAffineTransform(translationX: 150, y: 0)
                self?.userNameTextField.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5) //Сам класс UIView он не привязан к какой-то конкретной Вью - его можно применить к любому объекту/элементу - мы просто вызываем его методы- это пример с текстовым полем
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3) {
                [weak self] in
                    self?.yellowView.transform = CGAffineTransform(translationX: 0, y: 100)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                [weak self] in
                    self?.yellowView.transform = CGAffineTransform(translationX: -10, y: 0)
            }
        } completion: { [weak self] _ in
            guard let self = self else {return}
            self.performSegue(withIdentifier: self.toTabBarController, sender: nil)
        }
    }
}
