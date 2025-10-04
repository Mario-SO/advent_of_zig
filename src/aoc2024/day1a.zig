const std = @import("std");
const print = std.debug.print;
const input = @embedFile("./i1.txt");

pub fn main() !void {
    const alloc = std.heap.page_allocator;

    var left_list: std.ArrayListUnmanaged(u32) = .{};
    defer left_list.deinit(alloc);

    var right_list: std.ArrayListUnmanaged(u32) = .{};
    defer right_list.deinit(alloc);

    var it = std.mem.tokenizeAny(u8, input, " \t\r\n");
    while (true) {
        const a_str = it.next() orelse break;
        const b_str = it.next() orelse return error.UnpairedValue;

        try left_list.append(alloc, try std.fmt.parseInt(u32, a_str, 10));
        try right_list.append(alloc, try std.fmt.parseInt(u32, b_str, 10));
    }

    std.mem.sort(u32, left_list.items, {}, std.sort.asc(u32));
    std.mem.sort(u32, right_list.items, {}, std.sort.asc(u32));

    var result: u64 = 0;

    for (left_list.items, right_list.items) |l, r| {
        const diff: u64 = if (l >= r)
            @intCast(l - r)
        else
            @intCast(r - l);
        result += diff;
    }

    print("Result: {d}\n", .{result});
}
