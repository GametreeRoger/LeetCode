import XCTest

public class Node {
    public var val: Int
    public var prev: Node?
    public var next: Node?
    public var child: Node?
    public init(_ val: Int) {
        self.val = val
        self.prev = nil
        self.next = nil
        self.child  = nil
    }
}

class Solution {
    func flatten(_ head: Node?) -> Node? {
        if head == nil {
            return nil
        }
        
        var head = head
        var curr = head
        DFS(curr!)
        return head
    }
    
    func DFS(_ node: Node) -> Node {
        
        var node = node
        if node.child != nil {
            var next = node.next
            node.next = node.child
            node.child!.prev = node
            var childListEnd = DFS(node.child!)
            node.child = nil
            childListEnd.next = next
            if next != nil {
                next!.prev = childListEnd
                node = next!
            }
        }
        
        if node.next != nil {
            node = DFS(node.next!)
        }
        
        if node.next == nil {
            return node
        }
        return node
    }
}

class LinkedListFactor {
    func createLinkedList(_ input: [Int?]) -> Node? {
        if input.isEmpty {
            return nil
        }
        
        if input.first == nil {
            return nil
        }
        
        var head = Node(input[0]!)
        var curr = head
        var listStart = head
        var nilCount = 0
        for i in 1..<input.count {
            if let val = input[i] {
                if nilCount > 0 {
                    nilCount -= 1
                    curr = listStart
                    for _ in 0..<nilCount {
                        if curr.next != nil {
                            curr = curr.next!
                        }
                    }
                    nilCount = 0
                    var child = Node(val)
                    listStart = child
                    curr.child = child
//                    print("\(curr.val).child -> \(child.val)")
                    curr = child
                } else {
                    var next = Node(val)
                    curr.next = next
                    next.prev = curr
//                    print("\(curr.val) -> \(next.val)")
                    curr = next
                }
            } else {
                // nil
                nilCount += 1
//                print("nil")
            }
        }
        
        return head
    }
    
    func convertArray(_ head: Node?) -> [Int] {
        guard head != nil else {
            return [Int]()
        }
        
        var valList = [Int]()
        var curr = head
        while curr != nil {
            valList.append(curr!.val)
//            print("curr: \(curr?.val), curr.next:\(curr?.next?.val), curr.prev:\(curr?.prev?.val), curr.child:\(curr?.child?.val)")
            curr = curr!.next
        }
        
        return valList
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        var head = LinkedListFactor().createLinkedList([1,2,3,4,5,6,nil,nil,nil,7,8,9,10,nil,nil,11,12])
        let resulthead = sol.flatten(head)
        let result = LinkedListFactor().convertArray(resulthead)
        XCTAssertEqual(result, [1,2,3,7,8,11,12,9,10,4,5,6])
    }

    func testSolution_02() {
        let sol = Solution()
        var head = LinkedListFactor().createLinkedList([1,2,nil,3])
        let resulthead = sol.flatten(head)
        let result = LinkedListFactor().convertArray(resulthead)
        XCTAssertEqual(result, [1,3,2])
    }

    func testSolution_03() {
        let sol = Solution()
        var head = LinkedListFactor().createLinkedList([])
        let resulthead = sol.flatten(head)
        let result = LinkedListFactor().convertArray(resulthead)
        XCTAssertEqual(result, [])
    }
    
    func testSolution_04() {
        let sol = Solution()
        var head = LinkedListFactor().createLinkedList([1,nil,2,nil,3,nil])
        let resulthead = sol.flatten(head)
        let result = LinkedListFactor().convertArray(resulthead)
        XCTAssertEqual(result, [1,2,3])
    }
}

SolutionTests.defaultTestSuite.run()
