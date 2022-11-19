//
//  binary_tree.swift
//  
//
//  Created by Fang Ling on 2022/11/7.
//

public class Node {
    public var left : Node?
    public var right : Node?
    public var p : Node?
    public var key : String?
    
    init() {
        left = nil
        right = nil
        p = nil
        key = nil
    }
    
    init(_ key : String?) {
        self.left = nil
        self.right = nil
        self.p = nil
        self.key = key
    }
    
    init(_ left : Node?, _ right : Node?, _ key : String?) {
        self.left = left
        self.right = right
        self.p = nil
        self.key = key
    }
    
    public func toString() -> String {
        var res = ""
        if left != nil {
            res += (left?.key)!
        }
        res += key!
        if right != nil {
            res += (right?.key)!
        }
        return res
    }
}
