import XCTest

// 用 swift 提供的 sort
class Solution2 {
    func findMin(_ nums: [Int]) -> Int {
        if nums.count == 1 {
            return nums[0]
        }
        if let first = nums.first,
           let last = nums.last,
            first < last {
            return first
        }
        return nums.sorted()[0]
    }
}

// 自己寫的 最慢
class Solution3 {
    var minRecord = 5001
    func findMin(_ nums: [Int]) -> Int {
        if nums.count == 1 {
            return nums[0]
        }
        if nums.count == 2 {
            return min(nums[0], nums[1])
        }
        if let first = nums.first,
           let last = nums.last,
            first < last {
            return first
        }
        
        // 剩下不是前小後大的組合
        findHalfMin(nums)
        
        return minRecord
    }
    
    func findHalfMin(_ nums: [Int]) {
        if nums.count == 1 && nums[0] < minRecord {
            minRecord = nums[0]
            return
        }
        if nums.count == 2 {
            minRecord = min(nums[0], nums[1], minRecord)
            return
        }
        if nums.count == 3 {
            minRecord = min(nums[0], nums[1], nums[2], minRecord)
            return
        }
        
        let mid = Int(floor(Double(nums.count) / 2))
        let last = nums.count - 1
        var firstHalf = minRecord
        
        // 前段
        // 如果 nums[0](5) < nums[mid](11) 表示 5,7,9,11,0,1,3 是從小到大
        // 如果 nums[0](7) > nums[mid](0) 表示 7,9,11,0,1,3,5 是有接到最小的部分
        // 如果 nums[0](5) == nums[mid](5) 表示 5,0,1,3,5,5,5,5,5 or 5,5,5,5,5,0,1,3,5 有重複的，不代表中間都是重複的
        if nums[0] <= nums[mid] && nums[0] < firstHalf {
            firstHalf = nums[0]
        } else if nums[mid] < nums[0] && nums[mid] < firstHalf {
            firstHalf = nums[mid]
        }
        
        var secondHalf = firstHalf
        // 後段
        // 如果 nums[mid](1) < nums[last](7) 表示 9,11,0,1,3,5,7 從小到大
        // 如果 nums[mid](11) > nums[last](3) 表是 5,7,9,11,0,1,3 有接到最小的部分
        // 如果 nums[mid](5) == nums[last](5) 表示 5,0,1,3,5,5,5,5,5 or 5,5,5,5,5,0,1,3,5 有重複的，不代表中間都是重複的
        if nums[mid] <= nums[last] && nums[mid] < secondHalf {
            secondHalf = nums[mid]
        } else if nums[last] < nums[mid] && nums[last] < secondHalf {
            secondHalf = nums[last]
        }
        minRecord = min(firstHalf, secondHalf, minRecord)
        // 如果 firstHalf == secondHalf 無法判斷最小在哪一半
        // 如果 firstHalf < secondHalf 表示按順序了 0,1,2,3,4,5 (不會判斷到了，前面被過濾掉了)
        // 如果 secondHalf < firstHalf 表示最小在後半段 如：5,7,9,11,0,1,3
        if secondHalf < firstHalf {
            findHalfMin(Array(nums[mid...last]))
        } else {
            if mid != 0 {
                findHalfMin(Array(nums[0...mid - 1]))
            } else {
                findHalfMin(Array(nums[0...mid]))
            }
            findHalfMin(Array(nums[mid...last]))
        }
    }
}

// 看第一快的人 跑了還是很慢但比自己的好了
class Solution {
    func findMin(_ nums: [Int]) -> Int {
        var left = 0
        var right = nums.count - 1
        while left < right {
            // 兩邊重複的去掉
            while left < right && nums[left] == nums[left+1] {
                left += 1
            }
            while left < right && nums[right] == nums[right-1] {
                right -= 1
            }
            let center = (left + right) / 2
            // 剩下2, 3 個的狀況
            if left + 1 >= center {
                var i = left
                for j in center...right {
                    if nums[j] < nums[i] {
                        i = j
                    }
                }
                return nums[i]
            }
            if nums[center] > nums[right] {
                // ex:  2,3,4,0,1 or 1,2,3,4,0
                // 表示最小在右半邊
                left = center
            } else {
                // ex: 0,1,2,3,4 or 4,0,1,2,3
                // 表示最小在左半邊
                right = center
            }
        }
        return nums[left]
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.findMin([1,3,5])
        XCTAssertEqual(result, 1)
    }
    
    func testSolution_02() {
        let sol = Solution()
        let result = sol.findMin([2,2,2,0,1])
        XCTAssertEqual(result, 0)
    }
}

SolutionTests.defaultTestSuite.run()
