//
//  Networking.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/23.
//

import UIKit

enum HttpMethod {
    case GET,POST
}

class Networking: NSObject {
    class func request(method:HttpMethod, urlString:String, params:[String:Any] = [:], complete: @escaping(_ result:[String : Any]) -> Void, error:@escaping(_ error:Error?) -> Void) {
        var urlString = urlString
        let param = self.parserParams(params: params)
        if method == .GET && param != "" {
            if urlString.contains("?"){
                urlString.append("&\(param)")
            }else{
                urlString.append("?\(param)")
            }
        }
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.timeoutInterval=50
        request.httpMethod = method == .GET ? "GET" : "POST"
        if method == .POST && param != "" {
            request.httpBody = param.data(using: .utf8)
        }
        let session = URLSession.shared
        let httpTask = session.dataTask(with: request as URLRequest) { (data,response ,err ) in
            OperationQueue.main.addOperation {
                if err != nil {
                    error(err)
                    return
                }
                if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                    complete(dict)
                }else if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Dictionary<String, Any>] {
                    complete(["data":dict])
                }
            }
        }
        httpTask.resume()
    }
    private class func parserParams(params:[String:Any]) -> String {
        var newStr=""
        for param in params{
            newStr.append("\(param.key)=\(param.value)&")
        }
        return newStr
    }
}
