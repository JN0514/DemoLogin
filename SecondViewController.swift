//
//  ViewController.swift
//  Login_SnapKit
//
//  Created by Jayasurya on 16/08/22.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {

    private let refreshControl = UIRefreshControl()
    var dict: [Any] = []
//Post json data
    let param = """
{

}
""".data(using: .utf8)!
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = self.view.frame.size.height/3.1
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.separatorStyle = .none
        
        view.backgroundColor = .init(white: 1, alpha: 0.9)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        view.backgroundColor = .init(white: 1, alpha: 0.9)
        //Call the API
        loadUrl("")
        refreshControl.addTarget(self, action: #selector(refreshing), for: .valueChanged)
    }
    
    func setTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.idenitfier)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{
            make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshing), for: .valueChanged)
    }
    
    func setTimer(){
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshing), userInfo: nil, repeats: true)
    }
    @objc
    func refreshing(){
        //Call the API
        loadUrl("")
        self.refreshControl.endRefreshing()
    }
    
    func loadUrl(_ url: String){
        let session = URLSession.shared
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = param
        
        let task = session.dataTask(with: request){
            data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    guard let jsonObj = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObj, options: .prettyPrinted) else {
                        print("Error: Convert JSON object to pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    let d = jsonObj["response"]! as! [String: Any]
                    let d1 = d["data"]! as! [String: Any]
                    let d2 = d1["notes"]! as! [Any]
                    self.dict = d2
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch{
                    print("Error: Trying to convert JSON String")
                    return
                }
            }
        }
        task.resume()
    }

}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dict.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.idenitfier, for: indexPath) as! TableViewCell
        let eachCellDetail = dict[indexPath.row] as! [String: Any]
        let comp = eachCellDetail["symName"] as? String
        let time = eachCellDetail["udpateTime"] as? String
        let price = eachCellDetail["lTP"] as? String
        let exchange = eachCellDetail["source"] as? String
        let sentiment = eachCellDetail["sentiment"] as? String
        var imgURL = eachCellDetail["mediaURL"] as? String
        if(eachCellDetail["mediaType"] as? String == "PDF"){
            imgURL = eachCellDetail["thumbNailUrl"] as? String
        }
        print(eachCellDetail)
        cell.configureCell(comp: comp ?? "", time: time ?? "", price: price ?? "", exchange: exchange ?? "", sentiment: sentiment ?? "", imgURL: imgURL ?? "")
        return cell
    }
    
    
}
