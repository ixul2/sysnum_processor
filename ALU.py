from lib_carotte import *
from settings import *
from functools import *
from memory import update_registers
allow_ribbon_logic_operations(True)

def list_to_bus(l):
    return reduce(lambda s, r: Concat(s, r), l)


def bitwise_op(a, b, op):
    assert(a.bus_size == b.bus_size)
    c = [op(a[i], b[i]) for i in range(a.bus_size)]
    return list_to_bus(c)

def full_add(a, b, c):
    return (a ^ b ^ c, a & b & c)

def carry_lookahead(a, b, c, g, p, k):
    n = 1 << k
    tree = [[0] * (1 << i) for i in range(k + 1)]
    def get_gp(g, p, j, d):
        l = g.bus_size
        if l == 1:
            tree[d][j] = (g[0], p[0])
            return tree[d][j]
        (g1, p1) = get_gp(g[:l//2], p[:l//2], 2 * j, d + 1)
        (g2, p2) = get_gp(g[l//2:], p[l//2:], 2 * j + 1, d + 1)
        tree[d][j] = (g1 & p2 | g2, p1 & p2)
        return tree[d][j]
    get_gp(g, p, 0, 0)
    cc = [c] * n
    def comp_cc(j, d, acc):
        if d == k:
            cc[j] = acc
        else:
            comp_cc(j * 2, d + 1, acc)
            (gg, pp) = tree[d][j]
            comp_cc(j * 2 + 1, d + 1, gg | pp & acc)
    comp_cc(0, 0, c)
    r = [full_add(a[i], b[i], cc[i]) for i in range(n)]
    return (list_to_bus([x[0] for x in r]), r[n-1][1])

def main():
    a = Input(REG_SIZE)
    b = Input(REG_SIZE)
    ctrl = Input(3)
      
    r_or = bitwise_op(a, b, lambda x, y: x | y)
    r_and = bitwise_op(a, b, lambda x, y: x & y)
    r_xor = bitwise_op(a, b, lambda x, y: x ^ y)
    r_not = bitwise_op(a, b, lambda _, y: ~y)

    r_lshift = Constant("0" * REG_SIZE)
    r_rshift = Constant("0" * REG_SIZE)
	
    (r_sum, carry) = carry_lookahead(a, Mux(ctrl[2], b, r_not), ctrl[2], r_and, r_xor, 2)

    r_bw = Mux(ctrl[1], Mux(ctrl[2], r_or, r_and), Mux(ctrl[2], r_xor, r_not))
    r_s = Mux(ctrl[2], r_rshift, r_lshift)
    r = Mux(ctrl[0], Mux(ctrl[1], r_s, r_sum), r_bw)

    carry.set_as_output("carry")
    r.set_as_output("result")
