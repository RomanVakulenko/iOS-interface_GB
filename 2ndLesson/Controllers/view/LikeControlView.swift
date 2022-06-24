//
//  LikeControlView.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 17.06.2022.
//

import UIKit
// как делать CustomControl (heart - like)

//8L1h23m надо из LikeControlView передать нажатия и счет лайков - напишем протокол

protocol LikeControlProtocol: AnyObject { //8L1h29m AnyObject - так мы говорим, что протокол только для ссылочного типа - т.е этот протокол смогут использовать какие-то объекты, т.е классы, которые ссылку на себя смогут передать в качестве делегата
    func pressLike(likeState: Bool, currentCounter: Int)
}


class LikeControlView: UIView {
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
   
    weak var delegate: LikeControlProtocol? //8L1h26m надо объявить протокол - дать ссылку на него, weak + AnyObject  в протоколе развязывают цикл сильных ссылок
    var counter = 0
    var isPressed = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup() //после написанного кода дописали, что тут вызываем setup и не важно каким способом мы инициализировали LikeControlView, он все равно подхватит xib файл в func loadFromXIB() и прилепит его сверху на нашу вью
    }
//если будем использовать в сториборде,то нам нужно переопределять инициализатор с кодером - фиксим, убираем код и вызываем супер.инит
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup() //после написанного кода дописали, что тут вызываем setup и не важно каким способом мы инициализировали LikeControlView, он все равно подхватит xib файл в func loadFromXIB() и прилепит его сверху на нашу вью
    }

// напишем функцию, кот будет доставать наш xib файл и чтобы к ней не было доступа извне:
    private func loadFromXIB() -> UIView { //доступ в пределах класса, где объявлена
        let bundle = Bundle(for: type(of: self)) // селф, тк  бандл лежит там же где и наш класс на диске
        let xib = UINib(nibName: "LikeControlView", bundle: bundle) //bundle  - то место где лежат наши файлы
        
//остается прикрутить к view
        let xibView = xib.instantiate(withOwner: self).first as! UIView //тк возвращает массив и мы знаем, что там 1 элемент, то пишем фёст; тк там только UiView, то as"!" forceUnwrap
        return xibView
    }
// вьюшку, что достали из xib файла, берем и прилепляем на текущую вью
    private func setup() {
        let xibVew = loadFromXIB()
        // берем границы нашей вьюшки и размещаем в них xibView
        xibVew.frame = self.bounds // self, тк наш ЛайкКонтролВью наследник UIView, то мы можем вызвать баундс
        
        // чтобы xibview следовала за основной вью:
        xibVew.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibVew)
        
        counterLabel.text = String(counter) //обрабатываем нажатия
    }

//8.45м если функцию кто-то вызвал(нажал), то мы устанавливаем исходные значения
    func configure(isLiked: Bool, counter: Int) {
        self.counter = counter
        isPressed = isLiked
    }
    
    func likeState () { //ее вызываем по нажатию на лайк
        if isPressed {
            heartImageView.image = UIImage.init(systemName: "heart.fill")
        }
        else {
            heartImageView.image = UIImage.init(systemName: "heart")
        }
        counterLabel.text = String(counter)
    }
    
    @IBAction func pressLikeButton(_ sender: UIButton) {
        isPressed = !isPressed //нажали и кнопка стала тру, если была фолс
        if isPressed {
            counter += 1
        }
        else {
            counter -= 1
        }
        likeState() //8L54m меняется состояние лайка и число
        delegate?.pressLike(likeState: isPressed, currentCounter: counter) // 1ч30м ? - опциональный, т.к. слабая ссылка
    }
    
    
}
