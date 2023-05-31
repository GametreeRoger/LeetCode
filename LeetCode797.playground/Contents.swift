import XCTest

class Solution {
    var result = [[Int]]()
    func allPathsSourceTarget(_ graph: [[Int]]) -> [[Int]] {
        DFS(graph, 0, [0])
        return result
    }
    
    func DFS(_ graph: [[Int]], _ index: Int, _ currentList: [Int]) {
        for i in graph[index] {
            var nextList = currentList
            nextList.append(i)
            if i == graph.count - 1 {
                result.append(nextList)
            } else {
                DFS(graph, i, nextList)
            }
        }
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.allPathsSourceTarget([[1,2],[3],[3],[]])
        XCTAssertEqual(result, [[0,1,3],[0,2,3]])
    }
    
    func testSolution_02() {
        let sol = Solution()
        let result = sol.allPathsSourceTarget([[4,3,1],[3,2,4],[3],[4],[]])
        XCTAssertEqual(result, [[0,4],[0,3,4],[0,1,3,4],[0,1,2,3,4],[0,1,4]])
    }
}

SolutionTests.defaultTestSuite.run()
