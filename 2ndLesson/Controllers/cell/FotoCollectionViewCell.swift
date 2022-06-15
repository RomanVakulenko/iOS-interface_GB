//
//  FotoCollectionViewCell.swift
//  5thCollectionView
//
//  Created by Roman Vakulenko on 14.06.2022.
//

import UIKit

class FotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var fotoImafeView: UIImageView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImafeView.image = nil
    }
    

    func configure (image: UIImage?){
        fotoImafeView.image = image
    }
    
   
}
