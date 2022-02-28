abstract class Segment
    abstract def values : Array(Float64)
    abstract def colours : Array(Colour)
    abstract def format(value : Number, index : Number) : String

    def joiner
        "<span fgcolor='#aaaaaa'>/</span>"
    end

    def icons
        [] of String
    end

    def thresholds
        [] of Int32
    end

    # Mark whether or not this segment is optional. If the segment returns a value of 0 it will be
    # omitted entirely.
    def optional?
        false
    end

    def self.format_segment(threshold, value, formatted, icon, colour)
        if threshold && value >= threshold
            component = "<span fgcolor='red'>#{formatted}</span>"
            icon_colour = "red"
        else
            component = "<span fgcolor='#{colour}'>#{formatted}</span>"
            icon_colour = Util.adjust_colour(colour, -10)
        end

        if icon
            component = "<span fgcolor='#{icon_colour}'>#{icon}</span> " + component
        end

        component
    end

    def self.to_html
        instance = new

        formatted_segments = instance.values.map_with_index do |value, index|
            if value == 0 && instance.optional?
                next
            end

            formatted = instance.format(value, index)
            colour = instance.colours[index].to_hex

            threshold = instance.thresholds[index] rescue nil
            icon = instance.icons[index] rescue nil

            format_segment(threshold, value, formatted, icon, colour)
        end.compact

        if formatted_segments.size > 0
            formatted_segments.join(instance.joiner)
        end
    end
end
