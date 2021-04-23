class Sv4git < Formula
    desc "Semantic Version tool for git"
    homepage "https://github.com/bvieira/sv4git"
    url "https://github.com/bvieira/sv4git/archive/refs/tags/2.2.1.tar.gz"
    version "2.2.1"
    sha256 "af7d8b3cd50aa393ad6acd33f9d68890ea1bccf8bb9200db0c3bceac8cdce82c"

    bottle :unneeded

    depends_on "go" => :build

    def install
        ENV["GOPATH"] = buildpath
        (buildpath/"src/github.com/bvieira/sv4git").install buildpath.children
        cd "src/github.com/bvieira/sv4git" do
            ENV["BUILDOS"] = "darwin"
            ENV["BUILDARCH"] = "amd64"
            ENV["VERSION"] = "2.2.1"
            system "make", "build"
            bin.install "bin/local/darwin_amd64/git-sv"
            prefix.install_metafiles
        end
    end

    test do
        assert_match version.to_s, shell_output("#{bin}/git-sv -v")
  end

end
