//
//  ViewController.swift
//  MVPSample
//
//  Created by 謝佳瑋 on 2017/2/22.
//  Copyright © 2017年 謝佳瑋. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {
    var presenter:LoginPresenter?

    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = LoginPresenter(view: self)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLoginSuccess(_ text:String){
        self.showMessage(text, type: .success)
    }
    @IBAction func login(_ sender: UIButton) {
        guard !(self.account.text?.isEmpty)! || !(self.password.text?.isEmpty)! else {
            return
        }
        let model = LoginModel(account: self.account.text!, password: self.password.text!)
        self.presenter?.login(model)
    }


}

