import XCTest

class Solution {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let letters = [Character](word)
        let firstLetter = letters[0]
        var letterPos = Set<UInt8>()
        for y in 0..<board.count {
            for x in 0..<board[y].count {
                let currentLetter = board[y][x]
                if firstLetter == currentLetter {
                    letterPos.insert(convertPosToByte(x, y))
                }
            }
        }
        
        for pos in letterPos {
            if searchWord(board, letters, pos, Set()) {
                return true
            }
        }
        
        return false
    }
    
    func searchWord(_ board: [[Character]], _ letters: [Character], _ current: UInt8, _ passList: Set<UInt8>) -> Bool {
        let letterIndex = passList.count
        var passList = passList
        if passList.contains(current) {
            return false
        } else {
            passList.insert(current)
        }
        
        if passList.count == letters.count {
            return true
        }
        
        let nextIndex = letterIndex + 1
        let currentPos = convertByteToPos(current)
        if currentPos.y > 0, board[currentPos.y - 1][currentPos.x] == letters[nextIndex] {
            if searchWord(board, letters, convertPosToByte(currentPos.x, currentPos.y - 1), passList) {
                return true
            }
        }
        if currentPos.y < board.count - 1, board[currentPos.y + 1][currentPos.x] == letters[nextIndex] {
            if searchWord(board, letters, convertPosToByte(currentPos.x, currentPos.y + 1), passList) {
                return true
            }
        }
        if currentPos.x > 0, board[currentPos.y][currentPos.x - 1] == letters[nextIndex] {
            if searchWord(board, letters, convertPosToByte(currentPos.x - 1, currentPos.y), passList) {
                return true
            }
        }
        if currentPos.x < board[currentPos.y].count - 1, board[currentPos.y][currentPos.x + 1] == letters[nextIndex] {
            if searchWord(board, letters, convertPosToByte(currentPos.x + 1, currentPos.y), passList) {
                return true
            }
        }
        
        return false
    }
    
    func convertPosToByte(_ x: Int, _ y: Int) -> UInt8 {
        var result: UInt8 = 0
        if x > 0 {
            result = result | UInt8(x)
            result = result << 3
        }
        result = result | UInt8(y)
        
        return result
    }
    
    func convertByteToPos(_ pos: UInt8) -> (x: Int, y: Int) {
        var result: (x: Int, y: Int) = (0, 0)
        result.y = Int(pos & UInt8(7))
        result.x = Int((pos >> 3) & UInt8(7))
        return result
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let result = sol.exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCCED")
        XCTAssertEqual(result, true)
    }

    func testSolution_02() {
        let sol = Solution()
        let result = sol.exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "SEE")
        XCTAssertEqual(result, true)
    }

    func testSolution_03() {
        let sol = Solution()
        let result = sol.exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCB")
        XCTAssertEqual(result, false)
    }
    
    func testSolution_04() {
        let sol = Solution()
        let result = sol.exist([["a","a","b","a","a","b"],
                                ["a","a","b","b","b","a"],
                                ["a","a","a","a","b","a"],
                                ["b","a","b","b","a","b"],
                                ["a","b","b","a","b","a"],
                                ["b","a","a","a","a","b"]],
                               "bbbaabbbbbab")
        XCTAssertEqual(result, false)
    }
}

SolutionTests.defaultTestSuite.run()

