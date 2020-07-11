//
//  HTTPServiceMock.swift
//  RedditGalleryTests
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

class HTTPServiceMock: HTTPServiceProtocol {
    
    var trueJson = true
    
    func makeGetHttpRequest(endpoint: String) -> Single<HTTPServiceResponse> {
        
        return Single.create { observer -> Disposable in
            
            var jsonData: Data? = "".data(using: .utf8)
            
            if self.trueJson {
             
                jsonData = """
                {
                  "kind": "Listing",
                  "data": {
                    "modhash": "",
                    "dist": 2,
                    "children": [
                      {
                        "kind": "t3",
                        "data": {
                          "title": "What OneWeb's $1 billion rescue from bankruptcy means for SpaceX's Starlink",
                          "thumbnail": "https://a.thumbs.redditmedia.com/x1svVj-hKxKxpcMtd21Lopp21S-_rhzjqUngqFjlo_0.jpg",
                        }
                      },
                      {
                        "kind": "t3",
                        "data": {
                          "title": "Brilliant behind the scenes look at @SpaceX and @NASA Crew Dragon launch from @Space_Station point-of-view",
                          "thumbnail": "https://b.thumbs.redditmedia.com/HicreXfG0HE4kCNwh0Bvsknegza0BUb20FHK61422ks.jpg",
                        }
                      }
                    ],
                    "after": null,
                    "before": null
                  }
                }
                """.data(using: .utf8)
            }
                        
            let httpResponse = HTTPServiceResponse(data: jsonData!)
            
            observer(.success(httpResponse))
            
            return Disposables.create()
        }
    }
}
