//
//  Models.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/7/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import ObjectMapper

final class Pokemon: Mappable {
    var name: String = ""
    var urlString: String = ""

    init() {}

    init?(map: Map) {}

    func mapping(map: Map) {
        name <- map["name"]
        urlString <- map["url"]
    }
}

final class ListResultPokemon: Mappable {
    var count: Int = 0
    var previous: String = ""
    var next: String = ""
    var results: [Pokemon] = []

    init() {}
    
    init?(map: Map) {}

    func mapping(map: Map) {
        count <- map["count"]
        previous <- map["previous"]
        next <- map["next"]
        results <- map["results"]
    }
}
