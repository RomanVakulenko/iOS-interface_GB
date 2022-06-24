//
//  FotoCollectionViewCell.swift
//  5thCollectionView
//
//  Created by Roman Vakulenko on 14.06.2022.
//

import UIKit

class FotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var fotoImafeView: UIImageView!
    @IBOutlet weak var likeControlView: LikeControlView!
    
    var onlikeClosure: ((Bool, Int) -> Void)? //сохраняем, т.к. его нам надо будет вызвать в функции pressLike. Так мы получаем escaping - поэтому ?

    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImafeView.image = nil
        likeControlView.configure(isLiked: false, counter: 0)
        onlikeClosure = nil //1ч37 обнулим, чтобы не было никаких артефактов
    }

    func configure (image: UIImage?, isLiked: Bool, likeCounter: Int, onlikeClosure: @escaping (Bool, Int) -> Void){ //1ч35м - добавим клоужер и передавать бул и инт
        fotoImafeView.image = image
        likeControlView.configure(isLiked: isLiked, counter: likeCounter)
        likeControlView.delegate = self // 1ч31м - берем свойство класса LikeControlView и записываем туда ссылку на нашу ячейку (также с тейблВью и коллекшнВью)
        self.onlikeClosure = onlikeClosure
    }
}
//Чтобы уйти от ошибки  вфункции выше напишем расширение протокола
extension FotoCollectionViewCell: LikeControlProtocol {
    func pressLike(likeState: Bool, currentCounter: Int) {
//        print("counter \(currentCounter)")   //делали для проверки вывода значений в консоль - т.е. работы кода
//        print(likeState ? "true" : "false")
        self.onlikeClosure?(likeState,currentCounter) // вызовем клоужер и передадим ему 2 параметра), сам опциональный
    }
}

