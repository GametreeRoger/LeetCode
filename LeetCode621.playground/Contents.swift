import XCTest

// 自己寫的 比較慢
class Solution2 {
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        if n == 0 {
            return tasks.count
        }
        var taskCollections = [Character: Int]()
        for task in tasks {
            taskCollections[task, default: 0] += 1
        }
        // 從最多的字母開始用
        var taskArray = taskCollections.map { ($0, $1) }.sorted { $0.1 > $1.1 }
        var result = 0
        let maxTask = n + 1
        var characterSet = Set<Character>()
        var taskIndex = 0
        while taskArray.count > 0 {
            if !characterSet.contains(taskArray[taskIndex].0) {
                taskArray[taskIndex].1 -= 1
                characterSet.insert(taskArray[taskIndex].0)
                if taskArray[taskIndex].1 == 0 {
                    let removeItem = taskArray.remove(at: taskIndex)
                    taskIndex -= 1
                }
                
            } else {
                result += maxTask
                taskIndex = 0
                characterSet.removeAll()
                continue
            }
            
            if characterSet.count == maxTask {
                result += maxTask
                taskIndex = 0
                characterSet.removeAll()
                // 經過一輪重新排序一次
                taskArray.sort { $0.1 > $1.1 }
            } else {
                taskIndex += 1
            }
            
            if taskIndex >= taskArray.count {
                taskIndex = 0
            }
        }
        
        if characterSet.count != 0 {
            result += characterSet.count
        }
        return result
    }
}

// 最快的人寫的
class Solution {
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        var map = [Character: Int]()

        for task in tasks {
            map[task, default: 0] += 1
        }

        // m == 字數最多的字母
        // ex. "A","A","A","B","B","B" m = 3
        let m = map.values.max()!

        // numMax == 跟最多字數的字母一樣多的個數
        // ex. "A","A","A","B","B","B" numMax = 2
        let numMax = map.values.filter({ $0 == m }).count

        return max(tasks.count,  (m - 1) * (n + 1) + numMax)
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.leastInterval(["A","A","A","B","B","B"], 2)
        XCTAssertEqual(result, 8)
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.leastInterval(["A","A","A","B","B","B"], 0)
        XCTAssertEqual(result, 6)
    }

    func testSolution_03() {
        let sol = Solution()
        let result = sol.leastInterval(["A","A","A","A","A","A","B","C","D","E","F","G"], 2)
        XCTAssertEqual(result, 16)
    }
    
    func testSolution_04() {
        let sol = Solution()
        let result = sol.leastInterval(["A","A","A","B","B","B", "C","C","C", "D", "D", "E"], 2)
        XCTAssertEqual(result, 12)
    }
}

SolutionTests.defaultTestSuite.run()
