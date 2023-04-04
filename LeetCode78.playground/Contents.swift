import XCTest

// 超時
class Solution2 {
    func subsets(_ nums: [Int]) -> [[Int]] {
        
        var result = Set<[Int]>()
        for i in 0...nums.count {
            let cnums = Combination(nums, i)
            for num in cnums {
                result.insert(num)
            }
        }
        return Array(result)
    }
    
    func Combination(_ nums: [Int], _ n: Int) -> [[Int]] {
        if n == 0 {
            return [[]]
        }
        if n == nums.count {
            return [nums]
        }
        
        if n == 1 {
            return nums.map { [$0] }
        } else {
            var record = Set<[Int]>()
            for i in nums.indices {
                var tempNums = nums
                let recordNum = tempNums.remove(at: i)
                print("recordNum:\(recordNum), tempNums:\(tempNums)")
                var cNums = Combination(tempNums, n - 1)
                
                for i in cNums.indices {
                    cNums[i].append(recordNum)
                }
                print("cNums:\(cNums)")
                for num in cNums {
                    if !isContainInSet(record, num) {
                        record.insert(num)
                    }
                }
                print("--------------- record:\(record)")
            }
            return Array(record)
        }
    }
    
    func isContainInSet(_ records: Set<[Int]>, _ num: [Int]) -> Bool {
        for record in records {
            print("compare: \(record) and \(num)")
            if record == num {
                return true
            }
        }
        return false
    }
}

extension Array where Element == Int {
    var hashValue: Int {
        get {
            String(self.sorted().map { String($0) }.joined(separator: "")).hashValue
        }
    }
    
    static func == (lhs: Array<Element>, rhs: Array<Element>) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

class Solution {
    var records = [Int : [[Int]]]()
    func subsets(_ nums: [Int]) -> [[Int]] {
        
        for i in 0...nums.count {
            Combination(Array(nums[0..<i]))
        }
        
        var result = [[Int]]()
        for (_, numArray) in records {
            result += numArray
        }
        
        return result
    }
    
    func Combination(_ nums: [Int]) {
        if nums.isEmpty {
            records[0] = [[]]
        }
        
        for i in stride(from: nums.count, through: 1, by: -1) {
            if records[i] == nil {
                records[i] = []
            }
            if let num = nums.last {
                if i == 1 {
                    records[1]!.append([num])
                } else {
                    let preIndex = i - 1
                    if let preList = records[preIndex] {
                        for item in preList {
                            var newArray = item
                            newArray.append(num)
                            records[i]!.append(newArray)
                        }
                    }
                }
            }
        }
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.subsets([1,2,3])
        var count = result.count
        let answer = [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
        for item in result {
            for an in answer {
                if an == item {
                    count -= 1
                }
            }
        }
        XCTAssertTrue(count == 0)
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.subsets([0])
        var count = result.count
        let answer = [[],[0]]
        for item in result {
            for an in answer {
                if an == item {
                    count -= 1
                }
            }
        }
        XCTAssertTrue(count == 0)
    }
}

SolutionTests.defaultTestSuite.run()

