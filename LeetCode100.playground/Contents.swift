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
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        return DFS(p, q)
    }
    
    func DFS(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if let p = p, let q = q {
            if p.val != q.val {
                return false
            }
            
            if !DFS(p.left, q.left) {
                return false
            }
            
            if !DFS(p.right, q.right) {
                return false
            }
        } else {
            if p != nil || q != nil {
                return false
            }
        }
        return true
    }
}

class TreeNodeFactory {
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
        var root1 = TreeNodeFactory().createTree([1,2,3])
        var root2 = TreeNodeFactory().createTree([1,2,3])
        let result = sol.isSameTree(root1, root2)
        XCTAssertEqual(result, true)
    }

    func testSolution_02() {
        let sol = Solution()
        var root1 = TreeNodeFactory().createTree([1,2])
        var root2 = TreeNodeFactory().createTree([1,nil,2])
        let result = sol.isSameTree(root1, root2)
        XCTAssertEqual(result, false)
    }
    
    func testSolution_03() {
        let sol = Solution()
        var root1 = TreeNodeFactory().createTree([1,2,1])
        var root2 = TreeNodeFactory().createTree([1,1,2])
        let result = sol.isSameTree(root1, root2)
        XCTAssertEqual(result, false)
    }
}

SolutionTests.defaultTestSuite.run()
