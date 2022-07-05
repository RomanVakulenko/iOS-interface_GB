//
//  Animator.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 04.07.2022.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let durationTimeInterval: Double = 1
    // transitionDuration и animateTransition - две обязательные функции для соответствия протоколу (фикс Хкода)
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationTimeInterval
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //достанем контроллеры
        guard let sourceVC = transitionContext.viewController(forKey: .from),
              let destinationVC = transitionContext.viewController(forKey: .to)
        else {return}
        
        //подготовимся к анимации
        transitionContext.containerView.addSubview(destinationVC.view) //на суперВью добавили destinationVC.view ссылкой
        let containerFrame = transitionContext.containerView.frame //запоминаем границы суперВью
        let upRightFrame = CGRect(x: 2*containerFrame.width, y: -containerFrame.width, width: 0, height: 0) // задали верхнееПравое расположение и его размеры - куда придет 2ая Вью
        
        let destinationFrame = sourceVC.view.frame //запомнилиСозд.будущуюРамку для 2ой Вью такуюЖеКак sourceVC.view.frame
        
        destinationVC.view.transform = CGAffineTransform(rotationAngle: -(.pi/2)) //2ую повернем на 90градусов противЧасовой
        destinationVC.view.frame = upRightFrame //2ую Вью установим в правое верхнее местоположение, размером с 0,0)
        
        let upLeftFrame = CGRect(x: -0.5*containerFrame.height, y: -0.5*containerFrame.width, width: 0.5*containerFrame.width, height: 0.5*containerFrame.height) // задали верхнееЛевое расположение и его размеры - куда придет 1ая Вью
        
        //мы должны соблюсти соответствие длительности наших анимаций с заявленной изначальной длительностью анимации
        let duration = transitionDuration(using: transitionContext) // или просто = durationTimeInterval
        
        UIView.animate(withDuration: duration) {// соблюли соответствие длительности наших анимаций
            
            sourceVC.view.transform = CGAffineTransform(rotationAngle: .pi / 2)//анимируем по часовой на 90град
            sourceVC.view.frame = upLeftFrame // в верхнееЛевое расположение
            
            destinationVC.view.transform = .identity //2ую вью анимированно отправлям в начМесторасположение
            destinationVC.view.frame = destinationFrame//2ой вью задали начМесторасп. - расположение 1ой Вью (запоминали)
            
        }  completion: { isOk in
                transitionContext.completeTransition(isOk)
//                sourceVC.view.transform = .identity //возвращает 1ую Вью в начальное место
            }
        }
    }






