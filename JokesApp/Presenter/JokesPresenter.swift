//
//  Presnter.swift
//  JokesApp
//
//  Created by deeksha bhatia on 28/09/23.
//

import Foundation


class LoginPresenter {
    weak var view: LoginView?
    let loginService: LoginService

    init(view: LoginView, service: LoginService) {
        self.view = view
        self.loginService = service
    }

    func validateCredentials(username: String, password: String) {
        loginService.loginUser() { [weak self] result in
            switch result {
            case .joke:
                break
            case .failure(let message):
                break;
            }
        }
    }
}
//    func fetchData(completionHandler: @escaping([Jokes]) -> Void){
//        let url = URL(string: "https://geek-jokes.sameerkumar.website/api?format=json")!
//
//        let task = URLSession.shared.dataTask(with: url, completionHandler:{(data,response,error) in
//            if let error = error {
//                print("error with fetching films: \(error)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else{
//                print("Error with the response, unexpected status code: \(response)")
//                return
//            }
//            DispatchQueue.main.async {
//
//
//                if let data = data,
//
//                    let filmSummary = try? JSONDecoder().decode(Jokes.self, from: data){
//                    completionHandler([filmSummary])
//                }
//            }
//            view?.displayData(data: data)
//        })
//
//        task.resume();
//    }
//}
