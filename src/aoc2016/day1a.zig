const input = @embedFile("./i1.txt");
const std = @import("std");

// Moving clockwise => R
// ----------------------------
//          3
//       ┌─────┐
//       │North│
//       └─────┘
//  ┌────┐ .─. ┌────┐
// 2│West│(   )│East│0
//  └────┘ `─' └────┘
//       ┌─────┐
//       │South│
//       └─────┘
//          1
// ----------------------------
// Moving counter clockwise => L

const Direction = enum(u32) {
    North = 3, // Up
    South = 1, // Down
    East = 0, // Right
    West = 2, // Left
};

const Position = struct {
    x: i32,
    y: i32,
};

pub fn main() !void {
    var split_iter = std.mem.split(u8, input, ", ");
    var position: Position = .{ .x = 0, .y = 0 };
    var dir: Direction = Direction.North;

    while (split_iter.next()) |instr| {
        const turn = instr[0];
        const dist = try std.fmt.parseInt(i32, instr[1..], 10);

        switch (turn) {
            'R' => dir = @as(Direction, @enumFromInt((@intFromEnum(dir) + 1) % 4)),
            'L' => dir = @as(Direction, @enumFromInt((@intFromEnum(dir) + 3) % 4)),
            else => return error.InvalidTurn,
        }

        switch (dir) {
            .North => position.y += dist,
            .South => position.y -= dist,
            .East => position.x += dist,
            .West => position.x -= dist,
        }
    }

    const result = @as(u32, std.math.absCast(position.x) + std.math.absCast(position.y));
    std.debug.print("{}", .{result});
}
