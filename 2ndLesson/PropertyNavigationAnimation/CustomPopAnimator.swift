//
//  CustomPopAnimator.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 07.07.2022.
//

import UIKit
//Далее надо сделать идентичную анимацию для перехода назад. Для этого создадим новый класс-аниматор CustomPopAnimator.
class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6 }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view) //целевую Вью кладем "под" текущую
        destination.view.frame = source.view.frame // для целевой запоминаем рамки текущей Вью
        
        let translation = CGAffineTransform(translationX: -200, y: 0)
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        destination.view.transform = translation.concatenating(scale) // до анимации целевую вью переместили налево, уменьшив
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.4, animations: {
                let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                source.view.transform = translation.concatenating(scale) //текущаяВью перемещ.На0.5экранаВправо, увеличиваясь
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4,
                               relativeDuration: 0.4, animations: {
                source.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0) //текущаяВью перемещ.ВсюШиринуэкранаВправо,тем самым прячется за экраномСправа
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25,
                               relativeDuration: 0.75, animations: {
                destination.view.transform = .identity }) // Целевая Вью возвращается в запомненные рамки
        })
        { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(true)
        }
    }
}
