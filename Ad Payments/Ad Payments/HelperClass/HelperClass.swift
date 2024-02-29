//
//  HelperClass.swift
//  Ad Payments
//
//  Created by Muhammed Ayaz on 28/02/24.
//

import Foundation
import UIKit


func verifyUrl (urlString: String?) -> Bool {
    if let urlString = urlString {
        if let url = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}

func isValidUrl(urlString: String?) -> Bool {
        //let regex = "((http|https|ftp)://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
    let regex = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        
    
    
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: urlString)
    }



func showAlert (title : String, message : String, controller : UIViewController) {
    
    // create the alert
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

    // add an action (button)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

    // show the alert
    controller.present(alert, animated: true, completion: nil)
}
