Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B3394499
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956897; cv=none; b=soDX5LXLY6DL9mqb9MFSf8zE9aVp2l89dSM8uW2efeeEtm5YTIz9+u6Pwuzd0GcmIWdjbt+KpqFzDIzYvFOxYxxlAz0pXyxAwmNciOx8SpsbO3i/AywgtTE95lGx3y/+K6OhWGb7VbcaBbEvvtJEdBAtbad5js2FjgaRACDdkqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956897; c=relaxed/simple;
	bh=BV9J3THl4S5DP5wy6kNT9WEsaKIRd2/LEOJgTvPPIhE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AT0r4iXRlxebAu3qFAp2ExhSRn5Q7Gwc18bh5MWjVi+xU9bLVUsKF4mYV78gx00QvRUaL76zDRArLDDAJeDb9//yRgTTp6E1b8x0vGztqDMzPJFyJKuCxL1eGbCr4nL13Av5iiIOy1yVNmtlyvvbWkPFd0KjCSqBxgzZHdUqe/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lukasldc.fr; spf=pass smtp.mailfrom=lukasldc.fr; dkim=pass (2048-bit key) header.d=lukasldc.fr header.i=@lukasldc.fr header.b=B4oJAnvx; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lukasldc.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukasldc.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukasldc.fr header.i=@lukasldc.fr header.b="B4oJAnvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lukasldc.fr;
	s=protonmail3; t=1785956880; x=1786216080;
	bh=1RzhjpKE23bNvZ6/pRW+z0pJdpUp3ZDeFIGuOFzpBrg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=B4oJAnvxSwo/TN1kYVq6MF3NfTkmnlT6apwjZNTolhflEpIaeKBho6ekFZNCun6dl
	 lgT7k2QuFFzUhkA+vLuUSTqRStlZBYCiGWpepG7vgfCoEdI8DmUrj8lg6ZsKsvqWc8
	 34I2duHnafKVNuofqRlcsxH2ndrUFOyibuspoyfMT4VKkaV66ByogSFDmmdXTDT1cT
	 ZR/51pgmSR9BrOHMouLCOR60HP57ByI31a50YdR9TZjZhfWw59nF+WVcQGto2LQM/p
	 jhuNdJ2PHYcYQaKiAofCrPnu0RCZwdjjXbxlusKLXWy2ltnN4K4W+qKzoJiNBX1utd
	 ypSygxKFlkY0g==
Date: Wed, 05 Aug 2026 19:07:58 +0000
To: "almaz.alexandrovich@paragon-software.com" <almaz.alexandrovich@paragon-software.com>
From: Lukas LOPES DA CONCEICAO <contact@lukasldc.fr>
Cc: "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, "djwong@kernel.org" <djwong@kernel.org>
Subject: [BUG] ntfs3: IOMAP_INLINE mapping exceeds its page - BUG_ON in iomap
Message-ID: <4_qSHDGTzev3i2hKqtp_9TpB7p5JWTBKwOucZ49wWdoLB9TphDDLl-QsnEjjPLerlfuk-xS9J_qL7TQefUZxd3qW9MttPZT-UgBWJW9B_eE=@lukasldc.fr>
Feedback-ID: 100544131:user:proton
X-Pm-Message-ID: aca22f412653724044935216046ffe16d8d39e9d
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------efa0dbf689cf65b250962014e3f19bda2f30acafa787622ee3543735d0cce140"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------efa0dbf689cf65b250962014e3f19bda2f30acafa787622ee3543735d0cce140
Content-Type: multipart/mixed;boundary=---------------------25ba79cbbfdfa0f645d94e32445bb00b

-----------------------25ba79cbbfdfa0f645d94e32445bb00b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi,

Up front, so nobody wastes time on a wrong assumption: the analysis and
the wording of this report were produced by an AI assistant (Assisted-by
tag at the end). I work in software but not on kernels; I read it through
and it holds together as far as I can judge, but I cannot independently
verify the reasoning or the source reading behind it.

What is mine is the data. The machine, the seven crashes, the traces and
the probe runs are real and reproducible here. Please treat the measured
output as evidence and the analysis as a hypothesis to check.

Buffered writes to small (resident) files on an ntfs3 volume reliably
trigger a kernel BUG in the iomap layer: 7 times in 11 days of normal
desktop use, on both 7.0.0-28 and 7.0.0-29. It points at
ntfs_iomap_begin() in fs/ntfs3/inode.c building an IOMAP_INLINE mapping
whose length is not bounded by the page holding iomap->inline_data.

Environment
-----------
Kernel:     7.0.0-28-generic and 7.0.0-29-generic (Ubuntu), both affected
Board:      Intel Z790 desktop, x86_64
Filesystem: ntfs3 on a 3.6T NVMe partition, 4096-byte blocks
Mount opts: rw,nosuid,nodev,relatime,uid=3D1000,gid=3D1000,acl,
            iocharset=3Dutf8,prealloc
Taint:      G O - out-of-tree NVIDIA module. The faulting path is
            entirely in fs/iomap and fs/ntfs3; the module is unrelated.

The workload is the Steam client writing to a game library directory on
the ntfs3 volume - shader cache, game metadata, runtime installs. No
special configuration and no stress tooling; ordinary buffered write()
calls from an unmodified Steam client.

Occurrences
-----------
  date         process           write len   syscall path
  2026-07-26   CGenericAsyncFi   0x81  129   __ia32_sys_write (int80)
  2026-07-27   CGenericAsyncFi   0xa6  166   __ia32_sys_write (int80)
  2026-07-27   CGenericAsyncFi   0xba  186   __ia32_sys_write (int80)
  2026-07-29   fossilize_repla   0x18   24   __x64_sys_write
  2026-07-31   fossilize_repla   0x18   24   __x64_sys_write
  2026-08-03   fossilize_repla   0x18   24   __x64_sys_write
  2026-08-05   CGenericAsyncFi   0x8c  140   __ia32_sys_write (int80)

The 2026-08-03 one fired 21 seconds after the volume was mounted, during
Steam's Vulkan shader pre-caching pass - so it does not need a
long-running or heavy workload to show up. The 2026-08-05 one is on
7.0.0-29 and happened while Steam was installing its Linux runtime -
an ordinary download-and-install, no stress tool involved. It was caught
live by the probe described below.

Both the 32-bit compat and the native 64-bit write paths hit it, so this
is not a compat-layer issue. All seven crash at the exact same
instruction, iomap_write_end+0x1e0/0x1f0, and the trapping insn is ud2.

Analysis
--------
fs/iomap/buffered-io.c:1061 is, in iomap_write_end_inline():

	BUG_ON(!iomap_inline_data_valid(iomap));

with, from include/linux/iomap.h:

	static inline bool iomap_inline_data_valid(const struct iomap *iomap)
	{
		return iomap->length <=3D
			PAGE_SIZE - offset_in_page(iomap->inline_data);
	}

The register state is identical across all seven oopses:

	RAX =3D 0x40  =3D 64    -> PAGE_SIZE - offset_in_page(inline_data)
	RDX =3D 0xfc0 =3D 4032  -> offset_in_page(iomap->inline_data)
	RDI ends in 0xfc0   -> iomap->inline_data itself
	RBX =3D RCX           -> the folio

So inline_data sits 4032 bytes into its page, leaving 64 bytes, while
iomap->length exceeds that.

The mapping is built in ntfs_iomap_begin(), fs/ntfs3/inode.c:

	if (lcn =3D=3D RESIDENT_LCN) {
		if (offset >=3D clen) {
			kfree(res);
			...
			return -EFAULT;
		}

		iomap->private =3D iomap->inline_data =3D res;
		iomap->type =3D IOMAP_INLINE;
		iomap->offset =3D 0;
		iomap->length =3D clen; /* resident size in bytes. */
		return 0;
	}

iomap->length is set to the full resident attribute size, and the
function returns immediately. It therefore never reaches the clamping
block at the end of the same function:

	if (... && (iomap->type =3D=3D IOMAP_MAPPED ||
		    iomap->type =3D=3D IOMAP_DELALLOC)) {
		/* Avoid too large requests. */
		u32 tail;
		u32 off_a =3D offset & (PAGE_SIZE - 1);
		if (off_a)
			tail =3D PAGE_SIZE - off_a;
		else
			tail =3D PAGE_SIZE;

		if (iomap->length > tail)
			iomap->length =3D tail;
	}

which in any case excludes IOMAP_INLINE.

This looks like a regression from "fs/ntfs3: implement iomap-based file
operations" (Dec 2025), which introduced the IOMAP_INLINE path for
resident attributes. 6.x kernels are unaffected.

Instrumented evidence
---------------------
A kprobe/kretprobe pair on ntfs_iomap_begin() evaluating
iomap_inline_data_valid() on every IOMAP_INLINE mapping it returns
(script at the end) catches the violation live:

  WOULD BUG  comm=3Dcs2              len=3D135 off_in_page=3D4032 tail=3D6=
4 flags=3D0x0 read
  WOULD BUG  comm=3DCGenericAsyncFi  len=3D140 off_in_page=3D4032 tail=3D6=
4 flags=3D0x1 WRITE

The read one did not panic; only the write path reaches
iomap_write_end_inline(). The write one is the 2026-08-05 oops below,
whose RSI is 0x8c =3D 140, matching the value the probe reported
microseconds earlier. Same invalid mapping on both paths.

Geometry: 135 and 140 both land in kmalloc-192, and 192 * 21 =3D 4032, so
the 22nd object of an order-1 slab starts at page offset 4032 and runs to
4224, straddling the 4096 boundary. Offset 4032 and tail 64 appear in all
seven oopses (RDX =3D 0xfc0, RAX =3D 0x40).

Buckets whose size divides PAGE_SIZE cannot straddle, and over several
thousand further samples they never came close to failing: with
kmalloc-64, -128, -256 and -512 the buffer sits in the last slot of its
page, so tail equals the bucket size and is always >=3D len. Closest was
exact equality (len=3D512, tail=3D512).

So the trigger is a resident attribute sized into a non-power-of-two
kmalloc bucket, placed at a slab offset that crosses a page boundary.

Suggested fix
-------------
iomap requires inline data to live within a single page, so the fix is
to make sure res never straddles one. Since kmalloc buckets whose size
divides PAGE_SIZE never place an object across a page boundary,
rounding the allocation up to a power of two would be enough, and keeps
the mapping complete:

	res =3D kmalloc(roundup_pow_of_two(clen), GFP_NOFS);

Clamping the length instead:

	iomap->length =3D min_t(loff_t, clen,
			      PAGE_SIZE - offset_in_page(res));

would silence the BUG_ON but truncate the mapping, so the caller would
see a short inline extent - probably not what you want here.

Note on the BUG_ON
------------------
Independently of the ntfs3 fix: this BUG_ON is reachable from an
unprivileged write(). The task dies holding the inode and folio locks, so
every later access to that mount blocks in D state, the filesystem cannot
be unmounted, and shutdown hangs - forcing a hard power-off that leaves
the volume dirty. Here that has already cost data: chkdsk recovered
orphaned directory entries into found.000, and two Proton prefixes were
emptied.

A WARN_ON_ONCE plus returning false would let the write fail cleanly
instead of wedging the mount. Would the iomap maintainers consider that?

Impact
------
Steam libraries on NTFS are a common dual-boot setup, so this likely
affects a fair number of desktop users on 7.0. Two existing reports look
like the same bug:

  https://github.com/CachyOS/linux-cachyos/issues/841
  https://bbs.archlinux.org/viewtopic.php?pid=3D2296728

Full oops (2026-08-05, kernel 7.0.0-29, the one caught by the probe)
--------------------------------------------------------------------
------------[ cut here ]------------
kernel BUG at fs/iomap/buffered-io.c:1061!
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 6 UID: 1000 PID: 17654 Comm: CGenericAsyncFi Tainted: G           O  =
      7.0.0-29-generic #29-Ubuntu PREEMPT(lazy) =


Tainted: [O]=3DOOT_MODULE
Hardware name: [redacted]
RIP: 0010:iomap_write_end+0x1e0/0x1f0
Code: 8b 38 e8 e3 1c f9 ff e9 23 ff ff ff 48 8b 03 a8 08 74 10 e9 8c fe ff=
 ff eb 8a 0f 0b e9 54 ff ff ff 0f 0b 31 c0 e9 0a ff ff ff <0f> 0b 0f 1f 00=
 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0000:ffffcfff4bb67b80 EFLAGS: 00010297
RAX: 0000000000000040 RBX: fffff61fcc304f40 RCX: fffff61fcc304f40
RDX: 0000000000000fc0 RSI: 000000000000008c RDI: ffff8b315cdc2fc0
RBP: ffffcfff4bb67bb0 R08: ffffcfff4bb67c50 R09: 000000000000008c
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000008c
R13: ffffcfff4bb67c50 R14: 000000000000008c R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8b39108ff000(0063) knlGS:00000000bb4f9b=
40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000734dfc569000 CR3: 000000037e81b002 CR4: 0000000000f72ef0
PKRU: 55555554
Call Trace:
 <TASK>
 iomap_write_iter+0x171/0x340
 iomap_file_buffered_write+0xa6/0x110
 ntfs_file_write_iter+0x267/0x310 [ntfs3]
 vfs_write+0x25b/0x490
 ksys_write+0x71/0xf0
 __ia32_sys_write+0x17/0x30
 ia32_sys_call+0x1ed9/0x2b10
 do_int80_emulation+0xaf/0x540
 ? __do_fast_syscall_32+0xd7/0x610
 ? arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
 ? __do_fast_syscall_32+0xd7/0x610
 ? __do_fast_syscall_32+0xd7/0x610
 ? __audit_syscall_exit+0x36/0x120
 ? arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
 ? do_fast_syscall_32+0x33/0x90
 asm_int80_emulation+0x1b/0x20
RIP: 0023:0xed3e164b
Code: 57 56 53 8b 44 24 14 f6 00 08 75 23 8b 44 24 18 8b 5c 24 1c 8b 4c 24=
 20 8b 54 24 24 8b 74 24 28 8b 7c 24 2c 8b 6c 24 30 cd 80 <5b> 5e 5f 5d c3=
 5b 5e 5f 5d e9 07 31 ff ff 66 90 66 90 66 90 90 f3
RSP: 002b:00000000bb4f762c EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000000000e6 RCX: 00000000bf226640
RDX: 000000000000008c RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in: [redacted]
---[ end trace 0000000000000000 ]---

Assisted-by: Claude:claude-opus-5 bpftrace

Appendix: the bpftrace probe
----------------------------
Evaluates iomap_inline_data_valid() on every IOMAP_INLINE mapping
ntfs_iomap_begin() hands back, so the invalid mapping can be observed
on a live system without waiting for the write path to panic.

  #!/usr/bin/env bpftrace
  /*
   * Observe ntfs3 resident (IOMAP_INLINE) mappings.
   *
   * iomap_write_end_inline() asserts:
   *     iomap->length <=3D PAGE_SIZE - offset_in_page(iomap->inline_data)
   *
   * This probe reports both sides of that comparison without triggering i=
t,
   * so we can see how close normal workloads get to the BUG_ON.
   */

  BEGIN
  {
  	printf("probing ntfs_iomap_begin, IOMAP_INLINE only. Ctrl-C to stop.\n\=
n");
  }

  kprobe:ntfs3:ntfs_iomap_begin
  {
  	@iomap[tid] =3D arg4;
  	@flags[tid] =3D arg3;	/* IOMAP_WRITE is bit 0 */
  }

  kretprobe:ntfs3:ntfs_iomap_begin
  /@iomap[tid]/
  {
  	$io =3D (struct iomap *)@iomap[tid];

  	if ($io->type =3D=3D 4) {			/* IOMAP_INLINE */
  		$off  =3D (uint64)$io->inline_data & 0xfff;
  		$tail =3D 4096 - $off;
  		$len  =3D $io->length;

  		@resident_len =3D hist($len);
  		@offset_in_page =3D lhist($off, 0, 4096, 256);
  		@by_comm[comm] =3D count();

  		@margin =3D lhist($tail - $len, 0, 512, 64);

  		/* Near-miss cases are already characterised: the buffer always
  		 * sits in the last slot of its slab page, so tail equals the
  		 * bucket size and len never exceeds it.  Printing them again
  		 * adds noise, so only the real thing is reported.  The margin
  		 * histogram still records how close we get. */
  		if ($len > $tail) {
  			/* Only the write path reaches iomap_write_end_inline(),
  			 * where the BUG_ON lives.  A read builds the same invalid
  			 * mapping but never asserts on it. */
  			printf("WOULD BUG  comm=3D%-16s len=3D%llu off_in_page=3D%llu tail=3D=
%llu flags=3D0x%x %s\n",
  			       comm, $len, $off, $tail, @flags[tid],
  			       (@flags[tid] & 1) ? "WRITE" : "read");
  			@would_bug[(@flags[tid] & 1) ? "write" : "read"] =3D count();
  		} else if ($tail - $len < 16) {
  			@tight =3D count();
  		}
  	}

  	delete(@iomap, tid);
  	delete(@flags, tid);
  }

  END
  {
  	clear(@iomap);
  	clear(@flags);
  }

-----------------------25ba79cbbfdfa0f645d94e32445bb00b--

--------efa0dbf689cf65b250962014e3f19bda2f30acafa787622ee3543735d0cce140
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsG5BAEBCgBtBYJqc4n+CRDuBpvbNc2xoEUUAAAAAAAcACBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3Jn8JG1ThgTpU8ZJdRKdhY6yiL+aRYKvUyjhRS1
2pM9Ms8WIQTaXN155Azon7TFONPuBpvbNc2xoAAAgVMP/34lvJ06e2Bd554h
nFeFyFaIdfaUe79WX6yjBjz3+V99Py3tsi2QLzeO1IIGOw7txOwGXwwDJxYp
y/9mWyxGlfEslWOd9wf4MQ7ScTbi6MXEuFiPsIvriMCqpEREzFH444GUQju2
iqMq3bcWCChDrGdlu6M547i2nSTZ85nnVZF+TB5WuQZSOSw7gs+t3ORiF4SO
taFIAGnpVIfbFtQyCcVeFydbebb4iHdBEAzfvLwUYQyVM5C75RqkJ8GWejoV
I1+S/Wxf2QURq909IHv6zQaDhJXWCESd3hEpYNxhMh+0mHY7x2TRZV/EK59e
yWpfJ6OQK+wKbh8Yjjm2ryp4DaK0btb0z7cCftB2wzyxIRu8MDC4c5rSgkwf
WMJGEguPuLIb6n0rAO70XQZXB+ECw2jrF8knQlBAFgU4YN/kmGAPpsx/NVfY
PAo4Kba1O7OrtlmROC/N8vT/Y4etWYLlFB3LkFZf/6kRGGxCwocj70vxEXhJ
LWIW9DGNU8oSbZ4m7LUQrPoBOGoSG+9pyFYn9UP1j//mDzndegflJ3cMXym6
lU0yCrnNO7KKUwnV/QWNOpxzMXzL6QW+/DJJeV1b98cmzRYypYNSmcOrbFsN
5uT+qbqgec/IGzf1Qf9ISvXbh38Qfn9spWP1OCgdY83/rkTdv4wy6Y16Zo+L
PXTC0rX5
=0SKP
-----END PGP SIGNATURE-----


--------efa0dbf689cf65b250962014e3f19bda2f30acafa787622ee3543735d0cce140--

