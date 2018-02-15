//
//  StreamsManager.swift
//  LiveTV
//
//  Created by Til Blechschmidt on 13.02.18.
//  Copyright © 2018 Til Blechschmidt. All rights reserved.
//

import Foundation

class StreamsManager {

    private let categories: [Category]

    func getCategories() -> [String] {
        return categories.map { $0.name }
    }

    func getStreams(forCategory category: Int) -> [Stream] {
        return categories[category].streams
    }

    private init() {
        let path = Bundle.main.path(forResource: "Streams", ofType: "plist")
        let data = try! Data.init(contentsOf: URL.init(fileURLWithPath: path!), options: [])

        categories = try! PropertyListDecoder.init().decode([Category].self, from: data)
    }

    static let `default` = StreamsManager()
}
