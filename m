Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40843BADBD
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940768; cv=none; b=ErYR6yhLQiM9juBobzuhcOAuM0Mi40cMi7cIL8SpkZ7avwRP4df/7aPx4YAfErwNj3T0fUuC02YqK5TakLwQ1LGcCJ3cnSqzTzkzh2x/F418ANSbDpGymbYCvp6aDXDm0PrO6//kX/v2NcJFA+pff08tZw16NgV/+zEQiyqPbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940768; c=relaxed/simple;
	bh=CdRTjobQteWp8YK55b49xdhgexe3tPqKB+Av8mYKE4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X76gTeRkrgQZSXL/RORY+3/7GFYQaZRM7LBQqqUuNxl1W+kfIjUHZb8bRpRXbl7J8ugrpcIYE+fV7PqhzROg8mD5fB9e7rEopJ+85KU+/R+7sZeauF3ZmyqPApenUZzjzuATUewsQkbCzkY006j7lVi77cvlgmE/+WLEQtBo23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FB1F5BEA4;
	Tue, 31 Mar 2026 07:06:05 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68BE44A0A2;
	Tue, 31 Mar 2026 07:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SLjTCFlyy2mEQAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 31 Mar 2026 07:06:01 +0000
From: David Disseldorp <ddiss@suse.de>
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
Subject: [PATCH v5 4/6] initramfs: Refactor to use hex2bin() instead of custom approach
Date: Tue, 31 Mar 2026 17:57:34 +1100
Message-ID: <20260331070519.5974-5-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260331070519.5974-1-ddiss@suse.de>
References: <20260331070519.5974-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 5FB1F5BEA4
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
 init/initramfs_test.c | 24 ++++-------------------
 2 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 4ed796566cf35..0d38ea8e63a29 100644
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
index b9f83dc194aa6..8a0ddc2db2c08 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -31,8 +31,8 @@ struct initramfs_test_cpio {
 #define CPIO_HDR_FMT "%s%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%s"
 /*
  * Bogus newc header with "0x" prefixes on the uid, gid, and namesize values.
- * parse_header()/simple_str[n]toul() accept this, contrary to the initramfs
- * specification.
+ * parse_header()/simple_str[n]toul() accepted this, contrary to the initramfs
+ * specification. hex2bin() now fails.
  */
 #define CPIO_HDR_OX_INJECT \
 	"%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s"
@@ -508,8 +508,7 @@ static void __init initramfs_test_hdr_hex(struct kunit *test)
 {
 	char *err;
 	size_t len;
-	struct kstat st0 = {}, st1 = {};
-	char fdata[] = "this file data will be unpacked";
+	char fdata[] = "this file data will not be unpacked";
 	struct initramfs_test_bufs {
 		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)) * 2];
 	} *tbufs = kzalloc(sizeof(struct initramfs_test_bufs), GFP_KERNEL);
@@ -539,22 +538,7 @@ static void __init initramfs_test_hdr_hex(struct kunit *test)
 	len = fill_cpio(c, ARRAY_SIZE(c), true, tbufs->cpio_src);
 
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
2.51.0

