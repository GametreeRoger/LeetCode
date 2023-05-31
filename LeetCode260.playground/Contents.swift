import XCTest

class Solution {
    func singleNumber(_ nums: [Int]) -> [Int] {
        var singleSet = Set<Int>()
        for num in nums {
            if singleSet.contains(num) {
                singleSet.remove(num)
            } else {
                singleSet.insert(num)
            }
        }
        
        return Array(singleSet)
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.singleNumber([1,2,1,3,2,5])
        let answer = Set<Int>([3,5])
        let resultSet = Set<Int>(result)
        XCTAssertTrue(answer == resultSet)
    }
    
    func testSolution_02() {
        let sol = Solution()
        let result = sol.singleNumber([-1,0])
        let answer = Set<Int>([-1,0])
        let resultSet = Set<Int>(result)
        XCTAssertTrue(answer == resultSet)
    }

    func testSolution_03() {
        let sol = Solution()
        let result = sol.singleNumber([0,1])
        let answer = Set<Int>([1,0])
        let resultSet = Set<Int>(result)
        XCTAssertTrue(answer == resultSet)
    }
}

SolutionTests.defaultTestSuite.run()

