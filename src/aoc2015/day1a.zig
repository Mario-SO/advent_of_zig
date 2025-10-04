const input = @embedFile("./i1.txt");
const std = @import("std");

fn getFloor(comptime length: usize, chars: *const [length]u8) i32 {
    // start at floor 0
    var floor: i32 = 0;
    for (chars) |byte| {
        switch (byte) {
            // floor up on (
            '(' => floor += 1,
            // floor down on )
            ')' => floor -= 1,
            // ignore whitespace/newlines
            '\n', '\r', ' ', '\t' => continue,
            else => unreachable,
        }
    }
    return floor;
}

pub fn main() !void {
    std.log.debug("Floor: {d}", .{getFloor(input.len, input)});
}
