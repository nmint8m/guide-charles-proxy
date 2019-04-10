//
//  APIManager.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 4/7/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import Foundation
import Alamofire

enum CompletionResult {
    case success
    case failure(Error)
}
typealias CompletionHandler = (CompletionResult) -> Void
typealias Completion<Value> = (Result<Value>) -> Void
typealias JSObject = [String: Any]

final class APIManager {

    static let shared = APIManager()

    private init() {}

    // Chứa header mặc định cần phải có trong mỗi request
    static var defaultHeader: [String: String] = {
        var header: [String: String] = [:]
        /* Header mặc định như là
         - Access token
         - App version
         - OS device
         - ...
         */
        return header
    }()

    static let networkManager: NetworkReachabilityManager = {
        guard let networkManager = NetworkReachabilityManager() else {
            fatalError("Network manager cannot be generated")
        }
        return networkManager
    }()

    @discardableResult
    func request(path: String,
                 method: HTTPMethod,
                 parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers: HTTPHeaders? = nil,
                 completion: Completion<Any>? = nil) -> Request? {

        // Kiểm tra path và network -> URL có tồn tại hay không, nếu không thì return nil
        guard APIManager.networkManager.isReachable,
            let url = URL(string: path) else {
                return nil
        }

        // Thêm header riêng vào defaultHeader
        var allHeaders: HTTPHeaders = APIManager.defaultHeader
        if let headers = headers {
            for pair in headers {
                allHeaders[pair.key] = pair.value
            }
        }

        // Tạo DataRequest
        let request = Alamofire.request(url,
                                        method: method,
                                        parameters: parameters,
                                        encoding: encoding,
                                        headers: allHeaders
            ).responseJSON { response in
                completion?(response.result)
        }
        return request
    }
}

// MARK: - Xử lý response của data request
extension DataRequest {

    // Chuyển việc serializer của alamofire -> serializer của mình
    func responseJSON(completion: @escaping (DataResponse<Any>) -> Void) -> Self {
        return response(responseSerializer: responseSerializer(),
                        completionHandler: completion)
    }

    /** Serialize của mình tự define có nhiều nhiệm vụ:
     - Ví dụ như xem thử cấu trúc JSON trả về đúng hay không
     - Đối với một số status code error nhất định thì mình sẽ xử lý khác hẳn với những status khác.
     - Giả dụ như yêu cầu của KH đối với status 500 -> luôn luôn là lỗi authen -> mình phải show pop up, log out tài khoản đang sử dụng và trở lại màn hình splash chả hạn. --> TH này mình có thể bắn Notification đến AppDelegate để show pop up và change root view controller...
     */
    func responseSerializer() -> DataResponseSerializer<Any> {
        return DataResponseSerializer(serializeResponse: { _, response , data, error in
            return self.responseJSONSerializer(response: response,
                                               data: data,
                                               error: error)
        })
    }
}

// MARK: - Xử lý JSON trả về
extension Request {
    /* Vì sao không phải DataRequest mà là Request?
     - Vì mình muốn sử dụng chung 1 json serialize cho tất cả các request: data, download,...
     - class DataRequest thừa kế Request*/

    func responseJSONSerializer(response: HTTPURLResponse?,
                                data: Data?,
                                error: Error?) -> Result<Any> {

        guard APIManager.networkManager.isReachable else {
            return .failure(API.Errors.networkNotConnect)
        }

        // Khi response không trả về và không có lỗi error --> failure với error no response
        if let error = error {
            return .failure(error)
        }

        guard let response = response else {
            return .failure(API.Errors.noResponse)
        }

        let statusCode = response.statusCode

        guard statusCode == 200 else {
            if statusCode == API.Errors.badRequest.code {
                return .failure(API.Errors.badRequest)
            } else if statusCode == API.Errors.authentication.code {
                return .failure(API.Errors.authentication)
            }
            return .failure(API.Errors.notFound)
        }

        if let data = data, let json = data.toJSON() {
            // Success with JSON response
            return .success(json)
        } else if let data = data, let string = data.toString(), string.isEmpty {
            // Success but no JSON response
            return .success([:])
        }
        // Failure vì JSON format
        return .failure(API.Errors.jsonFormat)
    }
}

// MARK: - Xử lý error
extension Error {
    public var code: Int {
        if let this = self as? API.Errors {
            return this.code
        }
        let this = self as NSError
        return this.code
    }
}

// MARK: - Xử lý Data
extension Data {
    public func toJSON() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments)
        } catch {
            return nil
        }
    }

    public func toString(_ encoding: String.Encoding = String.Encoding.utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
}
