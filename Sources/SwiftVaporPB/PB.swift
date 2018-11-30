//
//  PB.swift
//  SwiftVaporPB
//
//  Created by sk on 2018/11/30.
//

import Foundation
import SwiftProtobuf

class PBBase<Base,  T> where T: Message{
    let base: PB<T>
    init(_ base: Base) {
        self.base = base as! PB<T>
    }
}
protocol PBProtocol {
    associatedtype PBType
    associatedtype T: Message
    var pb:PBType{get}
}

extension PBProtocol{
  public  var pb:PBBase<Self, T>{
        return PBBase.init(self)
    }
}
extension PBBase{
    public static func with<T>(_ populator:( inout T)->()) throws -> PB<T> where T: Message{
        return try PB<T>.with(populator)
//        var p = T.init()
//        populator(&p)
//        let pb = try  PB<T>.init(p)
//        return pb
    }
    public  var entry:T? {
        return self.base.entry
    }
    public func textFormatString() -> String{
        return self.base.textString
    }
    public  var textString:String{
        guard let entry = self.entry else {
            return ""
        }
        return entry.textFormatString()
    }
}
extension PB : PBProtocol where T: Message{}
