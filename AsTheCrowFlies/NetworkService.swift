//
//  NetworkService.swift
//  AsTheCrowFlies
//
//  Created by Joshua Kaden on 1/15/23.
//

import Foundation

final class NetworkService {
    
    private(set) var session: URLSession

    // MARK: - Lifecycle
    
    init(session: URLSession? = nil, requestTimeout: TimeInterval = 60) {
        if let session = session {
            self.session = session
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            configuration.urlCache = nil
            configuration.timeoutIntervalForRequest = requestTimeout
            let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
            self.session = session
        }
    }
    
    // MARK: - Public Methods
    
    func GET(_ url: URL, httpHeaders: [String : String]?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let request = makeGETRequestWithURL(url, httpHeaders: httpHeaders)
        performDataTask(with: request, completion: completion)
    }
        
    // MARK: - Private Methods
    
    func makeGETRequestWithURL(_ url: URL, httpHeaders: [String : String]?) -> URLRequest {
        var request = URLRequest(url: url)
        
        if let httpHeaders = httpHeaders {
            for (key, value) in httpHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return request
    }
    
    func performDataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = session.dataTask(with: request) {
            (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}
