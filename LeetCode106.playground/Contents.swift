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
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        let rootVal = postorder[postorder.count - 1]
        let valPos = inorder.firstIndex(of: rootVal)
        let inorderRootIndex = inorder.distance(from: inorder.startIndex, to: valPos!)
        
        var node = TreeNode(rootVal)
        if inorderRootIndex != 0 {
            let leftInorderArray = Array(inorder[0..<inorderRootIndex])
            let leftPostorderArray = Array(postorder[0..<leftInorderArray.count])
            node.left = buildTree(leftInorderArray, leftPostorderArray)
        }
        
        if inorderRootIndex != inorder.count - 1 {
            let rightInorderArray = Array(inorder[inorderRootIndex + 1..<inorder.count])
            let postorderRightStartIndex = postorder.count - 1 - rightInorderArray.count
            let rightPostorderArray = Array(postorder[postorderRightStartIndex..<postorder.count - 1])
            node.right = buildTree(rightInorderArray, rightPostorderArray)
        }
        
        return node
    }
}

class LevelOrderFactor {
    func converArray(_ root: TreeNode?) -> [Int?] {
        var result = [Int?]()
        if let root = root {
            result = BFS(root)
        }
        
        return result
    }
    
    func BFS(_ node: TreeNode) -> [Int?] {
        var level = 0
        var levelNodeNilCount = 0
        var nodeList = [TreeNode?]()
        nodeList.append(node)
        var nextLevelQueue = [TreeNode?]()
        var result = [Int?]()
        
        while !nodeList.isEmpty {
            var currentNode = nodeList.remove(at: 0)
            if let currentNode = currentNode {
                result.append(currentNode.val)
                if let left = currentNode.left {
                    nextLevelQueue.append(left)
                } else {
                    nextLevelQueue.append(nil)
                    levelNodeNilCount += 1
                }
                if let right = currentNode.right {
                    nextLevelQueue.append(right)
                } else {
                    nextLevelQueue.append(nil)
                    levelNodeNilCount += 1
                }
            } else {
                result.append(nil)
            }
            
            if nodeList.isEmpty && !nextLevelQueue.isEmpty {
                if levelNodeNilCount < nextLevelQueue.count {
                    nodeList.append(contentsOf: nextLevelQueue)
                }
                nextLevelQueue.removeAll()
                levelNodeNilCount = 0
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
//                print("right:\(node.right!.val)")
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
        var root = sol.buildTree([9,3,15,20,7], [9,15,7,20,3])
        let result = LevelOrderFactor().converArray(root)
        XCTAssertEqual(result, [3,9,20,nil,nil,15,7])
    }

    func testSolution_02() {
        let sol = Solution()
        var root = sol.buildTree([-1], [-1])
        let result = LevelOrderFactor().converArray(root)
        XCTAssertEqual(result, [-1])
    }
}

SolutionTests.defaultTestSuite.run()
