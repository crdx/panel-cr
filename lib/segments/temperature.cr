class Temperature < Segment
    def icons
        # https://fontawesome.com/v5.15/icons?d=gallery&m=free
        icons = %w[   ]
        temps = [60, 50, 40, 30]
        current_icon = icons.last

        icons.each_with_index do |icon, i|
            if values.any? { |v| v >= temps[i] }
                current_icon = icon
                break
            end
        end

        [current_icon + "°"]
    end

    def optional?
        true
    end

    def thresholds
        [70, 70]
    end

    def colours : Array(Colour)
        [Colour.blue, Colour.green]
    end

    def format(value : Number, index : Number) : String
        value.to_i.to_s
    end

    def cpu_value
        sensor_data = `sensors coretemp-isa-0000`

        if sensor_data =~ /Tdie:\s*\+(.*?)°C/
            $1.to_f
        elsif sensor_data =~ /Package id 0:\s*\+(.*?)°C/
            $1.to_f
        else
            0.0
        end
    end

    def gpu_value
        if File.exists?("/bin/nvidia-smi")
            return `nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits`.to_f
        else
            0.0
        end
    rescue
        0.0
    end

    def values : Array(Float64)
        values = [cpu_value]

        # Only include GPU temperature if it's >0 as it may not be relevant to this system.
        gpu_temperature = gpu_value
        if gpu_temperature > 0
            values << gpu_temperature
        end

        values
    end
end
