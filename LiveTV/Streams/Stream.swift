//
//  Stream.swift
//  LiveTV
//
//  Created by Til Blechschmidt on 13.02.18.
//  Copyright © 2018 Til Blechschmidt. All rights reserved.
//

import UIKit

struct Stream : Codable {
    let name: String
    private let icon: String
    var image: UIImage? {
        return UIImage(named: icon)
    }
    let substreams: [Substream]

    enum CodingKeys : String, CodingKey {
        case name = "Name"
        case icon = "Icon"
        case substreams = "Substreams"
    }

    func getSelectedStream() -> Substream {
        return substreams[0]
    }
}

struct Substream : Codable {
    let name: String
    let urlSD: String?
    let urlHD: String?

    enum CodingKeys : String, CodingKey {
        case name = "Name"
        case urlSD = "URL-SD"
        case urlHD = "URL-HD"
    }

    func getSelectedQuality() -> String? {
        return urlHD ?? urlSD
    }
}
