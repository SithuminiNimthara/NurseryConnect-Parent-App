import SwiftUI

struct VisionCard<Content: View>: View {
    let title: String
    let icon: String
    let width: CGFloat
    let height: CGFloat
    let content: Content

    init(
        title: String,
        icon: String,
        width: CGFloat = 340,
        height: CGFloat = 280,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.icon = icon
        self.width = width
        self.height = height
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(.purple)

                Text(title)
                    .font(.title3.bold())

                Spacer()
            }

            Divider()

            content

            Spacer()
        }
        .padding(24)
        .frame(width: width, height: height, alignment: .topLeading)
        .glassBackgroundEffect()
    }
}
