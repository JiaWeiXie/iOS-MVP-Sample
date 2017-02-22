//
//  Presenter.swift
//  MVPSample
//
//  Created by 謝佳瑋 on 2017/2/22.
//  Copyright © 2017年 謝佳瑋. All rights reserved.
//

import Foundation
import UIKit

class Presenter:ApiHelperDelegate{
    var view:ViewController?
    
    init(delegate:ViewController){
        ///畫面跟Presenter連結
        self.view = delegate
        
    }
    
    func apiSuccess(dataType:ApiActionType,api:ApiHelper){
        
    }
    
    func apiError(error: Error,errorType:ApiErrorType){
        self.view?.showErrorMessage(errorType.rawValue)
    }
    
    func viewMain(action:@escaping ()->Void){
        DispatchQueue.main.async {
            action()
        }
    }
}
