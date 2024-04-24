//
//  GeoCoder.swift
//  Spacing
//
//  Created by Sam.Lee on 4/24/24.
//

import Foundation
import Alamofire
struct Address : Codable{
    let addresses : Coordinate
}
struct Coordinate : Codable {
    var x : String
    var y : String
}
class GeoCoder {
    let apiUrl = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode"
    let headers: HTTPHeaders = [
        "X-NCP-APIGW-API-KEY-ID": "h41fk6xsah",
        "X-NCP-APIGW-API-KEY": "mNEhExKU9u2v4X0yd63T0CAw7TmQKVAlyhxJx6HV"
    ]
    func getAlamofire(address: String){
        let parameters: [String: Any] = [
            "query": address,
        ]
        AF.request(apiUrl, method: .get, parameters: parameters, headers: headers).response{ response in
                switch response.result {
                case .success(let data):
                    do{
                        let newSearchResult = try JSONDecoder().decode([Address].self, from: data!)
                        print(newSearchResult[0].addresses.x)
                        print(newSearchResult[0].addresses.y)
                    }catch let error {
                        print("ERROR PARSING JSON: \(error)")
                    }
                case .failure(let error):
                    // 오류 처리
                    print("응답 실패: \(error)")
                }
            }
    }
    
}
// 요청할 URL
