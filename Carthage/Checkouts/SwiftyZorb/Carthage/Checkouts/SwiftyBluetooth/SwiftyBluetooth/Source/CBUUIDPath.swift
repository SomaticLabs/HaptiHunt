//
//  CBUUIDPath.swift
//
//  Copyright (c) 2016 Jordane Belanger
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import CoreBluetooth

struct CBUUIDPath: Hashable {
    let hash: Int
    
    init(uuids: CBUUID...) {
        var stringPath: String = String()
        
        for uuid in uuids {
            stringPath.append(uuid.uuidString)
        }
        
        self.hash = stringPath.hashValue
    }
    
    var hashValue : Int {
        return self.hash
    }
}
func ==(lhs: CBUUIDPath, rhs: CBUUIDPath) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

func servicePath(service: CBUUIDConvertible) -> CBUUIDPath {
    return CBUUIDPath(uuids: service.CBUUIDRepresentation)
}

func characteristicPath(service: CBUUIDConvertible,
                        characteristic: CBUUIDConvertible) -> CBUUIDPath {
    return CBUUIDPath(uuids: service.CBUUIDRepresentation,
                      characteristic.CBUUIDRepresentation)
}

func descriptorPath(service: CBUUIDConvertible,
                    characteristic: CBUUIDConvertible,
                    descriptor: CBUUIDConvertible) -> CBUUIDPath {
    return CBUUIDPath(uuids: service.CBUUIDRepresentation,
                      characteristic.CBUUIDRepresentation,
                      descriptor.CBUUIDRepresentation)
}

extension CBService {
    var uuidPath: CBUUIDPath {
        return servicePath(service: self)
    }
}

extension CBCharacteristic {
    var uuidPath: CBUUIDPath {
        return characteristicPath(service: self.service, characteristic: self)
    }
}

extension CBDescriptor {
    var uuidPath: CBUUIDPath {
        return descriptorPath(service: self.characteristic.service, characteristic: self.characteristic, descriptor: self)
    }
}
