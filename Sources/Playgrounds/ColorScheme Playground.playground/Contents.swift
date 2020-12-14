import Aesthete
import SwiftUI
import CoreGraphics
import PlaygroundSupport


struct ColorsOfSchemeView: View {

    let colors: [HSBAColor]

    var body: some View {
        VStack(alignment: .center) {
            Rectangle()
                .fill(Color(hsbaColor: colors[1]))
                .frame(width: 300, height: 50)
            Rectangle()
                .fill(Color(hsbaColor: colors[2]))
                .frame(width: 300, height: 50)
            Rectangle()
                .fill(Color(hsbaColor: colors[3]))
                .frame(width: 300, height: 50)
            Rectangle()
                .fill(Color(hsbaColor: colors[4]))
                .frame(width: 300, height: 50)
        }
    }
}

struct ColorSchemeView: View {

    enum SupportedScheme {
        case analogous
        case accentedAnalogous
        case shades
        case monochromatic
        case complementary
        case splitComplementary
        case triadic
        case compound
    }

    @State private var selectedScheme = SupportedScheme.analogous
    @State private var selectedColor = Color.blue

    var colorScheme: Aesthete.ColorScheme {
        switch selectedScheme {
        case .analogous:
            return AnalogousColorScheme(themeColor: selectedColor.hsbaColor)

        case .accentedAnalogous:
            return AccentedAnalogousColorScheme(themeColor: selectedColor.hsbaColor)

        case .shades:
            return ShadesColorScheme(themeColor: selectedColor.hsbaColor)

        case .monochromatic:
            return MonochromaticColorScheme(themeColor: selectedColor.hsbaColor)

        case .complementary:
            return ComplementaryColorScheme(themeColor: selectedColor.hsbaColor)

        case .splitComplementary:
            return SplitComplementaryColorScheme(themeColor: selectedColor.hsbaColor)

        case .triadic:
            return TriadicColorScheme(themeColor: selectedColor.hsbaColor)

        case .compound:
            return CompoundColorScheme(themeColor: selectedColor.hsbaColor)
        }
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Color Scheme Demo").font(.largeTitle)
            Picker(selection: $selectedScheme, label: Text("Scheme type")) {
                Text("Analogous").tag(SupportedScheme.analogous)
                Text("Accented Analogous").tag(SupportedScheme.accentedAnalogous)
                Text("Shades").tag(SupportedScheme.shades)
                Text("Monochromatic").tag(SupportedScheme.monochromatic)
                Text("Complementary").tag(SupportedScheme.complementary)
                Text("Split Complementary").tag(SupportedScheme.splitComplementary)
                Text("Triadic").tag(SupportedScheme.triadic)
                Text("Compound").tag(SupportedScheme.compound)
            }
            ColorPicker(
                "Select a Theme Color",
                selection: $selectedColor
            ).frame(width: 300, height: 50)
            Spacer()
            ColorsOfSchemeView(colors: colorScheme.colors)
        }.padding(.vertical, 70)
    }
}

PlaygroundPage.current.setLiveView(ColorSchemeView())

