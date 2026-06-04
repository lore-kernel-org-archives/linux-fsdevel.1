Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9B30D3F8
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611868; cv=none; b=oT2QgYnJoAKDORmmW+DR+fjkdwX6XW5qcaQHZ732RcvSJrNsRzVgbYpoAJrmU8ZNvEzxCfg+uuQfDOP/WqNssPaI6DmEbwshFS3Rf3Z5i7v/9aTvPxapiHrRVvCHg1zvmw9ll/TUovHLFMjw1ga90JRlB5QFdiGBb7xBz+YEm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611868; c=relaxed/simple;
	bh=ChIPRYNBIsfkUlMkx67JGcNsHMTa9R5dyM0Ccg9CU5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfN/8ha/twRleVxa7HSaX4CRltxj/K4oYgfRwq5rSdWDjrc0IqO0z+jGTwK6spVRs5zl1It6LUqW9I2ZF9iFmUGtWF87FPzKNM/Hk2rBCt5XzUFbOMasarEYWK2olcosQ7Lv1DCMH4GBwGlOZHaKnSsNwKOgoUo1eTodu5kdi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=UeMsmWdR; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="UeMsmWdR"
X-KPN-MessageId: 1e0e482e-6064-11f1-beab-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1e0e482e-6064-11f1-beab-005056992ed3;
	Fri, 05 Jun 2026 00:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=duWrDuzKezfxERU9Ex6cAs7tpBOAAgEWumvStbzuBls=;
	b=UeMsmWdRKlzxz/shJb5ZZJ4w+fOXoMuBLCfHMH04jvVp0i5n6pV5/r1k8jDMaocfIo3uvOG/5XtqB
	 Z/U2aH5HnRr2bU5E2NesfyUHDHJAGM1uanhhykKHlv0ZC6nLUHBwjF+xpTb4G+acrm5okOLnHWPgRK
	 IbF9EgPCI89mmZwyDwXP77HXh4dxFcZaZFTYR5IXr0lssIjRi+/fpi5Ok2tjUNPb7rftDgNa5DanDj
	 cUGA+DRUXlL1+CwfGpToWBBEwCz7+tCXY1Shoddixk4U9W6HHoqpTOafgW0b9xg21Ov/fWwvQId8kD
	 iQFepxAQY0kaIvWmfzkaXnXp5rX2cKA==
X-KPN-MID: 33|wbeH6OyWrFtpyjbYlSLemtKx2Oowrah9P1KVBz4PZgJr1t1Pf2ddfGQdba7TbIp
 54SOqADW/OgTzZlGiovuP1G9RU0WfSYeiRw+ZCbwuIVM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|g62LH/2GyQ8OqZkprgCJpsdnsXpzfYRM0/Mg0x9nSyGRREIXio1SyilToQwGv8G
 DhYD4udQwI+e+tOgNvo46nA==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1b7dfbaf-6064-11f1-abb2-00505699b758;
	Fri, 05 Jun 2026 00:24:14 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH] vfs: uapi: retire octal and hex numbers in favor of (1 << n) for O_ flags
Date: Fri,  5 Jun 2026 00:24:05 +0200
Message-ID: <20260604222405.5382-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent build failure[1] exposed the diffculty of working with the
current octal and hex definitions of O_ flags when trying to find a gap
for a new flag. This difficulty is compounded by the fact that O_ flags
may have architectural specific values.

Replace the hex/octal #defines, which are hard to parse when looking for
free bits, with explicit bit shifts like (1 << 11). Also, add comments
that identify which architectures redefine some of the seemingly free
("cursed") bits in uapi/asm-generic/fcntl.h. These should not be used to
define new O_ flags (for now, at least).

The translastion was done with Claude Opus 4.8, and verified with a
(non-AI) gawk script. The accounting of which architectures claim
which bit-gaps in uapi/asm-generic/fcntl.h is also done by hand.

[1]: https://lore.kernel.org/all/agruPPybCx8q2XcJ@sirena.org.uk/

Assisted-by: Claude:Opus 4.8
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---

The following gawk script outputs:

Mismatch in arch/sparc/include/uapi/asm/fcntl.h, flag O_NDELAY changed: 1212 -> 4

which is because O_NDELAY in sparc is not defined in the standard
"#define O_BLABLA number" form. This one was checked by hand to be sure.


function num(x)    { gsub(/[^0-9xXa-fA-F]/, "", x); return strtonum(x) }
function val(s, a) { sub(/\/[*/].*/, "", s)
		     if (s ~ /<</) { split(s, a, /<</); return lshift(num(a[1]), num(a[2])) }
		     return num(s) }

/^\+\+\+ /	{ f = $2; sub(/^[ab]\//, "", f); next }
/^(---|@@)/	{ next }
/^-#define/	{ v=""; for (i=3; i<=NF; i++) v = v $i" "; old[f SUBSEP $2] = val(v) }
/^\+#define/	{ v=""; for (i=3; i<=NF; i++) v = v $i" "; new[f SUBSEP $2] = val(v) }

function diff_old(   k, p, file, flag, o, n) {
	for (k in old) {
		split(k, p, SUBSEP)
		file = p[1]; flag = p[2]
		if (k in new) {
			o = old[k]; n = new[k]
			if (o != n)
				printf "Mismatch in %s, flag %s changed: %d -> %d\n", file, flag, o, n
			delete new[k]
		} else
			printf "Flag %s is -'ed but not +'ed in %s\n", flag, file
	}
}

function diff_new(   k, p, file, flag) {
	for (k in new) {
		split(k, p, SUBSEP)
		file = p[1]; flag = p[2]
		printf "Flag %s is +'ed but not -'ed in %s\n", flag, file
	}
}

END { diff_old(); diff_new() }
---
 arch/alpha/include/uapi/asm/fcntl.h   | 34 +++++++++---------
 arch/arm/include/uapi/asm/fcntl.h     |  8 ++---
 arch/arm64/include/uapi/asm/fcntl.h   |  8 ++---
 arch/m68k/include/uapi/asm/fcntl.h    |  8 ++---
 arch/mips/include/uapi/asm/fcntl.h    | 22 ++++++------
 arch/parisc/include/uapi/asm/fcntl.h  | 28 +++++++--------
 arch/powerpc/include/uapi/asm/fcntl.h |  8 ++---
 arch/sparc/include/uapi/asm/fcntl.h   | 34 +++++++++---------
 include/uapi/asm-generic/fcntl.h      | 50 ++++++++++++++++-----------
 9 files changed, 104 insertions(+), 96 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
index 50bdc8e8a271..c7e1c5cf646d 100644
--- a/arch/alpha/include/uapi/asm/fcntl.h
+++ b/arch/alpha/include/uapi/asm/fcntl.h
@@ -2,20 +2,20 @@
 #ifndef _ALPHA_FCNTL_H
 #define _ALPHA_FCNTL_H
 
-#define O_CREAT		 01000	/* not fcntl */
-#define O_TRUNC		 02000	/* not fcntl */
-#define O_EXCL		 04000	/* not fcntl */
-#define O_NOCTTY	010000	/* not fcntl */
-
-#define O_NONBLOCK	 00004
-#define O_APPEND	 00010
-#define O_DSYNC		040000	/* used to be O_SYNC, see below */
-#define O_DIRECTORY	0100000	/* must be a directory */
-#define O_NOFOLLOW	0200000 /* don't follow links */
-#define O_LARGEFILE	0400000 /* will be set by the kernel on every open */
-#define O_DIRECT	02000000 /* direct disk access - should check with OSF/1 */
-#define O_NOATIME	04000000
-#define O_CLOEXEC	010000000 /* set close_on_exec */
+#define O_CREAT		(1 << 9)	/* not fcntl */
+#define O_TRUNC		(1 << 10)	/* not fcntl */
+#define O_EXCL		(1 << 11)	/* not fcntl */
+#define O_NOCTTY	(1 << 12)	/* not fcntl */
+
+#define O_NONBLOCK	(1 << 2)
+#define O_APPEND	(1 << 3)
+#define O_DSYNC		(1 << 14)	/* used to be O_SYNC, see below */
+#define O_DIRECTORY	(1 << 15)	/* must be a directory */
+#define O_NOFOLLOW	(1 << 16)	/* don't follow links */
+#define O_LARGEFILE	(1 << 17)	/* will be set by the kernel on every open */
+#define O_DIRECT	(1 << 19)	/* direct disk access - should check with OSF/1 */
+#define O_NOATIME	(1 << 20)
+#define O_CLOEXEC	(1 << 21)	/* set close_on_exec */
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -29,11 +29,11 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	020000000
+#define __O_SYNC	(1 << 22)
 #define O_SYNC		(__O_SYNC|O_DSYNC)
 
-#define O_PATH		040000000
-#define __O_TMPFILE	0100000000
+#define O_PATH		(1 << 23)
+#define __O_TMPFILE	(1 << 24)
 
 #define F_GETLK		7
 #define F_SETLK		8
diff --git a/arch/arm/include/uapi/asm/fcntl.h b/arch/arm/include/uapi/asm/fcntl.h
index e6b5d7141c05..b576ff00beb2 100644
--- a/arch/arm/include/uapi/asm/fcntl.h
+++ b/arch/arm/include/uapi/asm/fcntl.h
@@ -2,10 +2,10 @@
 #ifndef _ARM_FCNTL_H
 #define _ARM_FCNTL_H
 
-#define O_DIRECTORY	 040000	/* must be a directory */
-#define O_NOFOLLOW	0100000	/* don't follow links */
-#define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0400000
+#define O_DIRECTORY	(1 << 14)	/* must be a directory */
+#define O_NOFOLLOW	(1 << 15)	/* don't follow links */
+#define O_DIRECT	(1 << 16)	/* direct disk access hint - currently ignored */
+#define O_LARGEFILE	(1 << 17)
 
 #include <asm-generic/fcntl.h>
 
diff --git a/arch/arm64/include/uapi/asm/fcntl.h b/arch/arm64/include/uapi/asm/fcntl.h
index f8db34f2622d..e503fdb74ecb 100644
--- a/arch/arm64/include/uapi/asm/fcntl.h
+++ b/arch/arm64/include/uapi/asm/fcntl.h
@@ -20,10 +20,10 @@
 /*
  * Using our own definitions for AArch32 (compat) support.
  */
-#define O_DIRECTORY	 040000	/* must be a directory */
-#define O_NOFOLLOW	0100000	/* don't follow links */
-#define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0400000
+#define O_DIRECTORY	(1 << 14)	/* must be a directory */
+#define O_NOFOLLOW	(1 << 15)	/* don't follow links */
+#define O_DIRECT	(1 << 16)	/* direct disk access hint - currently ignored */
+#define O_LARGEFILE	(1 << 17)
 
 #include <asm-generic/fcntl.h>
 
diff --git a/arch/m68k/include/uapi/asm/fcntl.h b/arch/m68k/include/uapi/asm/fcntl.h
index c6861e6ee313..66c0e5515105 100644
--- a/arch/m68k/include/uapi/asm/fcntl.h
+++ b/arch/m68k/include/uapi/asm/fcntl.h
@@ -2,10 +2,10 @@
 #ifndef _M68K_FCNTL_H
 #define _M68K_FCNTL_H
 
-#define O_DIRECTORY	040000	/* must be a directory */
-#define O_NOFOLLOW	0100000	/* don't follow links */
-#define O_DIRECT	0200000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0400000
+#define O_DIRECTORY	(1 << 14)	/* must be a directory */
+#define O_NOFOLLOW	(1 << 15)	/* don't follow links */
+#define O_DIRECT	(1 << 16)	/* direct disk access hint - currently ignored */
+#define O_LARGEFILE	(1 << 17)
 
 #include <asm-generic/fcntl.h>
 
diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
index 0369a38e3d4f..549fc65d849d 100644
--- a/arch/mips/include/uapi/asm/fcntl.h
+++ b/arch/mips/include/uapi/asm/fcntl.h
@@ -11,15 +11,15 @@
 
 #include <asm/sgidefs.h>
 
-#define O_APPEND	0x0008
-#define O_DSYNC		0x0010	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x0080
-#define O_CREAT		0x0100	/* not fcntl */
-#define O_TRUNC		0x0200	/* not fcntl */
-#define O_EXCL		0x0400	/* not fcntl */
-#define O_NOCTTY	0x0800	/* not fcntl */
-#define FASYNC		0x1000	/* fcntl, for BSD compatibility */
-#define O_LARGEFILE	0x2000	/* allow large file opens */
+#define O_APPEND	(1 << 3)
+#define O_DSYNC		(1 << 4)	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	(1 << 7)
+#define O_CREAT		(1 << 8)	/* not fcntl */
+#define O_TRUNC		(1 << 9)	/* not fcntl */
+#define O_EXCL		(1 << 10)	/* not fcntl */
+#define O_NOCTTY	(1 << 11)	/* not fcntl */
+#define FASYNC		(1 << 12)	/* fcntl, for BSD compatibility */
+#define O_LARGEFILE	(1 << 13)	/* allow large file opens */
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -33,9 +33,9 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x4000
+#define __O_SYNC	(1 << 14)
 #define O_SYNC		(__O_SYNC|O_DSYNC)
-#define O_DIRECT	0x8000	/* direct disk access hint */
+#define O_DIRECT	(1 << 15)	/* direct disk access hint */
 
 #define F_GETLK		14
 #define F_SETLK		6
diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
index 03dee816cb13..2e1bb18eefb8 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -2,23 +2,23 @@
 #ifndef _PARISC_FCNTL_H
 #define _PARISC_FCNTL_H
 
-#define O_APPEND	000000010
-#define O_CREAT		000000400 /* not fcntl */
-#define O_EXCL		000002000 /* not fcntl */
-#define O_LARGEFILE	000004000
-#define __O_SYNC	000100000
+#define O_APPEND	(1 << 3)
+#define O_CREAT		(1 << 8)	/* not fcntl */
+#define O_EXCL		(1 << 10)	/* not fcntl */
+#define O_LARGEFILE	(1 << 11)
+#define __O_SYNC	(1 << 15)
 #define O_SYNC		(__O_SYNC|O_DSYNC)
-#define O_NONBLOCK	000200000
-#define O_NOCTTY	000400000 /* not fcntl */
-#define O_DSYNC		001000000
-#define O_NOATIME	004000000
-#define O_CLOEXEC	010000000 /* set close_on_exec */
+#define O_NONBLOCK	(1 << 16)
+#define O_NOCTTY	(1 << 17)	/* not fcntl */
+#define O_DSYNC		(1 << 18)
+#define O_NOATIME	(1 << 20)
+#define O_CLOEXEC	(1 << 21)	/* set close_on_exec */
 
-#define O_DIRECTORY	000010000 /* must be a directory */
-#define O_NOFOLLOW	000000200 /* don't follow links */
+#define O_DIRECTORY	(1 << 12)	/* must be a directory */
+#define O_NOFOLLOW	(1 << 7)	/* don't follow links */
 
-#define O_PATH		020000000
-#define __O_TMPFILE	040000000
+#define O_PATH		(1 << 22)
+#define __O_TMPFILE	(1 << 23)
 
 #define F_GETLK64	8
 #define F_SETLK64	9
diff --git a/arch/powerpc/include/uapi/asm/fcntl.h b/arch/powerpc/include/uapi/asm/fcntl.h
index 65ce08322a89..003bc5ea78e1 100644
--- a/arch/powerpc/include/uapi/asm/fcntl.h
+++ b/arch/powerpc/include/uapi/asm/fcntl.h
@@ -2,10 +2,10 @@
 #ifndef _ASM_FCNTL_H
 #define _ASM_FCNTL_H
 
-#define O_DIRECTORY      040000	/* must be a directory */
-#define O_NOFOLLOW      0100000	/* don't follow links */
-#define O_LARGEFILE     0200000
-#define O_DIRECT	0400000	/* direct disk access hint */
+#define O_DIRECTORY	(1 << 14)	/* must be a directory */
+#define O_NOFOLLOW	(1 << 15)	/* don't follow links */
+#define O_LARGEFILE	(1 << 16)
+#define O_DIRECT	(1 << 17)	/* direct disk access hint */
 
 #include <asm-generic/fcntl.h>
 
diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index 67dae75e5274..29c5639bc3fa 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -2,23 +2,23 @@
 #ifndef _SPARC_FCNTL_H
 #define _SPARC_FCNTL_H
 
-#define O_APPEND	0x0008
-#define FASYNC		0x0040	/* fcntl, for BSD compatibility */
-#define O_CREAT		0x0200	/* not fcntl */
-#define O_TRUNC		0x0400	/* not fcntl */
-#define O_EXCL		0x0800	/* not fcntl */
-#define O_DSYNC		0x2000	/* used to be O_SYNC, see below */
-#define O_NONBLOCK	0x4000
+#define O_APPEND	(1 << 3)
+#define FASYNC		(1 << 6)	/* fcntl, for BSD compatibility */
+#define O_CREAT		(1 << 9)	/* not fcntl */
+#define O_TRUNC		(1 << 10)	/* not fcntl */
+#define O_EXCL		(1 << 11)	/* not fcntl */
+#define O_DSYNC		(1 << 13)	/* used to be O_SYNC, see below */
+#define O_NONBLOCK	(1 << 14)
 #if defined(__sparc__) && defined(__arch64__)
-#define O_NDELAY	0x0004
+#define O_NDELAY	(1 << 2)
 #else
-#define O_NDELAY	(0x0004 | O_NONBLOCK)
+#define O_NDELAY	((1 << 2) | O_NONBLOCK)
 #endif
-#define O_NOCTTY	0x8000	/* not fcntl */
-#define O_LARGEFILE	0x40000
-#define O_DIRECT        0x100000 /* direct disk access hint */
-#define O_NOATIME	0x200000
-#define O_CLOEXEC	0x400000
+#define O_NOCTTY	(1 << 15)	/* not fcntl */
+#define O_LARGEFILE	(1 << 18)
+#define O_DIRECT	(1 << 20)	/* direct disk access hint */
+#define O_NOATIME	(1 << 21)
+#define O_CLOEXEC	(1 << 22)
 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
  * the O_SYNC flag.  We continue to use the existing numerical value
@@ -32,11 +32,11 @@
  *
  * Note: __O_SYNC must never be used directly.
  */
-#define __O_SYNC	0x800000
+#define __O_SYNC	(1 << 23)
 #define O_SYNC		(__O_SYNC|O_DSYNC)
 
-#define O_PATH		0x1000000
-#define __O_TMPFILE	0x2000000
+#define O_PATH		(1 << 24)
+#define __O_TMPFILE	(1 << 25)
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..359622b083d5 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -15,51 +15,55 @@
  * When introducing new O_* bits, please check its uniqueness in fcntl_init().
  */
 
-#define O_ACCMODE	00000003
-#define O_RDONLY	00000000
-#define O_WRONLY	00000001
-#define O_RDWR		00000002
+#define O_ACCMODE	3
+#define O_RDONLY	0
+#define O_WRONLY	(1 << 0)
+#define O_RDWR		(1 << 1)
+/* (1 << 2) must not be used -- it collides with flags on alpha, sparc */
+/* (1 << 3) must not be used -- it collides with flags on alpha, mips, parisc, sparc */
+/* (1 << 4) must not be used -- it collides with flags on mips */
+/* (1 << 5) is free */
 #ifndef O_CREAT
-#define O_CREAT		00000100	/* not fcntl */
+#define O_CREAT		(1 << 6)	/* not fcntl */
 #endif
 #ifndef O_EXCL
-#define O_EXCL		00000200	/* not fcntl */
+#define O_EXCL		(1 << 7)	/* not fcntl */
 #endif
 #ifndef O_NOCTTY
-#define O_NOCTTY	00000400	/* not fcntl */
+#define O_NOCTTY	(1 << 8)	/* not fcntl */
 #endif
 #ifndef O_TRUNC
-#define O_TRUNC		00001000	/* not fcntl */
+#define O_TRUNC		(1 << 9)	/* not fcntl */
 #endif
 #ifndef O_APPEND
-#define O_APPEND	00002000
+#define O_APPEND	(1 << 10)
 #endif
 #ifndef O_NONBLOCK
-#define O_NONBLOCK	00004000
+#define O_NONBLOCK	(1 << 11)
 #endif
 #ifndef O_DSYNC
-#define O_DSYNC		00010000	/* used to be O_SYNC, see below */
+#define O_DSYNC		(1 << 12)	/* used to be O_SYNC, see below */
 #endif
 #ifndef FASYNC
-#define FASYNC		00020000	/* fcntl, for BSD compatibility */
+#define FASYNC		(1 << 13)	/* fcntl, for BSD compatibility */
 #endif
 #ifndef O_DIRECT
-#define O_DIRECT	00040000	/* direct disk access hint */
+#define O_DIRECT	(1 << 14)	/* direct disk access hint */
 #endif
 #ifndef O_LARGEFILE
-#define O_LARGEFILE	00100000
+#define O_LARGEFILE	(1 << 15)
 #endif
 #ifndef O_DIRECTORY
-#define O_DIRECTORY	00200000	/* must be a directory */
+#define O_DIRECTORY	(1 << 16)	/* must be a directory */
 #endif
 #ifndef O_NOFOLLOW
-#define O_NOFOLLOW	00400000	/* don't follow links */
+#define O_NOFOLLOW	(1 << 17)	/* don't follow links */
 #endif
 #ifndef O_NOATIME
-#define O_NOATIME	01000000
+#define O_NOATIME	(1 << 18)
 #endif
 #ifndef O_CLOEXEC
-#define O_CLOEXEC	02000000	/* set close_on_exec */
+#define O_CLOEXEC	(1 << 19)	/* set close_on_exec */
 #endif
 
 /*
@@ -76,16 +80,16 @@
  * Note: __O_SYNC must never be used directly.
  */
 #ifndef O_SYNC
-#define __O_SYNC	04000000
+#define __O_SYNC	(1 << 20)
 #define O_SYNC		(__O_SYNC|O_DSYNC)
 #endif
 
 #ifndef O_PATH
-#define O_PATH		010000000
+#define O_PATH		(1 << 21)
 #endif
 
 #ifndef __O_TMPFILE
-#define __O_TMPFILE	020000000
+#define __O_TMPFILE	(1 << 22)
 #endif
 
 /* a horrid kludge trying to make sure that this will fail on old kernels */
@@ -95,6 +99,10 @@
 #define O_NDELAY	O_NONBLOCK
 #endif
 
+/* (1 << 23) must not be used -- it collides with flags on alpha, parisc, sparc */
+/* (1 << 24) must not be used -- it collides with flags on alpha, sparc */
+/* (1 << 25) must not be used -- it collides with flags on sparc */
+
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
 #define F_SETFD		2	/* set/clear close_on_exec */

base-commit: 6a08076f009e3d9460bebae9f209c1dc1d8a46b7
-- 
2.54.0

