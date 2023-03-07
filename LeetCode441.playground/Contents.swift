import XCTest

class Solution {
    var areaRecord = 1
    func arrangeCoins(_ n: Int) -> Int {
        areaRecord = 1
        var height = getHeight(1, n)
        var area = getArea(height)
        if area == n {
            return height
        }
        
        return height - 1
    }
    
    func getHeight(_ height: Int, _ n: Int) -> Int {
        if height > 1 {
            areaRecord += height
        }
        if areaRecord >= n {
            return height
        }
        
        return getHeight(height + 1, n)
    }
    
    func getArea(_ height: Int) -> Int {
        (1 + height) * height / 2
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.arrangeCoins(5)
        XCTAssertEqual(result, 2)
    }
    
    func testSolution_02() {
        let sol = Solution()
        let result = sol.arrangeCoins(8)
        XCTAssertEqual(result, 3)
    }
}

SolutionTests.defaultTestSuite.run()
