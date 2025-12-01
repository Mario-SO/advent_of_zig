const std = @import("std");
const input = @embedFile("./i1.txt");
const print = std.debug.print;

fn binarySearch(arr: []const i64, target: i64) bool {
    var left: usize = 0;
    var right: usize = arr.len;

    while (left < right) {
        const mid = left + (right - left) / 2;
        if (arr[mid] == target) return true;
        if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return false;
}

pub fn main() !void {
    const alloc = std.heap.page_allocator;

    // Parse all non-empty lines into a list of i64
    var nums: std.ArrayListUnmanaged(i64) = .{};
    defer nums.deinit(alloc);
    var tok = std.mem.tokenizeScalar(u8, input, '\n');
    while (tok.next()) |part| {
        const v = try std.fmt.parseInt(i64, part, 10);
        // Prune impossible values: can't use numbers >= 2020
        if (v < 2020) {
            try nums.append(alloc, v);
        }
    }

    // Sort for binary search and early termination
    std.mem.sort(i64, nums.items, {}, std.sort.asc(i64));

    // O(n² log n) approach: for each pair, binary search for the third
    for (nums.items, 0..) |a, i| {
        if (a >= 2020) break; // Early exit if value too large

        for (nums.items[i + 1 ..], i + 1..) |b, j| {
            const sum_ab = a + b;
            if (sum_ab >= 2020) break; // Early exit if pair sum too large

            const target = 2020 - sum_ab;

            // Binary search for target in remaining sorted elements
            const remaining = nums.items[j + 1 ..];
            if (binarySearch(remaining, target)) {
                print("Result: {d}\n", .{a * b * target});
                return;
            }
        }
    }

    print("No solution found\n", .{});
}
