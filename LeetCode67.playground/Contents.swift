import XCTest

class Solution {
    func addBinary(_ a: String, _ b: String) -> String {
        let aChars = [Character](a)
        let bChars = [Character](b)
        var aIndex = a.count - 1
        var bIndex = b.count - 1
        var carry = false
        var acurrent = 0
        var bcurrent = 0
        var result = ""
        while aIndex >= 0 || bIndex >= 0 {
            
            if aIndex >= 0 {
                acurrent = aChars[aIndex] == "1" ? 1 : 0
            } else {
                acurrent = 0
            }
            if bIndex >= 0 {
                bcurrent = bChars[bIndex] == "1" ? 1 : 0
            } else {
                bcurrent = 0
            }
            
            if acurrent == 0 && bcurrent == 0 {
                if carry {
                    result = "1\(result)"
                    carry = false
                } else {
                    result = "0\(result)"
                }
            } else if acurrent == 1 && bcurrent == 1 {
                if carry {
                    result = "1\(result)"
                } else {
                    result = "0\(result)"
                }
                carry = true
            } else {
                if carry {
                    result = "0\(result)"
                } else {
                    result = "1\(result)"
                }
            }
            
            aIndex -= 1
            bIndex -= 1
        }
        
        if carry {
            result = "1\(result)"
        }
        
        return result
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.addBinary("11", "1")
        XCTAssertEqual(result, "100")
    }
    
    func testSolution_02() {
        let sol = Solution()
        let result = sol.addBinary("1010", "1011")
        XCTAssertEqual(result, "10101")
    }
}

SolutionTests.defaultTestSuite.run()
