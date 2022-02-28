class NetworkInfo
    def self.rx_bytes
        new.transferred_bytes[:rx]
    end

    def self.tx_bytes
        new.transferred_bytes[:tx]
    end

    def data
        @@data ||= File.read("/proc/net/dev")
    end

    def transferred_bytes
        rx = 0
        tx = 0

        data.each_line do |line|
            match = /
                (?:enp|eno|wlp)\w+:
                \s*(\d+)
                \s*\d+
                \s*\d+
                \s*\d+
                \s*\d+
                \s*\d+
                \s*\d+
                \s*\d+
                \s*(\d+)
            /x.match(line)

            if match
                rx += (match.try(&.[1]) || 0).to_f
                tx += (match.try(&.[2]) || 0).to_f
            end
        end

        return {
            :rx => rx,
            :tx => tx,
        }
    end
end
