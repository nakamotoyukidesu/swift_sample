//
//  FavoriteState.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/02/18.
//

import Foundation
import UIKit

protocol ArticleCellState {
    func favoriteButtonTapped(articleCell: SubViewController)
}

// State classes
class CellStateRegisteredAsFavorite: NSObject, ArticleCellState {
    func favoriteButtonTapped(articleCell: SubViewController) {
        articleCell.removeFavorite()    // Do action(s) for the state
        articleCell.setState( state: CellStateNotRegisteredAsFavorite() )      // Set new state
    }
}

class CellStateNotRegisteredAsFavorite: NSObject, ArticleCellState {
    func favoriteButtonTapped(articleCell: SubViewController) {
        articleCell.addFavorite()       // Do action(s) for the state
        articleCell.setState( state: CellStateRegisteredAsFavorite() )      // Set new state
    }
}


