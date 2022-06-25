//
//  LikeControlView.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 17.06.2022.
//

import UIKit
// как делать CustomControl (heart - like)

@IBDesignable class LikeControlView: UIView {
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
   
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

//чтобы лайки не перезаписывались хаотично надо добавить конфигурилку(функцию), которая будет их либо чистить, либо устанавливать //8.45м если функцию кто-то вызвал(нажал), то мы устанавливаем исходные значения
    func configure(isLiked: Bool, counter: Int) {
        self.counter = counter
        isPressed = isLiked
        likeState() //чтобы код не дублировать - я здесь же вызову эту функцию - соответствие принципу DRY
    }
    
    func likeState () { //управляет состоянием лайков, ее вызываем по нажатию на лайк
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
    }
    
    
}
