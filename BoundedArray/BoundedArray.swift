//
//  BoundedArray.swift
//  BoundedArray
//
//  Created by Andrew Campoli on 4/20/17.
//  Copyright © 2017 Andrew Campoli. All rights reserved.
//

import Foundation

public struct BoundedArray<Element>: MutableCollection, RandomAccessCollection {
    public typealias Index = Array<Element>.Index
    public typealias Iterator = Array<Element>.Iterator
    private var elements: Array<Element>
    
    public let limit: Int
    
    public var startIndex: Index {
        return elements.startIndex
    }
    
    public var endIndex: Index {
        return elements.endIndex
    }
    
    public init(elements: Element..., limit: Int = .max) {
        self.init(array: elements, limit: limit)
    }
    
    public init(array: [Element], limit: Int = .max) {
        self.limit = limit
        self.elements = array
        
        while elements.count > limit {
            elements.removeFirst()
        }
    }
    
    public func makeIterator() -> IndexingIterator<Array<Element>> {
        return elements.makeIterator()
    }
    
    public subscript(position: Index) -> Iterator.Element {
        get {
            return elements[position]
        }
        set {
            elements[position] = newValue
        }
    }
    
    public mutating func append(_ element: Element) {
        makeSpaceForNewElementIfNecessary()
        elements.append(element)
    }
    
    public mutating func insert(_ newElement: Element, at position: Int) {
        makeSpaceForNewElementIfNecessary()
        elements.insert(newElement, at: position)
    }
    
    private mutating func makeSpaceForNewElementIfNecessary() {
        while elements.count > limit - 1 {
            elements.removeFirst()
        }
    }
}
