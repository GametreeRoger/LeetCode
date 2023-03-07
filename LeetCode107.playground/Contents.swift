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
    var output = [[Int]]()
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        output.removeAll()
        if let root = root {
            output.append([root.val])
            DFS(root, 1)
            output.reverse()
        }
        
        return output
    }
    
    func DFS(_ node: TreeNode, _ level: Int) {
        if let left = node.left {
            checkLevelArray(level)
            output[level].append(left.val)
            DFS(left, level + 1)
        }
        if let right = node.right {
            checkLevelArray(level)
            output[level].append(right.val)
            DFS(right, level + 1)
        }
    }
    
    func checkLevelArray(_ level: Int) {
        if output.count <= level {
            output.append([Int]())
        }
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
        let result = sol.levelOrderBottom(root)
        XCTAssertEqual(result, [[15,7],[9,20],[3]])
    }

    func testSolution_02() {
        let sol = Solution()
        var root = TreeNodeFactor().createTree([1])
        let result = sol.levelOrderBottom(root)
        XCTAssertEqual(result, [[1]])
    }

    func testSolution_03() {
        let sol = Solution()
        var root = TreeNodeFactor().createTree([])
        let result = sol.levelOrderBottom(root)
        XCTAssertEqual(result, [])
    }
    
    func testSolution_04() {
        let sol = Solution()
        var root = TreeNodeFactor().createTree([1,2,3,4,nil,nil,5])
        let result = sol.levelOrderBottom(root)
        XCTAssertEqual(result, [[4,5],[2,3],[1]])
    }
}

SolutionTests.defaultTestSuite.run()

