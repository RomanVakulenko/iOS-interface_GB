//
//  GVC+CollectionViewDelegate.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 15.06.2022.
//

import UIKit

extension GallaryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
//9.1 FullScreen зададим фрейм во весь экран
        let fullScreenView = UIView(frame: self.view.bounds) //создадим fullScreenView
        let fullScreenImageView = UIImageView(frame: fullScreenView.frame) //создадим ImageView
        fullScreenView.addSubview(fullScreenImageView)// добавляем ImageView на fullScreenView
        
        let imageFullScreen = Storage.shared.friends[fotoAlbumIndex].fotoAlbum[indexPath.item].url //возьмем из Сторадж, добавили url,чтобы в строке ниже named было действиетльно строка
        fullScreenImageView.image = UIImage(named: imageFullScreen) // берем картинку (можно взять по имени, можно взять системную картинку systemName, можно взять из url)
        self.view.addSubview(fullScreenView) // 14m добавляем fullScreenView на абсолютно отдельную Вью (типо вызываем)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:))) // создадим tap
        fullScreenView.addGestureRecognizer(tap)// 20m добавляем на Вью tap
    }
    //нам нужны будут параметры(UITapGestureRecognizer), чтобы выцепить из него Вьюшку
    @objc func onTap(_ recognizer: UITapGestureRecognizer) {
        guard let targetView = recognizer.view else {return} //тк recognizer.view опционал, то его надо развернуть
        targetView.removeFromSuperview()
    }
}
