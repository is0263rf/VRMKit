//
//  VRM1.swift
//  VRMKit
//
//  Created by Tatsuya Tanaka on 20180909.
//  Copyright © 2018年 tattn. All rights reserved.
//

import Foundation

public struct VRM1: VRMFile {
    public let gltf: BinaryGLTF
    public let specVersion: String
    public let meta: Meta
    public let humanoid: Humanoid
    public let firstPerson: FirstPerson?
    public let lookAt: LookAt?
    public let expressions: Expressions?
    public let springBone: SpringBone?
    public let extensions: CodableAny?
    public let extras: CodableAny?

    public init(data: Data) throws {
        gltf = try BinaryGLTF(data: data)

        let rawExtensions = try gltf.jsonData.extensions ??? .keyNotFound("extensions")
        let extensions = try rawExtensions.value as? [String: [String: Any]] ??? .dataInconsistent("extension type mismatch")
        let vrm = try extensions["VRMC_vrm"] ??? .keyNotFound("VRMC_vrm")
        specVersion = vrm["specVersion"] as! String

        let decoder = DictionaryDecoder()
        meta = try decoder.decode(Meta.self, from: try vrm["meta"] ??? .keyNotFound("meta"))
        humanoid = try decoder.decode(Humanoid.self, from: try vrm["humanoid"] ??? .keyNotFound("humanoid"))
        firstPerson = vrm.keys.contains("firstPerson") ? try decoder.decode(FirstPerson.self, from: vrm["firstPerson"] ?? "".data(using: .utf8)!) : nil
        lookAt = vrm.keys.contains("lookAt") ? try decoder.decode(LookAt.self, from: vrm["lookAt"] ?? "".data(using: .utf8)!) : nil
        expressions = vrm.keys.contains("expressions") ? try decoder.decode(Expressions.self, from: vrm["expressions"] ?? "".data(using: .utf8)!) : nil
        springBone = extensions.keys.contains("VRMC_springBone") ? try decoder.decode(SpringBone.self, from: extensions["VRMC_springBone"] ?? "".data(using: .utf8)!) : nil
        self.extensions = vrm.keys.contains("extensions") ? try decoder.decode(CodableAny.self, from: vrm["extensions"] ?? "".data(using: .utf8)!) : nil
        extras = vrm.keys.contains("extras") ? try decoder.decode(CodableAny.self, from: vrm["extras"] ?? "".data(using: .utf8)!) : nil
    }
}

// VRMC_vrm
public extension VRM1 {
    struct Meta: Codable {
        public let name: String
        public let version: String?
        public let authors: [String]
        public let copyrightInformation: String?
        public let contactInformation: String?
        public let references: [String]?
        public let thirdPartyLicenses: String?
        public let thumbnailImage: Int?
        public let licenseUrl: String
        public let avatarPermission: AvatarPermissionType?
        public let allowExcessivelyViolentUsage: Bool?
        public let allowExcessivelySexualUsage: Bool?
        public let commercialUsage: CommercialUsageType?
        public let allowPoliticalOrReligiousUsage: Bool?
        public let allowAntisocialOrHateUsage: Bool?
        public let creditNotation: CreditNotationType?
        public let allowRedistribution: Bool?
        public let modification: ModificationType?
        public let otherLicenseUrl: String?
        public let extensions: CodableAny?
        public let extras: CodableAny?

        public enum AvatarPermissionType: String, Codable {
            case onlyAuthor
            case onlySeparatelyLicensedPerson
            case everyone
        }

        public enum CommercialUsageType: String, Codable {
            case personalNonProfit
            case personalProfit
            case corporation
        }

        public enum CreditNotationType: String, Codable {
            case required
            case unnecessary
        }

        public enum ModificationType: String, Codable {
            case prohibited
            case allowModification
            case allowModificationRedistribution
        }
    }

    struct Humanoid: Codable {
        public let humanBones: HumanBones
        public let extensions: CodableAny?
        public let extras: CodableAny?

        public struct HumanBones: Codable{
            public let hips: HumanBone
            public let spine: HumanBone
            public let chest: HumanBone?
            public let upperChest: HumanBone?
            public let neck: HumanBone?
            public let head: HumanBone
            public let leftEye: HumanBone?
            public let rightEye: HumanBone?
            public let jaw: HumanBone?
            public let leftUpperLeg: HumanBone
            public let leftLowerLeg: HumanBone
            public let leftFoot:HumanBone
            public let leftToes: HumanBone?
            public let rightUpperLeg: HumanBone
            public let rightLowerLeg: HumanBone
            public let rightFoot: HumanBone
            public let rightToes: HumanBone?
            public let leftShoulder: HumanBone?
            public let leftUpperArm: HumanBone
            public let leftLowerArm: HumanBone
            public let leftHand: HumanBone
            public let rightShoulder: HumanBone?
            public let rightUpperArm: HumanBone
            public let rightLowerArm: HumanBone
            public let rightHand: HumanBone
            public let leftThumbMetacarpal: HumanBone?
            public let leftThumbProximal: HumanBone?
            public let leftThumbDistal: HumanBone?
            public let leftIndexProximal: HumanBone?
            public let leftIndexIntermediate: HumanBone?
            public let leftIndexDistal: HumanBone?
            public let leftMiddleProximal: HumanBone?
            public let leftMiddleIntermediate: HumanBone?
            public let leftMiddleDistal: HumanBone?
            public let leftRingProximal: HumanBone?
            public let leftRingIntermediate: HumanBone?
            public let leftRingDistal: HumanBone?
            public let leftLittleProximal: HumanBone?
            public let leftLittleIntermediate: HumanBone?
            public let leftLittleDistal: HumanBone?
            public let rightThumbMetacarpal: HumanBone?
            public let rightThumbProximal: HumanBone?
            public let rightThumbDistal: HumanBone?
            public let rightIndexProximal: HumanBone?
            public let rightIndexIntermediate: HumanBone?
            public let rightIndexDistal: HumanBone?
            public let rightMiddleProximal: HumanBone?
            public let rightMiddleIntermediate: HumanBone?
            public let rightMiddleDistal: HumanBone?
            public let rightRingProximal: HumanBone?
            public let rightRingIntermediate: HumanBone?
            public let rightRingDistal: HumanBone?
            public let rightLittleProximal: HumanBone?
            public let rightLittleIntermediate: HumanBone?
            public let rightLittleDistal: HumanBone?
            
            public struct HumanBone: Codable {
                public let node: Int
                public let extensions: CodableAny?
                public let extras: CodableAny?
            }
        }
    }

    struct FirstPerson: Codable {
        public let meshAnnotations: [MeshAnnotation]
        public let extensions: CodableAny?
        public let extras: CodableAny?
        
        public struct MeshAnnotation: Codable {
            public let type: FirstPersonType
            public let node: Int
            public let extensions: CodableAny?
            public let extras: CodableAny?
        }

        public enum FirstPersonType: String, Codable {
            case auto
            case both
            case thirdPersonOnly
            case firstPersonOnly
        }
    }

    struct LookAt: Codable {
        public let offsetFromHeadBone:[Double]
        public let type: LookAtType
        public let rangeMapHorizontalInner: LookAtRangeMap
        public let rangeMapHorizontalOuter: LookAtRangeMap
        public let rangeMapVerticalDown: LookAtRangeMap
        public let rangeMapVerticalUp: LookAtRangeMap
        public let extensions: CodableAny?
        public let extras: CodableAny?
        
        public enum LookAtType: String, Codable {
            case bone
            case expression
        }

        public struct LookAtRangeMap: Codable {
            public let inputMaxValue: Double
            public let outputScale: Double
            public let extensions: CodableAny?
            public let extras: CodableAny?

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                inputMaxValue = try decodeDouble(key: .inputMaxValue, container: container)
                outputScale = try decodeDouble(key: .outputScale, container: container)
                extensions = try container.decodeIfPresent(CodableAny.self, forKey: .extensions)
                extras = try container.decodeIfPresent(CodableAny.self, forKey: .extras)
            }
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            offsetFromHeadBone = try container.decode([Double].self, forKey: .offsetFromHeadBone)
            type = try container.decode(LookAtType.self, forKey: .type)
            rangeMapHorizontalInner = try container.decode(LookAtRangeMap.self, forKey: .rangeMapHorizontalInner)
            rangeMapHorizontalOuter = try container.decode(LookAtRangeMap.self, forKey: .rangeMapHorizontalOuter)
            rangeMapVerticalDown = try container.decode(LookAtRangeMap.self, forKey: .rangeMapVerticalDown)
            rangeMapVerticalUp = try container.decode(LookAtRangeMap.self, forKey: .rangeMapVerticalUp)
            extensions = try container.decodeIfPresent(CodableAny.self, forKey: .extensions)
            extras = try container.decodeIfPresent(CodableAny.self, forKey: .extras)
        }
    }
    
    struct Expressions: Codable {
        public let preset: Preset
        public let custom: CodableAny?
        public let extensions: CodableAny?
        public let extras: CodableAny?

        public struct Preset: Codable {
            public let happy: Expression
            public let angry: Expression
            public let sad: Expression
            public let relaxed: Expression
            public let surprised: Expression
            public let aa: Expression
            public let ih: Expression
            public let ou: Expression
            public let ee: Expression
            public let oh: Expression
            public let blink: Expression
            public let blinkLeft: Expression
            public let blinkRight: Expression
            public let lookUp: Expression
            public let lookDown: Expression
            public let lookLeft: Expression
            public let lookRight: Expression
            public let neutral: Expression
        }

        public struct Expression: Codable {
            public let morphTargetBinds: [MorphTargetBind]?
            public let materialColorBinds: [MaterialColorBind]?
            public let textureTransformBinds: [TextureTransformBind]?
            public let isBinary: Bool?
            public let overrideBlink: ExpressionOverrideType?
            public let overrideLookAt: ExpressionOverrideType?
            public let overrideMouth: ExpressionOverrideType?
            public let extensions: CodableAny?
            public let extras: CodableAny?

            public struct MorphTargetBind: Codable {
                public let node: Int
                public let index: Int
                public let weight: Double
                public let extensions: CodableAny?
                public let extras: CodableAny?

                public init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    node = try container.decode(Int.self, forKey: .node)
                    index = try container.decode(Int.self, forKey: .index)
                    weight = try decodeDouble(key: .weight, container: container)
                    extensions = try container.decodeIfPresent(CodableAny.self, forKey: .extensions)
                    extras = try container.decodeIfPresent(CodableAny.self, forKey: .extras)
                }
            }

            public struct MaterialColorBind: Codable {
                public let material: Int
                public let type: MaterialColorType
                public let targetValue: [Either<Int, Double>]
                public let extensions: CodableAny?
                public let extras: CodableAny?

                public enum MaterialColorType: String, Codable {
                    case color
                    case emissionColor
                    case shadeColor
                    case matcapColor
                    case rimColor
                    case outlineColor
                }
            }

            public struct TextureTransformBind: Codable {
                public let material: Int
                public let scale: [Either<Int, Double>]?
                public let offset: [Either<Int, Double>]?
                public let extensions: CodableAny?
                public let extras: CodableAny?
            }

            public enum ExpressionOverrideType: String, Codable {
                case none
                case block
                case blend
            }
        }
    }
}

// VRMC_springBone
extension VRM1 {
    public struct SpringBone: Codable {
        public let specVersion: String
        public let colliders: [Collider]?
        public let colliderGroups: [ColliderGroup]?
        public let springs: [Spring]?
        public let extensions: CodableAny?
        public let extras: CodableAny?

        public struct Collider: Codable {
            public let node: Int
            public let shape: Shape
            public let extensions: CodableAny?
            public let extras: CodableAny?

            public struct Shape: Codable {
                public let sphere: ColliderShapeSphere?
                public let capsule: ColliderShapeCapsule?
                public let extensions: CodableAny?
                public let extras: CodableAny?

                public struct ColliderShapeSphere: Codable {
                    public let offset: [Either<Int, Double>]
                    public let radius: Double
                }

                public struct ColliderShapeCapsule: Codable {
                    public let offset: [Either<Int, Double>]
                    public let radius: Double
                    public let tail: [Either<Int, Double>]
                }
            }
        }

        public struct ColliderGroup: Codable {
            public let colliders: [Int]
            public let extensions: CodableAny?
            public let extras: CodableAny?
        }

        public struct Spring: Codable {
            public let name: String?
            public let joints: [Joint]
            public let colliderGroups: [Int]?
            public let center: Int?
            public let extensions: CodableAny?
            public let extras: CodableAny?

            public struct Joint: Codable {
                public let node: Int
                public let hitRadius: Double
                public let stiffness: Double
                public let gravityPower: Double
                public let gravityDir: [Either<Int, Double>]
                public let dragForce: Double
                public let extensions: CodableAny?
                public let extras: CodableAny?

                public init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    node = try container.decode(Int.self, forKey: .node)
                    hitRadius = try container.decode(Double.self, forKey: .hitRadius)
                    stiffness = try decodeDouble(key: .stiffness, container: container)
                    gravityPower = try decodeDouble(key: .gravityPower, container: container)
                    gravityDir = try container.decode([Either<Int, Double>].self, forKey: .gravityDir)
                    do {
                        dragForce = try container.decode(Double.self, forKey: .dragForce)
                    } catch DecodingError.typeMismatch {
                        dragForce = Double(try container.decode(Int.self, forKey: .dragForce))
                    }
                    extensions = try container.decodeIfPresent(CodableAny.self, forKey: .extensions)
                    extras = try container.decodeIfPresent(CodableAny.self, forKey: .extras)
                }
            }
        }
    }
}
