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
    
    private var view: UIView?//
    
    private var interactiveAnimator: UIViewPropertyAnimator!
    
    private var mainImageView = UIImageView() //создали главную вью
    private var secondaryImageView = UIImageView() // создали второстепенную вью
    private var images = [UIImage]()// картинки будут из пока пустого массива класса UIImage
    private var isLeftSwipe = false // задали нач.значение
    private var isRightSwipe = false // задали нач.значение
    private var chooseFlag = false // однажды указываем направление движения, и по ходу изменяем
    private var currentIndex = 0 // задали нач.значение
    private var customPageView = UIPageControl() // customPageView будет того типа,кот.следитЗаПерелистыванием
    
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
        
        mainImageView.backgroundColor = UIColor.clear
        mainImageView.frame = self.bounds
        addSubview(mainImageView) //добавляем
        
        secondaryImageView.backgroundColor = UIColor.lightGray
        secondaryImageView.frame = self.bounds
        secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0) //установили сразу справа за экраном
        addSubview(secondaryImageView)
        
        customPageView.backgroundColor = UIColor.clear //установим точки перелистывания
        customPageView.frame = CGRect(x: 1, y: 1, width: 150, height: 50)
        customPageView.layer.zPosition = 100
        customPageView.numberOfPages = 1
        customPageView.currentPage = 0
        customPageView.pageIndicatorTintColor = self.inactiveIndicatorColor
        customPageView.currentPageIndicatorTintColor = self.activeIndicatorColor
        addSubview(customPageView)
        customPageView.translatesAutoresizingMaskIntoConstraints = false
        customPageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        customPageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.bounds.height / 15).isActive = true
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.addGestureRecognizer(recognizer)
    }
        
    private func onChange(isLeft: Bool) { //изменения, кот. произойдут при касании:
        self.mainImageView.transform = .identity //без анимации располагаем в origin точку, в нач.положение
        self.secondaryImageView.transform = .identity
        self.mainImageView.image = images[currentIndex] //говорим, что фото будут по текущему индексу
        
        if isLeft { //при свайпе влево
            self.secondaryImageView.image = images[self.currentIndex + 1] //2аяВью берет следущее фото
            self.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0) // ставим справа за экраном
        }
        else {
            self.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0) // ставим слева за экраном
            self.secondaryImageView.image = images[currentIndex - 1] //2аяВью берет предыдущее фото
        }
    }
    
    private func onChangeCompletion(isLeft: Bool) { //изменения будут завершаться этим:
        self.mainImageView.transform = .identity
        self.secondaryImageView.transform = .identity
        if isLeft {
            self.currentIndex += 1 //добавим, если был свайп влево
        }
        else {
            self.currentIndex -= 1
        }
        self.mainImageView.image = self.images[self.currentIndex] // как прочесть? зачем селфы
        self.bringSubviewToFront(self.mainImageView) // mainImageView будет поверх
        self.customPageView.currentPage = self.currentIndex
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) { //итак, логика работы
        if let animator = interactiveAnimator,
           animator.isRunning { //зачем это написано?
            return
        }
        
        switch recognizer.state { //у рекогнайзера есть states-состояния, через которые он проходит
        case .began: // палец коснулся вью
            self.mainImageView.transform = .identity // mainImageView в начальное ориджин состояние
            self.mainImageView.image = images[currentIndex]
            self.secondaryImageView.transform = .identity // в начальное ориджин состояние
            self.bringSubviewToFront(self.mainImageView)
            
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.3,
                                                         curve: .easeInOut,
                                                         animations: { [weak self] in
                                                            self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)//ДвигВлевоЗаЭкран
                                                         })
            interactiveAnimator.pauseAnimation() //ставим анимацию на паузу (тк за дальнейшее отвечает другой case)
            isLeftSwipe = false
            isRightSwipe = false
            chooseFlag = false
    
        case .changed: // палец двинулся вправо или влево
            var translation = recognizer.translation(in: self.view) //заберем из рекогнайзера перемещение пальца по Вью
            print(translation) // просто для проверки в консоли отрабатывает ли рекогнайзер
            
            if translation.x < 0 && (!isLeftSwipe) && (!chooseFlag) { //только если все тру, тогда заходим
                if self.currentIndex == (images.count - 1) {//чтобы не делать анимацию когда нет следующего изображения
                    interactiveAnimator.stopAnimation(true)
                    return
                }
                chooseFlag = true
                onChange(isLeft: true) //вызываем функцию
                
                interactiveAnimator.stopAnimation(true) //ТОЛЬКО ОСТАНОВИВ можем переопределять анимацию
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                    self?.secondaryImageView.transform = .identity
                }
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.onChangeCompletion(isLeft: true)
                })
                
                interactiveAnimator.startAnimation()
                interactiveAnimator.pauseAnimation()
                isLeftSwipe = true
            }
            
            if translation.x > 0 && (!isRightSwipe) && (!chooseFlag) {
                if self.currentIndex == 0 {
                    interactiveAnimator.stopAnimation(true)
                    return
                }
                chooseFlag = true
                onChange(isLeft: false)
                interactiveAnimator.stopAnimation(true) //ТОЛЬКО ОСТАНОВИВ можем переопределять анимацию
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    self?.secondaryImageView.transform = .identity
                }
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.onChangeCompletion(isLeft: false)
                })
                interactiveAnimator.startAnimation()
                interactiveAnimator.pauseAnimation()
                isRightSwipe = true
            }
            
            if isRightSwipe && (translation.x < 0) {return}//где ткнул палец - нулевая точка, пользователь может двигаться и вправо и влево от неё. От середины свайп немного влево, а затем до края вправо и, благодаря условию, картинка возвращается в исходное место плавно, несмотря на то, что пользователь ведёт палец дальше вправо(был бы лаг резкий скачок при отображении) - этот лаг игнорим if'ом
            if isLeftSwipe && (translation.x > 0) {return} //аналогично
            
            if translation.x < 0 {translation.x = -translation.x}
            
            interactiveAnimator.fractionComplete = translation.x / (UIScreen.main.bounds.width) //перемещение разделим на ширину экрана и получим % выполнения (работает только когда положительные значения) - нужно для отображения попиксельного-плавного перелистывания
            
        case .ended:
            if let animator = interactiveAnimator,
               animator.isRunning {
                return
            }
            var translation = recognizer.translation(in: self.view) //заберем из рекогнайзера перемещение пальца по Вью
            
            if translation.x < 0 {translation.x = -translation.x}

            if (translation.x / (UIScreen.main.bounds.width)) > 0.3  {
                interactiveAnimator.startAnimation()
            }
            else { //если не довел до 30% от ширины экрана, тогда:
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.finishAnimation(at: .start)
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = .identity
                    guard let weakSelf = self else {return}
                    if weakSelf.isLeftSwipe {
                        self?.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    }
                    if weakSelf.isRightSwipe {
                        self?.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                    }
                }
                
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.mainImageView.transform = .identity
                    self?.secondaryImageView.transform = .identity
                })
                
                interactiveAnimator.startAnimation()
            }
        default:
            return
        }
    }
    
    func setImages(images: [UIImage]) {
        self.images = images
        if self.images.count > 0 {
            self.mainImageView.image = self.images.first
        }
        customPageView.numberOfPages = self.images.count
    }
    
}
        
