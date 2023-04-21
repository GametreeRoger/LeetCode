import XCTest

// 直接用 swift 的 pow 會過但不是最快的
class Solution3 {
    func myPow(_ x: Double, _ n: Int) -> Double {
        return pow(x, Double(n))
    }
}

// 會超時
class Solution2 {
    func myPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 {
            return 1
        }
        
        var result = Double(1)
        let number = abs(n)
        for _ in 0..<number {
            result = x * result
        }
        return n < 0 ? 1.0 / result : result
    }
}

// 看最快的人寫的，但是跑完的結果不知道為什麼比用 swift 的 pow 還慢
class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 {return 1}
        var result = Double(1)
        var power = abs(n)
        var x2 = x
        while power > 0 {
            if power % 2 == 1 {
                result *= x2
            }
            x2 *= x2
            power = power / 2
        }
        
        return n < 0 ? 1.0 / result : result
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.myPow(2, 10)
        XCTAssertEqual(result, 1024)
    }
    
    func testSolution_02() {
        let sol = Solution()
        let result = sol.myPow(2.1, 3)
        XCTAssertEqual(result, 9.261)
    }

    func testSolution_03() {
        let sol = Solution()
        let result = sol.myPow(2, -2)
        XCTAssertEqual(result, 0.25)
    }
}

SolutionTests.defaultTestSuite.run()
