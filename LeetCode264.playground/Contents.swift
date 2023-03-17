import XCTest

// 暴力解會Timeout
class Solution1 {
    func nthUglyNumber(_ n: Int) -> Int {
        guard n > 1 else {
            return 1
        }
        
        var count = 1
        var number = 1
        var numberList = [Int]()
        numberList.append(1)
        while count < n {
            number += 1
            if isUglyNumber(number) {
                count += 1
                numberList.append(number)
            }
        }
        print(numberList)
        return number
    }
    
    func isUglyNumber(_ n: Int) -> Bool {
        var result = n
        
        while result >= 2 && result % 2 == 0 {
            result /= 2
        }
        
        while result >= 3 && result % 3 == 0 {
            result /= 3
        }
        
        while result >= 5 && result % 5 == 0 {
            result /= 5
        }
        
        return result == 1
    }
}

// 想不出解法只好參考 https://www.youtube.com/live/N-Oq5BREahU?feature=share
class Solution {
    var cache = [Int]()
    func nthUglyNumber(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        cache = [Int](repeating: 0, count: n + 1)
        cache[1] = 1
        return nUglyNumber(n)
    }
    
    func nUglyNumber(_ N: Int) -> Int {
        var min2index = 1
        var min3index = 1
        var min5index = 1
        for n in 2...N {
            let minNumber2 = cache[min2index] * 2
            let minNumber3 = cache[min3index] * 3
            let minNumber5 = cache[min5index] * 5
            
            cache[n] = min(minNumber2, minNumber3, minNumber5)
            if cache[n] == minNumber2 {
                min2index += 1
            }
            if cache[n] == minNumber3 {
                min3index += 1
            }
            if cache[n] == minNumber5 {
                min5index += 1
            }
            
            cache[n] = min(minNumber2, minNumber3, minNumber5)
        }
        
        return cache[N]
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.nthUglyNumber(10)
        XCTAssertEqual(result, 12)
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.nthUglyNumber(1)
        XCTAssertEqual(result, 1)
    }
}

SolutionTests.defaultTestSuite.run()
