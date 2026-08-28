import json, sys, os

def hx(s): s=s.lstrip('#'); return [int(s[i:i+2],16) for i in (0,2,4)]
def fmt(v): return "#%02X%02X%02X" % tuple(int(round(max(0,min(255,c)))) for c in v)

def mix(a, b, perc):           # ColorUtils.mix: a*perc + b*(1-perc)
    return [a[i]*perc + b[i]*(1-perc) for i in range(3)]

def solve(base, target, op):   # ColorUtils.solveOverlayColor
    inv = 1.0 - op
    raw = [(target[i] - base[i]*inv)/op for i in range(3)]
    clamped = [max(0.0, min(255.0, v)) for v in raw]
    return raw, clamped

def audit(path, label):
    d = json.load(open(path))
    bg   = hx(d['background']); prim = hx(d['primary'])
    # colLayer0Base only mixes in primary when extraBackgroundTint is on
    # (Appearance.qml:114). With it off the base is the background verbatim.
    cfg  = json.load(open(os.path.expanduser(
        '~/.config/illogical-impulse/config.json')))['appearance']
    tint = cfg.get('extraBackgroundTint', True)
    l0b  = mix(bg, prim, 0.99) if tint else bg
    alpha = 1 - cfg['transparency']['backgroundTransparency']
    print(f"\n=== {label} ===")
    print(f"colLayer0Base = {fmt(l0b)}   (extraBackgroundTint={tint})")
    print(f"alfa paneles  = {alpha:.2f}   {'blur ok' if alpha > 0.6 else 'BLUR APAGADO (umbral 0.6)'}")
    chain = [('surface_container_low','colLayer1'), ('surface_container','colLayer2'),
             ('surface_container_high','colLayer3'), ('surface_container_highest','colLayer4')]
    base = l0b; bad = 0
    for key, name in chain:
        tgt = hx(d[key])
        raw, cl = solve(base, tgt, 0.1)
        flags = []
        for i, ch in enumerate('RGB'):
            if raw[i] < 0:   flags.append(f"{ch}={raw[i]:.0f} CLAMP->0")
            elif raw[i] > 255: flags.append(f"{ch}={raw[i]:.0f} CLAMP->255")
        status = "  <-- " + ", ".join(flags) if flags else "  ok"
        if flags: bad += 1
        print(f"{name:9} target {d[key]}  overlay {fmt(cl)} @a=0.1{status}")
        base = tgt
    print("RESULTADO:", "OK, ningun canal se clampea" if bad==0 else f"{bad} capa(s) con canal clampeado -> tinte sucio")
    return bad

audit(sys.argv[1], sys.argv[2])
