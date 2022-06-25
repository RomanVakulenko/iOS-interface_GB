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
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImafeView.image = nil
        likeControlView.configure(isLiked: false, counter: 0)
    }

    
    func configure (image: UIImage?, isLiked: Bool, likeCounter: Int){ // и тем самым заставляем пользователя каждый раз писать эти поля; если бы написали isLiked: Bool = false и пользователь бы не написал, то было бы это дефолтное - фолс
        fotoImafeView.image = image
        likeControlView.configure(isLiked: isLiked, counter: likeCounter)
    }
}
