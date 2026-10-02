cask "portdeck@beta" do
  version "0.1.0-beta.18"
  sha256 "7b9d59ae747ffe91ac10b1b94186cb5130f81b93205f5377718c2280f570cdb5"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
