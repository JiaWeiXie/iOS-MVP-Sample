//
//  LoginPresenter.swift
//  MVPSample
//
//  Created by 謝佳瑋 on 2017/2/22.
//  Copyright © 2017年 謝佳瑋. All rights reserved.
//

import Foundation

class LoginPresenter:Presenter{
    var loginView:LoginViewController?
    
    required init(view:LoginViewController){
        super.init(delegate: view)
        self.loginView = view as LoginViewController?
    }
    
    func login(_ model:LoginModel){
        let api = ApiHelper(delegate: self)
        let json = JSONBuilder()
        let mirror = Mirror(reflecting: model)
        for n in mirror.children {
            json.addItem(key: n.label!, value: n.value)
        }
        api.setup(.TEST, .Login)
        api.setupJSON(json.value())
        api.postJSON()
        
    }
    
    override func apiSuccess(dataType: ApiActionType, api: ApiHelper) {
        self.loginView?.showLoginSuccess("\(dataType.rawValue) is Success")
    }
    
}
