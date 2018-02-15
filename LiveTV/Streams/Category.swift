//
//  Category.swift
//  LiveTV
//
//  Created by Til Blechschmidt on 14.02.18.
//  Copyright © 2018 Til Blechschmidt. All rights reserved.
//

import Foundation

struct Category : Codable {
    let name: String
    let streams: [Stream]

    enum CodingKeys : String, CodingKey {
        case name = "Name"
        case streams = "Streams"
    }
}
