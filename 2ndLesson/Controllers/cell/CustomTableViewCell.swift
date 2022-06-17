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
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
        
    }
    
    func configure (image: UIImage?, name: String?, description: String?) {
        fotoImageView.image = image
        nameLabel.text = name
        descriptionLabel.textColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        descriptionLabel.text = description
        
//скругляем края у картинок, а тень применяем ко Вью (в котором лежит сама аватарка-UIImage)
        fotoImageView.layer.cornerRadius = 30 // cutting corners with radius
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

}
