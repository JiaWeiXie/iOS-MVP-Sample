//
//  ApiHelper.swift
//  MVPSample
//
//  Created by 謝佳瑋 on 2017/2/22.
//  Copyright © 2017年 謝佳瑋. All rights reserved.
//

import Foundation
import UIKit

///處理網路任務類別之協定
protocol ApiHelperDelegate{
    func apiSuccess(dataType:ApiActionType,api:ApiHelper)
    func apiError(error: Error,errorType:ApiErrorType)
    
}
///簡易連線錯誤資訊類型
enum ApiErrorType:String {
    case PostFail = "Transfer Data Fail !"
    case ResponseError = "Loading Error !"
    case DataNull = "Data Error !"
    case ResolveError = "Paser Data Error !"
    case NotJSONType = "Format Data Error !"
}
///執行功能類型
enum ApiActionType:String{
    case SignUp = "signUp"
    case RegisterrGCMID = "registerrGCMID"
    case Login = "login"
}
///URL
enum IP:String{
    case TEST = "http://www.httpbin.org/post"
}

/// # 處理網路，與伺服器連線，post資料...相關處理
class ApiHelper:NSObject,URLSessionDelegate,URLSessionTaskDelegate {
    fileprivate var delegate :ApiHelperDelegate?
    fileprivate var urlstring = ""
    fileprivate var postString = ""
    fileprivate var params = [String:Any]()
    fileprivate var received : Data?
    fileprivate var jsonobjects = NSDictionary()
    fileprivate var postType:ApiActionType?
    
    override init(){}
    ///建構式
    init(delegate:ApiHelperDelegate){
        super.init()
        self.delegate = delegate
    }
    
    init(url:IP,delegate:ApiHelperDelegate) {
        super.init()
        self.delegate = delegate
        self.setupURL(url)
    }
    
    init(delegate:ApiHelperDelegate,type:ApiActionType){
        super.init()
        self.delegate = delegate
        self.setupType(type)
    }
    ///設定action，server位址
    func setup(_ url:IP,_ type:ApiActionType){
        self.setupURL(url)
        self.setupType(type)
    }
    ///設定server位址
    func setupURL(_ url:IP){
        self.urlstring = url.rawValue
    }
    ///設定上傳類型
    func setupType(_ type:ApiActionType){
        self.postType = type
    }
    ///設定post字串
    func setupPostString(_ postString:String){
        self.postString = postString
    }
    ///設定JSON
    func setupJSON(_ json:Dictionary<String, Any>){
        self.params = json
        print(json.debugDescription)
    }
    ///check JSON Type
    func isJSON(json:Dictionary<String, String>)->Bool{
        return JSONSerialization.isValidJSONObject(json)
    }
    ///post資料function
    func postData(){
        
        let charcterSet = NSMutableCharacterSet()
        charcterSet.formUnion(with: CharacterSet.urlFragmentAllowed)
        charcterSet.addCharacters(in: "+")
        
        let request = NSMutableURLRequest(url: Foundation.URL(string: urlstring)!,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 15.0)
        request.httpMethod = "POST"
        request.httpBody = postString.addingPercentEncoding(withAllowedCharacters: charcterSet as CharacterSet)?.data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest){data,response,error in
            
            if error != nil{
                self.delegate?.apiError(error: error!,errorType: ApiErrorType.ResponseError)
            }else{
                if let testingData = data{
                    self.received = testingData
                    self.delegate?.apiSuccess(dataType: self.postType!,api: self)
                }else{
                    
                    self.delegate?.apiError(error: error!,errorType: ApiErrorType.DataNull)
                }
                
            }
        }
        task.resume()
        
    }
    
    ///Post JSON Data Function
    func postJSON(){
        let successFail :NSDictionary = ["success":0]
        do{
            print("-----------> [Post] Seting connection <----------")
            let request = NSMutableURLRequest(url: URL(string: urlstring)!,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 50.0)
            request.httpMethod = "POST"
            print("-----------> [Post] Seting JSON Data <----------")
            print(self.params)
            request.httpBody = try JSONSerialization.data(withJSONObject: self.params, options: .prettyPrinted)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest){data,response,error in
                print("-----------> [Session] Get Response <----------")
                if error != nil{
                    print("-----------> [Session] Response Error <----------")
                    self.delegate?.apiError(error: error!,errorType: ApiErrorType.ResponseError)
                }else{
                    print("-----------> [Session] Response Success <----------")
                    if let testingData = data{
                        let kdata = testingData
                        self.received = kdata
                        let dataStr = NSString(data: self.received! as Data, encoding: String.Encoding.utf8.rawValue)
                        print(dataStr as! String)
                        self.delegate?.apiSuccess(dataType: self.postType!,api: self)
                    }else{
                        
                        self.delegate?.apiError(error: error!,errorType: ApiErrorType.DataNull)
                    }
                    
                }
            }
            task.resume()
        }catch let error{
            print("-----------> [Post] Parse JSON Data Error <----------")
            print(error.localizedDescription)
            self.delegate?.apiError(error: error,errorType: ApiErrorType.ResolveError)
            self.jsonobjects = successFail
        }
        
    }
    
    ///解析JSON
    func data()->NSDictionary{
        let successFail :NSDictionary = ["success":0]
        
        do{
            //print(String(data: self.received!, encoding: String.Encoding.utf8) as Any)
            print("-----------> [Response] Parse JSON Data <----------")
            self.jsonobjects  = try JSONSerialization.jsonObject(with: self.received!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        }catch let error{
            print("-----------> [Response] Parse JSON Data Error <----------")
            print(error.localizedDescription)
            self.delegate?.apiError(error: error,errorType: ApiErrorType.ResolveError)
            self.jsonobjects = successFail
        }
        
        return self.jsonobjects
    }
    ///伺服器回傳是否post成功資訊
    func isCorrect()->Bool{
        let object = self.data()
        if object.object(forKey: "success") == nil{
            return false
        }
        let temp_success = object.object(forKey: "success")!
        let success:String = "\(temp_success)"
        if(success == "1"){
            print("-----------> [Response] Data Success <----------")
            return true
        }
        print("-----------> [Response] Data Fail <----------")
        return false
    }
    
    func getData()->Data{
        return self.received!
    }
    //==================================================
    func UploadRequest(img:UIImage)
    {
        let url = URL(string: IP.TEST.rawValue)
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let image_data = UIImageJPEGRepresentation(img, 0.7)
        
        if(image_data == nil)
        {
            return
        }
        
        let body = NSMutableData()
        
        let fname = "\(boundary).jpg"
        let mimetype = "image/jpg"
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"\(boundary)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = body as Data
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest){data,response,error in
            print("-----------> [Session] Get Response <----------")
            if error != nil{
                print("-----------> [Session] Response Error <----------")
                self.delegate?.apiError(error: error!,errorType: ApiErrorType.ResponseError)
            }else{
                print("-----------> [Session] Response Success <----------")
                if let testingData = data{
                    self.received = testingData
                    self.delegate?.apiSuccess(dataType: self.postType!,api: self)
                }else{
                    
                    self.delegate?.apiError(error: error!,errorType: ApiErrorType.DataNull)
                }
                
            }
        }
        task.resume()
    }
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(UUID().uuidString)"
    }
    
    //==================================================

}
