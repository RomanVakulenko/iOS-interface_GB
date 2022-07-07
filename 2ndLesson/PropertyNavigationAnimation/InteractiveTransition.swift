//
//  InteractiveTransition.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 05.07.2022.
//

import UIKit
//10.2. 2h03m
class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var viewController: UIViewController? { //определяем UIViewController"у свойство UIViewController, кот. мы ему подставим для последующей анимации
        didSet {// и когда мы устанавливаем этот контроллер мы добавляем на него рекогнайзер
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
            viewController?.view.addGestureRecognizer(panGestureRecognizer)
            //в методичке panEdgeGestureRecognizer - это пальцем от края экрана - мышкой не получится потому простоПан
        }
    }
    private var isRightSwipe = false // задали нач.значение
    
    var complete = false
    var isAnimationStarted = false
    //2h05m. здесь мы прописываем ТОЛЬКО покадровость анимации, а саму анимацию мы делаем в файле Animation
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state { //покадровая как в кастомном переходе по сеге или в пропертиАниматор
        case .began:
            isAnimationStarted = true
            self.viewController?.navigationController?.popViewController(animated: true) //типа поп
            self.pause()
            
            isRightSwipe = false
            
        case .changed:
            var translation = recognizer.translation(in: recognizer.view)
            
            if translation.x > 0 && (!isRightSwipe) {
//                if translation.x < 0 {translation.x = -translation.x} //определяем влево/вправо - куда ведет палец
                let percentComplete = translation.x / (recognizer.view?.frame.width ?? 1)
                let progress = max(0, min(1, percentComplete))
                if progress > 0.3 {complete = true} //если больше 0.3, то завершаем анимацию, если нет - то возвращаем
                self.update(progress)
            }
// Родион, почему закомментированное ниже не сработало (до else пытался так решить вопрос с левым свайпом)?
//            if isRightSwipe && (translation.x < 0) {return}//где ткнул палец - нулевая точка, пользователь может двигаться и вправо и влево от неё. От середины свайп немного влево, а затем до края вправо и, благодаря условию, Вью должна возвращаться в исходное место плавно, несмотря на то, что пользователь ведёт палец дальше вправо(был бы лаг резкий скачок при отображении) - в случае с листанием фоток это работало, а как сдесь сделать так, чтобы на левый свайп не было реакции, даже если потом передумал и повел вправо - в общем как сдлетаь то же самое(что работало с истанием фоток) только здесь при анимации контроллеров?
//            isRightSwipe = false
            else {
                self.cancel() // оптимальное ли это решение (вместо того, что вышеЗакомментированное) для того, чтобы реакцию на левый свайп отключить? ведь после cancel все заново загружается - повлияет ли заметно на быстродействие на, каком-нибудь 6ом айфоне, да и вообще?
            }
        case .ended:
            isAnimationStarted = false
            if complete { //если комплит true - то финишируем, иначе отменяем
                self.finish()
            }
            else {
                self.cancel()
            }
        default:
            isAnimationStarted = false //возвращаем все значения в исходную позицию
        }
    }
}
