Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF943BAD96
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940755; cv=none; b=EpoCeLwNF3OSA5u0rTa97IS33lPR670E9RaOzErQnqFHFA+AdwBJQJEiOeAIN5HLRf7m0HkxbMKfZ/gHVbg2D1oLM1xKAWb3NYYCaufVADhmm65bhgCAujytGYbz5toHt7tPljGX5JNEaOz9jyfYfSFpRS+0CV5g+lwLYx1kNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940755; c=relaxed/simple;
	bh=Z4qRXVyMBzLs4cUyAVglvKXOG3YAfN5QlN3Usvr38Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXefZOGfKr1WTLZE0y++B8nBnWiPwrhR0kl5TWIt4wr0+vsrjVqHr/Ft7bmSkckb1OUIsZcZQwh9baltyQ4222XlAxOMDqNvntB4pUczstUlAzLMlj/J+VXVbi3rKkfqRPZSwsUSDOdFA7oRW6Z5JpwH+tLLnfU0R0t7wWm7uoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D299D4D549;
	Tue, 31 Mar 2026 07:05:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB0134A0B0;
	Tue, 31 Mar 2026 07:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GCusJEtyy2mEQAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 31 Mar 2026 07:05:47 +0000
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
Subject: [PATCH v5 1/6] initramfs_test: add fill_cpio() inject_ox parameter
Date: Tue, 31 Mar 2026 17:57:31 +1100
Message-ID: <20260331070519.5974-2-ddiss@suse.de>
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D299D4D549
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

fill_cpio() uses sprintf() to write out the in-memory cpio archive from
an array of struct initramfs_test_cpio. This change allows callers to
modify the cpio sprintf() format string so that future tests can
intentionally corrupt the header with "0x" and "0X" prefixed fields.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 init/initramfs_test.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 2ce38d9a8fd0f..6fe1c44a74a58 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -27,7 +27,18 @@ struct initramfs_test_cpio {
 	char *data;
 };
 
-static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
+/* regular newc header format */
+#define CPIO_HDR_FMT "%s%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%s"
+/*
+ * Bogus newc header with "0x" prefixes on the uid, gid, and namesize values.
+ * parse_header()/simple_str[n]toul() accept this, contrary to the initramfs
+ * specification.
+ */
+#define CPIO_HDR_OX_INJECT \
+	"%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s"
+
+static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz,
+			bool inject_ox, char *out)
 {
 	int i;
 	size_t off = 0;
@@ -38,9 +49,8 @@ static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
 		size_t thislen;
 
 		/* +1 to account for nulterm */
-		thislen = sprintf(pos, "%s"
-			"%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x"
-			"%s",
+		thislen = sprintf(pos,
+			inject_ox ? CPIO_HDR_OX_INJECT : CPIO_HDR_FMT,
 			c->magic, c->ino, c->mode, c->uid, c->gid, c->nlink,
 			c->mtime, c->filesize, c->devmajor, c->devminor,
 			c->rdevmajor, c->rdevminor, c->namesize, c->csum,
@@ -102,7 +112,7 @@ static void __init initramfs_test_extract(struct kunit *test)
 	/* +3 to cater for any 4-byte end-alignment */
 	cpio_srcbuf = kzalloc(ARRAY_SIZE(c) * (CPIO_HDRLEN + PATH_MAX + 3),
 			      GFP_KERNEL);
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
 	ktime_get_real_ts64(&ts_before);
 	err = unpack_to_rootfs(cpio_srcbuf, len);
@@ -177,7 +187,7 @@ static void __init initramfs_test_fname_overrun(struct kunit *test)
 	/* limit overrun to avoid crashes / filp_open() ENAMETOOLONG */
 	cpio_srcbuf[CPIO_HDRLEN + strlen(c[0].fname) + 20] = '\0';
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 	/* overwrite trailing fname terminator and padding */
 	suffix_off = len - 1;
 	while (cpio_srcbuf[suffix_off] == '\0') {
@@ -219,7 +229,7 @@ static void __init initramfs_test_data(struct kunit *test)
 	cpio_srcbuf = kmalloc(CPIO_HDRLEN + c[0].namesize + c[0].filesize + 6,
 			      GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -274,7 +284,7 @@ static void __init initramfs_test_csum(struct kunit *test)
 
 	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -284,7 +294,7 @@ static void __init initramfs_test_csum(struct kunit *test)
 
 	/* mess up the csum and confirm that unpack fails */
 	c[0].csum--;
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NOT_NULL(test, err);
@@ -330,7 +340,7 @@ static void __init initramfs_test_hardlink(struct kunit *test)
 
 	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -371,7 +381,7 @@ static void __init initramfs_test_many(struct kunit *test)
 		};
 
 		c.namesize = 1 + sprintf(thispath, "initramfs_test_many-%d", i);
-		p += fill_cpio(&c, 1, p);
+		p += fill_cpio(&c, 1, false, p);
 	}
 
 	len = p - cpio_srcbuf;
@@ -425,7 +435,7 @@ static void __init initramfs_test_fname_pad(struct kunit *test)
 	} };
 
 	memcpy(tbufs->padded_fname, "padded_fname", sizeof("padded_fname"));
-	len = fill_cpio(c, ARRAY_SIZE(c), tbufs->cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_srcbuf);
 
 	err = unpack_to_rootfs(tbufs->cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -481,7 +491,7 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	memcpy(tbufs->fname_oversize, "fname_oversize",
 	       sizeof("fname_oversize") - 1);
 	memcpy(tbufs->fname_ok, "fname_ok", sizeof("fname_ok") - 1);
-	len = fill_cpio(c, ARRAY_SIZE(c), tbufs->cpio_src);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_src);
 
 	/* unpack skips over fname_oversize instead of returning an error */
 	err = unpack_to_rootfs(tbufs->cpio_src, len);
-- 
2.51.0

