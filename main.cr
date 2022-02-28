require "system"

require "./lib/util"
require "./lib/colour"
require "./lib/network_info"

# All segments derive from here.
require "./lib/segment"

require "./lib/segments/cpu_load"
require "./lib/segments/temperature"
require "./lib/segments/network_down"
require "./lib/segments/network_up"
require "./lib/segments/memory_usage"

segments = [
    CPULoad,
    Temperature,
    NetworkDown,
    NetworkUp,
    MemoryUsage,
]

rendered = segments.map(&.to_html).compact.join("  ")

puts "<txt> #{rendered} </txt>"
