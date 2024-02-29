//
//  AddEntryViewController.swift
//  Ad Payments
//
//  Created by Muhammed Ayaz on 28/02/24.
//

import UIKit

class AddEntryViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveBtnPress(_ sender: Any) {
        
        if nameTextField.text != "" && urlTextField.text != "" {
            
            if isValidUrl(urlString: urlTextField.text) {
                InsertIntoDB()
               
                self.navigationController?.popViewController(animated: true)
            } else {
                showAlert(title: "Error", message: "URL is not valid", controller: self)
            }
        } else {
            showAlert(title: "Error", message: "Empty not allowed", controller: self)
        }
        
    }
    
    
    func InsertIntoDB() {
        
        let databaseTableObj =  DataBaseHandler.sharedInstance.getTableObj(tableNameStr: Str_PaymentEntryTable) as! PaymentEntryTable
        
        let tempArray = DataBaseHandler.sharedInstance.fetchAllDataFromTable(entityNameStr: Str_PaymentEntryTable)
        
        databaseTableObj.name = nameTextField.text
        databaseTableObj.url = urlTextField.text
        databaseTableObj.id = String(tempArray.count)
        
        DataBaseHandler.sharedInstance.SaveInDB()
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
