import SwiftUI

struct NurseryAreaPanel: View {
    let zone: NurseryZone

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: zone.icon)
                .font(.system(size: 40))
                .foregroundStyle(zone.themeColor)
            
            Text(zone.rawValue)
                .font(.title2.bold())
            
            Text(zone.summary)
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Text("Tap to explore")
                .font(.headline)
                .foregroundStyle(.purple)
                .padding(.top, 8)
        }
        .padding(32)
        .frame(width: 350, height: 280)
        .glassBackgroundEffect()
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(zone.themeColor.opacity(0.3), lineWidth: 2)
        )
    }
}
