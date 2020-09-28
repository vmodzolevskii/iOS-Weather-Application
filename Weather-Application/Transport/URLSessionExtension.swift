//
//  URSSessionExtension.swift
//  Weather-Application
//
//  Created by sdf on 9/28/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import Foundation


extension URLSession {
    
    func dataTask(with url: URL, completionHandler: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url, completionHandler: { (data, urlResponse, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else if let data = data, let urlResponse = urlResponse as? HTTPURLResponse {
                completionHandler(.success((data, urlResponse)))
            }
        })
    }
    
}
