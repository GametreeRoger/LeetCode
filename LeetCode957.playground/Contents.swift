import XCTest

class Solution {
    func prisonAfterNDays(_ cells: [Int], _ n: Int) -> [Int] {
        func getNext(_ index: Int) -> Int {
            if index == 0 || index == pref.count - 1 {
                return 0
            }
            if pref[index - 1] == pref[index + 1] {
                return 1
            }
            
            return 0
        }
        
        let isFirstIndexZero = cells[0] == 0 && cells[cells.count - 1] == 0
        var checkCount = isFirstIndexZero ? n % 14 : (n - 1) % 14 + 1
        print("Days 00: \(cells)")
        var pref = cells
        var result = cells
        for day in stride(from: 1, through: checkCount, by: 1) {
            for i in stride(from: 0, to: pref.count, by: 1) {
                result[i] = getNext(i)
            }
            print("Days \(String(format: "%02d", day)): \(result)")
            pref = result
        }
        return result
    }
}


class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.prisonAfterNDays([0,1,0,1,1,0,0,1], 7)
        XCTAssertEqual(result, [0,0,1,1,0,0,0,0])
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.prisonAfterNDays([1,0,0,1,0,0,1,0], 1000000000)
        XCTAssertEqual(result, [0,0,1,1,1,1,1,0])
    }
    
    func testSolution_03() {
        let sol = Solution()
        let result = sol.prisonAfterNDays([1,1,0,1,1,0,0,1], 300663720)
        XCTAssertEqual(result, [0,0,1,0,0,1,1,0])
    }
}

SolutionTests.defaultTestSuite.run()

