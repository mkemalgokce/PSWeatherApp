//
//  XCTests+MemoryLeakTrackingUtils.swift
//  PSWeatherLoaderTests
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject,
                                     file: StaticString = #filePath,
                                     line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallacoted. Potential memory leak.", file: file, line: line)
        }
    }
}
