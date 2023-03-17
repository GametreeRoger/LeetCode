import XCTest

class Solution {
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var diff = x ^ y
        var count = 0
        while diff > 0 {
            if diff & 1 == 1 {
                count += 1
            }
            diff = diff >> 1
        }
        
        return count
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.hammingDistance(1, 4)
        XCTAssertEqual(result, 2)
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.hammingDistance(3, 1)
        XCTAssertEqual(result, 1)
    }
}

SolutionTests.defaultTestSuite.run()
