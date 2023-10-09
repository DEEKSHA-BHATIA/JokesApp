//
//  JokesView.swift
//  JokesApp
//
//  Created by deeksha bhatia on 09/10/23.
//

import Foundation
protocol JokesView {
    func setJokes(_ jokes: [JokesViewData])
}
public struct JokesViewData {
    let joke: String
}

