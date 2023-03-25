import UIKit
import XCTest
import Foundation

// 暴力破解，遇到多一點的題目會超時
class Solution2 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var record = [String: [Int]]()
        var result = [[Int]]()
        for i in 0..<nums.count {
            let aNumber = nums[i]
            
            for j in 0..<nums.count {
                if j == i {
                    continue
                }
                let bNumber = nums[j]
                let remain = 0 - (aNumber + bNumber)
                for k in 0..<nums.count {
                    if k == i || k == j {
                        continue
                    }
                    if nums[k] == remain {
                        let triplet = [aNumber, bNumber, nums[k]].sorted()
                        let key = triplet.map{String($0)}.joined(separator: "")
                        if record[key] == nil {
                            record[key] = triplet
                        }
                    }
                }
            }
        }
        result.append(contentsOf: record.values)
        return result
    }
}


class Solution3 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        var resultsDic = [String: [Int]]()
        var numIndexSet = [Int: Int]()
        var map = [Int: [Int]]()
        for (index, number) in nums.enumerated() {
            if map[number] == nil {
                map[number] = [Int]()
            }
            if numIndexSet[number] == nil {
                numIndexSet[number] = index
            }
            map[number]!.append(index)
        }
        
        for (number, index) in numIndexSet {
            let threeSum = twoSum(map, nums, -number, index)
            if threeSum.isEmpty {
                continue
            }
            
            if !threeSum.isEmpty {
                let threeResult = getTriplet(nums, threeSum)
                resultsDic = resultsDic.merging(threeResult, uniquingKeysWith: { first, _ in first })
            }
            
        }
        
        results.append(contentsOf: resultsDic.values)
        results.sort { x, y in
            var isLessThan = false
            for i in 0..<x.count {
                if x[i] == y[i], i == x.count - 1 {
                    isLessThan = x[i] < y[i]
                } else if x[i] == y[i] {
                    continue
                } else {
                    isLessThan = x[i] < y[i]
                    break
                }
            }
            return isLessThan
        }
        return results
    }
    
    private func getTriplet(_ nums: [Int], _ indexsArray: [[Int]]) -> [String: [Int]] {
        var dic = [String: [Int]]()
        for indexs in indexsArray {
            let result = [nums[indexs[0]], nums[indexs[1]], nums[indexs[2]]].sorted()
            let key = result.map{String($0)}.joined(separator: "")
            if dic[key] == nil {
                dic[key] = result
            }
        }
        return dic
    }
    
    func twoSum(_ map: [Int: [Int]], _ nums: [Int], _ target: Int, _ notInclude: Int) -> [[Int]] {
        var result = [[Int]]()
        var complementSet = Set<Int>()
        for (i, num) in nums.enumerated() {
            if i == notInclude {
                continue
            }
            let complement = target - num
            if !complementSet.contains(complement),
               let indexs = map[complement]
            {
                complementSet.insert(complement)
                
                for index in indexs {
                    if index == notInclude || index == i {
                        continue
                    }
                    result.append([notInclude, index, i])
                }
            }
        }
        return result
    }
}

// 先排序，然後前後夾擊
class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 2 else { return [] }
        let nums = nums.sorted()
        
        var results = [[Int]]()
        
        for i in 0..<nums.count - 2 {
            
            if i == 0 || i > 0 && nums[i] != nums[i - 1] {
                
                var low = i + 1
                var high = nums.count - 1
                let sum = 0 - nums[i]
                
                while low < high {
                    
                    if nums[low] + nums[high] == sum {
                        results.append([nums[low], nums[high], nums[i]])
                        
                        while low < high && nums[low] == nums[low + 1] {
                            low += 1
                        }
                        
                        while low < high && nums[high] == nums[high - 1] {
                            high -= 1
                        }
                        
                        low += 1
                        high -= 1
                    } else if nums[low] + nums[high] > sum {
                        high -= 1
                    } else {
                        low += 1
                    }
                }
            }
        }
        
        return results
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.threeSum([-1,0,1,2,-1,-4])
        let testArray =  [[-1,-1,2],[-1,0,1]]
        for a in result {
            let answer = a.sorted().map{String($0)}.joined(separator: "")
            var ismatch = false
            for b in testArray {
                let test = b.sorted().map{String($0)}.joined(separator: "")
                if test == answer {
                    ismatch = true
                    break
                }
            }
            XCTAssertTrue(ismatch)
        }
    }
    
    func testSolution_02() {
        let sol = Solution()
        let result = sol.threeSum([0,1,1])
        XCTAssertEqual(result, [])
    }
    
    func testSolution_03() {
        let sol = Solution()
        let result = sol.threeSum([0,0,0])
        XCTAssertEqual(result, [[0,0,0]])
    }
}

SolutionTests.defaultTestSuite.run()


