//
//  ModifierFlags.swift
//  SpiceKey
//
//  Created by Takuto Nakamura on 2019/03/03.
//  Copyright © 2019 Takuto Nakamura. All rights reserved.
//

import AppKit.NSEvent
import Carbon.HIToolbox.Events

public struct ModifierFlags: OptionSet {
    
    public var rawValue: UInt8
    
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
    
    public static let ctrl = ModifierFlags(rawValue: 1 << 0)   // ⌃
    public static let opt  = ModifierFlags(rawValue: 1 << 1)   // ⌥
    public static let sft  = ModifierFlags(rawValue: 1 << 2)   // ⇧
    public static let cmd  = ModifierFlags(rawValue: 1 << 3)   // ⌘
    
    public static let empty         : ModifierFlags = []
    public static let ctrlOpt       : ModifierFlags = [.ctrl, .opt]             // ⌃⌥
    public static let ctrlSft       : ModifierFlags = [.ctrl, .sft]             // ⌃⇧
    public static let ctrlCmd       : ModifierFlags = [.ctrl, .cmd]             // ⌃⌘
    public static let optSft        : ModifierFlags = [.opt, .sft]              // ⌥⇧
    public static let optCmd        : ModifierFlags = [.opt, .cmd]              // ⌥⌘
    public static let sftCmd        : ModifierFlags = [.sft, .cmd]              // ⇧⌘
    public static let ctrlOptSft    : ModifierFlags = [.ctrl, .opt, .sft]       // ⌃⌥⇧
    public static let ctrlOptCmd    : ModifierFlags = [.ctrl, .opt, .cmd]       // ⌃⌥⌘
    public static let ctrlSftCmd    : ModifierFlags = [.ctrl, .sft, .cmd]       // ⌃⇧⌘
    public static let optSftCmd     : ModifierFlags = [.opt, .sft, .cmd]        // ⌥⇧⌘
    public static let ctrlOptSftCmd : ModifierFlags = [.ctrl, .opt, .sft, .cmd] // ⌃⌥⇧⌘
    
    public var string: String {
        var s = ""
        s += self.contains(.ctrl) ? "⌃" : ""
        s += self.contains(.opt) ? "⌥" : ""
        s += self.contains(.sft) ? "⇧" : ""
        s += self.contains(.cmd) ? "⌘" : ""
        return s
    }
    
    public init?(flags: NSEvent.ModifierFlags) {
        switch flags {
        case [.control]: self = .ctrl
        case [.option]:  self = .opt
        case [.shift]:   self = .sft
        case [.command]: self = .cmd
        case [.control, .option]:  self = .ctrlOpt
        case [.control, .shift]:   self = .ctrlSft
        case [.control, .command]: self = .ctrlCmd
        case [.option,  .shift]:   self = .optSft
        case [.option,  .command]: self = .optCmd
        case [.shift,   .command]: self = .sftCmd
        case [.control, .option, .shift]:   self = .ctrlOptSft
        case [.control, .option, .command]: self = .ctrlOptCmd
        case [.control, .shift,  .command]: self = .ctrlSftCmd
        case [.option,  .shift,  .command]: self = .optSftCmd
        case [.control, .option, .shift, .command]: self = .ctrlOptSftCmd
        default: return nil
        }
    }
    
    public init(control: Bool, option: Bool, shift: Bool, command: Bool) {
        self = .empty
        if control { self.formUnion(.ctrl) }
        if option  { self.formUnion(.opt) }
        if shift   { self.formUnion(.sft) }
        if command { self.formUnion(.cmd) }
    }
    
    internal var flags32: UInt32 {
        var flags: UInt32 = 0
        if self.contains(.ctrl) {
            flags |= UInt32(controlKey)
        }
        if self.contains(.opt) {
            flags |= UInt32(optionKey)
        }
        if self.contains(.sft) {
            flags |= UInt32(shiftKey)
        }
        if self.contains(.cmd) {
            flags |= UInt32(cmdKey)
        }
        return flags
    }
    
}
