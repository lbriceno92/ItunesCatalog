//
//  NetworkingManager.swift
//  Rappi
//
//  Created by lbriceno on 10/18/16.
//  Copyright © 2016 Lbriceno. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class NetworkingManager {
    
    private let ENDPOINT = "https://itunes.apple.com/";
    
    
    func makeFeedRequest(completionHandler: (String!, NSError!) -> Void){
        let requestUrl = String(format: "%@%@",ENDPOINT,"us/rss/topfreeapplications/limit=100/json");
        
        dispatch_async(dispatch_get_main_queue()) { // 2
            Alamofire.request(.GET, requestUrl).responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print("JSON: \(json)")
                        let response  = Json4Swift_Base(dictionary: json.dictionaryObject!);
                        DatabaseManager().saveResposneObject((response?.feed!)!);
                        completionHandler("Data Successfully Updated",nil);
                    }
                case .Failure(let error):
                    print(error)
                    completionHandler("Could not Update Data.",error);
                }
            }
        }
  
    }
    
}