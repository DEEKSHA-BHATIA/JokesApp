//
//  ViewController.swift
//  JokesApp
//
//  Created by deeksha bhatia on 27/09/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var jokesArray: [String]? = []
    private var myTableView: UITableView!
    var timer: Timer?
    let cellReuseIdentifier = "PaddedCell"
    fileprivate let jokesPresenter = JokesPresenter()
    fileprivate var jokesToDisplay = [JokesViewData]()
    let maxItems = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let statusBarFrame = windowScene.statusBarManager?.statusBarFrame
            let barHeight: CGFloat = statusBarFrame?.size.height ?? 0
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            myTableView = UITableView(frame: CGRect(x: 10, y: barHeight + 20, width: displayWidth - 10, height: displayHeight - barHeight))
        }
        self.view.backgroundColor = UIColor.black
        myTableView.backgroundColor = UIColor.black
        myTableView.register(PaddedTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        self.jokesPresenter.attachView(view: self)
        startTimer()
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.jokesPresenter.getJokes()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if jokesArray?.count ?? 0 > maxItems {
            jokesArray?.removeFirst()
        }
        return self.jokesArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as! PaddedTableViewCell
        let reversedIndex = ((jokesArray?.count ?? 0) - 1) - indexPath.row
        let userViewData = jokesArray?[reversedIndex]
        cell.textLabel?.text = userViewData?.description ?? ""
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.backgroundColor = UIColor.black
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel(frame: CGRect(x: 140, y: 0, width: tableView.bounds.width, height: 20))
        label.text = "Unlimit Jokes"
        label.textColor = UIColor(red: 57/255, green: 255/255, blue: 20/255, alpha: 1.0)
        headerView.addSubview(label)
        return headerView
    }
    
}
extension ViewController : JokesView{
    func setJokes(_ jokes: [JokesViewData]) {
        jokesToDisplay = jokes
        jokesArray?.append(jokesToDisplay[0].joke)
        myTableView?.reloadData()
    }
}
