Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526778;
	b=sAYiKcnFkabKzxYmdw3WtjO5g0jbaH4OVtUwPSx4rlDiT7h1MJHEZvJSLJR0TZeBGVjw
	 RSqsUpZv5zywleyzvANovTtqHsQpV2kWcz6+eGN47rz/suef5s+E7TeQ7ONvUuja/9oOw
	 pYTvZelZNuZg153pQyHP/H4HOrh+mFvMwg5UAJMFoKSX4hBEFq+QF1fdHTvuftvWcrzkV
	 YL+++6+8DZq6iJsBHPMrQ+CMSeJ2MICj6SNAF9tMdObF8NfGr/cOELLFoja8PXRuyEaNV
	 qdCYtNkYY19nxN1xL3EEMbBl6PUNRsR+o+vnTbFntJVJ4CgeuHgKKVxMz10VsLiTKtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526778;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lPXR/ZYc2I7ez6L6FEiNKVXHMQzIEPgjNzFczDrA9e4=;
	b=EDYhR1vMUj0VdPH8eQGx82+CQ8V+LqvzZrWgM3XmK7R7xnY2Zm7XKRGu5uwoY5L06wCD
	 36lW/4zVum0hgy6BMwVl3lnGx3aI3tYgVH4r4+tUnLx6dyJs97VJtUDlzUWLXCHAql27G
	 UjMh+IWv5klSAen2yKckntts+XQc7YG4SsVGuHOPzYXYRK/nnoXTi2agrR7LdPudgdwQk
	 FBUdYLm0avyFDk+Hf7I+hyYv4tVFp9gzA5zSB1Ct2fysXDAL7Ca0LMMllH1KoVADoxbLd
	 68SkODD38sLnvPXp0ydvJVyMzxNf2rizV7jOi2ZNrze3lfgDioBcFDfM5Wj1i7stA0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Za0AvD2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5E606A31E;
	Tue, 24 Nov 2026 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Za0AvD2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A468F1F000C4;
	Tue, 24 Nov 2026 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526778;
	bh=lPXR/ZYc2I7ez6L6FEiNKVXHMQzIEPgjNzFczDrA9e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Za0AvD2/0vOeE2ptr7m2s3lOgjVlEs6UwEfLakICSb9xznNTROxBLXakZT6elpmbz
	 962kWesctGZbr93kN1BE2kf/Tc76Bi1iiJ14bhE99LvKp/NJkswPSIf2dQsw279shV
	 /KM+b+Ms+ZVKLJn1xvVYhuap7K+CbBC4jm5qLDpdyFhafJJW76zKbMSIu63Vh/plkr
	 +YwpxVKg5KQ0NzGu+t6ufN5Qgf6QWdt79Na+DE0NRboXTw0K7JoGpqrz1M+F0TNxaM
	 4eKhyBDT77watxMSKL5jTL2LWTG45be+bSqV5QDng7Glc7YdGT0EbvjSGzhKo6NcQh
	 QO/K+UPsNqGsQ==
Date: Tue, 24 Nov 2026 14:26:12 +0100
From: Joel Granados <joel.granados@kernel.org>
To: wen.yang@linux.dev
Cc: David Laight <david.laight.linux@gmail.com>, 
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/6] sysctl: replace overloaded extra pointers
 with typed bounds and core stride
Message-ID: <awV04op6IxD2NWQA@hobbes>
References: <cover.1794844686.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g2m7r27qa7zhkbsf"
Content-Disposition: inline
In-Reply-To: <cover.1794844686.git.wen.yang@linux.dev>


--g2m7r27qa7zhkbsf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 0/6] sysctl: replace overloaded extra pointers
 with typed bounds and core stride
MIME-Version: 1.0

On Tue, Nov 17, 2026 at 12:07:32AM +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
Thx for taking the time to put this out. This gives perspective and adds
to the discussion of how best to move forward with "struct ctl_table".

>=20
> struct ctl_table has long relied on extra1 and extra2 pointers to serve
> multiple unrelated duties, including range limits and caller-specific
> context.  This series addresses both:
>=20
> 1. Replace bound pointers with plain unsigned long min and max fields
>    directly in struct ctl_table.
>=20
> 2. Replace per-entry context pointers with a core stride mechanism,
>    allowing callers to register arrays of structures embedding struct
>    ctl_table and recover enclosing context via standard container_of().
I think having these two at the same time is not the way to go. We need
to figure out where to put the non-bound context pointers first. And
after that is settled, we address the bound pointers.

Yes, we are doing the first to get to the later, but mixing them just
adds to the confusion. One thing at a time!

>=20
> This RFC focuses on the core stride infrastructure and two representative
> complex users (netfilter nf_log and IPv4 devinet), as suggested by Joel
> Granados.  The remaining treewide callers are converted in a single
My suggestion was **not** for this implementation specifically. I
suggested you create an RFC to clearly understand your idea. Apologies
if that was not clear.

> squashed commit to ensure the tree builds and tests pass cleanly.
>=20
> Changes from v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> v1: https://lore.kernel.org/all/cover.1793204511.git.wen.yang@linux.dev/
>=20
> 1. Abandoned per-entry 'void *priv' (David Laight):
Though not adding yet another entry in ctl_table is commendable, I
prefer adding a priv entry over the stride mechanism in this series.
Here are my thoughts:

1. The type should set the stride in sysctl core. The situation where
   the stride of a type might be different from its size should be avoided.
   In these cases I would prefer a whole new type.

2. Having ctl_table as the grounding entry inside another struct and, at
   the same time, it be a regular (non-grounding) entry is asking for
   trouble.
   - A proc_handler assumes there is a containing entry around only to
     realize that it was passed just a pointer.
   - The core might start overlaying clt_table entries to deal with
     namespaces [1], [2], [3]

>    - v1 added 'priv' to struct ctl_table, incurring 8 bytes on 64-bit and
>      4 bytes on 32-bit for all ~1,000 entries across thousands of dynamic
>      instances, even though <7% of entries need context.
Just a quick comment here: If you want to get rid of 8/4 bytes with the
ctl_table struct, you might want to look at struct ctl_table_poll, which
(to my knowledge) is only used in one ctl_table array. Finding a way to
service utsname while at the same time removing that entry is much more
of a low hanging fruit IMO.

>    - Refactor: context lives outside struct ctl_table via core stride;
>      callers embed ctl_table at offset 0 of their own record and recover
>      context with standard container_of().
>    - Cost: zero growth in struct ctl_table (56/32 bytes) and zero growth
>      in struct ctl_table_header (88/52 bytes, packing u16 stride and type=
).
>=20
> 2. Eliminated slot wrappers & index coupling (Joel Granados, David Laight=
):
>    - An intermediate prototype discussed on the list used slot-indexed
>      container recovery, requiring 32 wrapper functions in devinet and 11
>      in nf_log.
>    - Refactor: with core stride, the core passes the exact registered
>      entry pointer to the handler, so handlers use container_of() directly
>      and all 43 wrappers disappear without touching proc_handler
>      signatures.
>=20
> 3. KUnit purity & dependency fix (0-day robot):
>    - Removed register_sysctl() calls from KUnit; tests invoke
>      proc_handler directly so no live /proc/sys nodes are modified.
>    - Added 'depends on SYSCTL' to SYSCTL_KUNIT_TEST in lib/Kconfig.debug,
>      fixing undefined symbols when built as a module with SYSCTL=3Dn.
>=20
> 4. Baseline rebase & conflict resolution:
>    - Rebased onto next-20261111 (aaa2f954c21b).
Thx for clarifying the base. It really helps with rebasing and
reviewing. Personally I prefer it be on top of one of the "rc"
candidates (like 7.4-rc3); with the only exception of dependencies
existing in next. Also, rebasing on the "rc" candidates might be easier
for sashiko to understand [4]=20

>    - Added proc_dointvec_jiffies_minmax and proc_dointvec_ms_jiffies_minm=
ax
>      to sysctl_check_table().
>=20
> 5. Added Coccinelle verification script (Joel Granados):
>    - A 17-rule script (patch and context modes) maps all 15 SYSCTL_*
>      constants through one lookup table instead of repeating two rules
>      per constant.
>    - Bounds that point at a variable (&foo_min, &foo_max) are left
>      untouched and reported: in several callers (power/main.c, i915_perf,
>      ipc_sysctl, pid, sched/rt, rds, xprtsock) that variable is updated
>      at boot or at run time, so inlining its initial value would silently
>      freeze a live bound.  The script also flags .min/.max fields holding
>      a pointer or a legacy macro.
>=20
> 6. Streamlined RFC series layout (Joel Granados):
>    - Reduced from 39 patches in v1 to 6 focused patches (core
>      infrastructure, unit test, two complex stride consumers, coccinelle
>      script.
Very nice!. This meant that I could just ignore that last commit and
focus on the core of your idea.

>=20
> Key Design Points:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 1. Zero Memory Growth:
>    - struct ctl_table keeps its exact size (56 bytes on 64-bit, 32 bytes =
on
>      32-bit). No 'priv' field is added.
>    - u16 ctl_table_stride is introduced into struct ctl_table_header.
>      Together with u16 type, it occupies the existing alignment padding
>      hole on 64-bit (88 bytes unchanged) and keeps 52 bytes on 32-bit.
>      Registration rejects stride values that exceed U16_MAX.
>    - Headers are allocated once per table registration (~240 sites
>      in-tree), not per entry (thousands in-tree).
>=20
> 2. Eliminates some Wrapper Functions:
>    - net/ipv4 devinet: registers strided struct devinet_sysctl_entry,
>      eliminating 32 per-attribute wrapper functions.
>    - Handlers recover their context using standard container_of() without
>      changing any proc_handler signatures.
>=20
> 3. Standalone Stride API vs. Existing _sz:
>    register_sysctl_stride() and register_net_sysctl_stride() are added
>    alongside register_*_sz() so existing callers remain untouched.  If
>    preferred, stride can instead be folded into register_*_sz() as an
>    element-size parameter (similar to bsearch()).
>=20
> 4. Fixes & Cleanups:
>    - Fixes net.core sysctl write permissions in init_net (mode 0222 is
>      now cleared only for non-init network namespaces).
>    - Cleans up redundant '.min =3D 0' initializers treewide.
>    - Provides a Coccinelle script (scripts/coccinelle/api/sysctl/) for
>      automated conversion and proof of no leftover extra1/extra2 uses.

Did you consider the relation between the stride approach and namespaces?
The network subsys duplicates ctl_table arrays to have a unique value
per namespace. Would this still be possible with the stride approach?
Would it be orthogonal?

>=20
> Series Structure:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Patch 1: Core stride infrastructure and numeric bounds.
> - Patch 2: KUnit unit test coverage (21 tests, pure handler execution).
> - Patch 3: netfilter nf_log stride migration (11 wrappers removed).
> - Patch 4: net/ipv4 devinet stride migration (32 wrappers removed).
> - Patch 5: Coccinelle script for detection and conversion.
>=20
> Testing:
> =3D=3D=3D=3D=3D=3D=3D=3D
> - KUnit sysctl_test: pass:21 fail:0 (UML).
> - x86_64 defconfig build of kernel/, fs/proc/, net/ passed.
> - Coccinelle: full-tree MODE=3Dcontext finds 0 leftovers after conversion
>   and 822 before it; MODE=3Dpatch converts the legacy net/unix table.
>=20
>=20
> Wen Yang (5):
>   sysctl: add numeric bounds and core stride infrastructure
>   sysctl: cover numeric bounds and table containers in KUnit
>   netfilter: embed logger sysctl context using stride
>   net/ipv4: embed device sysctl context using stride
>   scripts/coccinelle: add script to detect and convert sysctl bounds
>=20
>  fs/proc/proc_sysctl.c                         |  82 +-
>  include/linux/sysctl.h                        |  43 +-
>  include/net/net_namespace.h                   |  10 +
>  kernel/sysctl-test.c                          | 776 +++++++++++++++++-
>  kernel/sysctl.c                               |  38 +-
>  lib/Kconfig.debug                             |   1 +
>  net/ipv4/devinet.c                            | 190 +++--
>  net/netfilter/nf_log.c                        |  84 +-
>  net/sysctl_net.c                              |  31 +-
>  .../api/sysctl/sysctl_numeric_bounds.cocci    | 276 +++++++
>  10 files changed, 1339 insertions(+), 192 deletions(-)
>  create mode 100644 scripts/coccinelle/api/sysctl/sysctl_numeric_bounds.c=
occi
>=20
> base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
> --=20
> 2.25.1
>=20

Thanks for working this through, and for reducing it to the real users;
that is what made the trade-offs visible. Having now understood your
idea, I don't think it is the right direction and would rather not take
it into the sysctl tree.

Best

[1] https://lore.kernel.org/all/cover.1787770053.git.legion@kernel.org
[2] https://lore.kernel.org/all/cover.1789987960.git.legion@kernel.org
[3] https://lore.kernel.org/all/cover.1790439358.git.legion@kernel.org
[4] https://sashiko.dev/#/patchset/cover.1794844686.git.wen.yang%40linux.dev

--g2m7r27qa7zhkbsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmsFkGwACgkQupfNUreW
QU+wrgv/ZpvL/qXmowA+P6iI7nl02GIjseWNl+o0GUb0d7L57nJr9f8v5vhF7CNV
hizLGRvuTWuGvcLcWtPMd3smExu00Huv8/wYZco2VJH0KzVYOdAxy2hPyDAzW2Xk
fqQ7hku8oAclVcq/BgZj2gbkNVBov2v8N6CJe1rkgi5vWXTAr1hl5kI9rspDJnA7
H8Az4fbVkcRIUpGHJkaJwkmU6VHeuqlfsJrH/TCqoSjorqhJqeP7IuE4ZEI6hhqa
qW4vN0oR78m6iPEMAcXPcfGA4CjUmq/lJ3+pO8XVrwDgD9Kr7z9Kr87FbI+YiUan
2YQrb8Vs+UR+lg2Dc0Vh5e+dUTiphA6OGTkg1FX2cDqbUQLKlBQCtVBL1c0mDAun
7xA4D4h5ZLqjPaan3TVeSFiTcBZ9a85xddM06YkQ84b7mjfdTCce6E8jUwpB+xOi
TI4p2lXN5K1CYku0zujchFSaEO2HHBoMhU8DzvgwA1bEld9epzMyaUiO40ggRIq9
kmu/yOZo
=KLhT
-----END PGP SIGNATURE-----

--g2m7r27qa7zhkbsf--
