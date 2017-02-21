//
//  ImageHelper.swift
//  MVPSample
//
//  Created by 謝佳瑋 on 2017/2/22.
//  Copyright © 2017年 謝佳瑋. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class HandleImage{
    var errorImage:UIImage = UIImage()
    
    init(){}
    
    func parseImage(_ imageString:String)throws ->UIImage{
        guard imageString != "" else{
            throw parseImageError.imageStringEmpty
        }
        let imageData = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters)
        let img = UIImage(data: imageData!)
        return img! as UIImage
        
    }
    enum parseImageError :Error {
        case imageStringEmpty
    }
    func tryParseImage(_ imageString:String)->UIImage{
        do{
            let image = try self.parseImage(imageString)
            return image
        }catch parseImageError.imageStringEmpty{
            return errorImage
        }catch{
            return errorImage
        }
    }
    
    
    //------------------------上傳圖片相關function-------------------------------
    func imageToSting(_ image:UIImage)->String{
        let imageData: Data = UIImageJPEGRepresentation(image, 0.7)!
        let dataString = imageData.base64EncodedString()
        
        return dataString
    }
    
    func imageRsize(_ image : UIImage)->UIImage{
        let newSize:CGSize = CGSize(width: 300,height: 300)
        let rect = CGRect(x: 0,y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        
        // image is a variable of type UIImage
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    //====================== URL Loading Image Data ========================
    func downloadImage(url:URL,userPhoto:UIImageView){
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else {
                return
            }
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                userPhoto.image = UIImage(data: data)
                
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}
