//
//  CustomTableViewCell.swift
//  Table&CollectionView
//
//  Created by Roman Vakulenko on 06.06.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var viewForShadowFoto: UIView!
    
    var closure: ( () -> Void )? //8L2h27 сохраним и сделаем ? чтобы не инициализировать ее
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
        closure = nil           //обнуляем 8L2h28
    }
    
    func configure (image: UIImage?, name: String?, description: String?, closure: @escaping () -> Void) {//8L2h27 клоужер для факта нажатия
        fotoImageView.image = image
        nameLabel.text = name
        descriptionLabel.textColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        descriptionLabel.text = description
        self.closure = closure  //8L2h28
        
//скругляем края у картинок, а тень применяем ко Вью (в котором лежит сама аватарка-UIImage)
        fotoImageView.layer.cornerRadius = 65 // cutting corners with radius
        viewForShadowFoto.layer.shadowColor = UIColor.gray.cgColor
        viewForShadowFoto.layer.shadowOffset = CGSize(width: 8, height: 6) //смещение
        viewForShadowFoto.layer.shadowRadius = 5 //  размытие тени
        viewForShadowFoto.layer.shadowOpacity = 0.6 // то на сколько она будет затухать (до1)
    }
    
    //будет полезен при работе с фриендами
    func configure (_ group: Group) {
        fotoImageView.image = UIImage(named: group.avatar)
        nameLabel.text = group.name
        if let description = group.description {
            descriptionLabel.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            descriptionLabel.text = description
        }
    }
    
    @IBAction func pressImageViewButton(_ sender: UIButton) {
//        UIView.animate(withDuration: 0.7) {[weak self] in
//            self?.fotoImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6) // так мы изменяем мастшаб фото
//        } completion: { [weak self]_ in
//            self?.closure? () // переходим на след.Вью посредством клоужера
//        }

//ДЗ: чтобы картинка сжималась, потом пружиной разжималась и оставалась первоначального масштаба. Чтобы аватарка возвращалась в исходное состояние до масштабированного уменьшения и ОСТАВАЛАСЬ В ТАКОМ ИСХОДНОМ РАЗМЕРЕ 1 вариант: использовать перемещение 0,0 и тогда картинка как исходная
//        UIView.animate(withDuration: 1,
//                             delay: 0,
//                             options: []) { [weak self] in
//            self?.fotoImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
//        } completion: {_ in
//            UIView.animate(withDuration: 0.5,
//                           delay: 0,
//                           usingSpringWithDamping: 0.2, // пружиннаяАнимация,Damping - жесткостьПружины
//                           initialSpringVelocity: 1, //начальная скорость
//                           options: [],
//                           animations: { [weak self] in
//                                guard let self = self else {return} // избавились от опционала
//                                let translation = CGAffineTransform(translationX: 0, y: 0)//использовать перемещение 0,0 и тогда картинка как исходная //сместитьОтносительноИсхТ.(origin)
//                                self.fotoImageView.transform = translation //анимация перемещения
//                                },
//                               completion: { _ in
//                                    self.closure? ()}
//                          )
//                    }
//        }

//2ой вариант как уменьшить картинку и пружинно вернуть в размер, но после размер остается уменьшенный - solved below
        UIView.animate(withDuration: 0.6,
                    delay: 0,
                    options: [.autoreverse]) { [weak self] in
                self?.fotoImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

            } completion: { [weak self]_ in
                 self?.closure? ()
                self?.fotoImageView.transform = .identity //Чтобы вернуть в исходный размер картинку, нужно применить .identity
            }
    }
}
