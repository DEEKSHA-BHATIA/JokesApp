//
//  ViewController.swift
//  JokesApp
//
//  Created by deeksha bhatia on 27/09/23.
//

import UIKit




class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private var myTableView: UITableView!
    var timer: Timer?
    private var films: [Jokes]?
    var arr : [String]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        startTimer()
    }
    
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            let urlString = "https://geek-jokes.sameerkumar.website/api?format=json"
            
            // Ensure the string is a valid URL
            if let url = URL(string: urlString) {
                // Create a URL session task
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    // Ensure there's no error, and there is data to process
                    if let error = error {
                        print("Error fetching data: \(error)")
                        return
                    }
                    if let data = data,
                       
                        let filmSummary = try? JSONDecoder().decode(Jokes.self, from: data){
                        print("ddds",filmSummary.joke!)
                        self!.films = [filmSummary]
                        self?.arr?.append(filmSummary.joke!)
                        DispatchQueue.main.async {
                            self!.myTableView.reloadData()
                        }
                    }
                }
                
                // Start the task
                task.resume()
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(String(describing: self.arr?[indexPath.row]))"
        cell.backgroundColor = UIColor.green
        return cell
    }
    
    func fetchFilms(completionHandler: @escaping([Jokes]) -> Void){
        let url = URL(string: "https://geek-jokes.sameerkumar.website/api?format=json")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler:{(data,response,error) in
            if let error = error {
                print("error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else{
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            DispatchQueue.main.async {
                
                
                if let data = data,
                   
                    let filmSummary = try? JSONDecoder().decode(Jokes.self, from: data){
                    self.films = [filmSummary]
                    completionHandler(self.films!)
                }
            }
        })
        
        task.resume();
    }
}

