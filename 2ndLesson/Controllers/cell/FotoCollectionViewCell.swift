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
    
    var onlikeClosure: ((Bool, Int) -> Void)? //8.2.2 (нажатый лайк и счет надо передать в GallaryViewController closure2) сохраняем, т.к. его нам надо будет вызвать в функции pressLike. Так мы получаем escaping - поэтому ?

    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImafeView.image = nil
        likeControlView.configure(isLiked: false, counter: 0)
        onlikeClosure = nil //8.2.2 (нажатый лайк и счет надо передать в GallaryViewController closure4) 1ч37 обнулим, чтобы не было никаких артефактов
    }

    func configure (image: UIImage?, isLiked: Bool, likeCounter: Int, onlikeClosure: @escaping (Bool, Int) -> Void){ //8.2.2 (нажатый лайк и счет надо передать в GallaryViewController closure1) 1ч35м - добавим клоужер и передает он бул и инт
        fotoImafeView.image = image
        likeControlView.configure(isLiked: isLiked, counter: likeCounter)
        likeControlView.delegate = self //8.2.2 (LikeControlView передать нажатия и счет лайков_delegate4) 1ч31м - берем свойство класса LikeControlView и записываем туда ссылку на нашу ячейку (также с тейблВью и коллекшнВью)
        self.onlikeClosure = onlikeClosure //8.2.2 (нажатый лайк и счет надо передать в GallaryViewController closure3)
    }
}
//8.2.2 (LikeControlView передать нажатия и счет лайков_delegate5)  Чтобы уйти от ошибки в функции выше напишем расширение протокола
extension FotoCollectionViewCell: LikeControlProtocol {
    func pressLike(likeState: Bool, currentCounter: Int) {
//        print("counter \(currentCounter)")   //делали для проверки вывода значений в консоль - т.е. работы кода
//        print(likeState ? "true" : "false")
        self.onlikeClosure?(likeState,currentCounter) //8.2.2 (нажатый лайк и счет надо передать в GallaryViewController closure4) вызовем клоужер и передадим ему 2 параметра, сам опциональный
    }
}

