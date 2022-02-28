class NetworkUp < Segment
    def icons
        # https://fontawesome.com/v5.15/icons?d=gallery&m=free
        ["↑"]
    end

    def colours : Array(Colour)
        [Colour.orange]
    end

    def format(value : Number, index : Number) : String
        Util.format_bytes(value, 4)
    end

    def values : Array(Float64)
        [NetworkInfo.tx_bytes.to_f]
    end
end
