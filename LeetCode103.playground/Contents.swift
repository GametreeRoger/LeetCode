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
class Solution {
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        
        var result = [[Int]]()
        if let root = root {
            result = BFS(root)
        }
        
        return result
    }
    
    func BFS(_ node: TreeNode) -> [[Int]] {
        var level = 0
        var nodeList = [TreeNode]()
        nodeList.append(node)
        var nextLevelQueue = [TreeNode]()
        var result = [[Int]]()
        
        while !nodeList.isEmpty {
            var currentNode: TreeNode
            currentNode = nodeList.remove(at: 0)
            if result.count <= level {
                result.append([Int]())
            }
            if level % 2 == 0 {
                result[level].append(currentNode.val)
            } else {
                result[level].insert(currentNode.val, at: 0)
            }
            
            if let left = currentNode.left {
                nextLevelQueue.append(left)
            }
            if let right = currentNode.right {
                nextLevelQueue.append(right)
            }
            
            if nodeList.isEmpty && !nextLevelQueue.isEmpty {
                nodeList.append(contentsOf: nextLevelQueue)
                nextLevelQueue.removeAll()
                level += 1
            }
        }
        return result
    }
}

class TreeNodeFactor {
    var leafList = [TreeNode]()
    func createTree(_ input: [Int?]) -> TreeNode? {
        if input.isEmpty {
            return nil
        }
        
        var root = TreeNode(input[0]!)
        leafList.append(root)
//        print("root:\(root.val)")
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
//            print("node:\(node.val)")
            if let left = createNode(input, currentIndex) {
                node.left = left
                currentIndex += 1
                currentLeafList.append(node.left!)
//                print("left:\(node.left!.val)")
            } else {
                if currentIndex < input.count {
                    currentIndex += 1
//                    print("left - null")
                } else {
                    return
                }
            }
            
            if let right = createNode(input, currentIndex) {
                node.right = right
                currentIndex += 1
                currentLeafList.append(node.right!)
//                print("left:\(node.right!.val)")
            } else {
                if currentIndex < input.count {
                    currentIndex += 1
//                    print("right - null")
                } else {
                    return
                }
            }
        }
        leafList.removeAll()
        if !currentLeafList.isEmpty {
//            print("Next Level!!!!!!!!!!!!")
            leafList.append(contentsOf: currentLeafList)
            addNode(input, currentIndex)
        }
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
        var root = TreeNodeFactor().createTree([3,9,20,nil,nil,15,7])
        let result = sol.zigzagLevelOrder(root)
        XCTAssertEqual(result, [[3],[20,9],[15,7]])
    }
    func testSolution_02() {
        let sol = Solution()
        var root = TreeNodeFactor().createTree([1])
        let result = sol.zigzagLevelOrder(root)
        XCTAssertEqual(result, [[1]])
    }
    func testSolution_03() {
        let sol = Solution()
        var root = TreeNodeFactor().createTree([])
        let result = sol.zigzagLevelOrder(root)
        XCTAssertEqual(result, [])
    }
    
    func testSolution_04() {
        let sol = Solution()
        var root = TreeNodeFactor().createTree([1,2,3,4,6,7,5])
        let result = sol.zigzagLevelOrder(root)
        XCTAssertEqual(result, [[1],[3,2],[4,6,7,5]])
    }
}

SolutionTests.defaultTestSuite.run()
