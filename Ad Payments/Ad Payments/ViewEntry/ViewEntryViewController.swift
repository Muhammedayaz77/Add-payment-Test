//
//  ViewEntryViewController.swift
//  Ad Payments
//
//  Created by Muhammed Ayaz on 28/02/24.
//

import UIKit
import CloudKit

class ViewEntryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dbPaymentEntryTableArray = [PaymentEntryTable]()
    
    
    @IBOutlet weak var aTableView: UITableView!
    
    override func viewDidLoad() {
        self.navigationController!.isNavigationBarHidden = false

        aTableView.register(UINib(nibName: "ViewEntryTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewEntryTableViewCellID")
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        initRecords()
        aTableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    
    func initRecords() {
        
        let tempArray = DataBaseHandler.sharedInstance.fetchAllDataFromTable(entityNameStr: Str_PaymentEntryTable)
        dbPaymentEntryTableArray.removeAll()
        for recentChatData in tempArray {
            dbPaymentEntryTableArray.append(recentChatData as! PaymentEntryTable)
        }
    }
    
    
    //MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbPaymentEntryTableArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromDB(index: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    //MARK: - cell For Row At indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewEntryTableViewCellID", for: indexPath) as! ViewEntryTableViewCell
        
        cell.nameLabel.text = dbPaymentEntryTableArray[indexPath.row].name
        cell.urlLabel.text = dbPaymentEntryTableArray[indexPath.row].url
        
        return cell
    }
    
    //MARK: - did Select Row At indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switchToModifyController(index: indexPath.row)
    }
    
    func switchToModifyController (index : Int) {
        let controller = ModifyViewController(nibName: "ModifyViewController", bundle: nil)
        controller.dbTableObject = dbPaymentEntryTableArray[index]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
    func deleteFromDB(index : Int) {
        
        DataBaseHandler.sharedInstance.deleteDataFromTable(managedObject: dbPaymentEntryTableArray[index])
        
        DataBaseHandler.sharedInstance.SaveInDB()
        initRecords()
        aTableView.reloadData()
        
    }
    
}
