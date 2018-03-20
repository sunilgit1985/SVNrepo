// Copyright 2012 Google Inc. All rights reserved.
(function ()
{

    var data = {
        "resource": {
            "version": "1",
            "macros": [],
            "tags": [],
            "predicates": [],
            "rules": []
        },
        "runtime": [
            [], []
        ]
    };

    var aa = function (a, b)
    {
        function c()
        {
        }

        c.prototype = b.prototype;
        a.he = b.prototype;
        a.prototype = new c;
        a.prototype.constructor = a;
        a.Ud = function (a, c, f)
        {
            for (var d = Array(arguments.length - 2), e = 2; e < arguments.length; e++)d[e - 2] = arguments[e];
            return b.prototype[c].apply(a, d)
        }
    };
    var g = function (a, b)
    {
        this.o = a;
        this.Gc = b
    };
    g.prototype.Tc = function ()
    {
        return this.o
    };
    g.prototype.getType = g.prototype.Tc;
    g.prototype.getData = function ()
    {
        return this.Gc
    };
    g.prototype.getData = g.prototype.getData;
    var ba = function (a)
    {
        return "number" === typeof a && 0 <= a && isFinite(a) && 0 === a % 1 || "string" === typeof a && "-" !== a[0] && a === "" + parseInt(a, 10)
    }, ca = function ()
    {
        this.W = {};
        this.Ga = !1
    };
    ca.prototype.get = function (a)
    {
        return this.W["dust." + a]
    };
    ca.prototype.set = function (a, b)
    {
        !this.Ga && (this.W["dust." + a] = b)
    };
    ca.prototype.has = function (a)
    {
        return this.W.hasOwnProperty("dust." + a)
    };
    var da = function (a)
    {
        var b = [], c;
        for (c in a.W)a.W.hasOwnProperty(c) && b.push(c.substr(5));
        return b
    };
    ca.prototype.remove = function (a)
    {
        !this.Ga && delete this.W["dust." + a]
    };
    var t = function (a)
    {
        this.Z = new ca;
        this.h = [];
        a = a || [];
        for (var b in a)a.hasOwnProperty(b) && (ba(b) ? this.h[Number(b)] = a[Number(b)] : this.Z.set(b, a[b]))
    };
    t.prototype.toString = function ()
    {
        for (var a = [], b = 0; b < this.h.length; b++)
        {
            var c = this.h[b];
            null === c || void 0 === c ? a.push("") : a.push(c.toString())
        }
        return a.join(",")
    };
    t.prototype.set = function (a, b)
    {
        if ("length" == a)
        {
            if (!ba(b))throw"RangeError: Length property must be a valid integer.";
            this.h.length = Number(b)
        }
        else ba(a) ? this.h[Number(a)] = b : this.Z.set(a, b)
    };
    t.prototype.set = t.prototype.set;
    t.prototype.get = function (a)
    {
        return "length" == a ? this.length() : ba(a) ? this.h[Number(a)] : this.Z.get(a)
    };
    t.prototype.get = t.prototype.get;
    t.prototype.length = function ()
    {
        return this.h.length
    };
    t.prototype.I = function ()
    {
        for (var a = da(this.Z), b = 0; b < this.h.length; b++)a.push(b + "");
        return new t(a)
    };
    t.prototype.getKeys = t.prototype.I;
    t.prototype.remove = function (a)
    {
        ba(a) ? delete this.h[Number(a)] : this.Z.remove(a)
    };
    t.prototype.remove = t.prototype.remove;
    t.prototype.pop = function ()
    {
        return this.h.pop()
    };
    t.prototype.pop = t.prototype.pop;
    t.prototype.push = function (a)
    {
        return this.h.push.apply(this.h, Array.prototype.slice.call(arguments))
    };
    t.prototype.push = t.prototype.push;
    t.prototype.shift = function ()
    {
        return this.h.shift()
    };
    t.prototype.shift = t.prototype.shift;
    t.prototype.splice = function (a, b, c)
    {
        return new t(this.h.splice.apply(this.h, arguments))
    };
    t.prototype.splice = t.prototype.splice;
    t.prototype.unshift = function (a)
    {
        return this.h.unshift.apply(this.h, Array.prototype.slice.call(arguments))
    };
    t.prototype.unshift = t.prototype.unshift;
    t.prototype.has = function (a)
    {
        return ba(a) && this.h.hasOwnProperty(a) || this.Z.has(a)
    };
    var ea = function ()
    {
        function a(a, b)
        {
            c[a] = b
        }

        function b()
        {
            c = {}
        }

        var c = {}, d = {
            add: a, reset: b, create: function (d)
            {
                var e = {
                    add: a, request: function (a, b)
                    {
                        return c[a] ? c[a].apply(d, Array.prototype.slice.call(arguments, 1)) : !1
                    }, reset: b
                };
                e.add = e.add;
                e.request = e.request;
                e.reset = e.reset;
                return e
            }
        };
        d.add = d.add;
        d.reset = d.reset;
        return d
    };
    var fa = function ()
    {
        function a(a, c)
        {
            if (b[a])
            {
                if (b[a].Aa + c > b[a].max)throw Error("Quota exceeded");
                b[a].Aa += c
            }
        }

        var b = {}, c = void 0, d = void 0, e = {
            od: function (a)
            {
                c = a
            }, ub: function ()
            {
                c && a(c, 1)
            }, pd: function (a)
            {
                d = a
            }, M: function (b)
            {
                d && a(d, b)
            }, Gd: function (a, c)
            {
                b[a] = b[a] || {Aa: 0};
                b[a].max = c
            }, Sc: function (a)
            {
                return b[a] && b[a].Aa || 0
            }, reset: function ()
            {
                b = {}
            }, Bc: a
        };
        e.onFnConsume = e.od;
        e.consumeFn = e.ub;
        e.onStorageConsume = e.pd;
        e.consumeStorage = e.M;
        e.setMax = e.Gd;
        e.getConsumed = e.Sc;
        e.reset = e.reset;
        e.consume = e.Bc;
        return e
    };
    var ha = function (a, b, c)
    {
        this.D = a;
        this.O = b;
        this.N = c;
        this.h = new ca
    };
    ha.prototype.add = function (a, b)
    {
        this.D.M(("string" === typeof a ? a.length : 1) + ("string" === typeof b ? b.length : 1));
        this.h.set(a, b)
    };
    ha.prototype.add = ha.prototype.add;
    ha.prototype.set = function (a, b)
    {
        this.N && this.N.has(a) ? this.N.set(a, b) : (this.D.M(("string" === typeof a ? a.length : 1) + ("string" === typeof b ? b.length : 1)), this.h.set(a, b))
    };
    ha.prototype.set = ha.prototype.set;
    ha.prototype.get = function (a)
    {
        return this.h.has(a) ? this.h.get(a) : this.N ? this.N.get(a) : void 0
    };
    ha.prototype.get = ha.prototype.get;
    ha.prototype.has = function (a)
    {
        return !!this.h.has(a) || !(!this.N || !this.N.has(a))
    };
    ha.prototype.has = ha.prototype.has;
    ha.prototype.J = function ()
    {
        return this.D
    };
    var ia = function (a)
    {
        return "[object Array]" == Object.prototype.toString.call(Object(a))
    }, ja = function (a, b)
    {
        if (Array.prototype.indexOf)
        {
            var c = a.indexOf(b);
            return "number" == typeof c ? c : -1
        }
        for (var d = 0; d < a.length; d++)if (a[d] === b)return d;
        return -1
    };
    var u = function (a, b)
    {
        ca.call(this);
        this.Gb = a;
        this.Qc = b
    };
    aa(u, ca);
    var ma = function (a, b)
    {
        for (var c, d = 0; d < b.length && !(c = ka(a, b[d]), c instanceof g); d++);
        return c
    }, ka = function (a, b)
    {
        var c = a.get(String(b[0]));
        if (!(c && c instanceof u))throw"Attempting to execute non-function " + b[0] + ".";
        return c.i.apply(c, [a].concat(b.slice(1)))
    };
    u.prototype.toString = function ()
    {
        return this.Gb
    };
    u.prototype.getName = function ()
    {
        return this.Gb
    };
    u.prototype.getName = u.prototype.getName;
    u.prototype.I = function ()
    {
        return new t(da(this))
    };
    u.prototype.getKeys = u.prototype.I;
    u.prototype.i = function (a, b)
    {
        var c, d = {
            w: function ()
            {
                return a
            }, evaluate: function (b)
            {
                var c = a;
                return ia(b) ? ka(c, b) : b
            }, ha: function (b)
            {
                return ma(a, b)
            }, J: function ()
            {
                return a.J()
            }, Yd: function ()
            {
                c || (c = a.O.create(d));
                return c
            }
        };
        a.J().ub();
        return this.Qc.apply(d, Array.prototype.slice.call(arguments, 1))
    };
    u.prototype.invoke = u.prototype.i;
    var w = function ()
    {
        ca.call(this)
    };
    aa(w, ca);
    w.prototype.I = function ()
    {
        return new t(da(this))
    };
    w.prototype.getKeys = w.prototype.I;
    /*
     jQuery v1.9.1 (c) 2005, 2012 jQuery Foundation, Inc. jquery.org/license. */
    var na = /\[object (Boolean|Number|String|Function|Array|Date|RegExp)\]/, oa = function (a)
    {
        if (null == a)return String(a);
        var b = na.exec(Object.prototype.toString.call(Object(a)));
        return b ? b[1].toLowerCase() : "object"
    }, pa = function (a, b)
    {
        return Object.prototype.hasOwnProperty.call(Object(a), b)
    }, qa = function (a)
    {
        if (!a || "object" != oa(a) || a.nodeType || a == a.window)return !1;
        try
        {
            if (a.constructor && !pa(a, "constructor") && !pa(a.constructor.prototype, "isPrototypeOf"))return !1
        }
        catch (c)
        {
            return !1
        }
        for (var b in a);
        return void 0 ===
                b || pa(a, b)
    }, ra = function (a, b)
    {
        var c = b || ("array" == oa(a) ? [] : {}), d;
        for (d in a)if (pa(a, d))
        {
            var e = a[d];
            "array" == oa(e) ? ("array" != oa(c[d]) && (c[d] = []), c[d] = ra(e, c[d])) : qa(e) ? (qa(c[d]) || (c[d] = {}), c[d] = ra(e, c[d])) : c[d] = e
        }
        return c
    };
    var sa = function (a)
    {
        if (a instanceof t)
        {
            for (var b = [], c = Number(a.get("length")), d = 0; d < c; d++)a.has(d) && (b[d] = sa(a.get(d)));
            return b
        }
        if (a instanceof w)
        {
            for (var e = {}, f = a.I(), h = f.length(), k = 0; k < h; k++)e[f.get(k)] = sa(a.get(f.get(k)));
            return e
        }
        return a instanceof u ? function ()
        {
            for (var b = Array.prototype.slice.call(arguments, 0), c = 0; c < b.length; c++)b[c] = ta(b[c]);
            var d = new ha(fa(), ea());
            return sa(a.i.apply(a, [d].concat(b)))
        } : a
    }, ta = function (a)
    {
        if (ia(a))
        {
            for (var b = [], c = 0; c < a.length; c++)a.hasOwnProperty(c) && (b[c] = ta(a[c]));
            return new t(b)
        }
        if (qa(a))
        {
            var d = new w, e;
            for (e in a)a.hasOwnProperty(e) && d.set(e, ta(a[e]));
            return d
        }
        if ("function" === typeof a)return new u("", function (b)
        {
            for (var c = Array.prototype.slice.call(arguments, 0), d = 0; d < c.length; d++)c[d] = sa(this.evaluate(c[d]));
            return ta(a.apply(a, c))
        });
        var f = typeof a;
        if (null === a || "string" === f || "number" === f || "boolean" === f)return a
    };
    var ua = {
        control: function (a, b)
        {
            return new g(a, this.evaluate(b))
        }, fn: function (a, b, c)
        {
            var d = this.w(), e = this.evaluate(b);
            if (!(e instanceof t))throw"Error: non-List value given for Fn argument names.";
            var f = Array.prototype.slice.call(arguments, 2);
            this.J().M(a.length + f.length);
            return new u(a, function ()
            {
                return function (a)
                {
                    for (var b = new ha(d.D, d.O, d), c = Array.prototype.slice.call(arguments, 0), h = 0; h < c.length; h++)if (c[h] = this.evaluate(c[h]), c[h] instanceof g)return c[h];
                    for (var n = e.get("length"), p = 0; p < n; p++)p <
                    c.length ? b.set(e.get(p), c[p]) : b.set(e.get(p), void 0);
                    b.set("arguments", new t(c));
                    var q = ma(b, f);
                    if (q instanceof g)return "return" === q.o ? q.getData() : q
                }
            }())
        }, list: function (a)
        {
            var b = this.J();
            b.M(arguments.length);
            for (var c = new t, d = 0; d < arguments.length; d++)
            {
                var e = this.evaluate(arguments[d]);
                "string" === typeof e && b.M(e.length ? e.length - 1 : 0);
                c.push(e)
            }
            return c
        }, map: function (a)
        {
            for (var b = this.J(), c = new w, d = 0; d < arguments.length - 1; d += 2)
            {
                var e = this.evaluate(arguments[d]) + "", f = this.evaluate(arguments[d + 1]), h = e.length;
                h += "string" === typeof f ? f.length : 1;
                b.M(h);
                c.set(e, f)
            }
            return c
        }, undefined: function ()
        {
        }
    };
    var y = function ()
    {
        this.D = fa();
        this.O = ea();
        this.Fa = new ha(this.D, this.O)
    };
    y.prototype.L = function (a, b)
    {
        var c = new u(a, b);
        c.Ga = !0;
        this.Fa.set(a, c)
    };
    y.prototype.addInstruction = y.prototype.L;
    y.prototype.tb = function (a, b)
    {
        ua.hasOwnProperty(a) && this.L(b || a, ua[a])
    };
    y.prototype.addNativeInstruction = y.prototype.tb;
    y.prototype.J = function ()
    {
        return this.D
    };
    y.prototype.getQuota = y.prototype.J;
    y.prototype.Bd = function ()
    {
        this.D = fa();
        this.Fa.D = this.D
    };
    y.prototype.resetQuota = y.prototype.Bd;
    y.prototype.Ad = function ()
    {
        this.O = ea();
        this.Fa.O = this.O
    };
    y.prototype.resetPermissions = y.prototype.Ad;
    y.prototype.C = function (a, b)
    {
        var c = Array.prototype.slice.call(arguments, 0), d = ka(this.Fa, c);
        if (d instanceof g || d instanceof u || d instanceof t || d instanceof w || null === d || void 0 === d || "string" === typeof d || "number" === typeof d || "boolean" === typeof d)return d
    };
    y.prototype.execute = y.prototype.C;
    y.prototype.Dd = function (a)
    {
        for (var b = 0; b < arguments.length; b++)this.C.apply(this, arguments[b])
    };
    y.prototype.run = y.prototype.Dd;
    var va = function (a)
    {
        for (var b = [], c = Number(a.get("length")), d = 0; d < c; d++)a.has(d) && (b[d] = a.get(d));
        return b
    };
    var z = {Jd: "concat every filter forEach hasOwnProperty indexOf join lastIndexOf map pop push reduce reduceRight reverse shift slice some sort splice unshift toString".split(" ")}, xa = function (a)
    {
        return Number(a.get("length"))
    };
    z.concat = function (a, b)
    {
        for (var c = [], d = xa(this), e = 0; e < d; e++)c.push(this.get(e));
        for (e = 1; e < arguments.length; e++)if (arguments[e] instanceof t)for (var f = arguments[e], h = xa(f), k = 0; k < h; k++)c.push(f.get(k));
        else c.push(arguments[e]);
        return new t(c)
    };
    z.every = function (a, b)
    {
        for (var c = xa(this), d = 0; d < xa(this) && d < c; d++)if (this.has(d) && !b.i(a, this.get(d), d, this))return !1;
        return !0
    };
    z.filter = function (a, b)
    {
        for (var c = xa(this), d = [], e = 0; e < xa(this) && e < c; e++)this.has(e) && b.i(a, this.get(e), e, this) && d.push(this.get(e));
        return new t(d)
    };
    z.forEach = function (a, b)
    {
        for (var c = xa(this), d = 0; d < xa(this) && d < c; d++)this.has(d) && b.i(a, this.get(d), d, this)
    };
    z.hasOwnProperty = function (a, b)
    {
        return this.has(b)
    };
    z.indexOf = function (a, b, c)
    {
        var d = xa(this), e = void 0 === c ? 0 : Number(c);
        0 > e && (e = Math.max(d + e, 0));
        for (var f = e; f < d; f++)if (this.has(f) && this.get(f) === b)return f;
        return -1
    };
    z.join = function (a, b)
    {
        for (var c = [], d = xa(this), e = 0; e < d; e++)c.push(this.get(e));
        return c.join(b)
    };
    z.lastIndexOf = function (a, b, c)
    {
        var d = xa(this), e = d - 1;
        void 0 !== c && (e = 0 > c ? d + c : Math.min(c, e));
        for (var f = e; 0 <= f; f--)if (this.has(f) && this.get(f) === b)return f;
        return -1
    };
    z.map = function (a, b)
    {
        for (var c = xa(this), d = [], e = 0; e < xa(this) && e < c; e++)this.has(e) && (d[e] = b.i(a, this.get(e), e, this));
        return new t(d)
    };
    z.pop = function ()
    {
        return this.pop()
    };
    z.push = function (a, b)
    {
        return this.push.apply(this, Array.prototype.slice.call(arguments, 1))
    };
    z.reduce = function (a, b, c)
    {
        var d = xa(this), e, f;
        if (void 0 !== c)e = c, f = 0;
        else
        {
            if (0 == d)throw"TypeError: Reduce on List with no elements.";
            for (var h = 0; h < d; h++)if (this.has(h))
            {
                e = this.get(h);
                f = h + 1;
                break
            }
            if (h == d)throw"TypeError: Reduce on List with no elements.";
        }
        for (h = f; h < d; h++)this.has(h) && (e = b.i(a, e, this.get(h), h, this));
        return e
    };
    z.reduceRight = function (a, b, c)
    {
        var d = xa(this), e, f;
        if (void 0 !== c)e = c, f = d - 1;
        else
        {
            if (0 == d)throw"TypeError: ReduceRight on List with no elements.";
            for (var h = 1; h <= d; h++)if (this.has(d - h))
            {
                e = this.get(d - h);
                f = d - (h + 1);
                break
            }
            if (h > d)throw"TypeError: ReduceRight on List with no elements.";
        }
        for (h = f; 0 <= h; h--)this.has(h) && (e = b.i(a, e, this.get(h), h, this));
        return e
    };
    z.reverse = function ()
    {
        for (var a = va(this), b = a.length - 1, c = 0; 0 <= b; b--, c++)a.hasOwnProperty(b) ? this.set(c, a[b]) : this.remove(c);
        return this
    };
    z.shift = function ()
    {
        return this.shift()
    };
    z.slice = function (a, b, c)
    {
        var d = xa(this);
        void 0 === b && (b = 0);
        b = 0 > b ? Math.max(d + b, 0) : Math.min(b, d);
        c = void 0 === c ? d : 0 > c ? Math.max(d + c, 0) : Math.min(c, d);
        c = Math.max(b, c);
        for (var e = [], f = b; f < c; f++)e.push(this.get(f));
        return new t(e)
    };
    z.some = function (a, b)
    {
        for (var c = xa(this), d = 0; d < xa(this) && d < c; d++)if (this.has(d) && b.i(a, this.get(d), d, this))return !0;
        return !1
    };
    z.sort = function (a, b)
    {
        var c = va(this);
        void 0 === b ? c.sort() : c.sort(function (c, d)
                                         {
                                             return Number(b.i(a, c, d))
                                         });
        for (var d = 0; d < c.length; d++)c.hasOwnProperty(d) ? this.set(d, c[d]) : this.remove(d)
    };
    z.splice = function (a, b, c, d)
    {
        return this.splice.apply(this, Array.prototype.splice.call(arguments, 1, arguments.length - 1))
    };
    z.toString = function ()
    {
        return this.toString()
    };
    z.unshift = function (a, b)
    {
        return this.unshift.apply(this, Array.prototype.slice.call(arguments, 1))
    };
    var B = {
        Eb: {
            ADD: 0,
            AND: 1,
            APPLY: 2,
            ASSIGN: 3,
            BREAK: 4,
            CASE: 5,
            CONTINUE: 6,
            CONTROL: 49,
            CREATE_ARRAY: 7,
            CREATE_OBJECT: 8,
            DEFAULT: 9,
            DEFN: 50,
            DIVIDE: 10,
            DO: 11,
            EQUALS: 12,
            EXPRESSION_LIST: 13,
            FN: 51,
            FOR: 14,
            FOR_IN: 47,
            GET: 15,
            GET_CONTAINER_VARIABLE: 48,
            GET_INDEX: 16,
            GET_PROPERTY: 17,
            GREATER_THAN: 18,
            GREATER_THAN_EQUALS: 19,
            IDENTITY_EQUALS: 20,
            IDENTITY_NOT_EQUALS: 21,
            IF: 22,
            LESS_THAN: 23,
            LESS_THAN_EQUALS: 24,
            MODULUS: 25,
            MULTIPLY: 26,
            NEGATE: 27,
            NOT: 28,
            NOT_EQUALS: 29,
            NULL: 45,
            OR: 30,
            PLUS_EQUALS: 31,
            POST_DECREMENT: 32,
            POST_INCREMENT: 33,
            PRE_DECREMENT: 34,
            PRE_INCREMENT: 35,
            QUOTE: 46,
            RETURN: 36,
            SET_PROPERTY: 43,
            SUBTRACT: 37,
            SWITCH: 38,
            TERNARY: 39,
            TYPEOF: 40,
            UNDEFINED: 44,
            VAR: 41,
            WHILE: 42
        }
    }, ya = "charAt concat indexOf lastIndexOf match replace search slice split substring toLowerCase toLocaleLowerCase toString toUpperCase toLocaleUpperCase trim".split(" "), za = new g("break"), Aa = new g("continue");
    B.add = function (a, b)
    {
        return this.evaluate(a) + this.evaluate(b)
    };
    B.and = function (a, b)
    {
        return this.evaluate(a) && this.evaluate(b)
    };
    B.apply = function (a, b, c)
    {
        a = this.evaluate(a);
        b = this.evaluate(b);
        c = this.evaluate(c);
        if (!(c instanceof t))throw"Error: Non-List argument given to Apply instruction.";
        if (null === a || void 0 === a)throw"TypeError: Can't read property " + b + " of " + a + ".";
        if ("boolean" == typeof a || "number" == typeof a)
        {
            if ("toString" == b)return a.toString();
            throw"TypeError: " + a + "." + b + " is not a function.";
        }
        if ("string" == typeof a)
        {
            if (0 <= ja(ya, b))return ta(a[b].apply(a, va(c)));
            throw"TypeError: " + b + " is not a function";
        }
        if (a instanceof t)
        {
            if (a.has(b))
            {
                var d =
                        a.get(b);
                if (d instanceof u)
                {
                    var e = va(c);
                    e.unshift(this.w());
                    return d.i.apply(d, e)
                }
                throw"TypeError: " + b + " is not a function";
            }
            if (0 <= ja(z.Jd, b))return e = va(c), e.unshift(this.w()), z[b].apply(a, e)
        }
        if (a instanceof u || a instanceof w)
        {
            if (a.has(b))
            {
                d = a.get(b);
                if (d instanceof u)return e = va(c), e.unshift(this.w()), d.i.apply(d, e);
                throw"TypeError: " + b + " is not a function";
            }
            if ("toString" == b)return a instanceof u ? a.getName() : a.toString();
            if ("hasOwnProperty" == b)return a.has.apply(a, va(c))
        }
        throw"TypeError: Object has no '" +
        b + "' property.";
    };
    B.assign = function (a, b)
    {
        a = this.evaluate(a);
        if ("string" != typeof a)throw"Invalid key name given for assignment.";
        var c = this.w();
        if (!c.has(a))throw"Attempting to assign to undefined value " + b;
        var d = this.evaluate(b);
        c.set(a, d);
        return d
    };
    B["break"] = function ()
    {
        return za
    };
    B["case"] = function (a)
    {
        for (var b = this.evaluate(a), c = 0; c < b.length; c++)
        {
            var d = this.evaluate(b[c]);
            if (d instanceof g)return d
        }
    };
    B["continue"] = function ()
    {
        return Aa
    };
    B.Hc = function (a, b, c)
    {
        var d = new t;
        b = this.evaluate(b);
        for (var e = 0; e < b.length; e++)d.push(b[e]);
        var f = [B.Eb.FN, a, d].concat(Array.prototype.splice.call(arguments, 2, arguments.length - 2));
        this.w().set(a, this.evaluate(f))
    };
    B.Kc = function (a, b)
    {
        return this.evaluate(a) / this.evaluate(b)
    };
    B.Mc = function (a, b)
    {
        return this.evaluate(a) == this.evaluate(b)
    };
    B.Oc = function (a)
    {
        for (var b, c = 0; c < arguments.length; c++)b = this.evaluate(arguments[c]);
        return b
    };
    B.Rc = function (a, b, c)
    {
        a = this.evaluate(a);
        b = this.evaluate(b);
        c = this.evaluate(c);
        var d = this.w();
        if ("string" == typeof b)for (var e = 0; e < b.length; e++)
        {
            d.set(a, e);
            var f = this.ha(c);
            if (f instanceof g)
            {
                if ("break" == f.o)break;
                if ("return" == f.o)return f
            }
        }
        else if (b instanceof w || b instanceof t || b instanceof u)
        {
            var h = b.I(), k = h.length();
            for (e = 0; e < k; e++)if (d.set(a, h.get(e)), f = this.ha(c), f instanceof g)
            {
                if ("break" == f.o)break;
                if ("return" == f.o)return f
            }
        }
    };
    B.get = function (a)
    {
        return this.w().get(this.evaluate(a))
    };
    B.Cb = function (a, b)
    {
        var c;
        a = this.evaluate(a);
        b = this.evaluate(b);
        if (void 0 === a || null === a)throw"TypeError: cannot access property of " + a + ".";
        a instanceof w || a instanceof t || a instanceof u ? c = a.get(b) : "string" == typeof a && ("length" == b ? c = a.length : ba(b) && (c = a[b]));
        return c
    };
    B.Uc = function (a, b)
    {
        return this.evaluate(a) > this.evaluate(b)
    };
    B.Vc = function (a, b)
    {
        return this.evaluate(a) >= this.evaluate(b)
    };
    B.Zc = function (a, b)
    {
        return this.evaluate(a) === this.evaluate(b)
    };
    B.$c = function (a, b)
    {
        return this.evaluate(a) !== this.evaluate(b)
    };
    B["if"] = function (a, b, c)
    {
        var d = [];
        this.evaluate(a) ? d = this.evaluate(b) : c && (d = this.evaluate(c));
        var e = this.ha(d);
        if (e instanceof g)return e
    };
    B.gd = function (a, b)
    {
        return this.evaluate(a) < this.evaluate(b)
    };
    B.hd = function (a, b)
    {
        return this.evaluate(a) <= this.evaluate(b)
    };
    B.jd = function (a, b)
    {
        return this.evaluate(a) % this.evaluate(b)
    };
    B.multiply = function (a, b)
    {
        return this.evaluate(a) * this.evaluate(b)
    };
    B.kd = function (a)
    {
        return -this.evaluate(a)
    };
    B.ld = function (a)
    {
        return !this.evaluate(a)
    };
    B.md = function (a, b)
    {
        return this.evaluate(a) != this.evaluate(b)
    };
    B["null"] = function ()
    {
        return null
    };
    B.or = function (a, b)
    {
        return this.evaluate(a) || this.evaluate(b)
    };
    B.Mb = function (a, b)
    {
        var c = this.evaluate(a);
        this.evaluate(b);
        return c
    };
    B.Nb = function (a)
    {
        return this.evaluate(a)
    };
    B.quote = function (a)
    {
        return Array.prototype.slice.apply(arguments)
    };
    B["return"] = function (a)
    {
        return new g("return", this.evaluate(a))
    };
    B.setProperty = function (a, b, c)
    {
        a = this.evaluate(a);
        b = this.evaluate(b);
        c = this.evaluate(c);
        if (null === a || void 0 === a)throw"TypeError: Can't set property " + b + " of " + a + ".";
        (a instanceof u || a instanceof t || a instanceof w) && a.set(b, c);
        return c
    };
    B.Id = function (a, b)
    {
        return this.evaluate(a) - this.evaluate(b)
    };
    B["switch"] = function (a, b, c)
    {
        a = this.evaluate(a);
        b = this.evaluate(b);
        c = this.evaluate(c);
        if (!ia(b) || !ia(c))throw"Error: Malformed switch instruction.";
        for (var d, e = !1, f = 0; f < b.length; f++)if (e || a === this.evaluate(b[f]))if (d = this.evaluate(c[f]), d instanceof g)
        {
            var h = d.o;
            if ("break" == h)return;
            if ("return" == h || "continue" == h)return d
        }
        else e = !0;
        if (c.length == b.length + 1 && (d = this.evaluate(c[c.length - 1]), d instanceof g && ("return" == d.o || "continue" == d.o)))return d
    };
    B.Kd = function (a, b, c)
    {
        return this.evaluate(a) ? this.evaluate(b) : this.evaluate(c)
    };
    B["typeof"] = function (a)
    {
        a = this.evaluate(a);
        return a instanceof u ? "function" : typeof a
    };
    B.undefined = function ()
    {
    };
    B["var"] = function (a)
    {
        for (var b = this.w(), c = 0; c < arguments.length; c++)
        {
            var d = arguments[c];
            "string" != typeof d || b.add(d, void 0)
        }
    };
    B["while"] = function (a, b, c, d)
    {
        var e, f = this.evaluate(d);
        if (this.evaluate(c) && (e = this.ha(f), e instanceof g))
        {
            if ("break" == e.o)return;
            if ("return" == e.o)return e
        }
        for (; this.evaluate(a);)
        {
            e = this.ha(f);
            if (e instanceof g)
            {
                if ("break" == e.o)break;
                if ("return" == e.o)return e
            }
            this.evaluate(b)
        }
    };
    var Ca = function ()
    {
        this.Db = !1;
        this.fa = new y;
        Ba(this);
        this.Db = !0
    };
    Ca.prototype.ed = function ()
    {
        return this.Db
    };
    Ca.prototype.isInitialized = Ca.prototype.ed;
    Ca.prototype.C = function (a)
    {
        return this.fa.C.apply(this.fa, a)
    };
    Ca.prototype.execute = Ca.prototype.C;
    var Ba = function (a)
    {
        function b(a, b)
        {
            e.fa.tb(a, String(b))
        }

        function c(a, b)
        {
            e.fa.L(String(d[a]), b)
        }

        var d = B.Eb, e = a;
        b("control", d.CONTROL);
        b("fn", d.FN);
        b("list", d.CREATE_ARRAY);
        b("map", d.CREATE_OBJECT);
        b("undefined", d.UNDEFINED);
        c("ADD", B.add);
        c("AND", B.and);
        c("APPLY", B.apply);
        c("ASSIGN", B.assign);
        c("BREAK", B["break"]);
        c("CASE", B["case"]);
        c("CONTINUE", B["continue"]);
        c("DEFAULT", B["case"]);
        c("DEFN", B.Hc);
        c("DIVIDE", B.Kc);
        c("EQUALS", B.Mc);
        c("EXPRESSION_LIST", B.Oc);
        c("FOR_IN", B.Rc);
        c("GET", B.get);
        c("GET_INDEX",
          B.Cb);
        c("GET_PROPERTY", B.Cb);
        c("GREATER_THAN", B.Uc);
        c("GREATER_THAN_EQUALS", B.Vc);
        c("IDENTITY_EQUALS", B.Zc);
        c("IDENTITY_NOT_EQUALS", B.$c);
        c("IF", B["if"]);
        c("LESS_THAN", B.gd);
        c("LESS_THAN_EQUALS", B.hd);
        c("MODULUS", B.jd);
        c("MULTIPLY", B.multiply);
        c("NEGATE", B.kd);
        c("NOT", B.ld);
        c("NOT_EQUALS", B.md);
        c("NULL", B["null"]);
        c("OR", B.or);
        c("POST_DECREMENT", B.Mb);
        c("POST_INCREMENT", B.Mb);
        c("PRE_DECREMENT", B.Nb);
        c("PRE_INCREMENT", B.Nb);
        c("QUOTE", B.quote);
        c("RETURN", B["return"]);
        c("SET_PROPERTY", B.setProperty);
        c("SUBTRACT", B.Id);
        c("SWITCH", B["switch"]);
        c("TERNARY", B.Kd);
        c("TYPEOF", B["typeof"]);
        c("VAR", B["var"]);
        c("WHILE", B["while"])
    };
    Ca.prototype.L = function (a, b)
    {
        this.fa.L(a, b)
    };
    Ca.prototype.addInstruction = Ca.prototype.L;
    var Da = function ()
    {
        this.Ea = {}
    };
    Da.prototype.get = function (a)
    {
        return this.Ea.hasOwnProperty(a) ? this.Ea[a] : void 0
    };
    Da.prototype.add = function (a, b)
    {
        if (this.Ea.hasOwnProperty(a))throw"Attempting to add a function which already exists: " + a + ".";
        var c = new u(a, function ()
        {
            for (var a = Array.prototype.slice.call(arguments, 0), c = 0; c < a.length; c++)a[c] = this.evaluate(a[c]);
            return b.apply(this, a)
        });
        c.Ga = !0;
        this.Ea[a] = c
    };
    Da.prototype.addAll = function (a)
    {
        for (var b in a)a.hasOwnProperty(b) && this.add(b, a[b])
    };
    var D = window, E = document, Ea = function (a, b)
            {
                var c = D[a];
                D[a] = void 0 === c ? b : c;
                return D[a]
            }, Fa = function (a)
            {
                var b = E.getElementsByTagName("script")[0] || E.body || E.head;
                b.parentNode.insertBefore(a, b)
            }, Ga = function (a, b)
            {
                b && (a.addEventListener ? a.onload = b : a.onreadystatechange = function ()
                {
                    a.readyState in {loaded: 1, complete: 1} && (a.onreadystatechange = null, b())
                })
            }, J = function (a, b, c)
            {
                var d = E.createElement("script");
                d.type = "text/javascript";
                d.async = !0;
                d.src = a;
                Ga(d, b);
                c && (d.onerror = c);
                Fa(d);
                return d
            }, Ha = function (a, b)
            {
                var c =
                        E.createElement("iframe");
                c.height = "0";
                c.width = "0";
                c.style.display = "none";
                c.style.visibility = "hidden";
                Fa(c);
                Ga(c, b);
                void 0 !== a && (c.src = a);
                return c
            }, Ia = function (a, b, c)
            {
                var d = new Image(1, 1);
                d.onload = function ()
                {
                    d.onload = null;
                    b && b()
                };
                d.onerror = function ()
                {
                    d.onerror = null;
                    c && c()
                };
                d.src = a
            }, Ja = function (a, b, c, d)
            {
                a.addEventListener ? a.addEventListener(b, c, !!d) : a.attachEvent && a.attachEvent("on" + b, c)
            }, Ka = function (a, b, c)
            {
                a.removeEventListener ? a.removeEventListener(b, c, !1) : a.detachEvent && a.detachEvent("on" + b, c)
            },
            P = function (a)
            {
                D.setTimeout(a, 0)
            }, Ma = function (a)
            {
                var b = E.getElementById(a);
                if (b && La(b, "id") != a)for (var c = 1; c < document.all[a].length; c++)if (La(document.all[a][c], "id") == a)return document.all[a][c];
                return b
            }, La = function (a, b)
            {
                return a && b && a.attributes && a.attributes[b] ? a.attributes[b].value : null
            }, Oa = function (a)
            {
                var b = a.innerText || a.textContent || "";
                b && " " != b && (b = b.replace(/^[\s\xa0]+|[\s\xa0]+$/g, ""));
                b && (b = b.replace(/(\xa0+|\s{2,}|\n|\r\t)/g, " "));
                return b
            }, Pa = function (a)
            {
                var b = E.createElement("div");
                b.innerHTML = "A<div>" + a + "</div>";
                b = b.lastChild;
                for (var c = []; b.firstChild;)c.push(b.removeChild(b.firstChild));
                return c
            };
    var Qa = function (a, b)
    {
        for (var c = a.split("&"), d = 0; d < c.length; d++)
        {
            var e = c[d].split("=");
            if (decodeURIComponent(e[0]).replace(/\+/g, " ") == b)return decodeURIComponent(e.slice(1).join("=")).replace(/\+/g, " ")
        }
    }, Q = function (a, b, c, d, e)
    {
        var f, h = a.protocol || D.location.protocol;
        h = h.replace(":", "").toLowerCase();
        b && (b = String(b).toLowerCase());
        switch (b)
        {
            case "protocol":
                f = h;
                break;
            case "host":
                f = (a.hostname || D.location.hostname).split(":")[0].toLowerCase();
                if (c)
                {
                    var k = /^www\d*\./.exec(f);
                    k && k[0] && (f = f.substr(k[0].length))
                }
                break;
            case "port":
                f = String(1 * (a.hostname ? a.port : D.location.port) || ("http" == h ? 80 : "https" == h ? 443 : ""));
                break;
            case "path":
                f = "/" == a.pathname.substr(0, 1) ? a.pathname : "/" + a.pathname;
                var l = f.split("/");
                0 <= ja(d || [], l[l.length - 1]) && (l[l.length - 1] = "");
                f = l.join("/");
                break;
            case "query":
                f = a.search.replace("?", "");
                e && (f = Qa(f, e));
                break;
            case "fragment":
                f = a.hash.replace("#", "");
                break;
            default:
                f = a && a.href
        }
        return f
    }, Ra = function (a)
    {
        var b = "";
        a && a.href && (b = a.hash ? a.href.replace(a.hash, "") : a.href);
        return b
    }, R = function (a)
    {
        var b =
                E.createElement("a");
        a && (b.href = a);
        return b
    };
    var Ua = function ()
    {
        this.Lb = new Ca;
        var a = new Da;
        a.addAll(Sa());
        Ta(this, function (b)
        {
            return a.get(b)
        })
    }, Sa = function ()
    {
        return {
            callInWindow: Va,
            getCurrentUrl: Wa,
            getInWindow: Xa,
            getReferrer: Ya,
            getUrlComponent: Za,
            getUrlFragment: $a,
            isPlainObject: ab,
            loadIframe: bb,
            loadJavaScript: cb,
            removeUrlFragment: db,
            replaceAll: fb,
            sendTrackingBeacon: gb,
            setInWindow: hb
        }
    };
    Ua.prototype.C = function (a)
    {
        return this.Lb.C(a)
    };
    Ua.prototype.execute = Ua.prototype.C;
    var Ta = function (a, b)
    {
        a.Lb.L("require", b)
    };

    function Va(a, b)
    {
        for (var c = a.split("."), d = D, e = d[c[0]], f = 1; e && f < c.length; f++)d = e, e = e[c[f]];
        if ("function" == oa(e))
        {
            var h = [];
            for (f = 1; f < arguments.length; f++)h.push(sa(arguments[f]));
            e.apply(d, h)
        }
    }

    function Wa()
    {
        return D.location.href
    }

    function Xa(a, b, c)
    {
        for (var d = a.split("."), e = D, f = 0; f < d.length - 1; f++)if (e = e[d[f]], void 0 === e || null === e)return;
        b && (void 0 === e[d[f]] || c && !e[d[f]]) && (e[d[f]] = sa(b));
        return ta(e[d[f]])
    }

    function Ya()
    {
        return E.referrer
    }

    function Za(a, b, c, d, e)
    {
        var f;
        if (d && d instanceof t)
        {
            f = [];
            for (var h = Number(d.get("length")), k = 0; k < h; k++)
            {
                var l = d.get(k);
                "string" == typeof l && f.push(l)
            }
        }
        return Q(R(a), b, c, f, e)
    }

    function $a(a)
    {
        return Q(R(a), "fragment")
    }

    function ab(a)
    {
        return a instanceof w
    }

    function bb(a, b)
    {
        var c = this.w();
        Ha(a, function ()
        {
            b instanceof u && b.i(c)
        })
    }

    var ib = {};

    function cb(a, b, c, d)
    {
        var e = this.w(), f = function ()
        {
            b instanceof u && b.i(e)
        }, h = function ()
        {
            c instanceof u && c.i(e)
        };
        d ? ib[d] ? (ib[d].onSuccess.push(f), ib[d].onFailure.push(h)) : (ib[d] = {onSuccess: [f], onFailure: [h]}, J(a, function ()
        {
            for (var a = ib[d].onSuccess, b = 0; b < a.length; b++)P(a[b]);
            a.push = function (a)
            {
                P(a);
                return 0
            }
        }, function ()
                                                                                                                      {
                                                                                                                          for (var a = ib[d].onFailure, b = 0; b < a.length; b++)P(a[b]);
                                                                                                                          ib[d] = null
                                                                                                                      })) : J(a, f, h)
    }

    function db(a)
    {
        return Ra(R(a))
    }

    function fb(a, b, c)
    {
        return a.replace(new RegExp(b, "g"), c)
    }

    function gb(a, b, c)
    {
        var d = this.w();
        Ia(a, function ()
        {
            b instanceof u && b.i(d)
        }, function ()
           {
               c instanceof u && c.i(d)
           })
    }

    function hb(a, b, c)
    {
        for (var d = a.split("."), e = D, f = 0; f < d.length - 1; f++)if (e = e[d[f]], void 0 === e)return !1;
        return void 0 === e[d[f]] || c ? (e[d[f]] = sa(b), !0) : !1
    };
    var Gb, Ib = [], Jb = [], Kb = [], Lb = [], Mb = [], Nb = {}, Ob, Pb, Qb = function (a)
    {
        var b = a["function"];
        if (!b)throw"Error: No function name given for function call.";
        if (Nb[b])
        {
            var c = {}, d;
            for (d in a)a.hasOwnProperty(d) && 0 === d.indexOf("vtp_") && (c[d] = a[d]);
            return Nb[b](c)
        }
        var e = new w, f;
        for (f in a)a.hasOwnProperty(f) && 0 === f.indexOf("vtp_") && e.set(f.substr(4), ta(a[f]));
        var h = Gb([b, e]);
        h instanceof g && "return" === h.o && (h = h.getData());
        return sa(h)
    }, Sb = function (a, b, c)
    {
        c = c || [];
        var d = {}, e;
        for (e in a)a.hasOwnProperty(e) && (d[e] =
                Rb(a[e], b, c));
        return d
    }, Rb = function (a, b, c)
    {
        if (ia(a))
        {
            var d;
            switch (a[0])
            {
                case "function_id":
                    return a[1];
                case "list":
                    d = [];
                    for (var e = 1; e < a.length; e++)d.push(Rb(a[e], b, c));
                    return d;
                case "macro":
                    var f = a[1];
                    if (c[f])return;
                    var h = Ib[f];
                    if (!h || b(h))return;
                    c[f] = !0;
                    d = Qb(Sb(h, b, c));
                    c[f] = !1;
                    return d;
                case "map":
                    d = {};
                    for (var k = 1; k < a.length; k += 2)d[Rb(a[k], b, c)] = Rb(a[k + 1], b, c);
                    return d;
                case "template":
                    d = [];
                    for (var l = !1, m = 1; m < a.length; m++)
                    {
                        var n = Rb(a[m], b, c);
                        Pb && (l = l || n === Pb.sa);
                        d.push(n)
                    }
                    return Pb && l ? Pb.Dc(d) : d.join("");
                case "escape":
                    d = Rb(a[1], b, c);
                    if (Pb && ia(a[1]) && "macro" === a[1][0] && Pb.fd(a))return Pb.sd(d);
                    d = String(d);
                    for (var p = 2; p < a.length; p++)jb[a[p]] && (d = jb[a[p]](d));
                    return d;
                case "tag":
                    var q = a[1];
                    if (!Lb[q])throw Error("Unable to resolve tag reference " + q + ".");
                    return d = {zb: a[2], index: q};
                case "zb":
                    var v = Tb({"function": a[1], arg0: a[2], arg1: a[3], ignore_case: a[5]}, b, c);
                    a[4] && (v = !v);
                    return v;
                default:
                    throw Error("Attempting to expand unknown Value type: " + a[0] + ".");
            }
        }
        return a
    }, Tb = function (a, b, c)
    {
        if (b(a))return !1;
        try
        {
            return Ob(Sb(a,
                         b, c))
        }
        catch (d)
        {
            JSON.stringify(a)
        }
        return null
    };
    var Ub = null, Xb = function (a)
    {
        function b(a)
        {
            for (var b = 0; b < a.length; b++)d[a[b]] = !0
        }

        var c = [], d = [];
        Ub = Vb(a);
        for (var e = 0; e < Jb.length; e++)
        {
            var f = Jb[e], h = Wb(f);
            if (h)
            {
                for (var k = f.add || [], l = 0; l < k.length; l++)c[k[l]] = !0;
                b(f.block || [])
            }
            else null === h && b(f.block || [])
        }
        var m = [];
        for (e = 0; e < Lb.length; e++)c[e] && !d[e] && (m[e] = !0);
        return m
    }, Wb = function (a)
    {
        for (var b = a["if"] || [], c = 0; c < b.length; c++)
        {
            var d = Ub(b[c]);
            if (!d)return null === d ? null : !1
        }
        var e = a.unless || [];
        for (c = 0; c < e.length; c++)
        {
            d = Ub(e[c]);
            if (null === d)return null;
            if (d)return !1
        }
        return !0
    };
    var Vb = function (a)
    {
        var b = [];
        return function (c)
        {
            void 0 === b[c] && (b[c] = Tb(Kb[c], a));
            return b[c]
        }
    };
    /*
     Copyright (c) 2014 Derek Brans, MIT license https://github.com/krux/postscribe/blob/master/LICENSE. Portions derived from simplehtmlparser, which is licensed under the Apache License, Version 2.0 */
    var $b = {}, ac = null;
    $b.A = "UA-116001373-1";
    var bc = null, cc = {}, dc = {};
    var ec = function ()
    {
    }, fc = function (a)
    {
        return "function" == typeof a
    }, gc = function (a)
    {
        return "string" == oa(a)
    }, hc = function (a)
    {
        return "number" == oa(a) && !isNaN(a)
    }, ic = function (a)
    {
        return Math.round(Number(a)) || 0
    }, jc = function (a)
    {
        return "false" == String(a).toLowerCase() ? !1 : !!a
    }, kc = function (a)
    {
        var b = [];
        if (ia(a))for (var c = 0; c < a.length; c++)b.push(String(a[c]));
        return b
    }, lc = function (a)
    {
        return a ? a.replace(/^\s+|\s+$/g, "") : ""
    }, mc = function (a, b)
    {
        if (!hc(a) || !hc(b) || a > b)a = 0, b = 2147483647;
        return Math.floor(Math.random() * (b - a + 1) +
                          a)
    }, nc = function ()
    {
        this.prefix = "gtm.";
        this.values = {}
    };
    nc.prototype.set = function (a, b)
    {
        this.values[this.prefix + a] = b
    };
    nc.prototype.get = function (a)
    {
        return this.values[this.prefix + a]
    };
    nc.prototype.contains = function (a)
    {
        return void 0 !== this.get(a)
    };
    var oc = function ()
    {
        var a = ac.sequence || 0;
        ac.sequence = a + 1;
        return a
    }, qc = function (a, b, c)
    {
        return a && a.hasOwnProperty(b) ? a[b] : c
    }, rc = function (a)
    {
        var b = !1;
        return function ()
        {
            if (!b)try
            {
                a()
            }
            catch (c)
            {
            }
            b = !0
        }
    };
    var sc = function ()
    {
        var a = function (a)
        {
            return {
                toString: function ()
                {
                    return a
                }
            }
        };
        return {
            T: a("function"),
            Tb: a("instance_name"),
            Ub: a("live_only"),
            Vb: a("malware_disabled"),
            Wb: a("once_per_event"),
            qb: a("once_per_load"),
            Xb: a("setup_tags"),
            Yb: a("tag_id"),
            Zb: a("teardown_tags")
        }
    }();
    var tc = new nc, uc = {}, xc = {
        set: function (a, b)
        {
            ra(vc(a, b), uc)
        }, get: function (a)
        {
            return wc(a, 2)
        }, reset: function ()
        {
            tc = new nc;
            uc = {}
        }
    }, wc = function (a, b)
    {
        return 2 != b ? tc.get(a) : yc(a)
    }, yc = function (a, b, c)
    {
        var d = a.split(".");
        var e = function (a, b)
        {
            for (var c = 0; void 0 !== a && c < d.length; c++)
            {
                if (null === a)return !1;
                a = a[d[c]]
            }
            return void 0 !== a || 1 < c ? a : b.length ? e(zc(b.pop()), b) : Ac(d)
        };
        return e(uc.eventModel, [b, c]);
        return Ac(d)
    }, Ac = function (a)
    {
        for (var b = uc, c = 0; c < a.length; c++)
        {
            if (null ===
                    b)return !1;
            if (void 0 === b)break;
            b = b[a[c]]
        }
        return b
    };
    var zc = function (a)
    {
        if (a)
        {
            var b = Ac(["gtag", "targets", a]);
            return qa(b) ? b : void 0
        }
    }, Bc = function (a, b)
    {
        function c(a)
        {
            if (a)for (var b in a)a.hasOwnProperty(b) && (d[b] = null)
        }

        var d = {};
        c(uc);
        delete d.eventModel;
        c(zc(a));
        c(zc(b));
        c(uc.eventModel);
        var e = [], f;
        for (f in d)d.hasOwnProperty(f) && e.push(f);
        return e
    };
    var Cc = function (a, b)
    {
        tc.set(a, b);
        ra(vc(a, b), uc)
    }, vc = function (a, b)
    {
        for (var c = {}, d = c, e = a.split("."), f = 0; f < e.length - 1; f++)d = d[e[f]] = {};
        d[e[e.length - 1]] = b;
        return c
    };
    var Dc = new RegExp(/^(.*\.)?(google|youtube|blogger|withgoogle)(\.com?)?(\.[a-z]{2})?\.?$/), Ec = {
        customPixels: ["nonGooglePixels"],
        html: ["customScripts", "customPixels", "nonGooglePixels", "nonGoogleScripts", "nonGoogleIframes"],
        customScripts: ["html", "customPixels", "nonGooglePixels", "nonGoogleScripts", "nonGoogleIframes"],
        nonGooglePixels: [],
        nonGoogleScripts: ["nonGooglePixels"],
        nonGoogleIframes: ["nonGooglePixels"]
    }, Fc = {
        customPixels: ["customScripts", "html"],
        html: ["customScripts"],
        customScripts: ["html"],
        nonGooglePixels: ["customPixels",
            "customScripts", "html", "nonGoogleScripts", "nonGoogleIframes"],
        nonGoogleScripts: ["customScripts", "html"],
        nonGoogleIframes: ["customScripts", "html", "nonGoogleScripts"]
    }, Gc = function (a, b)
    {
        for (var c = [], d = 0; d < a.length; d++)c.push(a[d]), c.push.apply(c, b[a[d]] || []);
        return c
    };
    var Hc = function (a)
    {
        var b = wc("gtm.whitelist");
        b = "gtagua gtagaw gtagfl e v oid op cn css ew eq ge gt lc le lt re sw um".split(" ");
        var c = b && Gc(kc(b), Ec), d = wc("gtm.blacklist") ||
                wc("tagTypeBlacklist") || [];
        Dc.test(D.location && D.location.hostname) && (d = kc(d), d.push("nonGooglePixels", "nonGoogleScripts"));
        var e = d && Gc(kc(d), Fc), f = {};
        return function (h)
        {
            var k = h && h[sc.T];
            if (!k || "string" != typeof k)return !0;
            k = k.replace(/_/g, "");
            if (void 0 !== f[k])return f[k];
            var l = dc[k] || [], m = a(k);
            if (b)
            {
                var n;
                if (n = m)a:{
                    if (0 > ja(c, k))if (l && 0 < l.length)for (var p = 0; p < l.length; p++)
                    {
                        if (0 >
                                ja(c, l[p]))
                        {
                            n = !1;
                            break a
                        }
                    }
                    else
                    {
                        n = !1;
                        break a
                    }
                    n = !0
                }
                m = n
            }
            var q = !1;
            if (d)
            {
                var v;
                if (!(v = 0 <= ja(e, k)))a:{
                    for (var r = l || [], x = new nc, F = 0; F < e.length; F++)x.set(e[F], !0);
                    for (F = 0; F < r.length; F++)if (x.get(r[F]))
                    {
                        v = !0;
                        break a
                    }
                    v = !1
                }
                q = v
            }
            return f[k] = !m || q
        }
    };
    var Ic = function (a)
    {
        var b = ac.zones;
        !b && a && (b = ac.zones = a());
        return b
    }, Jc = {
        active: !0, isWhitelisted: function ()
        {
            return !0
        }
    };
    var Kc = !1, Lc = 0, Mc = [];

    function Nc(a)
    {
        if (!Kc)
        {
            var b = E.createEventObject, c = "complete" == E.readyState, d = "interactive" == E.readyState;
            if (!a || "readystatechange" != a.type || c || !b && d)
            {
                Kc = !0;
                for (var e = 0; e < Mc.length; e++)P(Mc[e])
            }
            Mc.push = function ()
            {
                for (var a = 0; a < arguments.length; a++)P(arguments[a]);
                return 0
            }
        }
    }

    function Oc()
    {
        if (!Kc && 140 > Lc)
        {
            Lc++;
            try
            {
                E.documentElement.doScroll("left"), Nc()
            }
            catch (a)
            {
                D.setTimeout(Oc, 50)
            }
        }
    }

    var Pc = function (a)
    {
        Kc ? a() : Mc.push(a)
    };
    var Qc = !1;
    var Rc = function (a)
    {
        D.GoogleAnalyticsObject || (D.GoogleAnalyticsObject = a || "ga");
        var b = D.GoogleAnalyticsObject;
        if (!D[b])
        {
            var c = function ()
            {
                c.q = c.q || [];
                c.q.push(arguments)
            };
            c.l = Number(new Date);
            D[b] = c
        }
        return D[b]
    }, Sc = function ()
    {
        return D.GoogleAnalyticsObject && D[D.GoogleAnalyticsObject]
    }, Tc = function (a, b, c, d)
    {
        b = String(b).replace(/\s+/g, "").split(",");
        var e = Sc();
        e(a + "require", "linker");
        e(a + "linker:autoLink", b, c, d)
    };

    function Xc(a, b, c, d, e, f)
    {
        var h = Lb[a], k = Yc(a, b, c, d, e, f);
        if (!k)return null;
        var l = Rb(h[sc.Xb], f.ma, []);
        if (l && l.length)
        {
            var m = l[0];
            k = Xc(m.index, b, k, 1 === m.zb ? e : k, e, f)
        }
        return k
    }

    function Yc(a, b, c, d, e, f)
    {
        function h()
        {
            var a = Sb(k, f.ma);
            a.vtp_gtmOnSuccess = c;
            a.vtp_gtmOnFailure = d;
            a.vtp_gtmTagId = k.tag_id;
            k[sc.Vb] ? d() : Qb(a)
        }

        var k = Lb[a];
        if (f.ma(k))return null;
        var l = Rb(k[sc.Zb], f.ma, []);
        if (l && l.length)
        {
            var m = l[0], n = Xc(m.index, b, c, d, e, f);
            if (!n)return null;
            c = n;
            d = 2 === m.zb ? e : n
        }
        if (k[sc.qb] || k[sc.Wb])
        {
            var p = k[sc.qb] ? Mb : b, q = c, v = d;
            if (!p[a])
            {
                h = rc(h);
                var r = Zc(a, p, h);
                c = r.K;
                d = r.X
            }
            return function ()
            {
                p[a](q, v)
            }
        }
        return h
    }

    function Zc(a, b, c)
    {
        var d = [], e = [];
        b[a] = $c(d, e, c);
        return {
            K: function ()
            {
                b[a] = ad;
                for (var c = 0; c < d.length; c++)d[c]()
            }, X: function ()
            {
                b[a] = bd;
                for (var c = 0; c < e.length; c++)e[c]()
            }
        }
    }

    function $c(a, b, c)
    {
        return function (d, e)
        {
            a.push(d);
            b.push(e);
            c()
        }
    }

    function ad(a)
    {
        a()
    }

    function bd(a, b)
    {
        b()
    };
    function cd(a)
    {
        var b = 0, c = 0, d = !1;
        return {
            add: function ()
            {
                c++;
                return rc(function ()
                          {
                              b++;
                              d && b >= c && a()
                          })
            }, ic: function ()
            {
                d = !0;
                b >= c && a()
            }
        }
    }

    function dd(a, b)
    {
        return function ()
        {
            try
            {
                a()
            }
            catch (c)
            {
                b()
            }
        }
    }

    var ed = !1;
    var fd = function (a, b)
    {
        var c = {};
        c[sc.T] = "__" + a;
        for (var d in b)b.hasOwnProperty(d) && (c["vtp_" + d] = b[d]);
        for (d in void 0)(void 0).hasOwnProperty(d) && (c[d] = (void 0)[d]);
        Lb.push(c);
        return Lb.length - 1
    };
    var gd = /[A-Z]+/, hd = /\s/, id = function (a)
    {
        if (gc(a) && (a = a.trim(), !hd.test(a)))
        {
            var b = a.indexOf("-");
            if (!(0 > b))
            {
                var c = a.substring(0, b);
                if (gd.test(c))
                {
                    for (var d = a.substring(b + 1).split("/"), e = 0; e < d.length; e++)if (!d[e])return;
                    return {id: a, prefix: c, containerId: c + "-" + d[0], ka: d}
                }
            }
        }
    };
    var jd = null, kd = {}, ld = {}, md;

    function nd()
    {
        jd = jd || !ac.gtagRegistered;
        ac.gtagRegistered = !0;
        return jd
    }

    var od = function (a, b)
    {
        var c = {event: a};
        b && (c.eventModel = ra(b, void 0), b.event_callback && (c.eventCallback = b.event_callback), b.event_timeout && (c.eventTimeout = b.event_timeout));
        return c
    };

    function pd(a)
    {
        if (void 0 === ld[a.id])
        {
            var b;
            if ("UA" == a.prefix)b = fd("gtagua", {trackingId: a.id});
            else if ("AW" == a.prefix)b = fd("gtagaw", {conversionId: a});
            else if ("DC" == a.prefix)b = fd("gtagfl", {targetId: a.id});
            else return;
            if (!md)
            {
                var c = {name: "send_to", dataLayerVersion: 2}, d = {};
                d[sc.T] = "__v";
                for (var e in c)c.hasOwnProperty(e) && (d["vtp_" + e] = c[e]);
                Ib.push(d);
                md = ["macro", Ib.length - 1]
            }
            var f = {arg0: md, arg1: a.id, ignore_case: !1};
            f[sc.T] = "_lc";
            Kb.push(f);
            var h = {"if": [Kb.length - 1], add: [b]};
            h["if"] && (h.add || h.block) &&
            Jb.push(h);
            ld[a.id] = b
        }
    }

    var ud = {
        event: function (a)
        {
            var b = a[1];
            if (gc(b) && !(3 < a.length))
            {
                var c;
                if (2 < a.length)
                {
                    if (!qa(a[2]))return;
                    c = a[2]
                }
                var d = od(b, c);
                var e;
                var f = c, h = wc("gtag.fields.send_to", 2);
                gc(h) || (h = "send_to");
                var k = f && f[h];
                void 0 === k && (k = wc(h, 2), void 0 === k && (k = "default"));
                if (gc(k) || ia(k))
                {
                    for (var l, m = k.toString().replace(/\s+/g, "").split(","), n = [], p = 0; p < m.length; p++)0 <= m[p].indexOf("-") ? n.push(m[p]) : n = n.concat(kd[m[p]] || []);
                    l = n;
                    for (var q = {}, v = 0; v < l.length; ++v)
                    {
                        var r = id(l[v]);
                        r && (q[r.id] =
                                r)
                    }
                    var x = [], F;
                    for (F in q)if (q.hasOwnProperty(F))
                    {
                        var Y = q[F];
                        "AW" === Y.prefix && Y.ka[1] && x.push(Y.containerId)
                    }
                    for (var A = 0; A < x.length; ++A)delete q[x[A]];
                    var M = [], C;
                    for (C in q)q.hasOwnProperty(C) && M.push(q[C]);
                    e = M
                }
                else e = void 0;
                if (!e)return;
                var N = nd();
                N || qd();
                for (var I = [], K = 0; N && K < e.length; K++)
                {
                    var G = e[K];
                    I.push(G.id);
                    pd(G)
                }
                d.eventModel = d.eventModel || {};
                0 < e.length ? d.eventModel.send_to = I.join() : delete d.eventModel.send_to;
                return d
            }
        }, set: function (a)
        {
            var b;
            2 == a.length && qa(a[1]) ?
                    b = ra(a[1], void 0) : 3 == a.length && gc(a[1]) && (b = {}, b[a[1]] = a[2]);
            if (b)return b.eventModel = ra(b, void 0), b.event = "gtag.set", b._clear = !0, b
        }, js: function (a)
        {
            if (2 == a.length && a[1].getTime)return {event: "gtm.js", "gtm.start": a[1].getTime()}
        }, config: function (a)
        {
            var b = a[2] || {};
            if (2 > a.length || !gc(a[1]) || !qa(b))return;
            var c = id(a[1]);
            if (!c)return;
            nd() ? pd(c) : qd();
            var d = c.id, e;
            for (e in kd)if (kd.hasOwnProperty(e))
            {
                var f = ja(kd[e], d);
                0 <= f && kd[e].splice(f, 1)
            }
            var h = c.id, k = b.groups || "default";
            k = k.toString().split(",");
            for (var l = 0; l < k.length; l++)kd[k[l]] = kd[k[l]] || [], kd[k[l]].push(h);
            delete b.groups;
            Cc("gtag.targets." + c.id, void 0);
            Cc("gtag.targets." + c.id, ra(b, void 0));
            return od("gtag.config", {send_to: c.id});
        }
    }, qd = rc(function ()
               {
               });
    var vd = !1, wd = [];

    function xd()
    {
        if (!vd)
        {
            vd = !0;
            for (var a = 0; a < wd.length; a++)P(wd[a])
        }
    };
    var yd = [], zd = !1, Ad = function (a)
    {
        var b = a.eventCallback, c = rc(function ()
                                        {
                                            fc(b) && P(function ()
                                                       {
                                                           b($b.A)
                                                       })
                                        }), d = a.eventTimeout;
        d && D.setTimeout(c, Number(d));
        return c
    }, Bd = function ()
    {
        for (var a = !1; !zd && 0 < yd.length;)
        {
            zd = !0;
            delete uc.eventModel;
            var b = yd.shift();
            if (fc(b))try
            {
                b.call(xc)
            }
            catch (rd)
            {
            }
            else if (ia(b))
            {
                var c = b;
                if (gc(c[0]))
                {
                    var d = c[0].split("."), e = d.pop(), f = c.slice(1), h = wc(d.join("."), 2);
                    if (void 0 !== h && null !== h)try
                    {
                        h[e].apply(h, f)
                    }
                    catch (rd)
                    {
                    }
                }
            }
            else
            {
                var k = b;
                if (k && ("[object Arguments]" == Object.prototype.toString.call(k) ||
                        Object.prototype.hasOwnProperty.call(k, "callee")))
                {
                    a:{
                        var l = b;
                        if (l.length && gc(l[0]))
                        {
                            var m = ud[l[0]];
                            if (m)
                            {
                                b = m(l);
                                break a
                            }
                        }
                        b = void 0
                    }
                    if (!b)
                    {
                        zd = !1;
                        continue
                    }
                }
                var n;
                var p = void 0, q = b, v = q._clear;
                for (p in q)q.hasOwnProperty(p) && "_clear" !== p && (v && Cc(p, void 0), Cc(p, q[p]));
                var r = q.event;
                if (r)
                {
                    var x = q["gtm.uniqueEventId"];
                    x || (x = oc(), q["gtm.uniqueEventId"] = x, Cc("gtm.uniqueEventId", x));
                    bc = r;
                    var F;
                    var Y, A, M = q, C = M.event, N = M["gtm.uniqueEventId"], I = ac.zones;
                    A = I ? I.checkState($b.A, N) : Jc;
                    if (A.active)
                    {
                        var K = Ad(M);
                        c:{
                            var G =
                                    A.isWhitelisted;
                            if ("gtm.js" == C)
                            {
                                if (ed)
                                {
                                    Y = !1;
                                    break c
                                }
                                ed = !0
                            }
                            var L = {id: N, name: C, xc: K || ec, ma: Hc(G)};
                            L.fb = Xb(L.ma);
                            for (var wa, Na = L, pb = cd(Na.xc), Ke = [], Hb = [], qb = 0; qb < Na.fb.length; qb++)if (Na.fb[qb])
                            {
                                var Le = Lb[qb];
                                var eb = pb.add();
                                try
                                {
                                    var sd = Xc(qb, Ke, eb, eb, eb, Na);
                                    sd ? Hb.push(dd(sd, eb)) : eb()
                                }
                                catch (rd)
                                {
                                    eb()
                                }
                            }
                            pb.ic();
                            for (var pc = 0; pc < Hb.length; pc++)Hb[pc]();
                            wa = 0 < Hb.length;
                            if ("gtm.js" === C || "gtm.sync" === C)d:{
                            }
                            Y = wa
                        }
                        F = Y ? !0 : !1
                    }
                    else F = !1;
                    bc = null;
                    n = F
                }
                else n = !1;
                a = n || a
            }
            zd = !1
        }
        return !a
    }, Cd = function ()
    {
        return Bd()
    }, Dd = function ()
    {
        var a = Ea("dataLayer", []), b = Ea("google_tag_manager", {});
        b = b["dataLayer"] =
                b["dataLayer"] || {};
        Mc.push(function ()
                {
                    b.gtmDom || (b.gtmDom = !0, a.push({event: "gtm.dom"}))
                });
        wd.push(function ()
                {
                    b.gtmLoad || (b.gtmLoad = !0, a.push({event: "gtm.load"}))
                });
        var c = a.push;
        a.push = function ()
        {
            var b = [].slice.call(arguments, 0);
            c.apply(a, b);
            for (yd.push.apply(yd, b); 300 < this.length;)this.shift();
            return Bd()
        };
        yd.push.apply(yd, a.slice(0));
        P(Cd)
    };
    var T = {};
    T.sa = new String("undefined");
    T.Ma = {};
    var Ed = function (a)
    {
        this.resolve = function (b)
        {
            for (var c = [], d = 0; d < a.length; d++)c.push(a[d] === T.sa ? b : a[d]);
            return c.join("")
        }
    };
    Ed.prototype.toString = function ()
    {
        return this.resolve("undefined")
    };
    Ed.prototype.valueOf = Ed.prototype.toString;
    T.Dc = function (a)
    {
        return new Ed(a)
    };
    var Fd = {};
    T.yd = function (a, b)
    {
        var c = oc();
        Fd[c] = [a, b];
        return c
    };
    T.vb = function (a)
    {
        var b = a ? 0 : 1;
        return function (a)
        {
            var c = Fd[a];
            if (c && "function" === typeof c[b])c[b]();
            Fd[a] = void 0
        }
    };
    T.fd = function (a)
    {
        for (var b = !1, c = !1, d = 2; d < a.length; d++)b = b || 8 === a[d], c = c || 16 === a[d];
        return b && c
    };
    T.sd = function (a)
    {
        if (a === T.sa)return a;
        var b = oc();
        T.Ma[b] = a;
        return 'google_tag_manager["' + $b.A + '"].macro(' + b + ")"
    };
    T.$b = Ed;
    var Gd = new nc, Hd = function (a, b)
    {
        function c(a)
        {
            var b = R(a), c = Q(b, "protocol"), d = Q(b, "host", !0), e = Q(b, "port"), f = Q(b, "path").toLowerCase().replace(/\/$/, "");
            if (void 0 === c || "http" == c && "80" == e || "https" == c && "443" == e)c = "web", e = "default";
            return [c, d, e, f]
        }

        for (var d = c(String(a)), e = c(String(b)), f = 0; f < d.length; f++)if (d[f] !== e[f])return !1;
        return !0
    };

    function Id(a)
    {
        var b = a.arg0, c = a.arg1;
        switch (a["function"])
        {
            case "_cn":
                return 0 <= String(b).indexOf(String(c));
            case "_css":
                var d;
                a:{
                    if (b)
                    {
                        var e = ["matches", "webkitMatchesSelector", "mozMatchesSelector", "msMatchesSelector", "oMatchesSelector"];
                        try
                        {
                            for (var f = 0; f < e.length; f++)if (b[e[f]])
                            {
                                d = b[e[f]](c);
                                break a
                            }
                        }
                        catch (r)
                        {
                        }
                    }
                    d = !1
                }
                return d;
            case "_ew":
                var h, k;
                h = String(b);
                k = String(c);
                var l = h.length - k.length;
                return 0 <= l && h.indexOf(k, l) == l;
            case "_eq":
                return String(b) == String(c);
            case "_ge":
                return Number(b) >= Number(c);
            case "_gt":
                return Number(b) > Number(c);
            case "_lc":
                var m;
                m = b.toString().split(",");
                return 0 <= ja(m, String(c));
            case "_le":
                return Number(b) <= Number(c);
            case "_lt":
                return Number(b) < Number(c);
            case "_re":
                var n;
                var p = a.ignore_case ? "i" : void 0;
                try
                {
                    var q = String(c) + p, v = Gd.get(q);
                    v || (v = new RegExp(c, p), Gd.set(q, v));
                    n = v.test(b)
                }
                catch (r)
                {
                    n = !1
                }
                return n;
            case "_sw":
                return 0 == String(b).indexOf(String(c));
            case "_um":
                return Hd(b, c)
        }
        return !1
    };
    function Jd(a, b, c, d)
    {
        return (d || "https:" == D.location.protocol ? a : b) + c
    }

    function Kd(a, b)
    {
        for (var c = b || (a instanceof t ? new t : new w), d = a.I(), e = Number(d.get("length")), f = 0; f < e; f++)
        {
            var h = d.get(f);
            if (a.has(h))
            {
                var k = a.get(h);
                k instanceof t ? (c.get(h) instanceof t || c.set(h, new t), Kd(k, c.get(h))) : k instanceof w ? (c.get(h) instanceof w || c.set(h, new w), Kd(k, c.get(h))) : c.set(h, k)
            }
        }
        return c
    }

    function Ld()
    {
        return $b.A
    }

    function Md()
    {
        return (new Date).getTime()
    }

    function Nd(a, b)
    {
        return ta(wc(a, b || 2))
    }

    function Od()
    {
        return bc
    }

    function Pd(a)
    {
        return Pa('<a href="' + a + '"></a>')[0].href
    }

    function Qd(a)
    {
        return ic(sa(a))
    }

    function Rd(a)
    {
        return null === a ? "null" : void 0 === a ? "undefined" : a.toString()
    }

    function Sd(a, b)
    {
        return mc(a, b)
    }

    function Td(a, b, c)
    {
        if (!(a instanceof t))return null;
        for (var d = new w, e = !1, f = a.get("length"), h = 0; h < f; h++)
        {
            var k = a.get(h);
            k instanceof w && k.has(b) && k.has(c) && (d.set(k.get(b), k.get(c)), e = !0)
        }
        return e ? d : null
    }

    var Ud = function ()
    {
        var a = new Da;
        a.addAll(Sa());
        a.addAll({
                     buildSafeUrl: Jd,
                     decodeHtmlUrl: Pd,
                     copy: Kd,
                     generateUniqueNumber: oc,
                     getContainerId: Ld,
                     getCurrentTime: Md,
                     getDataLayerValue: Nd,
                     getEventName: Od,
                     makeInteger: Qd,
                     makeString: Rd,
                     randomInteger: Sd,
                     tableToMap: Td
                 });
        return function (b)
        {
            return a.get(b)
        }
    };
    var Vd = new Ua, Wd = function ()
    {
        var a = data.runtime || [];
        Gb = function (a)
        {
            return Vd.C(a)
        };
        Ob = Id;
        Ta(Vd, Ud());
        for (var b = 0; b < a.length; b++)
        {
            var c = a[b];
            if (!ia(c) || 3 > c.length)
            {
                if (0 == c.length)continue;
                break
            }
            Vd.C(c)
        }
    };
    var Xd = function (a, b)
    {
        var c = function ()
        {
        };
        c.prototype = a.prototype;
        var d = new c;
        a.apply(d, Array.prototype.slice.call(arguments, 1));
        return d
    };
    var Yd = function (a)
    {
        return encodeURIComponent(a)
    }, Zd = function (a)
    {
        var b = ["veinteractive.com", "ve-interactive.cn"];
        if (!a)return !1;
        var c = Q(R(a), "host");
        if (!c)return !1;
        for (var d = 0; b && d < b.length; d++)
        {
            var e = b[d] && b[d].toLowerCase();
            if (e)
            {
                var f = c.length - e.length;
                0 < f && "." != e.charAt(0) && (f--, e = "." + e);
                if (0 <= f && c.indexOf(e, f) == f)return !0
            }
        }
        return !1
    };
    var U = function (a, b, c)
    {
        for (var d = {}, e = !1, f = 0; a && f < a.length; f++)a[f] && a[f].hasOwnProperty(b) && a[f].hasOwnProperty(c) && (d[a[f][b]] = a[f][c], e = !0);
        return e ? d : null
    }, $d = function (a, b)
    {
        ra(a, b)
    }, ae = function (a)
    {
        return ic(a)
    }, be = function (a, b)
    {
        return ja(a, b)
    };
    var ce = function (a)
    {
        var b = {
            "gtm.element": a,
            "gtm.elementClasses": a.className,
            "gtm.elementId": a["for"] || La(a, "id") || "",
            "gtm.elementTarget": a.formTarget || a.target || ""
        };
        b["gtm.elementUrl"] = (a.attributes && a.attributes.formaction ? a.formAction : "") || a.action || a.href || a.src || a.code || a.codebase || "";
        return b
    }, de = function (a)
    {
        ac.hasOwnProperty("autoEventsSettings") || (ac.autoEventsSettings = {});
        var b = ac.autoEventsSettings;
        b.hasOwnProperty(a) || (b[a] = {});
        return b[a]
    }, ee = function (a, b, c, d)
    {
        var e = de(a), f = qc(e, b, d);
        e[b] =
                c(f)
    }, fe = function (a, b, c)
    {
        var d = de(a);
        return qc(d, b, c)
    };
    var ge = /(^|\.)doubleclick\.net$/i, he = /^(www\.)?google(\.com?)?(\.[a-z]{2})?$/, ie = function (a, b, c)
    {
        for (var d = String(b || E.cookie).split(";"), e = [], f = 0; f < d.length; f++)
        {
            var h = d[f].split("="), k = lc(h[0]);
            if (k && k == a)
            {
                var l = lc(h.slice(1).join("="));
                l && !1 !== c && (l = decodeURIComponent(l));
                e.push(l)
            }
        }
        return e
    }, je = function (a, b, c, d, e)
    {
        b = encodeURIComponent(b);
        var f = a + "=" + b + "; ";
        c && (f += "path=" + c + "; ");
        e && (f += "expires=" + e.toGMTString() + "; ");
        var h, k;
        if ("auto" == d)
        {
            var l = Q(D.location, "host", !0).split(".");
            if (4 == l.length &&
                    /^[0-9]*$/.exec(l[3]))k = ["none"];
            else
            {
                for (var m = [], n = l.length - 2; 0 <= n; n--)m.push(l.slice(n).join("."));
                m.push("none");
                k = m
            }
        }
        else k = [d || "none"];
        h = k;
        for (var p = E.cookie, q = 0; q < h.length; q++)
        {
            var v = f, r = h[q], x = c;
            if (ge.test(D.location.hostname) || "/" == x && he.test(r))break;
            "none" != h[q] && (v += "domain=" + h[q] + ";");
            E.cookie = v;
            if (p != E.cookie || 0 <= ja(ie(a), b))break
        }
    };
    var ke = !1;
    if (E.querySelectorAll)try
    {
        var le = E.querySelectorAll(":root");
        le && 1 == le.length && le[0] == E.documentElement && (ke = !0)
    }
    catch (a)
    {
    }
    var me = ke;
    var ne = function (a)
    {
        for (var b = [], c = E.cookie.split(";"), d = new RegExp("^\\s*" + a + "=\\s*(.*?)\\s*$"), e = 0; e < c.length; e++)
        {
            var f = c[e].match(d);
            f && b.push(f[1])
        }
        var h = [];
        if (!b || 0 == b.length)return h;
        for (var k = 0; k < b.length; k++)
        {
            var l = b[k].split(".");
            3 == l.length && "GCL" == l[0] && l[1] && h.push(l[2])
        }
        return h
    };
    var oe = /^\w+$/, pe = /^[\w-]+$/, qe = /^\d+\.fls\.doubleclick\.net$/;

    function re(a)
    {
        return a && "string" == typeof a && a.match(oe) ? a : "_gcl"
    }

    function se(a)
    {
        if (a)
        {
            if ("string" == typeof a)
            {
                var b = re(a);
                return {ea: b, da: b}
            }
            if (a && "object" == typeof a)return {ea: re(a.dc), da: re(a.aw)}
        }
        return {ea: "_gcl", da: "_gcl"}
    }

    function te(a)
    {
        var b = R(D.location.href), c = Q(b, "host", !1);
        if (c && c.match(qe))
        {
            var d = Q(b, "path").split(a + "=");
            if (1 < d.length)return d[1].split(";")[0].split("?")[0]
        }
    }

    function ue(a)
    {
        return a.filter(function (a)
                        {
                            return pe.test(a)
                        })
    }

    var we = function (a)
    {
        var b = te("gclaw");
        if (b)return b.split(".");
        var c = se(a);
        if ("_gcl" == c.da)
        {
            var d = ve();
            if (d && (null == d.H || "aw.ds" == d.H))return [d.ia]
        }
        return ue(ne(c.da + "_aw"))
    }, xe = function (a)
    {
        var b = te("gcldc");
        if (b)return b.split(".");
        var c = se(a);
        if ("_gcl" == c.ea)
        {
            var d = ve();
            if (d && ("ds" == d.H || "aw.ds" == d.H))return [d.ia]
        }
        return ue(ne(c.ea + "_dc"))
    };

    function ve()
    {
        var a = R(D.location.href), b = Q(a, "query", !1, void 0, "gclid"), c = Q(a, "query", !1, void 0, "gclsrc");
        if (!b || !c)
        {
            var d = Q(a, "fragment");
            b = b || Qa(d, "gclid");
            c = c || Qa(d, "gclsrc")
        }
        return void 0 !== b && b.match(pe) ? {ia: b, H: c} : null
    }

    var ye = function (a, b, c)
    {
        var d = se(a);
        c = c || "auto";
        b = b || "/";
        var e = ve();
        if (null != e)
        {
            var f = (new Date).getTime(), h = new Date(f + 7776E6), k = ["GCL", Math.round(f / 1E3), e.ia].join(".");
            e.H && "aw.ds" != e.H || je(d.da + "_aw", k, b, c, h);
            "aw.ds" != e.H && "ds" != e.H || je(d.ea + "_dc", k, b, c, h)
        }
    }, ze = function ()
    {
        var a = te("gac");
        if (a)return decodeURIComponent(a);
        for (var b = [], c = E.cookie.split(";"), d = /^\s*_gac_(UA-\d+-\d+)=\s*(.+?)\s*$/, e = 0; e < c.length; e++)
        {
            var f = c[e].match(d);
            f && b.push({ib: f[1], value: f[2]})
        }
        var h = {};
        if (b && b.length)for (var k =
                0; k < b.length; k++)
        {
            var l = b[k].value.split(".");
            "1" == l[0] && 3 == l.length && l[1] && (h[b[k].ib] || (h[b[k].ib] = []), h[b[k].ib].push({timestamp: l[1], ia: l[2]}))
        }
        var m = [], n;
        for (n in h)if (h.hasOwnProperty(n))
        {
            for (var p = [], q = h[n], v = 0; v < q.length; v++)p.push(q[v].ia);
            p = ue(p);
            p.length && m.push(n + ":" + p.join(","))
        }
        return m.join(";")
    };
    var Ae;
    a:{
        Ae = "g";
        break a;
        Ae = "G"
    }
    var Be = {"": "n", UA: "u", AW: "a", DC: "d", GTM: Ae}, Ce = function (a)
    {
        var b = $b.A.split("-"), c = b[0].toUpperCase();
        return (Be[c] || "i") + "32" + (a && "GTM" === c ? b[1] : "")
    };
    var De = function (a)
    {
        return !(void 0 === a || null === a || 0 === (a + "").length)
    }, Ee = function (a, b)
    {
        var c;
        if (2 === b.B)return a("ord", mc(1E11, 1E13)), !0;
        if (3 === b.B)return a("ord", "1"), a("num", mc(1E11, 1E13)), !0;
        if (4 === b.B)return De(b.sessionId) && a("ord", b.sessionId), !0;
        if (5 === b.B)c = "1";
        else if (6 === b.B)c = b.Ob;
        else return !1;
        De(c) && a("qty", c);
        De(b.Qa) && a("cost", b.Qa);
        De(b.jb) && a("ord", b.jb);
        return !0
    }, Fe = encodeURIComponent, Ge = function (a, b)
    {
        function c(a, b, c)
        {
            f.hasOwnProperty(a) || (b += "", e += ";" + a + "=" + (c ? b : Fe(b)))
        }

        var d = a.Sa,
                e = a.protocol;
        e += a.Ja ? "//" + d + ".fls.doubleclick.net/activityi" : "//ad.doubleclick.net/activity";
        e += ";src=" + Fe(d) + (";type=" + Fe(a.Ta)) + (";cat=" + Fe(a.ca));
        var f = a.Fc || {}, h;
        for (h in f)f.hasOwnProperty(h) && (e += ";" + Fe(h) + "=" + Fe(f[h] + ""));
        if (Ee(c, a))
        {
            De(a.lb) && c("u", a.lb);
            De(a.tran) && c("tran", a.tran);
            c("gtm", Ce());
            if (a.Pa)
            {
                var k = xe(a.Ba);
                k && k.length && c("gcldc", k.join("."));
                var l = we(a.Ba);
                l && l.length && c("gclaw", l.join("."));
                var m = ze();
                m && c("gac", m)
            }
            De(a.$a) && c("prd", a.$a, !0);
            for (var n in a.oa)a.oa.hasOwnProperty(n) &&
            c(n, a.oa[n]);
            e += b || "";
            De(a.Ha) && c("~oref", a.Ha);
            a.Ja ? Ha(e + "?", a.K) : Ia(e + "?", a.K, a.X)
        }
        else P(a.X)
    };
    var Se = "www.googletagmanager.com/gtm.js";
    Se = "www.googletagmanager.com/gtag/js";
    var Te = Se, Ue = function (a, b, c, d)
            {
                Ja(a, b, c, d)
            }, Ve = function (a, b)
            {
                return D.setTimeout(a, b)
            }, We = function (a, b, c)
            {
                J(a, b, c)
            }, Xe = {}, Ye = function (a, b, c)
            {
                var d = Xe[a];
                if (void 0 === d)
                {
                    var e = function (a, b)
                    {
                        return function ()
                        {
                            a.status = b;
                            for (var c = 2 == b ? a.Rb : a.yb, d = 0; d < c.length; d++)D.setTimeout(c[d], 0)
                        }
                    };
                    d = {status: 1, Rb: [], yb: [], Ed: void 0};
                    d.ee = J(a, e(d, 2), e(d, 3));
                    Xe[a] = d
                }
                0 === d.status && (d.Ed(), d.status = 2);
                2 === d.status ? b && b() : 3 === d.status ? c && c() : 1 === d.status && (b && d.Rb.push(b), c && d.yb.push(c))
            }, Ze = function ()
            {
                return D.location.href
            },
            $e = function (a)
            {
                return Q(R(a), "fragment")
            }, V = function (a, b)
            {
                return wc(a, b || 2)
            }, af = function (a, b, c)
            {
                b && (a.eventCallback = b, c && (a.eventTimeout = c));
                return D["dataLayer"].push(a)
            }, bf = function (a, b)
            {
                D[a] = b
            }, W = function (a, b, c)
            {
                b && (void 0 === D[a] || c && !D[a]) && (D[a] = b);
                return D[a]
            }, cf = function (a, b)
            {
                var c;
                a:{
                    var d;
                    d = 100;
                    for (var e = {}, f = 0; f < b.length; f++)e[b[f]] = !0;
                    for (var h = a, k = 0; h && k <= d; k++)
                    {
                        if (e[String(h.tagName).toLowerCase()])
                        {
                            c = h;
                            break a
                        }
                        h = h.parentElement
                    }
                    c = null
                }
                return c
            }, X = function (a, b, c, d)
            {
                var e = !d && "http:" ==
                        D.location.protocol;
                e && (e = 2 !== df());
                return (e ? b : a) + c
            };
    var ef = function (a)
    {
        var b = 0;
        return b
    }, ff = function (a)
    {
    }, gf = function (a)
    {
        var b = !1;
        return b
    }, hf = function (a, b)
    {
        var c;
        a:{
            if (a &&
                    ia(a))for (var d = 0; d < a.length; d++)if (a[d] && b(a[d]))
            {
                c = a[d];
                break a
            }
            c = void 0
        }
        return c
    }, jf = function (a, b, c, d)
    {
        ee(a, b, c, d)
    }, kf = function (a, b, c)
    {
        return fe(a, b, c)
    }, lf = function (a)
    {
        return !!fe(a, "init", !1)
    }, mf = function (a)
    {
        de(a).init = !0
    };
    var of = void 0, pf = function (a)
    {
        if (!of)
        {
            var b = function ()
            {
                var a = E.body;
                if (a)if (W("MutationObserver"))(new MutationObserver(function ()
                {
                    for (var a = 0; a < of.length; a++)P(of[a])
                })).observe(a, {childList: !0, subtree: !0});
                else
                {
                    var b = !1;
                    Ue(a, "DOMNodeInserted", function ()
                    {
                        b || (b = !0, P(function ()
                                        {
                                            b = !1;
                                            for (var a = 0; a < of.length; a++)P(of[a])
                                        }))
                    })
                }
            };
            of = [];
            E.body ? b() : P(b)
        }
        of.push(a)
    }, df = function ()
    {
        var a = Te;
        a = a.toLowerCase();
        for (var b = "https://" + a, c = "http://" + a, d = 1, e = E.getElementsByTagName("script"), f = 0; f < e.length && 100 > f; f++)
        {
            var h =
                    e[f].src;
            if (h)
            {
                h = h.toLowerCase();
                if (0 === h.indexOf(c))return 3;
                1 === d && 0 === h.indexOf(b) && (d = 2)
            }
        }
        return d
    };
    var qf = function (a, b)
    {
        return yc(a, b, void 0)
    };
    var rf = function (a)
    {
        var b = Te + "?id=" + encodeURIComponent(a) + "&l=dataLayer", c = X("https://", "http://", b);
        J(c, void 0, void 0)
    };
    var tf = function (a, b, c)
    {
        a instanceof T.$b && (a = a.resolve(T.yd(b, c)), b = ec);
        return {Ua: a, K: b}
    };
    var Z = {a: {}};

    Z.a.e = ["google"], function ()
    {
        (function (a)
        {
            Z.__e = a;
            Z.__e.b = "e";
            Z.__e.g = !0
        })(function ()
           {
               return bc
           })
    }();
    Z.a.v = ["google"], function ()
    {
        (function (a)
        {
            Z.__v = a;
            Z.__v.b = "v";
            Z.__v.g = !0
        })(function (a)
           {
               var b = V(a.vtp_name.replace(/\\\./g, "."), a.vtp_dataLayerVersion || 1);
               return void 0 !== b ? b : a.vtp_defaultValue
           })
    }();
    Z.a.gtagaw = ["google"], function ()
    {
        var a = !1, b = !1, c = [], d = "send_to aw_remarketing aw_remarketing_only custom_params send_page_view language value currency transaction_id user_id conversion_linker conversion_cookie_prefix page_location page_referrer phone_conversion_number phone_conversion_callback phone_conversion_css_class items aw_merchant_id aw_feed_country aw_feed_language discount transaction_id enable_mrc".split(" "), e = function (a)
        {
            var b = W("google_trackConversion"), c = a.gtm_onFailure;
            "function" == typeof b ? b(a) || c() : c()
        }, f = function ()
        {
            for (; 0 < c.length;)e(c.shift())
        }, h = function ()
        {
            a || (a = !0, We(X("https://", "http://", "www.googleadservices.com/pagead/conversion_async.js"), function ()
            {
                f();
                c = {push: e}
            }, function ()
                             {
                                 f();
                                 a = !1
                             }))
        }, k = function (a, c, d, e)
        {
            if (c)
            {
                var f = a.ka[0], h = a.ka[1], k = W("_googWcmImpl", function ()
                {
                    k.q = k.q || [];
                    k.q.push(arguments)
                });
                W("_googWcmAk", f);
                b || (b = !0, We(X("https://", "http://", "www.gstatic.com/wcm/loader.js")));
                var l = {ak: f, cl: h};
                void 0 === d && (l.autoreplace = c);
                k(2, d, l, c, e, new Date, e)
            }
        }, l = function (a)
        {
            if (a)
            {
                for (var b =
                        [], c = 0; c < a.length; ++c)
                {
                    var d = a[c];
                    d && b.push({item_id: d.id, quantity: d.quantity, value: d.price})
                }
                return b
            }
        };
        (function (a)
        {
            Z.__gtagaw = a;
            Z.__gtagaw.b = "gtagaw";
            Z.__gtagaw.g = !0
        })(function (a)
           {
               var b = a.vtp_conversionId, e = bc, f = "gtag.config" == e, m = b.ka[0], r = b.ka[1], x = void 0 !== r, F = b.containerId, Y = x ? b.id : void 0, A = function (a)
               {
                   return yc(a, F, Y)
               }, M = !1 !== A("conversion_linker"), C = A("conversion_cookie_prefix");
               f && M && ye(C, void 0, void 0);
               if (f && x)
               {
                   var N = A("phone_conversion_number"), I = A("phone_conversion_callback"), K = A("phone_conversion_css_class"),
                           G = A("phone_conversion_options");
                   k(b, N, I || K, G)
               }
               var L = !1 === A("aw_remarketing") || !1 === A("send_page_view");
               if (!f || !x && !L)
               {
                   !0 === A("aw_remarketing_only") && (x = !1);
                   var H = {
                       google_conversion_id: m,
                       google_remarketing_only: !x,
                       onload_callback: a.vtp_gtmOnSuccess,
                       gtm_onFailure: a.vtp_gtmOnFailure,
                       google_conversion_format: "3",
                       google_conversion_color: "ffffff",
                       google_conversion_domain: "",
                       google_conversion_label: r,
                       google_conversion_language: A("language"),
                       google_conversion_value: A("value"),
                       google_conversion_currency: A("currency"),
                       google_conversion_order_id: A("transaction_id"),
                       google_user_id: A("user_id"),
                       google_conversion_page_url: A("page_location"),
                       google_conversion_referrer_url: A("page_referrer"),
                       google_gtm: Ce(void 0),
                       google_read_gcl_cookie_opt_out: !M
                   };
                   M && C && (qa(C) ? H.google_gcl_cookie_prefix = C.aw : H.google_gcl_cookie_prefix = C);
                   var O = function ()
                   {
                       var a = A("custom_params"), b = {event: e};
                       if (ia(a))
                       {
                           for (var c = 0; c < a.length; ++c)
                           {
                               var f = a[c], h = A(f);
                               void 0 !== h && (b[f] = h)
                           }
                           return b
                       }
                       var k = A("eventModel");
                       if (!k)return null;
                       ra(k, b);
                       for (var l =
                               0; l < d.length; ++l)delete b[d[l]];
                       return b
                   }();
                   O && (H.google_custom_params = O);
                   if (x && "purchase" == e && A("aw_merchant_id"))
                   {
                       H.google_conversion_merchant_id = A("aw_merchant_id");
                       H.google_basket_feed_country = A("aw_feed_country");
                       H.google_basket_feed_language = A("aw_feed_language");
                       H.google_basket_discount = A("discount");
                       H.google_basket_transaction_type = e;
                       H.google_disable_merchant_reported_conversions = !0 !== A("enable_mrc");
                       var S = l(A("items"));
                       S && (H.google_conversion_items = S)
                   }
                   c.push(H)
               }
               h()
           })
    }();


    Z.a.gtagfl = [], function ()
    {
        function a(a)
        {
            var b = /^DC-(\d+)(\/([\w-]+)\/([\w-]+)\+(\w+))?$/.exec(a);
            if (b)
            {
                var c = {standard: 2, unique: 3, per_session: 4, transactions: 5, items_sold: 6, "": 1}[(b[5] || "").toLowerCase()];
                if (c)return {containerId: "DC-" + b[1], Sb: b[3] ? a : "", cc: b[1], bc: b[3] || "", ca: b[4] || "", B: c}
            }
        }

        function b(a, b)
        {
            function c(b, c, e)
            {
                void 0 !== e && 0 !== (e + "").length && d.push(b + c + ":" + a(e + ""))
            }

            var d = [], e = b("items") || [];
            if (ia(e))for (var l = 0; l < e.length; l++)
            {
                var m = e[l], n = l + 1;
                c("i", n, m.id);
                c("p", n, m.price);
                c("q", n, m.quantity);
                c("c", n, b("country"));
                c("l", n, b("language"))
            }
            return d.join("|")
        }

        function c(a, b, c)
        {
            var d = /^u([1-9]\d?|100)$/, e = a("custom_map") || {}, f = Bc(b, c), m = {}, n = {};
            if (qa(e))for (var p in e)if (e.hasOwnProperty(p) && d.test(p))
            {
                var q = e[p];
                gc(q) && (m[p] = q)
            }
            for (var v = 0; v < f.length; v++)
            {
                var r = f[v];
                d.test(r) && (m[r] = r)
            }
            for (var x in m)m.hasOwnProperty(x) && (n[x] = a(m[x]));
            return n
        }

        (function (a)
        {
            Z.__gtagfl = a;
            Z.__gtagfl.b = "gtagfl";
            Z.__gtagfl.g = !0
        })(function (d)
           {
               var e = d.vtp_gtmOnSuccess, f = d.vtp_gtmOnFailure, h = a(d.vtp_targetId);
               if (h)
               {
                   var k =
                           function (a)
                           {
                               return yc(a, h.containerId, h.Sb || void 0)
                           }, l = !1 !== k("conversion_linker"), m = k("conversion_cookie_prefix");
                   if ("gtag.config" === bc)l && ye(m, void 0, void 0), P(e);
                   else
                   {
                       var n = {}, p = k("dc_custom_params");
                       if (qa(p))for (var q in p)if (p.hasOwnProperty(q))
                       {
                           var v = p[q];
                           void 0 !== v && null !== v && (n[q] = v)
                       }
                       var r = "";
                       if (5 === h.B || 6 === h.B)r = b(Yd, k);
                       var x = c(k, h.containerId, h.Sb), F = 3 === df(), Y = !0 === k("allow_custom_scripts"), A = {
                           ca: h.ca,
                           Pa: l,
                           Ba: m,
                           Qa: k("value"),
                           B: h.B,
                           Fc: n,
                           Sa: h.cc,
                           Ta: h.bc,
                           X: f,
                           K: e,
                           Ha: Ra(R(Ze())),
                           $a: r,
                           protocol: F ?
                                   "http:" : "https:",
                           Ob: k("quantity"),
                           Ja: Y,
                           sessionId: k("session_id"),
                           jb: k("transaction_id"),
                           oa: x
                       };
                       Ge(A, void 0)
                   }
               }
               else P(f)
           })
    }();


    Z.a.gtagua = ["google"], function ()
    {
        var a, b = {
                    client_id: 1,
                    client_storage: "storage",
                    cookie_name: 1,
                    cookie_domain: 1,
                    cookie_expires: 1,
                    cookie_update: 1,
                    sample_rate: 1,
                    site_speed_sample_rate: 1,
                    use_amp_client_id: 1,
                    store_gac: 1,
                    conversion_linker: "storeGac"
                }, c = {
                    anonymize_ip: 1,
                    app_id: 1,
                    app_installer_id: 1,
                    app_name: 1,
                    app_version: 1,
                    campaign: {
                        name: "campaignName",
                        source: "campaignSource",
                        medium: "campaignMedium",
                        term: "campaignTerm",
                        content: "campaignContent",
                        id: "campaignId"
                    },
                    currency: "currencyCode",
                    description: "exDescription",
                    fatal: "exFatal",
                    language: 1,
                    non_interaction: 1,
                    page_hostname: "hostname",
                    page_referrer: "referrer",
                    page_path: "page",
                    page_location: "location",
                    page_title: "title",
                    screen_name: 1,
                    transport_type: "transport",
                    user_id: 1
                }, d = {
                    content_id: 1,
                    event_category: 1,
                    event_action: 1,
                    event_label: 1,
                    link_attribution: 1,
                    linker: 1,
                    method: 1,
                    name: 1,
                    send_page_view: 1,
                    value: 1
                }, e = {cookie_name: 1, cookie_expires: "duration", levels: 1}, f = {
                    anonymize_ip: 1,
                    fatal: 1,
                    non_interaction: 1,
                    use_amp_client_id: 1,
                    send_page_view: 1,
                    store_gac: 1,
                    conversion_linker: 1
                },
                h = function (a, b, c, d)
                {
                    if (void 0 !== c)if (f[b] && (c = jc(c)), "anonymize_ip" != b || c || (c = void 0), 1 === a)d[k(b)] = c;
                    else if (gc(a))d[a] = c;
                    else for (var e in a)a.hasOwnProperty(e) && void 0 !== c[e] && (d[a[e]] = c[e])
                }, k = function (a)
                {
                    return a && gc(a) ? a.replace(/(_[a-z])/g, function (a)
                    {
                        return a[1].toUpperCase()
                    }) : a
                }, l = function (a, b, c)
                {
                    a.hasOwnProperty(b) || (a[b] = c)
                }, m = function (a, e, f)
                {
                    var k = {}, m = {}, n = {}, p = qf("custom_map", a);
                    if (qa(p))for (var q in p)if (p.hasOwnProperty(q) && /^(dimension|metric)\d+$/.test(q))
                    {
                        var r = qf(p[q], a);
                        void 0 !==
                        r && l(m, q, r)
                    }
                    for (var x = Bc(a, void 0), v = 0; v < x.length; ++v)
                    {
                        var G = x[v], L = qf(G, a);
                        d.hasOwnProperty(G) ? h(d[G], G, L, k) : c.hasOwnProperty(G) ? h(c[G], G, L, m) : b.hasOwnProperty(G) ? h(b[G], G, L, n) : /^(dimension|metric|content_group)\d+$/.test(G) && h(1, G, L, m)
                    }
                    var H = String(bc);
                    l(n, "cookieDomain", "auto");
                    l(m, "forceSSL", !0);
                    var O = "general";
                    0 <= be("add_payment_info add_to_cart add_to_wishlist begin_checkout checkout_progress purchase refund remove_from_cart set_checkout_option".split(" "), H) ? O = "ecommerce" : 0 <= be("generate_lead login search select_content share sign_up view_item view_item_list view_promotion view_search_results".split(" "),
                                                                                                                                                                                                            H) ? O = "engagement" : "exception" == H && (O = "error");
                    l(k, "eventCategory", O);
                    0 <= be(["view_item", "view_item_list", "view_promotion", "view_search_results"], H) && l(m, "nonInteraction", !0);
                    "login" == H || "sign_up" == H || "share" == H ? l(k, "eventLabel", qf("method", a)) : "search" == H || "view_search_results" == H ? l(k, "eventLabel", qf("search_term", a)) : "select_content" == H && l(k, "eventLabel", qf("content_type", a));
                    var S = k.linker || {};
                    if (S.accept_incoming || 0 != S.accept_incoming && S.domains)n.allowLinker = !0;
                    !1 === qf("allow_display_features",
                              a) && (m.displayFeaturesTask = null);
                    n.name = e;
                    m["&gtm"] = Ce(!0);
                    m.hitCallback = f;
                    k.G = m;
                    k.wb = n;
                    return k
                }, n = function (a)
                {
                    function b(a)
                    {
                        var b = ra(a, void 0);
                        b.list = a.list_name;
                        b.listPosition = a.list_position;
                        b.position = a.list_position || a.creative_slot;
                        b.creative = a.creative_name;
                        return b
                    }

                    function c(a)
                    {
                        for (var c = [], d = 0; a && d < a.length; d++)a[d] && c.push(b(a[d]));
                        return c.length ? c : void 0
                    }

                    function d()
                    {
                        return {
                            id: e("transaction_id"),
                            affiliation: e("affiliation"),
                            revenue: e("value"),
                            tax: e("tax"),
                            shipping: e("shipping"),
                            coupon: e("coupon"),
                            list: e("list_name")
                        }
                    }

                    var e = function (b)
                    {
                        return yc(b, a, void 0)
                    }, f = e("items"), h = e("custom_map");
                    if (qa(h))for (var k = 0; f && k < f.length; ++k)
                    {
                        var m = f[k], n;
                        for (n in h)h.hasOwnProperty(n) && /^(dimension|metric)\d+$/.test(n) && l(m, n, m[h[n]])
                    }
                    var p = null, q = bc, v = e("promotions");
                    "purchase" == q || "refund" == q ? p = {action: q, ba: d(), Y: c(f)} : "add_to_cart" == q ? p = {
                        action: "add",
                        Y: c(f)
                    } : "remove_from_cart" == q ? p = {action: "remove", Y: c(f)} : "view_item" == q ? p = {
                        action: "detail",
                        ba: d(),
                        Y: c(f)
                    } : "view_item_list" == q ? p = {action: "impressions", ad: c(f)} :
                            "view_promotion" == q ? p = {
                                action: "promo_view",
                                ab: c(v)
                            } : "select_content" == q && v && 0 < v.length ? p = {
                                action: "promo_click",
                                ab: c(v)
                            } : "select_content" == q ? p = {
                                action: "click",
                                ba: {list: e("list_name")},
                                Y: c(f)
                            } : "begin_checkout" == q || "checkout_progress" == q ? p = {
                                action: "checkout",
                                Y: c(f),
                                ba: {step: "begin_checkout" == q ? 1 : e("checkout_step"), option: e("checkout_option")}
                            } : "set_checkout_option" == q && (p = {action: "checkout_option", ba: {step: e("checkout_step"), option: e("checkout_option")}});
                    p && (p.Vd = e("currency"));
                    return p
                }, p = {}, q = function (a,
                                         b)
                {
                    var c = p[a];
                    p[a] = ra(b, void 0);
                    if (!c)return !1;
                    for (var d in b)if (b.hasOwnProperty(d) && b[d] !== c[d])return !0;
                    for (d in c)if (c.hasOwnProperty(d) && c[d] !== b[d])return !0;
                    return !1
                };
        (function (a)
        {
            Z.__gtagua = a;
            Z.__gtagua.b = "gtagua";
            Z.__gtagua.g = !0
        })(function (b)
           {
               var c = b.vtp_trackingId, d = Rc(void 0), f = "gtag_" + c.split("-").join("_"), p = function (a)
               {
                   var b = [].slice.call(arguments, 0);
                   b[0] = f + "." + b[0];
                   d.apply(window, b)
               }, v = function ()
               {
                   var a = function (a, b)
                   {
                       for (var c = 0; b && c < b.length; c++)p(a, b[c])
                   }, b = n(c);
                   if (b)
                   {
                       var d = b.action;
                       if ("impressions" == d)a("ec:addImpression", b.ad);
                       else if ("promo_click" == d || "promo_view" == d)
                       {
                           var e = b.ab;
                           a("ec:addPromo", b.ab);
                           e && 0 < e.length && "promo_click" == d && p("ec:setAction", d)
                       }
                       else a("ec:addProduct", b.Y), p("ec:setAction", d, b.ba)
                   }
               }, M = function ()
               {
                   var a = qf("optimize_id", c);
                   a && (p("require", a, {dataLayer: "dataLayer"}), p("require", "render"))
               }, C = m(c, f, b.vtp_gtmOnSuccess);
               q(f, C.wb) && d(function ()
                               {
                                   Sc() && Sc().remove(f)
                               });
               d("create", c, C.wb);
               (function ()
               {
                   var a = qf("custom_map", c);
                   d(function ()
                     {
                         if (qa(a))
                         {
                             var b =
                                     C.G, c = Sc().getByName(f), d;
                             for (d in a)if (a.hasOwnProperty(d) && /^(dimension|metric)\d+$/.test(d))
                             {
                                 var e = c.get(k(a[d]));
                                 l(b, d, e)
                             }
                         }
                     })
               })();
               (function (a)
               {
                   if (a)
                   {
                       var b = {};
                       if (qa(a))for (var c in e)e.hasOwnProperty(c) && h(e[c], c, a[c], b);
                       p("require", "linkid", b)
                   }
               })(C.linkAttribution);
               var N = C.linker;
               N && N.domains && Tc(f + ".", N.domains, !!N.use_anchor, !!N.decorate_forms);
               var I = function (a, b, c)
               {
                   c && (b = "" + b);
                   C.G[a] = b
               }, K = bc;
               "page_view" == K ? (M(), p("send", "pageview", C.G)) : "gtag.config" == K ? 0 != C.sendPageView && (M(), p("send", "pageview",
                                                                                                                          C.G)) : "screen_view" == K ? p("send", "screenview", C.G) : "timing_complete" == K ? (I("timingCategory", C.eventCategory, !0), I("timingVar", C.name, !0), I("timingValue", ic(C.value)), void 0 !== C.eventLabel && I("timingLabel", C.eventLabel, !0), p("send", "timing", C.G)) : "exception" == K ? p("send", "exception", C.G) : (0 <= be("view_item_list select_content view_item add_to_cart remove_from_cart begin_checkout set_checkout_option purchase refund view_promotion checkout_progress".split(" "), K) && (p("require", "ec", "ec.js"), v()), I("eventCategory",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             C.eventCategory, !0), I("eventAction", C.eventAction || K, !0), void 0 !== C.eventLabel && I("eventLabel", C.eventLabel, !0), void 0 !== C.value && I("eventValue", ic(C.value)), p("send", "event", C.G));
               a || (a = !0, We("https://www.google-analytics.com/analytics.js", function ()
               {
                   Sc().loaded || b.vtp_gtmOnFailure()
               }, b.vtp_gtmOnFailure))
           })
    }();

    var uf = {
        macro: function (a)
        {
            if (T.Ma.hasOwnProperty(a))return T.Ma[a]
        }
    };
    uf.dataLayer = xc;
    uf.onHtmlSuccess = T.vb(!0);
    uf.onHtmlFailure = T.vb(!1);
    uf.callback = function (a)
    {
        cc.hasOwnProperty(a) && fc(cc[a]) && cc[a]();
        delete cc[a]
    };
    uf.oc = function ()
    {
        ac[$b.A] = uf;
        dc = Z.a;
        Pb = Pb || T
    };
    uf.bd = function ()
    {
        ac = D.google_tag_manager = D.google_tag_manager || {};
        if (ac[$b.A])
        {
            var a = ac.zones;
            a && a.unregisterChild($b.A)
        }
        else
        {
            for (var b = data.resource || {}, c = b.macros || [], d = 0; d < c.length; d++)Ib.push(c[d]);
            for (var e = b.tags || [], f = 0; f < e.length; f++)Lb.push(e[f]);
            for (var h = b.predicates || [], k = 0; k < h.length; k++)Kb.push(h[k]);
            for (var l = b.rules || [], m = 0; m < l.length; m++)
            {
                for (var n = l[m], p = {}, q = 0; q < n.length; q++)p[n[q][0]] = Array.prototype.slice.call(n[q], 1);
                Jb.push(p)
            }
            Nb = Z;
            Wd();
            uf.oc();
            Dd();
            Kc = !1;
            Lc = 0;
            if ("interactive" ==
                    E.readyState && !E.createEventObject || "complete" == E.readyState)Nc();
            else
            {
                Ja(E, "DOMContentLoaded", Nc);
                Ja(E, "readystatechange", Nc);
                if (E.createEventObject && E.documentElement.doScroll)
                {
                    var v = !0;
                    try
                    {
                        v = !D.frameElement
                    }
                    catch (x)
                    {
                    }
                    v && Oc()
                }
                Ja(D, "load", Nc)
            }
            vd = !1;
            "complete" === E.readyState ? xd() : Ja(D, "load", xd);
        }
    };
    uf.bd();

})()