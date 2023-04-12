import XCTest

class Solution {
    func reverseBits(_ n: Int) -> Int {
        var result : Int = 0
        var number = n
        for _ in 0..<32 {
            result = result << 1
            if number & 1 == 1 {
                result = result | 1
            }
//            print("result:\(String(result, radix: 2))")
            number = number >> 1
        }
        return result
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        //00000010100101000001111010011100
        let result = sol.reverseBits(43261596)
        //00111001011110000010100101000000
        XCTAssertEqual(result, 964176192)
    }
    
    func testSolution_02() {
        let sol = Solution()
        //11111111111111111111111111111101
        let result = sol.reverseBits(4294967293)
        //10111111111111111111111111111111
        XCTAssertEqual(result, 3221225471)
    }
}

SolutionTests.defaultTestSuite.run()
