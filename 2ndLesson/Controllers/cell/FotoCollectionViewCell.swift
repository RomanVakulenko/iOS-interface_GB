//
//  FotoCollectionViewCell.swift
//  5thCollectionView
//
//  Created by Roman Vakulenko on 14.06.2022.
//

import UIKit

class FotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var fotoImafeView: UIImageView!
    @IBOutlet weak var likeControlView: LikeControlView! //8lesson47m
    
    var onlikeClosure: ((Bool,Int)->Void)? //8L1h36m тк нам надо будет его вызвать в другой функции в экстеншене ниже, сохраним замыкание
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImafeView.image = nil
        likeControlView.configure(isLiked: false, counter: 0) //8L
        onlikeClosure = nil ////8L1h37m обнулим чтобы не было артефактов
    }

    func configure (image: UIImage?, isLiked: Bool = false, likeCounter: Int, onlikeClosure: @escaping (Bool,Int)->Void){ //фолс, значит дефолтное состояние и мы не вынуждаем пользователя все заполнять - 8L
        //8L1h35m onlikeClosure чтобы передать нажатие и счетчик конкретному другу по конкретной фото в галерее
        fotoImafeView.image = image
        likeControlView.configure(isLiked: isLiked, counter: likeCounter) //8L
        likeControlView.delegate = self //берем свойство delegate класса LikeControlView и записываем туда сссылку на нашу ячейку (также как и с тейблВью,коллекшнВью и тд). Выдает ошибку типо мы не можем назначить ячейку, тк типо не соответствует LikeControlProtocol'у - уйдет, если сделаем расширение протокола, где и делаем реализацию
        self.onlikeClosure = onlikeClosure //8L1h36m30сек
    }
}

extension FotoCollectionViewCell : LikeControlProtocol {
    func pressLike(likeState: Bool, currentCounter: Int) {
//        print("counter \(currentCounter)") //покажем в консоли, что делегат будет отрабатывать корректно
//        print(likeState ? "true" : "false") //если likeState будет истина, то напишет тру, иначе фолс
        self.onlikeClosure?(likeState, currentCounter) //вызовем замыкание и отдадим ему 2 параметра
    }
}
