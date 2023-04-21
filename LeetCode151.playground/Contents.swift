import XCTest

// 時間少，空間多
class Solution2 {
    func reverseWords(_ s: String) -> String {
        return s
            .split(separator: " ")
            .reversed()
            .joined(separator: " ")
    }
}

// 減少了一點點空間，但時間又多了
class Solution {
    func reverseWords(_ s: String) -> String {
        var result = ""
        var word = ""
        var isSpace = false
        for letter in s {
            if letter.isWhitespace {
                if word.count > 0 {
                    isSpace = true
                }
            } else {
                if isSpace {
                    result = " " + word + result
                    word = ""
                    isSpace = false
                }
                word += String(letter)
            }
        }
        if word.count > 0 {
            result = word + result
        }
        return result
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.reverseWords("the sky is blue")
        XCTAssertEqual(result, "blue is sky the")
    }
    
    func testSolution_02() {
        let sol = Solution()
        let result = sol.reverseWords("  hello world  ")
        XCTAssertEqual(result, "world hello")
    }
    
    func testSolution_03() {
        let sol = Solution()
        let result = sol.reverseWords("a good   example")
        XCTAssertEqual(result, "example good a")
    }
}

SolutionTests.defaultTestSuite.run()

