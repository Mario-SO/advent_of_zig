const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

const Turn = struct {
    dir: u8,
    amount: i32,
};

fn zerosDuringRotation(current: i32, turn: Turn) i32 {
    if (turn.amount <= 0) return 0;

    const offset: i32 = switch (turn.dir) {
        'L' => if (current == 0) 100 else current,
        'R' => if (current == 0) 100 else 100 - current,
        else => return 0,
    };

    if (turn.amount < offset) return 0;
    const extra_hits: i32 = @divFloor(turn.amount - offset, 100);
    return 1 + extra_hits;
}

fn parseTurn(line: []const u8) !Turn {
    const dir = line[0];
    const amount = std.fmt.parseInt(i32, line[1..], 10) catch |err| {
        return err;
    };
    return .{ .dir = dir, .amount = amount };
}

pub fn main() !void {
    var it = std.mem.tokenizeScalar(u8, input, '\n');
    var currentPos: i32 = 50;
    var zeros: i32 = 0;

    while (it.next()) |raw_line| {
        const line = std.mem.trim(u8, raw_line, " \r\t");
        if (line.len == 0) continue;

        const turn = try parseTurn(line);
        zeros += zerosDuringRotation(currentPos, turn);

        if (turn.dir == 'L') {
            currentPos = @mod((currentPos - turn.amount), 100);
        } else {
            currentPos = @mod((currentPos + turn.amount), 100);
        }
    }
    print("Result: {d}\n", .{zeros});
}
