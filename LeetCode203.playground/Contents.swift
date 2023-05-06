import XCTest

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        if head == nil {
            return nil
        }
        var head = head
        var current = head
        var prev: ListNode? = nil
        while current != nil {
            if current!.val == val {
                if prev == nil {
                    // head
                    head = current!.next
                    current = current!.next
                } else if current!.next == nil {
                    // tail
                    current = nil
                    prev!.next = current
                } else {
                    // middle
                    prev!.next = current!.next
                    current = current!.next
                }
            } else {
                prev = current
                current = current!.next
            }
        }
        return head
    }
}

class LinkedListFactor {
    func createLinkedList(_ input: [Int]) -> ListNode? {
        if input.isEmpty {
            return nil
        }
        
        if input.first == nil {
            return nil
        }
        
        var head = ListNode(input[0])
        var curr = head
        for i in 1..<input.count {
            curr.next = ListNode(input[i])
            curr = curr.next!
        }
        
        return head
    }
    
    func convertArray(_ head: ListNode?) -> [Int] {
        guard head != nil else {
            return [Int]()
        }
        
        var valList = [Int]()
        var curr = head
        while curr != nil {
            valList.append(curr!.val)
            curr = curr!.next
        }
        
        return valList
    }
}

class SolutionTests: XCTestCase {
    func testSolution_01() {
        let sol = Solution()
        let head = LinkedListFactor().createLinkedList([1,2,6,3,4,5,6])
        let elements = sol.removeElements(head, 6)
        let result = LinkedListFactor().convertArray(elements)
        XCTAssertEqual(result, [1,2,3,4,5])
    }

    func testSolution_02() {
        let sol = Solution()
        let head = LinkedListFactor().createLinkedList([])
        let elements = sol.removeElements(head, 1)
        let result = LinkedListFactor().convertArray(elements)
        XCTAssertEqual(result, [])
    }
    
    func testSolution_03() {
        let sol = Solution()
        let head = LinkedListFactor().createLinkedList([7,7,7,7])
        let elements = sol.removeElements(head, 7)
        let result = LinkedListFactor().convertArray(elements)
        XCTAssertEqual(result, [])
    }
}

SolutionTests.defaultTestSuite.run()

