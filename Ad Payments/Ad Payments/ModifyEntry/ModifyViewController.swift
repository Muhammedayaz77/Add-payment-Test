//
//  ModifyViewController.swift
//  Ad Payments
//
//  Created by Muhammed Ayaz on 29/02/24.
//

import UIKit

class ModifyViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var urlTextField: UITextField!
    
    var dbTableObject = PaymentEntryTable()
    

    override func viewDidLoad() {
        
        
        nameTextField.text = dbTableObject.name
        urlTextField.text = dbTableObject.url
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateBtnPress(_ sender: Any) {
        
        if nameTextField.text != "" && urlTextField.text != "" {
            
            if isValidUrl(urlString: urlTextField.text) {
                updateIntoDB()
               
                self.navigationController?.popViewController(animated: true)
            } else {
                showAlert(title: "Error", message: "URL is not valid", controller: self)
            }
        } else {
            showAlert(title: "Error", message: "Empty not allowed", controller: self)
        }
    }
    
    
    func updateIntoDB() {
        
        dbTableObject.name = nameTextField.text
        dbTableObject.url = urlTextField.text
        
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
