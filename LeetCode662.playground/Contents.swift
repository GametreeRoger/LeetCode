import XCTest

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

// 會超時
class Solution02 {
    var levelRecord = [[Bool]]()
    func widthOfBinaryTree(_ root: TreeNode?) -> Int {
        var result = 0
        if let root = root {
            levelRecord.removeAll()
            BFS(root)
            result = getMaxLevel()
        }
        
        return result
    }
    
    func BFS(_ node: TreeNode) {
        var nodeQueue = [TreeNode?]()
        nodeQueue.append(node)
        var level = 1
        var levelNodeCount = 0
        levelRecord.append([true])
        while !nodeQueue.isEmpty {
            if level >= levelRecord.count {
                let reapetCount = NSDecimalNumber(decimal: pow(2, level))
                levelRecord.append([Bool](repeating: false, count: Int(truncating: reapetCount)))
                levelNodeCount = 0
            }
            if let currentNode = nodeQueue.remove(at: 0) {
                nodeQueue.append(currentNode.left)
                nodeQueue.append(currentNode.right)
                if currentNode.left != nil {
                    levelRecord[level][levelNodeCount] = true
                }
                levelNodeCount += 1
                if currentNode.right != nil {
                    levelRecord[level][levelNodeCount] = true
                }
                levelNodeCount += 1
            } else {
                nodeQueue.append(nil)
                nodeQueue.append(nil)
                levelNodeCount += 2
            }
            if levelNodeCount == levelRecord[level].count {
                if levelRecord[level].filter({ $0 == false }).count == levelRecord[level].count {
                    nodeQueue.removeAll()
                    levelRecord.remove(at: level)
                } else {
                    level += 1
                }
            }
        }
    }
    
    func getMaxLevel() -> Int {
        var recordMax = 0
        for level in levelRecord {
            var lev = level
            while lev.first == false {
                lev.removeFirst()
            }
            while lev.last == false {
                lev.removeLast()
            }
            recordMax = max(recordMax, lev.count)
        }
        return recordMax
    }
}

class Solution {
    var levelRecord = [[Int]]()
    func widthOfBinaryTree(_ root: TreeNode?) -> Int {
        var result = 0
        if let root = root {
            levelRecord.removeAll()
            BFS(root)
            result = getMaxLevel()
        }
        
        return result
    }
    
    func BFS(_ node: TreeNode) {
        var nodeQueue = [TreeNode]()
        nodeQueue.append(node)
        var level = 1
        var levelNodeCount = 0
        levelRecord.append([0])
        while !nodeQueue.isEmpty {
            if level >= levelRecord.count {
                levelRecord.append([Int]())
                levelNodeCount = 0
            }
            levelNodeCount = checkNotEmptyIndex(level, levelNodeCount)
            let currentNode = nodeQueue.remove(at: 0)
            if let left = currentNode.left {
                nodeQueue.append(left)
                levelRecord[level].append(levelNodeCount)
//                print("append : \(levelNodeCount)")
            }
            levelNodeCount += 1
            if let right = currentNode.right {
                nodeQueue.append(right)
                levelRecord[level].append(levelNodeCount)
//                print("append : \(levelNodeCount)")
            }
            levelNodeCount += 1
            if levelNodeCount >= getPreLevelLastIndex(level) * 2 + 1 {
                if let base = levelRecord[level].first {
                    for i in 0..<levelRecord[level].count {
                        levelRecord[level][i] -= base
                    }
                }
                
                level += 1
            }
        }
    }
    
    // 只能確定現在在的位置上一層是不是空的，空的就往後移，如果不是空的就有可能有
    func checkNotEmptyIndex(_ level: Int, _ levelNodeCount: Int) -> Int {
        if level - 1 < 0 {
            return 0
        }
        var notEmptyIndex = levelNodeCount
        let preLevel = level - 1
        for node in levelRecord[preLevel] {
            if notEmptyIndex < node * 2 && ![node * 2, node * 2 + 1].contains(notEmptyIndex) {
                notEmptyIndex = node * 2
                break
            } else if [node * 2, node * 2 + 1].contains(notEmptyIndex) {
                break
            }
        }
        return notEmptyIndex
    }
    
    func getPreLevelLastIndex(_ level: Int) -> Int {
        let preLevel = level - 1
        return levelRecord[preLevel].last ?? 0
    }
    
    func getMaxLevel() -> Int {
        var recordMax = 0
        for level in levelRecord {
            var levelWidth = 0
            if let first = level.first, let last = level.last {
                levelWidth = last - first + 1
            }
            recordMax = max(recordMax, levelWidth)
        }
        return recordMax
    }
}

class TreeNodeFactor {
    var leafList = [TreeNode]()
    var level = 1
    func createTree(_ input: [Int?]) -> TreeNode? {
        if input.isEmpty {
            return nil
        }
        
        var root = TreeNode(input[0]!)
        leafList.append(root)
        addNode(input, 1)
        
        return root
    }

    func addNode(_ input: [Int?], _ index: Int) {
        guard !leafList.isEmpty else {
            return
        }
        
        var currentIndex = index
        var currentLeafList = [TreeNode]()
        for node in leafList {
            printNode("node:\(node.val)")
            if let left = createNode(input, currentIndex) {
                node.left = left
                currentIndex += 1
                currentLeafList.append(node.left!)
                printNode("left:\(node.left!.val)")
            } else {
                if currentIndex < input.count {
                    currentIndex += 1
                    printNode("left - null")
                } else {
                    return
                }
            }
            
            if let right = createNode(input, currentIndex) {
                node.right = right
                currentIndex += 1
                currentLeafList.append(node.right!)
                printNode("right:\(node.right!.val)")
            } else {
                if currentIndex < input.count {
                    currentIndex += 1
                    printNode("right - null")
                } else {
                    return
                }
            }
        }
        printNode("Level \(level) complete!")
        level += 1
        leafList.removeAll()
        if !currentLeafList.isEmpty {
            printNode("Next Level!!!!!!!!!!!!")
            leafList.append(contentsOf: currentLeafList)
            addNode(input, currentIndex)
        }
    }
    
    func printNode(_ val: String) {
//        print(val)
    }

    func createNode(_ input: [Int?], _ index: Int) -> TreeNode? {
        if index < input.count {
            if let val = input[index] {
                return TreeNode(val)
            }
        }
        return nil
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        var root = TreeNodeFactor().createTree([1,3,2,5,3,nil,9])
        let result = sol.widthOfBinaryTree(root)
        XCTAssertEqual(result, 4)
    }

    func testSolution_02() {
        let sol = Solution()
        var root = TreeNodeFactor().createTree([1,3,2,5,nil,nil,9,6,nil,7])
        let result = sol.widthOfBinaryTree(root)
        XCTAssertEqual(result, 7)
    }

    func testSolution_03() {
        let sol = Solution()
        var root = TreeNodeFactor().createTree([1,3,2,5])
        let result = sol.widthOfBinaryTree(root)
        XCTAssertEqual(result, 2)
    }

    func testSolution_04() {
        let sol = Solution()
        var root = TreeNodeFactor().createTree([1,1,1,1,1,1,1,nil,nil,nil,1,nil,nil,nil,nil,2,2,2,2,2,2,2,nil,2,nil,nil,2,nil,2])
        let result = sol.widthOfBinaryTree(root)
        XCTAssertEqual(result, 8)
    }
    
    func testSolution_05() {
        let sol = Solution()
        var root = TreeNodeFactor().createTree([0,0,0,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil,nil,0,0,nil])
        let result = sol.widthOfBinaryTree(root)
        XCTAssertEqual(result, 2)
    }
}

SolutionTests.defaultTestSuite.run()

