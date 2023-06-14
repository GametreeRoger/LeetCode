import XCTest

class Solution2 {
    var fac = [0:1, 1:1, 2:2]
    func climbStairs(_ n: Int) -> Int {
        if n <= 3 {
            return n
        }
        var number = n
        var result = 0
        var twoTimes = n / 2
        for i in stride(from: twoTimes, through: 0, by: -1) {
            number = n - (i * 2)
            result += combination(i + number, i)
        }
        return result
    }
    
    func combination(_ n: Int, _ m: Int) -> Int {
        if m == 0 || m == n {
            return 1
        }
        return factorial2(n, m)
    }
    
    func factorial2(_ n: Int, _ m: Int) -> Int {
        let maxNumber = max(m, n - m)
        var minNumber = min(m, n - m)
        var result = 1
        for i in stride(from: n, to: maxNumber, by: -1) {
            // 這邊可能會超過 Int 所以先把可以除的除掉讓他小一點
            if result * i > (Int.max / 100) {
                result /= minNumber
                minNumber -= 1
            }
            result *= i
            
        }

        result /= factorial(minNumber)
        return result
    }

    func factorial(_ n: Int) -> Int {
        if let f = fac[n] {
            return f
        }
        if let f = fac[n + 1] {
            fac[n] = f / (n + 1)
            return fac[n]!
        }
        if let f = fac[n - 1] {
            fac[n] = f * n
            return fac[n]!
        }
        var result = 1
        for i in 2...n {
            result *= i
        }
        fac[n] = result
        return result
    }
}

// 最快的人 結果就是 Fibonacci 數列...
class Solution {
    func climbStairs(_ n: Int) -> Int {
        var first = 0
        var second = 1
        for _ in 0..<n {
            let temp = first
            first = second
            second = temp + second
        }
        return second
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.climbStairs(2)
        XCTAssertEqual(result, 2)
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.climbStairs(3)
        XCTAssertEqual(result, 3)
    }

    func testSolution_03() {
        let sol = Solution()
        let result = sol.climbStairs(6)
        XCTAssertEqual(result, 13)
    }

    func testSolution_04() {
        let sol = Solution()
        let result = sol.climbStairs(35)
        XCTAssertEqual(result, 14930352)
    }

    func testSolution_05() {
        let sol = Solution()
        let result = sol.climbStairs(9)
        XCTAssertEqual(result, 55)
    }
    
    func testSolution_06() {
        let sol = Solution()
        let result = sol.climbStairs(44)
        XCTAssertEqual(result, 1134903170)
    }
}

SolutionTests.defaultTestSuite.run()


