//
//  GVC+CollectionViewDataSource.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 15.06.2022.
//

import UIKit

extension GallaryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    { return self.fotoAlbum.count }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fotoCollectionViewReuseIdentifier, for: indexPath) as? FotoCollectionViewCell else {return UICollectionViewCell()}
        
//        cell.configure(image: UIImage(named: self.fotoAlbum[indexPath.item])) //рисует не просто Петра какого-то, а чтото из фотоальбома; то, откуда он возьмет имя файла, в котором будут лежать фотос
        let image = UIImage(named: self.fotoAlbum[indexPath.item].url)
        cell.configure(image: image, isLiked: true, likeCounter: 5)
        return cell
    }
}
