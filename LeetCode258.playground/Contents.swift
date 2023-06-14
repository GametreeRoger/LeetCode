import XCTest

// 純數字
class Solution2 {
    func addDigits(_ num: Int) -> Int {
        if num < 10 {
            return num
        }
        var num = num
        var result = 0
        
        while num >= 10 {
            result += num % 10
            num = Int(floor(Double(num) / 10))
            if num < 10 {
                result += num
                if result >= 10 {
                    num = result
                    result = 0
                }
            }
        }
        return result
    }
}

// 字串 變慢
class Solution {
    func addDigits(_ num: Int) -> Int {
        if num < 10 {
            return num
        }
        var str = [Character](String(num))
        var index = 0
        var result = 0
        while index < str.count {
            result += str[index].wholeNumberValue!
            index += 1
            if index == str.count {
                if result >= 10 {
                    str = [Character](String(result))
                    result = 0
                    index = 0
                }
            }
        }
        
        return result
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.addDigits(38)
        XCTAssertEqual(result, 2)
    }
    
    func testSolution_02() {
        let sol = Solution()
        let result = sol.addDigits(0)
        XCTAssertEqual(result, 0)
    }
}

SolutionTests.defaultTestSuite.run()
