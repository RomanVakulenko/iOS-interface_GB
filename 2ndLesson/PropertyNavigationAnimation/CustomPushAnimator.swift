//
//  Animation.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 05.07.2022.
//

import UIKit
//сделан с кейфреймами, но по факту - это как мы и делали анимацию
class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6 }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view) // добавляем ссылку на ЦелевуюВью(куда переходим)
        destination.view.frame = source.view.frame // запоминаем для неё границы
        destination.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)//ставим ЦелевуюВью справо за экран
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.75, animations: {
                let translation = CGAffineTransform(translationX: -200, y: 0)
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                source.view.transform = translation.concatenating(scale) // сдвигаем текущуюВью влево, уменьшая
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2,
                               relativeDuration: 0.4, animations: {
                let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                destination.view.transform = translation.concatenating(scale) // задал вопрос Родиону и коллегам
            })
            UIView.addKeyframe(withRelativeStartTime: 0.6,
                               relativeDuration: 0.4, animations: {
                destination.view.transform = .identity // 2ая возвращается в рамки 1ой
            })
        })
        { finished in
            if finished && (!transitionContext.transitionWasCancelled) {
                source.view.transform = .identity }
            transitionContext.completeTransition(true)
        }
    }
}
