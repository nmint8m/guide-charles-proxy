//
//  PokemonListViewModel.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/9/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation

final class PokemonListViewModel {

    var listResult = ListResultPokemon()
    var currentURLString = API.Path.Pokemon.pokemon

    var status: String {
        if listResult.count == 0 {
            return "Không có pokemon."
        }
        return listResult.count > 1 ? "Hiện có \(listResult.count) pokemon." : "Hiện chỉ có 1 pokemon."
    }

    var previousURLString: String { return listResult.previous }

    var nextURLString: String { return listResult.next }

    var pokemons: [Pokemon] { return listResult.results }

    func getListPokemon(pageType: PageType, completion: CompletionHandler?) {
        switch pageType {
        case .previous: getListPokemon(urlString: previousURLString, completion: completion)
        case .current: getListPokemon(urlString: currentURLString, completion: completion)
        case .next: getListPokemon(urlString: nextURLString, completion: completion)
        }
    }

    func getListPokemon(urlString: String, completion: CompletionHandler?) {
        PokemonService.getListPokemon(urlString: urlString) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let listResult):
                this.listResult = listResult
                this.currentURLString = urlString
                completion?(.success)
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    func numberOfPokemon() -> Int {
        return pokemons.count
    }

    func viewModelForCell(indexPath: IndexPath) -> PokemonCellViewModel {
        guard indexPath.row < pokemons.count else { return PokemonCellViewModel(Pokemon()) }
        return PokemonCellViewModel(pokemons[indexPath.row])
    }
}

extension PokemonListViewModel {
    enum PageType {
        case previous
        case current
        case next
    }
}
