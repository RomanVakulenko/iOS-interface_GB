//
//  Animator.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 04.07.2022.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let durationTimeInterval: Double = 2
    // transitionDuration и animateTransition - две обязательные функции для соответствия протоколу (фикс Хкода)
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationTimeInterval
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //достанем контроллеры
        guard let sourceVC = transitionContext.viewController(forKey: .from),
              let destinationVC = transitionContext.viewController(forKey: .to)
        else {return}
        
        //подготовимся к основной анимации
        transitionContext.containerView.addSubview(destinationVC.view) //на суперВью добавили destinationVC.view ссылкой
        let containerFrame = transitionContext.containerView.frame //запоминаем границы суперВью
        let upRightFrame = CGRect(x: 2*containerFrame.width, y: -containerFrame.width, width: 0, height: 0) //задали верхнееПравое расположениеПод90градусов и его размеры, оттуда будет анимация 2ой Вью(при переходе)
        let destinationFrame = sourceVC.view.frame //Созд.будущуюРамку для 2ой Вью такуюЖеКак sourceVC.view.frame и запомнили
        
        destinationVC.view.transform = CGAffineTransform(rotationAngle: -(.pi/2)) //2уюПовернем на 90град противЧасовой
        destinationVC.view.frame = upRightFrame //Для 2ой Вью зададим правое верхнее местоположение, размером с 0,0
        
        let upLeftFrame = CGRect(x: -0.5*containerFrame.height, y: -0.5*containerFrame.width, width: 0, height: 0) // задали верхнееЛевое расположение и его размеры 0,0, куда анимированно уйдет 1ая Вью
        
        //надо соблюсти соответствие длительности наших анимаций с заявленной изначальной длительностью анимации
        let duration = transitionDuration(using: transitionContext) // или просто = durationTimeInterval
        UIView.animate(withDuration: duration) {// соблюли соответствие длительности наших анимаций
            
            sourceVC.view.transform = CGAffineTransform(rotationAngle: .pi / 2)//анимируем по часовой на 90град
            sourceVC.view.frame = upLeftFrame // в верхнееЛевое расположение 1ую Вью
            
            destinationVC.view.transform = .identity //2ую вью отправлям в этоРасположение анимированно (производится в обратном порядке тому как ее туда при подготовке отправили)
            destinationVC.view.frame = destinationFrame//2Вью задаем целевоеМесторасп. - начПолож. 1ой Вью (запоминали)
            
        }  completion: { isOk in
                transitionContext.completeTransition(isOk)
            }
        }
    }






