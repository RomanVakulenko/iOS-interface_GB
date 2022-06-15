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
        
        cell.configure(image: UIImage(named: self.fotoAlbum[indexPath.item])) //откуда он возьмет имя файла, в котором будут лежать фотос
    
        return cell
    }
}
