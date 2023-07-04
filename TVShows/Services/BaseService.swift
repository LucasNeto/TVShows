//
//  BaseService.swift
//  TVShows
//
//  Created by Lucas  N Santana on 30/06/23.
//

import Foundation

protocol BaseServiceProtocol {
    func doRequest<T:Codable>( _ endpoint: String, completion: @escaping((T?,ServiceError?)->()))
}
class BaseService: BaseServiceProtocol {
    
    private let baseUrl = "https://api.tvmaze.com"
    private var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func doRequest<T:Codable>( _ endpoint: String,
                               completion: @escaping((T?,ServiceError?)->())
    ) {
        guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
            completion(nil, ServiceError("Endpoint invalid."))
            return
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = self.session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let data = data {
                do {
                    print("data \(String(data: data, encoding: .utf8) ?? "")")
                    let response : T = try JSONDecoder().decode(T.self, from: data)
                    completion(response,nil)
                } catch {
                    print("catch \(error.localizedDescription)")
                    completion(nil,ServiceError(error.localizedDescription))
                }
            } else {
                print("data nil \(error?.localizedDescription ?? "")")
                completion(nil,ServiceError(error?.localizedDescription))
            }
        })
        
        task.resume()
    }
}

class ServiceError: Error {
    var message: String?
    init(_ message: String? = nil){
        self.message = message
    }
    func getMessage() -> String {
        return message ?? "We are offline, can you try again late?"
    }
}
