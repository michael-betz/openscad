#!/usr/bin/env python3
from sys import argv
from itertools import combinations_with_replacement

r_values = [
    0,
    1,
    2,
    2.2,
    4.7,
    5.1,
    10,
    20,
    22,
    33,
    47,
    49.9,
    51,
    75,
    100,
    120,
    150,
    200,
    220,
    270,
    300,
    330,
    390,
    470,
    510,
    560,
    680,
    820,
    1000,
    1200,
    1500,
    1800,
    2000,
    2200,
    2400,
    2700,
    3000,
    3300,
    3600,
    3900,
    4700,
    4990,
    5100,
    5600,
    6200,
    6800,
    7500,
    8200,
    9100,
    10000,
    12000,
    13000,
    15000,
    18000,
    20000,
    22000,
    24000,
    27000,
    30000,
    33000,
    39000,
    47000,
    49900,
    51000,
    56000,
    68000,
    75000,
    82000,
    100000,
    120000,
    150000,
    200000,
    220000,
    300000,
    330000,
    470000,
    510000,
    1000000,
    2000000,
    10000000,
]


def r_s(rr):
    return sum(rr)


def r_p(rr):
    if min(rr) == 0.0:
        return 0.0
    return 1.0 / sum(1.0 / r for r in rr)


def r_2p_s(rr):
    return r_p(rr[:2]) + r_s(rr[2:])


def r_2s_p(rr):
    return r_s(rr[:2]) + r_p(rr[2:])


topos = [r_s, r_p, r_2p_s, r_2s_p]


def best_combo(values, target, max_n=3):
    best = []
    best_err = float("inf")

    for n in range(1, max_n + 1):
        if n >= 3:
            modes = topos
        else:
            modes = topos[0:2]

        for combo in combinations_with_replacement(values, n):
            for mode in modes:
                r = mode(combo)
                err = abs(r - target)
                if err < best_err:
                    best_err = err
                    best = (combo, mode, r)
                    if err == 0.0:
                        return best, best_err

    return best, best_err


if __name__ == "__main__":
    if len(argv) not in (2, 3):
        print(f"Usage: {argv[0]} <target_value_ohm> [<max_number_of_resistors>]")
        exit(-1)

    r_target = float(argv[1])
    max_n = 3
    if len(argv) > 2:
        max_n = int(argv[2])

    best, best_err = best_combo(r_values, r_target, max_n=max_n)

    print("best match:", best)
    print(f"error: {best_err:.3} Ohm, {(best[2] - r_target) / r_target * 100:.1f} %")
