//
//  FotoHorizontalView.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 30.06.2022.
//

import UIKit

class FotoHorizontalView: UIView {

    @IBInspectable var inactiveIndicatorColor: UIColor = UIColor.lightGray //цвет неактивной точкиЛистания
    @IBInspectable var activeIndicatorColor: UIColor = UIColor.systemBlue//цвет активной точкиЛистания
    
    private var view: UIView? //
    
    private var interactiveAnimator: UIViewPropertyAnimator!
    
    private var mainImageView = UIImageView() //создали главную вью
    private var secondaryImageView = UIImageView() // создали второстепенную вью
    private var images = [UIImage]()// картинки будут из пока пустого массива класса UIImage
    private var isLeftSwipe = false // задали нач.значения
    private var isRightSwipe = false // задали нач.значения
    private var chooseFlag = false // задали нач.значения
    private var currentIndex = 0 // задали нач.значения
    private var customPageView = UIPageControl() // customPageView будет типа,кот.следитЗаПерелистыванием
    
    override init(frame: CGRect) {//во всех классах сначала в начале вызывается инициализатор, можем его переопределить и в нем достать этот XIB==NIB (new/file/View) - т.е. загрузить его в память
        super.init(frame: frame) //супер метод подтягивает сам все необходимое (инициализацию,выделение памяти,дескрипторы и тд), передадим в суперМетод frame
        setup() //вызовем и не важно каким способом мы инициализировали FotoHorizontalView, он все равно подхватит xib(nib) файл в функции loadFromNib() и прилепит его сверху на нашу view в FullScreenFotoViewController'e
    }
    
    required init?(coder: NSCoder) {//надо использовать инициализатор с кодером
        super.init(coder: coder)// тоже вызовем супер метод
        setup()
    }
    // напишем функцию, кот будет доставать Вью из xib(nib) файла:
    private func loadFromNib() -> UIView { //доступ в пределах класса,где объявлена (в ext буд.недоступна)
        let bundle = Bundle(for: type(of: self)) //селф, тк бандл лежит там же где и наш класс на диске
        let nib = UINib(nibName: "FotoHorizontalView", bundle: bundle) //можно поднять по имени
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()} //остается прикрутить к view. Тк возвращает массив и мы знаем, что там 1 элемент, то пишем фёст
        return nibView
    }
    
    private func setup() { //доступ в пределах класса,где объявлена (в ext буд.недоступна)
        view = loadFromNib() //загрузим вью
        guard let view = view else {return}
        view.frame = bounds // дефолтные границы
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight] // чтобы view следовала за основной вью:
        addSubview(view)
    
    }
    
//Далее обрабатываем нажатия
}
