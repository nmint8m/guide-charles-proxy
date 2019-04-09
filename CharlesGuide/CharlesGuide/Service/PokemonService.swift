//
//  PokemonService.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/9/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

final class PokemonService {
    @discardableResult
    static func getListPokemon(urlString: String, completion: Completion<ListResultPokemon>?) -> Request? {
        return APIManager.shared.request(path: urlString,
                                         method: .get,
                                         completion:
            { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let value):
                        guard let json = value as? JSObject,
                            let listResult = Mapper<ListResultPokemon>().map(JSON: json) else {
                                completion?(.failure(API.Errors.jsonFormat))
                                return
                        }
                        completion?(.success(listResult))
                    case .failure(let error):
                        completion?(.failure(error))
                    }
                }
        })
    }
}
