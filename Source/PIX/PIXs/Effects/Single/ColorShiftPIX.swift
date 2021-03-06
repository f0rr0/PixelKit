//
//  ColorShiftPIX.swift
//  PixelKit
//
//  Created by Hexagons on 2018-09-04.
//  Open Source - MIT License
//

import LiveValues
import RenderKit

@available(*, deprecated, renamed: "ColorShiftPIX")
public typealias HueSaturationPIX = ColorShiftPIX

public class ColorShiftPIX: PIXSingleEffect, PIXAuto {
    
    override open var shaderName: String { return "effectSingleColorShiftPIX" }
    
    // MARK: - Public Properties

    public var hue: LiveFloat = 0.0
    public var saturation: LiveFloat = 1.0
    public var tintColor: LiveColor = .white
    
    // MARK: - Property Helpers
    
    override public var liveValues: [LiveValue] {
        return [hue, saturation, tintColor]
    }
    
    // MARK: - Life Cycle
    
    public required init() {
        super.init(name: "Color Shift", typeName: "pix-effect-single-color-shift")
    }
    
}

public extension NODEOut {
    
    func _tint(_ tintColor: LiveColor) -> ColorShiftPIX {
        let colorShiftPix = ColorShiftPIX()
        colorShiftPix.name = "tint:colorShift"
        colorShiftPix.input = self as? PIX & NODEOut
        colorShiftPix.tintColor = tintColor
        return colorShiftPix
    }
    
    func _hue(_ hue: LiveFloat) -> ColorShiftPIX {
        let colorShiftPix = ColorShiftPIX()
        colorShiftPix.name = "hue:colorShift"
        colorShiftPix.input = self as? PIX & NODEOut
        colorShiftPix.hue = hue
        return colorShiftPix
    }
    
    func _saturation(_ saturation: LiveFloat) -> ColorShiftPIX {
        let colorShiftPix = ColorShiftPIX()
        colorShiftPix.name = "saturation:colorShift"
        colorShiftPix.input = self as? PIX & NODEOut
        colorShiftPix.saturation = saturation
        return colorShiftPix
    }
    
    func _monochrome(_ tintColor: LiveColor = .white) -> ColorShiftPIX {
        let colorShiftPix = ColorShiftPIX()
        colorShiftPix.name = "monochrome:colorShift"
        colorShiftPix.input = self as? PIX & NODEOut
        colorShiftPix.saturation = 0.0
        colorShiftPix.tintColor = tintColor
        return colorShiftPix
    }
    
}
