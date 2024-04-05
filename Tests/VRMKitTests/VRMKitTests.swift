//
//  VRMTests.swift
//  VRMKitTests
//
//  Created by Tatsuya Tanaka on 20180908.
//  Copyright © 2018年 tattn. All rights reserved.
//

import XCTest
import VRMKit

class VRMTests: XCTestCase {

    let vrm = try! VRM(data: Resources.aliciaSolid.data)
    
    override func setUp() {
        super.setUp()
    }
    
    func testMeta() {
        XCTAssertEqual(vrm.meta.title, "Alicia Solid")
        XCTAssertEqual(vrm.meta.author, "DWANGO Co., Ltd.")
        XCTAssertEqual(vrm.meta.contactInformation, "http://3d.nicovideo.jp/alicia/")
        XCTAssertEqual(vrm.meta.reference, "")
        XCTAssertEqual(vrm.meta.texture, 6)
        XCTAssertEqual(vrm.meta.version, "1.0.0")
        
        XCTAssertEqual(vrm.meta.allowedUserName, "Everyone")
        XCTAssertEqual(vrm.meta.violentUssageName, "Disallow")
        XCTAssertEqual(vrm.meta.sexualUssageName, "Disallow")
        XCTAssertEqual(vrm.meta.commercialUssageName, "Allow")
        XCTAssertEqual(vrm.meta.otherPermissionUrl, "http://3d.nicovideo.jp/alicia/rule.html")
        
        XCTAssertEqual(vrm.meta.licenseName, "Other")
        XCTAssertEqual(vrm.meta.otherLicenseUrl, "http://3d.nicovideo.jp/alicia/rule.html")
    }

    func testMaterialProperties() {
        let target = vrm.materialProperties[3]
        XCTAssertEqual(target.name, "Alicia_face")
        XCTAssertEqual(target.shader, "VRM/UnlitTexture")
        XCTAssertEqual(target.renderQueue, 2000)
        XCTAssertTrue((target.floatProperties.value as! [AnyHashable : Any]).isEmpty)
        XCTAssertEqual(target.keywordMap, ["_ALPHAPREMULTIPLY_ON": true])
        XCTAssertEqual(target.tagMap, ["RenderType": "Opaque"])
        XCTAssertEqual(target.textureProperties, ["_MainTex": 3])
        XCTAssertTrue((target.vectorProperties.value as! [AnyHashable : Any]).isEmpty)
    }

    func testHumanoid() {
        XCTAssertEqual(vrm.humanoid.armStretch, 0.05)
        XCTAssertEqual(vrm.humanoid.feetSpacing, 0)
        XCTAssertEqual(vrm.humanoid.hasTranslationDoF, false)
        XCTAssertEqual(vrm.humanoid.legStretch, 0.05)
        XCTAssertEqual(vrm.humanoid.lowerArmTwist, 0.5)
        XCTAssertEqual(vrm.humanoid.lowerLegTwist, 0.5)
        XCTAssertEqual(vrm.humanoid.upperArmTwist, 0.5)
        XCTAssertEqual(vrm.humanoid.upperLegTwist, 0.5)
        XCTAssertEqual(vrm.humanoid.humanBones[0].bone, "hips")
        XCTAssertEqual(vrm.humanoid.humanBones[0].node, 3)
        XCTAssertEqual(vrm.humanoid.humanBones[0].useDefaultValues, true)
    }

    func testBlendShapeMaster() {
        let target = vrm.blendShapeMaster.blendShapeGroups[1]
        XCTAssertEqual(target.binds?[0].index, 0)
        XCTAssertEqual(target.binds?[0].mesh, 3)
        XCTAssertEqual(target.binds?[0].weight, 100)
        XCTAssertTrue(target.materialValues?.isEmpty == true)
        XCTAssertEqual(target.name, "A")
        XCTAssertEqual(target.presetName, "a")
        XCTAssertEqual(target.isBinary, false)
    }

    func testFirstPerson() {
        XCTAssertEqual(vrm.firstPerson.firstPersonBone, 36)
        XCTAssertEqual(vrm.firstPerson.firstPersonBoneOffset.x, 0)
        XCTAssertEqual(vrm.firstPerson.firstPersonBoneOffset.y, 0.06)
        XCTAssertEqual(vrm.firstPerson.firstPersonBoneOffset.z, 0)
        XCTAssertEqual(vrm.firstPerson.meshAnnotations[0].firstPersonFlag, "Auto")
        XCTAssertEqual(vrm.firstPerson.meshAnnotations[0].mesh, 0)
    }

    func testSecondaryAnimationBoneGroups() {
        let target = vrm.secondaryAnimation.boneGroups[0]
        XCTAssertEqual(target.bones, [41, 49, 57, 59, 61])
        XCTAssertEqual(target.center, -1)
        XCTAssertEqual(target.colliderGroups, [2, 1, 0, 3, 5, 4, 6])
        XCTAssertEqual(target.comment, "")
        XCTAssertEqual(target.dragForce, 0.4)
        XCTAssertEqual(target.gravityDir.x, 0.0)
        XCTAssertEqual(target.gravityDir.y, -1.0)
        XCTAssertEqual(target.gravityDir.z, 0.0)
        XCTAssertEqual(target.gravityPower, 0.0)
        XCTAssertEqual(target.hitRadius, 0.01)
        XCTAssertEqual(target.stiffiness, 0.65)
    }
    
    func testSecondaryAnimationColliderGroups() {
        let target = vrm.secondaryAnimation.colliderGroups[0]
        XCTAssertEqual(target.node, 34)
        XCTAssertEqual(target.colliders[0].offset.x, 0.0)
        XCTAssertEqual(target.colliders[0].offset.y, 0.05)
        XCTAssertEqual(target.colliders[0].offset.z, 0.0)
        XCTAssertEqual(target.colliders[0].radius, 0.09)
    }
}

class VRM1Tests: XCTestCase {
    
    let vrm = try! VRM1(data: Resources.seedSan.data)
    
    override func setUp() {
        super.setUp()
    }
    
    func testSpecVersion() {
        XCTAssertEqual(vrm.specVersion, "1.0")
    }
    
    
    func testMeta() {
        XCTAssertEqual(vrm.meta.name, "Seed-san")
        XCTAssertEqual(vrm.meta.version, "1")
        XCTAssertEqual(vrm.meta.authors, ["VirtualCast, Inc."])
        XCTAssertEqual(vrm.meta.copyrightInformation, "VirtualCast, Inc.")
        XCTAssertEqual(vrm.meta.contactInformation, nil)
        XCTAssertEqual(vrm.meta.references, nil)
        XCTAssertEqual(vrm.meta.thirdPartyLicenses, nil)
        XCTAssertEqual(vrm.meta.thumbnailImage, 14)
        XCTAssertEqual(vrm.meta.licenseUrl, "https://vrm.dev/licenses/1.0/")
        XCTAssertEqual(vrm.meta.avatarPermission, .everyone)
        XCTAssertEqual(vrm.meta.allowExcessivelyViolentUsage, true)
        XCTAssertEqual(vrm.meta.allowExcessivelySexualUsage, true)
        XCTAssertEqual(vrm.meta.commercialUsage, .corporation)
        XCTAssertEqual(vrm.meta.allowPoliticalOrReligiousUsage, true)
        XCTAssertEqual(vrm.meta.allowAntisocialOrHateUsage, true)
        XCTAssertEqual(vrm.meta.creditNotation, .required)
        XCTAssertEqual(vrm.meta.allowRedistribution, true)
        XCTAssertEqual(vrm.meta.modification, .allowModificationRedistribution)
        XCTAssertEqual(vrm.meta.otherLicenseUrl, nil)
    }
    
    func testFirstPerson() {
        XCTAssertEqual(vrm.firstPerson?.meshAnnotations.count, 5)
        XCTAssertEqual(vrm.firstPerson?.meshAnnotations[0].type, .thirdPersonOnly)
        XCTAssertEqual(vrm.firstPerson?.meshAnnotations[0].node, 0)
        XCTAssertEqual(vrm.firstPerson?.meshAnnotations[1].type, .thirdPersonOnly)
        XCTAssertEqual(vrm.firstPerson?.meshAnnotations[1].node, 1)
        XCTAssertEqual(vrm.firstPerson?.meshAnnotations[2].type, .thirdPersonOnly)
        XCTAssertEqual(vrm.firstPerson?.meshAnnotations[2].node, 2)
        XCTAssertEqual(vrm.firstPerson?.meshAnnotations[3].type, .both)
        XCTAssertEqual(vrm.firstPerson?.meshAnnotations[3].node, 144)
        XCTAssertEqual(vrm.firstPerson?.meshAnnotations[4].type, .both)
        XCTAssertEqual(vrm.firstPerson?.meshAnnotations[4].node, 145)
    }
    
    func testLookAt() {
        XCTAssertEqual(vrm.lookAt?.offsetFromHeadBone.count, 3)
        XCTAssertEqual(vrm.lookAt?.offsetFromHeadBone[0].getValue(), 0)
        XCTAssertEqual(vrm.lookAt?.offsetFromHeadBone[1].getValue(), 0.07764859)
        XCTAssertEqual(vrm.lookAt?.offsetFromHeadBone[2].getValue(), 0.100730225)
        XCTAssertEqual(vrm.lookAt?.type, .expression)
        XCTAssertEqual(vrm.lookAt?.rangeMapHorizontalInner.inputMaxValue, 90)
        XCTAssertEqual(vrm.lookAt?.rangeMapHorizontalInner.outputScale, 1)
        XCTAssertEqual(vrm.lookAt?.rangeMapHorizontalOuter.inputMaxValue, 90)
        XCTAssertEqual(vrm.lookAt?.rangeMapHorizontalOuter.outputScale, 1)
        XCTAssertEqual(vrm.lookAt?.rangeMapVerticalDown.inputMaxValue, 90)
        XCTAssertEqual(vrm.lookAt?.rangeMapVerticalDown.outputScale, 1)
        XCTAssertEqual(vrm.lookAt?.rangeMapVerticalUp.inputMaxValue, 90)
        XCTAssertEqual(vrm.lookAt?.rangeMapVerticalUp.outputScale, 1)
    }
    
    func testHumanoid() {
        XCTAssertEqual(vrm.humanoid.humanBones.hips.node, 3)
        XCTAssertEqual(vrm.humanoid.humanBones.spine.node, 4)
        XCTAssertEqual(vrm.humanoid.humanBones.chest?.node, 5)
        XCTAssertEqual(vrm.humanoid.humanBones.upperChest?.node, nil)
        XCTAssertEqual(vrm.humanoid.humanBones.neck?.node, 44)
        XCTAssertEqual(vrm.humanoid.humanBones.head.node, 45)
        XCTAssertEqual(vrm.humanoid.humanBones.leftEye?.node, nil)
        XCTAssertEqual(vrm.humanoid.humanBones.rightEye?.node, nil)
        XCTAssertEqual(vrm.humanoid.humanBones.jaw?.node, nil)
        XCTAssertEqual(vrm.humanoid.humanBones.leftUpperLeg.node, 130)
        XCTAssertEqual(vrm.humanoid.humanBones.leftLowerLeg.node, 131)
        XCTAssertEqual(vrm.humanoid.humanBones.leftFoot.node, 132)
        XCTAssertEqual(vrm.humanoid.humanBones.leftToes?.node, 134)
        XCTAssertEqual(vrm.humanoid.humanBones.rightUpperLeg.node, 137)
        XCTAssertEqual(vrm.humanoid.humanBones.rightLowerLeg.node, 138)
        XCTAssertEqual(vrm.humanoid.humanBones.rightFoot.node, 139)
        XCTAssertEqual(vrm.humanoid.humanBones.rightToes?.node, 141)
        XCTAssertEqual(vrm.humanoid.humanBones.leftShoulder?.node, 82)
        XCTAssertEqual(vrm.humanoid.humanBones.leftUpperArm.node, 83)
        XCTAssertEqual(vrm.humanoid.humanBones.leftLowerArm.node, 84)
        XCTAssertEqual(vrm.humanoid.humanBones.leftHand.node, 86)
        XCTAssertEqual(vrm.humanoid.humanBones.rightShoulder?.node, 106)
        XCTAssertEqual(vrm.humanoid.humanBones.rightUpperArm.node, 107)
        XCTAssertEqual(vrm.humanoid.humanBones.rightLowerArm.node, 108)
        XCTAssertEqual(vrm.humanoid.humanBones.rightHand.node, 110)
        XCTAssertEqual(vrm.humanoid.humanBones.leftThumbMetacarpal?.node, 91)
        XCTAssertEqual(vrm.humanoid.humanBones.leftThumbProximal?.node, 92)
        XCTAssertEqual(vrm.humanoid.humanBones.leftThumbDistal?.node, 93)
        XCTAssertEqual(vrm.humanoid.humanBones.leftIndexProximal?.node, 88)
        XCTAssertEqual(vrm.humanoid.humanBones.leftIndexIntermediate?.node, 89)
        XCTAssertEqual(vrm.humanoid.humanBones.leftIndexDistal?.node, 90)
        XCTAssertEqual(vrm.humanoid.humanBones.leftMiddleProximal?.node, 95)
        XCTAssertEqual(vrm.humanoid.humanBones.leftMiddleIntermediate?.node, 96)
        XCTAssertEqual(vrm.humanoid.humanBones.leftMiddleDistal?.node, 97)
        XCTAssertEqual(vrm.humanoid.humanBones.leftRingProximal?.node, 99)
        XCTAssertEqual(vrm.humanoid.humanBones.leftRingIntermediate?.node, 100)
        XCTAssertEqual(vrm.humanoid.humanBones.leftRingDistal?.node, 101)
        XCTAssertEqual(vrm.humanoid.humanBones.leftLittleProximal?.node, 103)
        XCTAssertEqual(vrm.humanoid.humanBones.leftLittleIntermediate?.node, 104)
        XCTAssertEqual(vrm.humanoid.humanBones.leftLittleDistal?.node, 105)
        XCTAssertEqual(vrm.humanoid.humanBones.rightThumbMetacarpal?.node, 115)
        XCTAssertEqual(vrm.humanoid.humanBones.rightThumbProximal?.node, 116)
        XCTAssertEqual(vrm.humanoid.humanBones.rightThumbDistal?.node, 117)
        XCTAssertEqual(vrm.humanoid.humanBones.rightIndexProximal?.node, 112)
        XCTAssertEqual(vrm.humanoid.humanBones.rightIndexIntermediate?.node, 113)
        XCTAssertEqual(vrm.humanoid.humanBones.rightIndexDistal?.node, 114)
        XCTAssertEqual(vrm.humanoid.humanBones.rightMiddleProximal?.node, 119)
        XCTAssertEqual(vrm.humanoid.humanBones.rightMiddleIntermediate?.node, 120)
        XCTAssertEqual(vrm.humanoid.humanBones.rightMiddleDistal?.node, 121)
        XCTAssertEqual(vrm.humanoid.humanBones.rightRingProximal?.node, 123)
        XCTAssertEqual(vrm.humanoid.humanBones.rightRingIntermediate?.node, 124)
        XCTAssertEqual(vrm.humanoid.humanBones.rightRingDistal?.node, 125)
        XCTAssertEqual(vrm.humanoid.humanBones.rightLittleProximal?.node, 127)
        XCTAssertEqual(vrm.humanoid.humanBones.rightLittleIntermediate?.node, 128)
        XCTAssertEqual(vrm.humanoid.humanBones.rightLittleDistal?.node, 129)
    }

    func testExpressions() {
        XCTAssertEqual(vrm.expressions?.preset.happy.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.happy.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.happy.morphTargetBinds?[0].index, 33)
        XCTAssertEqual(vrm.expressions?.preset.happy.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.happy.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.happy.textureTransformBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.happy.textureTransformBinds?[0].material, 11)
        XCTAssertEqual(vrm.expressions?.preset.happy.textureTransformBinds?[0].offset?.count, 2)
        XCTAssertEqual(vrm.expressions?.preset.happy.textureTransformBinds?[0].offset?[0].getValue(), 0.25)
        XCTAssertEqual(vrm.expressions?.preset.happy.textureTransformBinds?[0].offset?[1].getValue(), 0)
        XCTAssertEqual(vrm.expressions?.preset.happy.textureTransformBinds?[0].scale?.count, 2)
        XCTAssertEqual(vrm.expressions?.preset.happy.textureTransformBinds?[0].scale?[0].getValue(), 1)
        XCTAssertEqual(vrm.expressions?.preset.happy.textureTransformBinds?[0].scale?[1].getValue(), 1)
        XCTAssertEqual(vrm.expressions?.preset.happy.isBinary, true)
        XCTAssertEqual(vrm.expressions?.preset.happy.overrideBlink, .blend)
        XCTAssertEqual(vrm.expressions?.preset.happy.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.happy.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.angry.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.angry.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.angry.morphTargetBinds?[0].index, 34)
        XCTAssertEqual(vrm.expressions?.preset.angry.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.angry.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.angry.textureTransformBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.angry.textureTransformBinds?[0].material, 11)
        XCTAssertEqual(vrm.expressions?.preset.angry.textureTransformBinds?[0].offset?.count, 2)
        XCTAssertEqual(vrm.expressions?.preset.angry.textureTransformBinds?[0].offset?[0].getValue(), 0.5)
        XCTAssertEqual(vrm.expressions?.preset.angry.textureTransformBinds?[0].offset?[1].getValue(), 0)
        XCTAssertEqual(vrm.expressions?.preset.angry.textureTransformBinds?[0].scale?.count, 2)
        XCTAssertEqual(vrm.expressions?.preset.angry.textureTransformBinds?[0].scale?[0].getValue(), 1)
        XCTAssertEqual(vrm.expressions?.preset.angry.textureTransformBinds?[0].scale?[1].getValue(), 1)
        XCTAssertEqual(vrm.expressions?.preset.angry.isBinary, true)
        XCTAssertEqual(vrm.expressions?.preset.angry.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.angry.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.angry.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.sad.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.sad.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.sad.morphTargetBinds?[0].index, 35)
        XCTAssertEqual(vrm.expressions?.preset.sad.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.sad.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.sad.textureTransformBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.sad.textureTransformBinds?[0].material, 11)
        XCTAssertEqual(vrm.expressions?.preset.sad.textureTransformBinds?[0].offset?.count, 2)
        XCTAssertEqual(vrm.expressions?.preset.sad.textureTransformBinds?[0].offset?[0].getValue(), 0.75)
        XCTAssertEqual(vrm.expressions?.preset.sad.textureTransformBinds?[0].offset?[1].getValue(), 0)
        XCTAssertEqual(vrm.expressions?.preset.sad.textureTransformBinds?[0].scale?.count, 2)
        XCTAssertEqual(vrm.expressions?.preset.sad.textureTransformBinds?[0].scale?[0].getValue(), 1)
        XCTAssertEqual(vrm.expressions?.preset.sad.textureTransformBinds?[0].scale?[1].getValue(), 1)
        XCTAssertEqual(vrm.expressions?.preset.sad.isBinary, true)
        XCTAssertEqual(vrm.expressions?.preset.sad.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.sad.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.sad.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.relaxed.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.morphTargetBinds?[0].index, 36)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.textureTransformBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.textureTransformBinds?[0].material, 11)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.textureTransformBinds?[0].offset?.count, 2)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.textureTransformBinds?[0].offset?[0].getValue(), 0.5)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.textureTransformBinds?[0].offset?[1].getValue(), 0.25)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.textureTransformBinds?[0].scale?.count, 2)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.textureTransformBinds?[0].scale?[0].getValue(), 1)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.textureTransformBinds?[0].scale?[1].getValue(), 1)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.isBinary, true)
        XCTAssertEqual(vrm.expressions?.preset.relaxed.overrideBlink, .some(.block))
        XCTAssertEqual(vrm.expressions?.preset.relaxed.overrideLookAt, .some(.block))
        XCTAssertEqual(vrm.expressions?.preset.relaxed.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.surprised.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.surprised.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.surprised.morphTargetBinds?[0].index, 38)
        XCTAssertEqual(vrm.expressions?.preset.surprised.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.surprised.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.surprised.textureTransformBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.surprised.textureTransformBinds?[0].material, 11)
        XCTAssertEqual(vrm.expressions?.preset.surprised.textureTransformBinds?[0].offset?.count, 2)
        XCTAssertEqual(vrm.expressions?.preset.surprised.textureTransformBinds?[0].offset?[0].getValue(), 0)
        XCTAssertEqual(vrm.expressions?.preset.surprised.textureTransformBinds?[0].offset?[1].getValue(), 0.25)
        XCTAssertEqual(vrm.expressions?.preset.surprised.textureTransformBinds?[0].scale?.count, 2)
        XCTAssertEqual(vrm.expressions?.preset.surprised.textureTransformBinds?[0].scale?[0].getValue(), 1)
        XCTAssertEqual(vrm.expressions?.preset.surprised.textureTransformBinds?[0].scale?[1].getValue(), 1)
        XCTAssertEqual(vrm.expressions?.preset.surprised.isBinary, true)
        XCTAssertEqual(vrm.expressions?.preset.surprised.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.surprised.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.surprised.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.aa.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.aa.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.aa.morphTargetBinds?[0].index, 25)
        XCTAssertEqual(vrm.expressions?.preset.aa.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.aa.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.aa.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.aa.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.aa.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.aa.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.aa.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.ih.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.ih.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.ih.morphTargetBinds?[0].index, 26)
        XCTAssertEqual(vrm.expressions?.preset.ih.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.ih.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.ih.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.ih.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.ih.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.ih.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.ih.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.ou.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.ou.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.ou.morphTargetBinds?[0].index, 27)
        XCTAssertEqual(vrm.expressions?.preset.ou.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.ou.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.ou.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.ou.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.ou.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.ou.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.ou.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.ee.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.ee.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.ee.morphTargetBinds?[0].index, 28)
        XCTAssertEqual(vrm.expressions?.preset.ee.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.ee.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.ee.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.ee.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.ee.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.ee.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.ee.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.oh.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.oh.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.oh.morphTargetBinds?[0].index, 29)
        XCTAssertEqual(vrm.expressions?.preset.oh.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.oh.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.oh.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.oh.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.oh.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.oh.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.oh.overrideMouth, .some(.none))

        XCTAssertEqual(vrm.expressions?.preset.blink.morphTargetBinds?.count, 2)
        XCTAssertEqual(vrm.expressions?.preset.blink.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.blink.morphTargetBinds?[0].index, 1)
        XCTAssertEqual(vrm.expressions?.preset.blink.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.blink.morphTargetBinds?[1].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.blink.morphTargetBinds?[1].index, 2)
        XCTAssertEqual(vrm.expressions?.preset.blink.morphTargetBinds?[1].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.blink.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.blink.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.blink.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.blink.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.blink.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.blink.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.blinkLeft.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.blinkLeft.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.blinkLeft.morphTargetBinds?[0].index, 1)
        XCTAssertEqual(vrm.expressions?.preset.blinkLeft.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.blinkLeft.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.blinkLeft.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.blinkLeft.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.blinkLeft.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.blinkLeft.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.blinkLeft.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.blinkRight.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.blinkRight.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.blinkRight.morphTargetBinds?[0].index, 2)
        XCTAssertEqual(vrm.expressions?.preset.blinkRight.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.blinkRight.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.blinkRight.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.blinkRight.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.blinkRight.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.blinkRight.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.blinkRight.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.lookUp.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.lookUp.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.lookUp.morphTargetBinds?[0].index, 39)
        XCTAssertEqual(vrm.expressions?.preset.lookUp.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.lookUp.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.lookUp.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.lookUp.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.lookUp.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.lookUp.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.lookUp.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.lookDown.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.lookDown.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.lookDown.morphTargetBinds?[0].index, 40)
        XCTAssertEqual(vrm.expressions?.preset.lookDown.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.lookDown.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.lookDown.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.lookDown.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.lookDown.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.lookDown.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.lookDown.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.lookLeft.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.lookLeft.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.lookLeft.morphTargetBinds?[0].index, 41)
        XCTAssertEqual(vrm.expressions?.preset.lookLeft.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.lookLeft.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.lookLeft.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.lookLeft.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.lookLeft.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.lookLeft.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.lookLeft.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.lookRight.morphTargetBinds?.count, 1)
        XCTAssertEqual(vrm.expressions?.preset.lookRight.morphTargetBinds?[0].node, 2)
        XCTAssertEqual(vrm.expressions?.preset.lookRight.morphTargetBinds?[0].index, 42)
        XCTAssertEqual(vrm.expressions?.preset.lookRight.morphTargetBinds?[0].weight, 1)
        XCTAssertEqual(vrm.expressions?.preset.lookRight.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.lookRight.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.lookRight.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.lookRight.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.lookRight.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.lookRight.overrideMouth, .some(.none))


        XCTAssertEqual(vrm.expressions?.preset.neutral.morphTargetBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.neutral.materialColorBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.neutral.textureTransformBinds?.count, nil)
        XCTAssertEqual(vrm.expressions?.preset.neutral.isBinary, false)
        XCTAssertEqual(vrm.expressions?.preset.neutral.overrideBlink, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.neutral.overrideLookAt, .some(.none))
        XCTAssertEqual(vrm.expressions?.preset.neutral.overrideMouth, .some(.none))
    }
}
