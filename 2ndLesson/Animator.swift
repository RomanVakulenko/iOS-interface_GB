//
//  Animator.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 04.07.2022.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let durationTimeInterval: Double = 3
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
        //destinationVC.view.frame = containerFrame // 2ую вью ставится как 1ая
        
        let destinationFrame = sourceVC.view.frame //запомнилиСозд.будущуюРамку для 2ой Вью такуюЖеКак sourceVC.view.frame
        
        destinationVC.view.frame = upRightFrame //2ую Вью установим в правое верхнее местоположение, размером с 0,0)
        destinationVC.view.transform = CGAffineTransform(rotationAngle: -.pi/2) //2ую повернем на 90градусов противЧасовой
        
        let upLeftFrame = CGRect(origin: CGPoint(x: -0.5*containerFrame.height, y: -0.5*containerFrame.width), size: CGSize(width: 0.5*containerFrame.width, height: 0.5*containerFrame.height))// задали верхнееЛевое расположение и его размеры - куда придет 1ая Вью
        
        //мы должны соблюсти соответствие длительности наших анимаций с заявленной изначально длительностью анимации
        let duration = transitionDuration(using: transitionContext) // или просто = durationTimeInterval
        
        UIView.animate(withDuration: duration/2) {
            sourceVC.view.frame = upLeftFrame // 1ой Вью задаем верхнееЛевое расположение
            sourceVC.view.transform = CGAffineTransform(rotationAngle: .pi / 2)//анимируем туда по часовой на 90град
        } completion: { _ in
            UIView.animate(withDuration: duration/2) {
                destinationVC.view.frame = destinationFrame//2ой вью задаем расположение 1ой Вью (запоминали)
                destinationVC.view.transform = .identity //2ую вью анимированно отправлям на место 1ой
            } completion: { isOk in
                transitionContext.completeTransition(isOk)
            }
        }
    }
}





