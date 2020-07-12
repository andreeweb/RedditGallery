//
//  HTTPService.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

class HTTPService: HTTPServiceProtocol {
    
    private let session = URLSession.shared
    
    func makeGetHttpRequest(endpoint: String) -> Single<HTTPServiceResponse> {
    
        return Single.create { [weak self]  observer -> Disposable in
            
            guard let strongSelf = self else {
                observer(.error(HTTPServiceErrorBuilder.error(forCode: HTTPServiceErrorCode.ReferenceError)))
                return Disposables.create()
            }
            
            let url = URL(string: endpoint)!
            
            strongSelf.session.dataTask(with: url, completionHandler: { data, response, error in
                
                if error != nil || data == nil || response == nil {
                    observer(.error(HTTPServiceErrorBuilder.error(forCode: HTTPServiceErrorCode.HTTPRequestError)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    observer(.error(HTTPServiceErrorBuilder.error(forCode: HTTPServiceErrorCode.HTTPResponseError)))
                    return
                }
                
                guard response.statusCode == 200 else {
                    observer(.error(HTTPServiceErrorBuilder.error(forCode: HTTPServiceErrorCode.HTTPResponseError)))
                    return
                }
                
                let httpResponse = HTTPServiceResponse(data: data!)
                
                observer(.success(httpResponse))
                
            }).resume()
            
            return Disposables.create()
        }
    }
}
