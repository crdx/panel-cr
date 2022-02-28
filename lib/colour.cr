class Colour
    def initialize(@hex : String)
    end

    def to_hex
        @hex
    end

    def self.black
        new("#000000")
    end

    def self.red
        new("#cc6666")
    end

    def self.purple
        new("#e4a8f9")
    end

    def self.blue
        new("#a6cdee")
    end

    def self.green
        new("#99ea86")
    end

    def self.yellow
        new("#e1d276")
    end

    def self.brown
        new("#de935f")
    end

    def self.orange
        new("#f9b384")
    end
end
