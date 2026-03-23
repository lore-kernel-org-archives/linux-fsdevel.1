Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339F35959;
	Mon, 23 Mar 2026 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278068; cv=none; b=Ixm9fgZS38swdBVlh0bq2NVNpJKJ80DhCI/gzkAlODAg0UUM4hOqQvwNXlVyYUc/3TY0yHQSUD0+7m8/AQbiBMRURETlSqGbYHz+XHhh+PAaPqFDUZYFrwGqRqmxxRLYeHq37h7ZcoPmhDuNevrdUaesXpNyUExXHSpp35sChhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278068; c=relaxed/simple;
	bh=rIaDlvHNA/jbeovQPA5Bk/hHAnp9WuI3nYIGC86eYSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpOGvNwf5ZZhbhkwJ15pMlkyzg+0rFFQRZr6PU7bLJJcsKot9QDzui6rAEAW7bFzyQDB4ln5dq6DtoGEbFA2W4f3mboM495pikV7rRDyFjdb6PqnviEOLmX3Kn83B+wusXlBv1abogKJLTeDNTZAROU8jpLzbRaRSRxccpJq8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtpIm3Sg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtpIm3Sg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774278067; x=1805814067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rIaDlvHNA/jbeovQPA5Bk/hHAnp9WuI3nYIGC86eYSU=;
  b=YtpIm3SgKFw4RBq7VQYMIK0QZNJRiSssaDVKGDdzWsMkZY1t253ZwYuj
   RkRVGeKd5xzDOTEseOp5sgok+Y+kg52huyh1m4Be9sfi95fHZVIRnJVjb
   IlVWLvSI0bMKRn9c9pObeZx0N2fG7Ye3eMADEFi2HQC/rsiBx234C3AQp
   kqPJVeMANT59oCD/Ok1AcA/5IWNXo0bDV1X2iotA4vNB74dTI6Mnnjd5w
   gDMMqCvJlG5dXNTisofapS1bvFD9yIB9jZ1ATVy0Lsj/Iz0PV4/kmqRxM
   VYghgcC0ZegXyL/RaJKa4xnjOXRGl7OlMexlfnGk1Jg7w0Q8oIvuHrJhQ
   g==;
X-CSE-ConnectionGUID: A+xYVd11SdCgZNwdIcQM1w==
X-CSE-MsgGUID: RW0QX3QOTLywm6ORaKjrJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74456147"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74456147"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 08:01:05 -0700
X-CSE-ConnectionGUID: 9AhVUAzcRBm5OAVEMXsdMw==
X-CSE-MsgGUID: rD1PVj0eR82mSgc07wKcXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223119638"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 23 Mar 2026 08:01:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2DCAB9E; Mon, 23 Mar 2026 16:01:00 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Disseldorp <ddiss@suse.de>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 4/6] initramfs: Refactor to use hex2bin() instead of custom approach
Date: Mon, 23 Mar 2026 15:54:20 +0100
Message-ID: <20260323150054.3587083-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a simple_strntoul() function used solely as a shortcut
for hex2bin() with proper endianess conversions. Replace that
and drop the unneeded function in the next changes.

This implementation will abort if we fail to parse the cpio header,
instead of using potentially bogus header values.

Co-developed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 init/initramfs.c      | 44 +++++++++++++++++++++++++------------------
 init/initramfs_test.c | 23 ++++------------------
 2 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 4ed796566cf3..0d38ea8e63a2 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -6,6 +6,7 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/hex.h>
 #include <linux/init.h>
 #include <linux/init_syscalls.h>
 #include <linux/kstrtox.h>
@@ -21,6 +22,8 @@
 #include <linux/umh.h>
 #include <linux/utime.h>
 
+#include <asm/byteorder.h>
+
 #include "do_mounts.h"
 #include "initramfs_internal.h"
 
@@ -190,26 +193,30 @@ static __initdata gid_t gid;
 static __initdata unsigned rdev;
 static __initdata u32 hdr_csum;
 
-static void __init parse_header(char *s)
+static int __init parse_header(char *s)
 {
-	unsigned long parsed[13];
-	int i;
+	__be32 header[13];
+	int ret;
 
-	for (i = 0, s += 6; i < 13; i++, s += 8)
-		parsed[i] = simple_strntoul(s, NULL, 16, 8);
+	ret = hex2bin((u8 *)header, s + 6, sizeof(header));
+	if (ret) {
+		error("damaged header");
+		return ret;
+	}
 
-	ino = parsed[0];
-	mode = parsed[1];
-	uid = parsed[2];
-	gid = parsed[3];
-	nlink = parsed[4];
-	mtime = parsed[5]; /* breaks in y2106 */
-	body_len = parsed[6];
-	major = parsed[7];
-	minor = parsed[8];
-	rdev = new_encode_dev(MKDEV(parsed[9], parsed[10]));
-	name_len = parsed[11];
-	hdr_csum = parsed[12];
+	ino = be32_to_cpu(header[0]);
+	mode = be32_to_cpu(header[1]);
+	uid = be32_to_cpu(header[2]);
+	gid = be32_to_cpu(header[3]);
+	nlink = be32_to_cpu(header[4]);
+	mtime = be32_to_cpu(header[5]); /* breaks in y2106 */
+	body_len = be32_to_cpu(header[6]);
+	major = be32_to_cpu(header[7]);
+	minor = be32_to_cpu(header[8]);
+	rdev = new_encode_dev(MKDEV(be32_to_cpu(header[9]), be32_to_cpu(header[10])));
+	name_len = be32_to_cpu(header[11]);
+	hdr_csum = be32_to_cpu(header[12]);
+	return 0;
 }
 
 /* FSM */
@@ -289,7 +296,8 @@ static int __init do_header(void)
 			error("no cpio magic");
 		return 1;
 	}
-	parse_header(collected);
+	if (parse_header(collected))
+		return 1;
 	next_header = this_header + N_ALIGN(name_len) + body_len;
 	next_header = (next_header + 3) & ~3;
 	state = SkipIt;
diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 4d9a4075476c..df484f9d9c1b 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -499,8 +499,7 @@ static void __init initramfs_test_hdr_hex(struct kunit *test)
 {
 	char *err, *fmt;
 	size_t len;
-	struct kstat st0, st1;
-	char fdata[] = "this file data will be unpacked";
+	char fdata[] = "this file data will not be unpacked";
 	struct initramfs_test_bufs {
 		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)) * 2];
 	} *tbufs = kzalloc(sizeof(struct initramfs_test_bufs), GFP_KERNEL);
@@ -528,28 +527,14 @@ static void __init initramfs_test_hdr_hex(struct kunit *test)
 	/*
 	 * override CPIO_HDR_FMT and instead use a format string which places
 	 * "0x" prefixes on the uid, gid and namesize values.
-	 * parse_header()/simple_str[n]toul() accept this.
+	 * parse_header()/simple_str[n]toul() accepted this, contrary to the
+	 * initramfs specification. hex2bin() now fails.
 	 */
 	fmt = "%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s";
 	len = fill_cpio(c, ARRAY_SIZE(c), fmt, tbufs->cpio_src);
 
 	err = unpack_to_rootfs(tbufs->cpio_src, len);
-	KUNIT_EXPECT_NULL(test, err);
-
-	KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st0, 0), 0);
-	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st1, 0), 0);
-
-	KUNIT_EXPECT_TRUE(test,
-		uid_eq(st0.uid, make_kuid(current_user_ns(), (uid_t)0x123456)));
-	KUNIT_EXPECT_TRUE(test,
-		gid_eq(st0.gid, make_kgid(current_user_ns(), (gid_t)0x123457)));
-	KUNIT_EXPECT_TRUE(test,
-		uid_eq(st1.uid, make_kuid(current_user_ns(), (uid_t)0x56)));
-	KUNIT_EXPECT_TRUE(test,
-		gid_eq(st1.gid, make_kgid(current_user_ns(), (gid_t)0x57)));
-
-	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-	KUNIT_EXPECT_EQ(test, init_rmdir(c[1].fname), 0);
+	KUNIT_EXPECT_NOT_NULL(test, err);
 
 	kfree(tbufs);
 }
-- 
2.50.1

