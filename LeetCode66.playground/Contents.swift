import XCTest

class Solution {
    func plusOne(_ digits: [Int]) -> [Int] {
        var carry = 1
        var result = digits
        for i in stride(from: result.count - 1, through: 0, by: -1) {
            if result[i] == 9 {
                carry = 1
                result[i] = 0
            } else {
                result[i] += 1
                carry = 0
                break
            }
        }
        if carry == 1 {
            result.insert(1, at: 0)
        }
        return result
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.plusOne([1,2,3])
        XCTAssertEqual(result, [1,2,4])
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.plusOne([4,3,2,1])
        XCTAssertEqual(result, [4,3,2,2])
    }
    
    func testSolution_03() {
        let sol = Solution()
        let result = sol.plusOne([9])
        XCTAssertEqual(result, [1,0])
    }
    
    func testSolution_04() {
        let sol = Solution()
        let result = sol.plusOne([9,9,9,9,9,9,9,9,9,9])
        XCTAssertEqual(result, [1,0,0,0,0,0,0,0,0,0,0])
    }
    
    func testSolution_05() {
        let sol = Solution()
        let result = sol.plusOne([9,9,9,9,9,8,9,9,9,9])
        XCTAssertEqual(result, [9,9,9,9,9,9,0,0,0,0])
    }
}

SolutionTests.defaultTestSuite.run()

