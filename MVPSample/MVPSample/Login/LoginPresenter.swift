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
        api.setup(.DJANGO, .Login)
        api.setupJSON(json.value())
        api.postJSON()
        
    }
    
    override func apiSuccess(dataType: ApiActionType, api: ApiHelper) {
        switch dataType {
        case .Login:
            if api.isCorrect(){
                viewMain {
                    self.loginView?.showLoginSuccess("\(dataType.rawValue) is Success")
                }
            }else{
                viewMain {
                    self.loginView?.showLoginSuccess("\(dataType.rawValue) is Fail")
                }
            }
        default:
            break
        }
        
        
    }
    
}
