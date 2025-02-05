const input = @embedFile("./i1.txt");
const std = @import("std");

const Direction = enum(u32) {
    North = 3,
    South = 1,
    East = 0,
    West = 2,
};

const Position = struct {
    x: i32,
    y: i32,
};

pub fn main() !void {
    var split_iter = std.mem.split(u8, input, ", ");
    var position = Position{ .x = 0, .y = 0 };
    var visitedPositions = std.ArrayList(Position).init(std.heap.page_allocator);
    defer visitedPositions.deinit();
    var dir: Direction = Direction.North;

    while (split_iter.next()) |instr| {
        const turn = instr[0];
        const dist = try std.fmt.parseInt(i32, instr[1..], 10);

        switch (turn) {
            'R' => dir = @as(Direction, @enumFromInt((@intFromEnum(dir) + 1) % 4)),
            'L' => dir = @as(Direction, @enumFromInt((@intFromEnum(dir) + 3) % 4)),
            else => return error.InvalidTurn,
        }

        var steps: i32 = 0;
        while (steps < dist) : (steps += 1) {
            switch (dir) {
                .North => position.y += 1,
                .South => position.y -= 1,
                .East => position.x += 1,
                .West => position.x -= 1,
            }
            if (isVisitedTwice(visitedPositions, position)) {
                const result = @as(u32, @abs(position.x) + @abs(position.y));
                std.debug.print("{}", .{result});
                return;
            }
            try visitedPositions.append(position);
        }
    }
    return error.NoTwiceVisitedPosition;
}

fn isVisitedTwice(visitedPositions: std.ArrayList(Position), position: Position) bool {
    for (visitedPositions.items) |item| {
        if (item.x == position.x and item.y == position.y) {
            return true;
        }
    }
    return false;
}
