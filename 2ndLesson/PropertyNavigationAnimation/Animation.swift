//
//  Animation.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 05.07.2022.
//

import UIKit
//сделан с кейфреймами, но по факту - это как мы и делали анимацию
class Animation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else {return}
        
        transitionContext.containerView.addSubview(destination.view) //добавили ссылкой 2ую вью(страницаКонкр.Друга)
        destination.view.frame = source.view.frame //запомнили границы
        
        destination.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)//УстСлевоЗаЭкран
        
        //управляемая по длительности анимирования элементов анимация
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModeCubicPaced) {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.5) {
                let translation = CGAffineTransform(translationX: -300, y: 0)
                let scale = CGAffineTransform(scaleX: 0.85, y: 0.85)
                source.view.transform = translation.concatenating(scale)//1уюВью сдвигаем вправо и уменьшаем
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5,
                               relativeDuration: 0.6) {
                let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 1.1, y: 1.1)
                destination.view.transform = translation.concatenating(scale)//2уюВью передвигаем вправо и увеличиваем
            }
            UIView.addKeyframe(withRelativeStartTime: 1.1,
                               relativeDuration: 0.9,
                               animations: {
                destination.view.transform = .identity //за 1.2 секунды возвращаем 2уюВью от 1.2 до масштаба = 1
            })
            
            
        } completion: { isSuccefully in
            if isSuccefully && (!transitionContext.transitionWasCancelled) {//если неfalse,тоВсеОк - анимацияПродолж.
                source.view.transform = .identity //вернем 1ую на свое начальное место
                transitionContext.completeTransition(true)
            }
            else {
                transitionContext.completeTransition(false)
            }
        }
    }
}
