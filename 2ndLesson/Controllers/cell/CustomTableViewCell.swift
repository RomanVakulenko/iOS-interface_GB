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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
        
    }
    
    func configure (image: UIImage?, name: String?, description: String?) {
        fotoImageView.image = image
        nameLabel.text = name
        descriptionLabel.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        descriptionLabel.text = description
    }
       
}
