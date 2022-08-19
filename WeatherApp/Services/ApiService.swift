//
//  ApiService.swift
//  WeatherApp
//
//  Created by Света Шибаева on 18.08.2022.
//

import Foundation

class ApiService {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder? = nil) {
        if let decoder = decoder {
            self.decoder = decoder
        } else {
            self.decoder = JSONDecoder()
            self.decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.decoder.dateDecodingStrategy = .secondsSince1970
        }
    }
    
    func performRequest<T: Decodable>(with endpoint: EndpointProtocol, type: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = buildUrl(with: endpoint) else { return completion(Result.failure(ApiServiceError.urlError)) }
        
        resumeTask(urlRequest: URLRequest(url: url), type: type, completion: completion)
    }
    
    private func buildUrl(with endpoint: EndpointProtocol) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.params.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        return urlComponents.url
    }
    
    private func resumeTask<T: Decodable>(urlRequest: URLRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "")
                
                if let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) {
                    guard let result = self.parseJSON(from: data, with: T.self) else { return completion(Result.failure(ApiServiceError.parseError)) }
                    
                    completion(Result.success(result))
                    
                } else {
                    guard let apiError = self.parseJSON(from: data, with: ApiError.self) else {
                        completion(Result.failure(ApiServiceError.unknownError))
                        return
                    }
                    completion(Result.failure(ApiServiceError.customError(error: apiError.message)))
                }
            }
        }.resume()
    }
    
    private func parseJSON<T: Decodable>(from data: Data, with type: T.Type) -> T? {
        return try? decoder.decode(type, from: data)
    }
}
