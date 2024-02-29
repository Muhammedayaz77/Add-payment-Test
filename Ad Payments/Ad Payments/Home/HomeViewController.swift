//
//  HomeViewController.swift
//  Ad Payments
//
//  Created by Muhammed Ayaz on 28/02/24.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBAction func addBtnPress(_ sender: Any) {
        let controller = AddEntryViewController(nibName: "AddEntryViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func viewBtnPress(_ sender: Any) {
        
        let tempArray = DataBaseHandler.sharedInstance.fetchAllDataFromTable(entityNameStr: Str_PaymentEntryTable)
        
        if tempArray.count > 0 {
            let controller = ViewEntryViewController(nibName: "ViewEntryViewController", bundle: nil)
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            showAlert(title: "No Record Found", message: "Please add some records", controller: self)
        }
        
       
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
