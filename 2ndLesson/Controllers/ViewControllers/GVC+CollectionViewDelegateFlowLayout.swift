//
//  GVC+CollectionViewDelegateFlowLayout.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 15.06.2022.
//

import UIKit
// если нужно, чтобы в строке было всегда фиксированное число ячеек и большее переходило на новую строку, то:
extension GallaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 32
        let cellWidth = width/3 - whiteSpaces
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
