////
////  GeoCoder.swift
////  Spacing
////
////  Created by Sam.Lee on 4/24/24.
////
//
//import Foundation
//import Alamofire
//
//struct Coordinate : Codable {
//    var x : Double
//    var y : Double
//}
//class GeoCoder {
//    let apiUrl = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode"
//    let headers: HTTPHeaders = [
//        "X-NCP-APIGW-API-KEY-ID": "h41fk6xsah",
//        "X-NCP-APIGW-API-KEY": "mNEhExKU9u2v4X0yd63T0CAw7TmQKVAlyhxJx6HV"
//    ]
//    func getAlamofire(address: String){
//        let parameters: [String: Any] = [
//            "query": address,
//        ]
//        AF.request(apiUrl, method: .get, parameters: parameters, headers: headers)
//            .responseDecodable(of: YourResponseModel.self) { response in
//                // 응답 처리
//                switch response.result {
//                case .success(let value):
//                    // 성공적으로 디코딩된 모델을 사용하여 응답을 처리합니다.
//                    print("응답 성공: \(value)")
//                case .failure(let error):
//                    // 오류 처리
//                    print("응답 실패: \(error)")
//                }
//            }
//    }
//    
//}
//// 요청할 URL
//
