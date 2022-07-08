//
//  CustomNavigationController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 05.07.2022.
//

import UIKit
//10. 2ч01м создали файл subclass UINavigationController, в мейне переодпределяем класс на наш CustomNavigationController
class CustomNavigationController: UINavigationController {
    
    let interactiveTransition = InteractiveTransition() //для интерактивнойАнимации нам нужен класс InteractiveTransition - создали объект, который будет управлять переходом
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self//"закручиваем делегат на сам CustomNavigationController",можно было "закрутить" на любой другой вьюконтроллер
    }
}

// т.к. закрутили делегат на сам контроллер, то в экстеншене:
extension CustomNavigationController: UINavigationControllerDelegate {
    
    //даем понять CustomNavigationController, что у нас интерактивная анимация
    //Теперь, когда есть готовый обработчик(interactiveTransition), можем использовать его в кастомном navigation controller. добавим его в код
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.isAnimationStarted ? interactiveTransition : nil //если анимация стартовала, то передаем ему ссылку на interactiveTransition, иначе нил (В методе делегата проверим свойство isAnimationStarted: если true — возвращаем объект, если false — возвращаем nil)
    }
    
    
    //Осталось присвоить свойству объекта тот viewController, для которого хотим сделать интерактивный переход. Этот код добавим в метод делегата, где он запрашивает аниматор
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //        if operation == .push { //если пуш, то мы запоминаем этот VC, на него налип UIPanGestureRecognizer  и рекогнайзер активирует стандартную анимацию(@objc func onPan...), т.е. интерактивная анимация в данном конкретном случае (.push) будет только при переходе назад
        //            interactiveTransition.viewController = toVC
        //        }
        //        return Animation() //Animator() //прописываем анимацию отдельно в файле Animation, а в файле InteractiveTransition - покадровость
        //    }
        if operation == .push {
            interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        } else if operation == .pop {
            interactiveTransition.viewController = fromVC
            return CustomPopAnimator()
        }
        return nil }
}

