//
//  PokemonCellViewModel.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/9/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation

final class PokemonCellViewModel {
    let pokemon: Pokemon

    var pokemonName: String { return pokemon.name }

    var pokemonURLString: String { return pokemon.urlString }

    init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}
