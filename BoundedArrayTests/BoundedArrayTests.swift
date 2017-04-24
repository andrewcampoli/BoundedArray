//
//  BoundedArrayTests.swift
//  BoundedArrayTests
//
//  Created by Andrew Campoli on 4/20/17.
//  Copyright © 2017 Andrew Campoli. All rights reserved.
//

import XCTest
@testable import BoundedArray

final class BoundedArrayTests: XCTestCase {
    func testValueSemantics() {
        let boundedArray = BoundedArray(elements: true)
        var boundedArrayCopy = boundedArray
        boundedArrayCopy[0] = false
        
        XCTAssertNotEqual(boundedArray[0], boundedArrayCopy[0], "Arrays should have value semantics.")
    }
    
    // MARK: Bounding Behavior
    
    func testInitBounding() {
        let limit = 1
        let boundedArray = BoundedArray(elements: "☝️", "✌️", limit: limit)
        
        XCTAssert(boundedArray.count <= limit, "A BoundedArray should not breach count limit on initialization.")
        
        XCTAssert(boundedArray.contains("✌️"), "A BoundedArray should make room for new elements in FIFO order on initialization.")
    }
    
    func testAppendBounding() {
        let limit = 1
        var boundedArray = BoundedArray<String>(limit: limit)
        boundedArray.append("🥇")
        boundedArray.append("🥈")
        
        XCTAssert(boundedArray.count <= limit, "A BoundedArray should not breach count limit when appending.")
        XCTAssert(boundedArray.contains("🥈"), "A BoundedArray should make room for new elements in FIFO order when appending.")
    }
    
    func testInsertBounding() {
        let limit = 2
        var boundedArray = BoundedArray(elements: "🌞", "🌚", limit: limit)
        boundedArray.insert("🌝", at: 1)
        
        XCTAssert(boundedArray.count <= limit, "A BoundedArray should not breach count limit when inserting.")
        XCTAssert(boundedArray.contains("🌚"), "A BoundedArray should make room for new elements in FIFO order when inserting.")
    }
    
    // MARK: Ordering Behavior
    
    func testInitOrdering() {
        let array = [0, 1, 2, 3, 4]
        let boundedArray = BoundedArray(array: array, limit: 5)
        
        zip(array, boundedArray).forEach({
            XCTAssert($0.0 == $0.1, "Arrays should maintain their order after initialization.")
        })
    }
    
    func testAppendOrdering() {
        let array = [0, 1, 2, 3, 4]
        var boundedArray = BoundedArray(array: array, limit: 6)
        
        let elementToAppend = 5
        boundedArray.append(elementToAppend)
        
        zip(array, boundedArray).forEach({
            XCTAssert($0.0 == $0.1, "Arrays should maintain their order after appending.")
        })
        
        XCTAssertEqual(boundedArray.last, elementToAppend, "Arrays should append new elements to the end.")
        
    }
    
    func testInsertOrdering() {
        let array = [0, 1, 2, 3, 4]
        var boundedArray = BoundedArray(array: array, limit: 5)
        
        let elementToInsert = 5
        boundedArray.insert(elementToInsert, at: 0)
        
        zip(array, boundedArray).forEach({element, boundedArrayElemet in
            guard element != array.first && boundedArrayElemet != boundedArray.first else {
                return
            }
            XCTAssert(element == boundedArrayElemet, "Arrays should maintain their order after inserting.")
        })
        
        XCTAssertEqual(boundedArray.first, elementToInsert, "Arrays should respect insertion index (even when doing a breaching insert into first position).")
    }
}
