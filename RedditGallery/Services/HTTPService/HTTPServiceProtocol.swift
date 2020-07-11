//
//  HTTPServiceProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

protocol HTTPServiceProtocol {
    
    /// This function makes HTTP request to the endpoint passed.
    /// The endpoint should return a JSON file.
    ///
    /// - Parameter endpoint: request endpoint
    /// - Returns: HTTPServiceResponse model
    func makeGetHttpRequest(endpoint: String) -> Single<HTTPServiceResponse>
}
