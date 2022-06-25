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
        
        let localFotoAlbumIndex = fotoAlbumIndex
        let currentFotoAlbum = Storage.shared.friends[localFotoAlbumIndex].fotoAlbum
        let image = UIImage(named: currentFotoAlbum[indexPath.item].url)
 
        //1ч40 а уже в GallaryViewController в клоужер прилетают 2 параметра
        cell.configure(image: image, isLiked: currentFotoAlbum[indexPath.item].isLiked, likeCounter: currentFotoAlbum[indexPath.item].likeCounter, onlikeClosure: {isLikePressed, currentCounter in
            print("counter \(currentCounter)")
            print(isLikePressed ? "true" : "false")
            Storage.shared.friends[localFotoAlbumIndex].fotoAlbum[indexPath.item].isLiked = isLikePressed
            Storage.shared.friends[localFotoAlbumIndex].fotoAlbum[indexPath.item].likeCounter = currentCounter
        })
        return cell
    }
}
