//
//  Presnter.swift
//  JokesApp
//
//  Created by deeksha bhatia on 28/09/23.
//

import Foundation
import Alamofire

class JokesPresenter {
    var jokeView: JokesView?
   
    func attachView(view: JokesView?) {
        if let view = view { jokeView = view }
        
    }
    func getJokes(){
        let jokesURL = "https://geek-jokes.sameerkumar.website/api?format=json"
        AF.request(jokesURL, method: .get, encoding: JSONEncoding.default)
            .responseJSON{ response in
                switch response.result {
                case .success:
                    let decoder = JSONDecoder()
                    if let data = response.data{
                        do{
                            let jsonData = try decoder.decode(Jokes.self, from: data)
                            self.jokeView?.setJokes([JokesViewData(joke: jsonData.joke ?? "")])
                        }catch{
                            print("JSONDecoder Error",error)
                        }
                    }
                case .failure(_):
                    print("API Error")
                    break;
            }
        }
    }
}
