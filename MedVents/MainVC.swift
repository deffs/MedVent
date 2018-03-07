//
//  MainVC.swift
//  MedVents
//
//  Created by Alex de France on 3/6/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit

struct Event {
    var time: String = ""
    var med: String = ""
    var type: String = ""
    var id: Int = 0
}

class MainVC: UIViewController {
    
    var elementToAdd: Event?
    var feed = [Event]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable),name:NSNotification.Name(rawValue: "updateTable"), object: nil)
    }
    
    func getData() {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String:AnyObject] {
                    if let events = jsonResult["events"] as? [[String:AnyObject]] {
                        for x in events {
                            var instance = Event()
                            instance.time = x["datetime"] as! String
                            instance.med = x["medication"] as! String
                            instance.type = x["medicationtype"] as! String
                            instance.id = x["id"] as! Int
                            feed.append(instance)
                        }
                    }
                }
                feed.sort {
                    $0.time < $1.time
                }
            }
            catch {
                // handle errors
            }
        }
        
    }
    
    @IBAction func addCell(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addCell", sender: self)
    }
    
    @objc func updateTable() {
        let index = IndexSet(integer: feed.count)
        feed.append(elementToAdd!)
        tableView.beginUpdates()
        tableView.insertSections(index, with: .automatic)
        feed.sort {
            $0.time < $1.time
        }
        tableView.endUpdates()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCell" {
            let vc = segue.destination as? AddVC
            vc?.tableCount = feed.count
        }
    }
    
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! MainTVCell
        
        cell.eventLbl.text = "\(feed[indexPath.section].id)"
        cell.medLbl.text = feed[indexPath.section].med
        cell.typeLbl.text = feed[indexPath.section].type
        cell.timeLbl.text = feed[indexPath.section].time
        
        if indexPath.section % 2 == 0 {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.4669565558, green: 0.1467571557, blue: 0.512390852, alpha: 1)
        } else {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.126434356, green: 0.7661903501, blue: 0.95423311, alpha: 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tableView.tableFooterView = footer
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
}
