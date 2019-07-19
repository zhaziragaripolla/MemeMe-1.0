//
//  MemeStorage.swift
//  MemeMe 1.0
//
//  Created by Zhazira Garipolla on 7/19/19.
//  Copyright © 2019 Zhazira Garipolla. All rights reserved.
//

import UIKit

class MemeStorage {
    
    static let shared = MemeStorage()
    
    var values = [Meme]()
    
    private init() {}
    
    func count()-> Int {
        return values.count
    }
    
    func append(_ meme: Meme) {
        values.append(meme)
    }
    
    func delete(_ index: Int) {
        values.remove(at: index)
    }
    
    func save(originalImage: UIImage, topText: String, bottomText: String, memedImage: UIImage) {
        let meme = Meme(originalImage: originalImage, memedImage: memedImage, topText: topText, bottomText: bottomText)
        values.append(meme)
    }
    
    func getOriginalImage(_ index: Int)-> UIImage {
        return values[index].originalImage
    }
    
    // To populate table/collection views according to IndexPath.row
    func memedImage(_ index: Int)-> UIImage {
        return values[index].memedImage
    }
    
    func name(_ index: Int)-> String? {
        let topString = values[index].topText
        let bottomString = values[index].bottomText
        return topString + bottomString
    }
    
}

extension MemeStorage: Collection {
    func index(after i: Int) -> Int {
        return values.index(after: i)
    }
    
    var startIndex: Int {
        return values.startIndex
    }
    
    var endIndex: Int {
        return values.endIndex
    }
    
    subscript(index: Int) -> Meme {
        return values[index]
    }
}
