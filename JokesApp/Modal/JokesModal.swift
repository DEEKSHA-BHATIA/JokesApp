//
//  JokesModal.swift
//  JokesApp
//
//  Created by deeksha bhatia on 28/09/23.
//

import Foundation
import Alamofire

class Jokes: Decodable {
    let joke: String?
    init(joke: String) {
        self.joke = joke
    }
}
