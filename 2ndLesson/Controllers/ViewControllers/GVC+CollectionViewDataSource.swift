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
         
        let localFotoAlbumIndex = fotoAlbumIndex
        let currentFotoAlbum = Storage.shared.friends[localFotoAlbumIndex].fotoAlbum //8.3.SavingLikesBySingleton
        
        let image = UIImage(named: currentFotoAlbum[indexPath.item].url) //рисует не просто Петра какого-то, а чтото из фотоальбома; то, откуда он возьмет имя файла, в котором будут лежать фотос 8.3.SavingLikesBySingleton  - вставили
        
        cell.configure(image: image, isLiked: currentFotoAlbum[indexPath.item].isLiked, likeCounter: currentFotoAlbum[indexPath.item].likeCounter, onlikeClosure: { [weak self] isLikePressed, currentCounter in //8L1h38m конфигурируем дополнительно клоужер; в клоужер прилетает 2 параметра нажата/нет и числоНажатий; 8.3.SavingLikesBySingleton 8L2h00 с использованием Storage мы должны в конфигураторе не просто лайкКаунтер , а должны считать его например из фотольбома
            print("counter \(currentCounter)") //выведем в консоль - посмотрим как отрабатывает делегат
            print(isLikePressed ? "true" : "false") //если likeState будет истина, то напишет тру, иначе фолс
            
            //8.3.SavingLikesBySingleton 8L1h57m можем в клоужере поменять наш singleton:
            Storage.shared.friends[self?.fotoAlbumIndex ?? 0].fotoAlbum[indexPath.item].isLiked = isLikePressed
            Storage.shared.friends[self?.fotoAlbumIndex ?? 0].fotoAlbum[indexPath.item].likeCounter = currentCounter
            
        })
        
        return cell
    }
}
