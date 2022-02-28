class CPULoad < Segment
    def thresholds
        [System.cpu_count == 1 ? 1 : System.cpu_count / 2]
    end

    def colours : Array(Colour)
        [Colour.purple]
    end

    def format(value : Number, index : Number) : String
        Util.format_sf(value, 3)
    end

    def values : Array(Float64)
        [File.read("/proc/loadavg").split(' ')[0].to_f]
    end
end
