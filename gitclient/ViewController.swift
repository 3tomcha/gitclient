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
    var name = Array<String>()
    var owner = Array<String>()
    var url = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue(label: "test").async {
            self.loadData()
        }
        
        // セルの高さ
        TableView.estimatedRowHeight = 0
        
        // セクションヘッダー
        TableView.estimatedSectionHeaderHeight = 0
        
        // セクションフッター
        TableView.estimatedSectionFooterHeight = 0
        
        
        TableView.rowHeight = UITableViewAutomaticDimension
        
        let headerCell: UITableViewCell = TableView.dequeueReusableCell(withIdentifier: "TableHeaderCell")!
        let headerView: UIView = headerCell.contentView
        TableView.tableHeaderView = headerView
        
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
        
        let indexcase = indexPath.row % 3
        
        switch indexcase {
        case 0:
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomTableViewCell
            
            
            
            cell.setCell(LabelText1: self.stargazers_count[indexPath.row], LabelText2: self.name[indexPath.row], LabelText3: self.owner[indexPath.row])
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomTableViewCell
            
            
            
            cell.setCell(LabelText1: self.stargazers_count[indexPath.row], LabelText2: self.name[indexPath.row], LabelText3: self.owner[indexPath.row])
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int{
        
        return self.stargazers_count.count
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
        
        print(url[indexPath[1]])
        let url_url = URL(string:url[indexPath[1]])
        
        if( UIApplication.shared.canOpenURL(url_url!) ) {
            UIApplication.shared.open(url_url!)
        }

        
    }
    
    
    
    func loadData(){
        
        Alamofire.request(
            "https://api.github.com/search/repositories?q=swift+language:swift&sort=stars&order=desc"
            , method: .get, encoding: JSONEncoding.default).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    var i=0
                    while i<30{
                        let stargazers_value:String = json["items"][i]["stargazers_count"].stringValue
                        self.stargazers_count.append(stargazers_value)
                        let name_value:String = json["items"][i]["name"].stringValue
                        self.name.append(name_value)
                        let owner_value:String = json["items"][i]["owner"]["login"].stringValue
                        self.owner.append(owner_value)
                        
                        
                        let url_value:String = json["items"][i]["html_url"].stringValue
                        self.url.append(url_value)
//                        print(url_value)
                        
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

