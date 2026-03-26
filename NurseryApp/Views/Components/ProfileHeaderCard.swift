import SwiftUI

struct ProfileHeaderCard: View {
    let child: ChildProfile

    var body: some View {
        HStack(spacing: 16) {
            if let photoName = child.photoName, !photoName.isEmpty {
                Image(photoName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 68, height: 68)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(AppTheme.primary, lineWidth: 2)
                    )
            } else {
                ZStack {
                    Circle()
                        .fill(AppTheme.softBackground)

                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 34)
                        .foregroundStyle(AppTheme.primary)
                }
                .frame(width: 68, height: 68)
                .overlay(
                    Circle()
                        .stroke(AppTheme.primary, lineWidth: 2)
                )
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(child.childName)
                    .font(.title3)
                    .fontWeight(.bold)

                Text("Known as: \(child.preferredName)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(AppTheme.border, lineWidth: 1)
        )
    }
}
