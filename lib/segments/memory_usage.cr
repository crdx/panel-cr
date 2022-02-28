class MemoryUsage < Segment
    def icons
        # https://fontawesome.com/v5.15/icons?d=gallery&m=free
        [""]
    end

    def thresholds
        [total * 0.8] # 80%
    end

    def colours : Array(Colour) | Array(Colour)
        [Colour.yellow]
    end

    def format(value : Number, index : Number) : String
        Util.format_bytes(value, 3)
    end

    def data : String
        @@data ||= File.read("/proc/meminfo")
    end

    def get(arg)
        (/#{arg}:\s*(\d+) kB/.match(data).try(&.[1]) || 0).to_i64 * 1024
    end

    def total
        get("MemTotal")
    end

    def free
        get("MemFree")
    end

    def caches
        get("Cached") + get("SReclaimable")
    end

    def buffers
        get("Buffers")
    end

    def values : Array(Float64)
        # Taken from `free`.
        # https://gitlab.com/procps-ng/procps/-/blob/b652c35f7f4d0fe644df4c756ef96cb4fd08a9f8/proc/meminfo.c#L694-704
        used = total - free - caches - buffers

        if used < 0
            used = total - free
        end

        [used.to_f]
    end
end
