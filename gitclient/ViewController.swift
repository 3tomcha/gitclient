//
//  ViewController.swift
//  gitclient
//
//  Created by 小林知弥 on 2018/02/24.
//  Copyright © 2018年 小林知弥. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Alamofire_Synchronous


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    
    
    
    var stargazers_count = Array<String>()
    var name: [Any] = []
    var owner: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
        DispatchQueue(label: "test").async {
            self.loadData()
        }
//
//        DispatchQueue.main.async{
//
//            self.TableView.reloadData()
//        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        // セルに表示する値を設定する
        if self.stargazers_count.count > 0 {
            cell.textLabel?.text = self.stargazers_count[indexPath.row]
        }
        
        print(self.stargazers_count[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int{
        
//        print(self.stargazers_count.count)
        return self.stargazers_count.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func loadData(){
        
        Alamofire.request(
            "https://api.github.com/search/repositories?q=swift+language:assembly&sort=stars&order=desc"
            , method: .get, encoding: JSONEncoding.default).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    var i=0
                    while i<100{
                        let stargazers_value:String = json["items"][i]["stargazers_count"].stringValue
                        self.stargazers_count.append(stargazers_value)
                        let name_value:String = json["items"][i]["name"].stringValue
                        self.name.append(name_value)
                        let owner_value:String = json["items"][i]["owner"]["login"].stringValue
                        self.owner.append(owner_value)
                        
                        
                        i+=1
                    }
                    self.TableView.reloadData()
                    
                    //                    return self.stargazers_count.count
                  
                    
                case .failure(let error):
                    print(error)
                }
                
        }
    }
    
    
    
}

