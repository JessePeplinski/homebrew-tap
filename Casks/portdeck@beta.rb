cask "portdeck@beta" do
  version "0.1.0-beta.16"
  sha256 "0cb1eb2b03469084d3319a3467d47ae35c83d6503d3ec6de0f6f099a55ce8d66"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip",
      verified: "github.com/JessePeplinski/portdeck/"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
