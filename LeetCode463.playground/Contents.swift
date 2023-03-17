import XCTest

class Solution {
    func islandPerimeter(_ grid: [[Int]]) -> Int {
        var count = 0
        for y in grid.indices {
            for x in grid[y].indices {
                count += getSide(grid, x, y)
            }
        }
        return count
    }
    
    func getSide(_ grid: [[Int]], _ x: Int, _ y: Int) -> Int {
        if(grid[y][x] == 0) {
            return 0
        }
        
        var side = 0
        // up
        if y == 0 || grid[y - 1][x] == 0 {
            side += 1
        }
        // down
        if y == grid.count - 1 || grid[y + 1][x] == 0 {
            side += 1
        }
        // left
        if x == 0 || grid[y][x - 1] == 0 {
            side += 1
        }
        // right
        if x == grid[y].count - 1 || grid[y][x + 1] == 0 {
            side += 1
        }
        return side
    }
}


class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.islandPerimeter([[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]])
        XCTAssertEqual(result, 16)
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.islandPerimeter([[1]])
        XCTAssertEqual(result, 4)
    }

    func testSolution_03() {
        let sol = Solution()
        let result = sol.islandPerimeter([[1,0]])
        XCTAssertEqual(result, 4)
    }

    func testSolution_04() {
        let sol = Solution()
        let result = sol.islandPerimeter([[0,1,0,1,0],[1,1,1,1,1],[0,1,1,1,0],[1,1,1,1,1],[0,0,0,0,0]])
        XCTAssertEqual(result, 24)
    }

    func testSolution_05() {
        let sol = Solution()
        let result = sol.islandPerimeter([[0,1]])
        XCTAssertEqual(result, 4)
    }
    
    func testSolution_06() {
        let sol = Solution()
        let result = sol.islandPerimeter([[1,1,1,1],[1,1,0,1],[1,1,0,1]])
        XCTAssertEqual(result, 18)
    }
}

SolutionTests.defaultTestSuite.run()
