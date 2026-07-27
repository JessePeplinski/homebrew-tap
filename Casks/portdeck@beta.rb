cask "portdeck@beta" do
  version "0.1.0-beta.10"
  sha256 "763ecdcded4c6698fefc53091ac85b9b770621db34d05a694fadd65f7f3f5259"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip",
      verified: "github.com/JessePeplinski/portdeck/"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
