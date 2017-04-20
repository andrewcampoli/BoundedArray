//
//  BoundedArray.swift
//  BoundedArray
//
//  Created by Andrew Campoli on 4/20/17.
//  Copyright © 2017 Andrew Campoli. All rights reserved.
//

import Foundation

struct BoundedArray<Element>: MutableCollection, RandomAccessCollection {
    typealias Index = Array<Element>.Index
    typealias Iterator = Array<Element>.Iterator
    private var elements: Array<Element>
    
    let max: Int
    
    var startIndex: Index {
        return elements.startIndex
    }
    
    var endIndex: Index {
        return elements.endIndex
    }
    
    init(elements: Element..., max: Int = .max) {
        self.init(array: elements, max: max)
    }
    
    init(array: [Element], max: Int = .max) {
        self.max = max
        self.elements = array
        
        while elements.count > max {
            elements.removeFirst()
        }
    }
    
    func makeIterator() -> IndexingIterator<Array<Element>> {
        return elements.makeIterator()
    }
    
    subscript(position: Index) -> Iterator.Element {
        get {
            return elements[position]
        }
        set {
            elements[position] = newValue
        }
    }
    
    mutating func append(_ element: Element) {
        makeSpaceForNewElementIfNecessary()
        elements.append(element)
    }
    
    mutating func insert(_ newElement: Element, at position: Int) {
        makeSpaceForNewElementIfNecessary()
        elements.insert(newElement, at: position)
    }
    
    private mutating func makeSpaceForNewElementIfNecessary() {
        while elements.count > max - 1 {
            elements.removeFirst()
        }
    }
}
