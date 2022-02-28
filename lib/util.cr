module Util
    def self.format_sf(value : Number, sf : Number) : String
        digits = value.to_i.to_s.size
        round_to = sf - digits

        if round_to < 1
            "%d" % value
        else
            # Apply round_to on the value itself before rounding with the formatting string as well.
            # Sometimes the rounding at the boundary was resulting in an increased digit, e.g. 10.00
            # for sf=3.
            ("%0.#{round_to}f" % value.round(round_to))[0, sf + 1]
        end
    end

    def self.format_bytes(value : Number, sf : Number) : String
        format_sf(value / 1024 ** 3, sf)
    end

    # Adjust a colour's brightness or darkness.
    # Assumes colour begins with '#' and returns a colour beginning with '#'.
    def self.adjust_colour(value : String, adjustment : Number) : String
        value = value[1..].to_i(16)

        red = (value >> 16) + adjustment
        green = ((value >> 8) & 0x00FF) + adjustment
        blue = (value & 0x0000FF) + adjustment

        red = [[255, red].min, 0].max.to_s(16).rjust(2, '0')
        green = [[255, green].min, 0].max.to_s(16).rjust(2, '0')
        blue = [[255, blue].min, 0].max.to_s(16).rjust(2, '0')

        '#' + red + green + blue
    end
end
