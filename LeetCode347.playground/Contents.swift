import XCTest

class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var nums = nums.sorted()
        var record: [Int: Int] = [Int: Int]()
        for num in nums {
            if record[num] == nil {
                record[num] = 1
            }
            record[num]! += 1
        }
        let maxrecord = record.sorted { $0.value > $1.value }.map{$0.key}
        return Array(maxrecord[0..<k])
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.topKFrequent([1,1,1,2,2,3], 2)
        XCTAssertEqual(result, [1,2])
    }
    
    func testSolution_02() {
        let sol = Solution()
        let result = sol.topKFrequent([1], 1)
        XCTAssertEqual(result, [1])
    }
}

SolutionTests.defaultTestSuite.run()
