//
//  ViewController.swift
//  Ad Payments
//
//  Created by Muhammed Ayaz on 28/02/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        DataBaseHandler.sharedInstance.copyDatabase()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // your function here
            self.SwitchToHomeScreen()
        }
    }
    
    func SwitchToHomeScreen () {
        
        // Register Nib
//        let viewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
//        viewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.present(viewController, animated: false, completion: nil)
        
        
        
        let  vc =  HomeViewController(nibName:"HomeViewController",bundle:Bundle.main)
           if let navigator = self.navigationController {
               navigator.pushViewController(vc, animated: true)
           }else{
               let navigation  = UINavigationController(rootViewController:vc)

               navigation.isNavigationBarHidden = true
               navigation.modalPresentationStyle = .fullScreen
               self.present(navigation, animated: true, completion: nil)
           }
        
    }
    

}

