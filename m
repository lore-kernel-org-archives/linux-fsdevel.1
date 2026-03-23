Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D99245020;
	Mon, 23 Mar 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278070; cv=none; b=jw93sCzErvgtjVvyfVzpyj92MnpCjAVjSVfz8gBOQGldZSN1E9+lPsN8k2XXNpJOyWzbKAspmW+VhqJFNGcR01pCKKxbhARJlgu53gQyH5ydaz4SkzuBvRBTMHLGU8KV7QYT38KuQgLeHkHEafcyuh40mbqrVjY/KTkH5Pg7pLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278070; c=relaxed/simple;
	bh=tEEgkiZs3Txk28j7BqRxxstVKJ421N/CH6XstsQpICk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjwAkh638oRXyFJY9FpLcAwg5qAg0SUosNLjItrPPBAwBkxRNovDZZHfLVgihSJgidLp9qFbef4gzwCzV/nxm3UpYMcme7QQLHGSaff2kBlhnj4Si+gEoLuxuFk2J4ZCDG+g5ClWifP4hrkQHAkoTtp9OiG+fZ4xf11F+I8Muac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2V+5mF2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2V+5mF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774278069; x=1805814069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tEEgkiZs3Txk28j7BqRxxstVKJ421N/CH6XstsQpICk=;
  b=D2V+5mF2Xxivkb/lqemhFGTECdKUxNq5j7LVvbnW5pBwcwxK2ucytGlY
   stoLD4SLwCAQRt9734Qk//RU3bNNloMLQW7zEuZyxqOwxmgyDQHyabr28
   VhyBZph/mDOHVS8CpYETzbCn3hXcencEp5artO7AdWv3c9svz5S+P5Jk2
   qZZ7RcYA1UrxBJWd+LPBVmV88MYhLnx1YtXjx0ysITA+ESYxKRrPZiH0d
   q4BczUuQLXrIyTFV3IqApzN7GNNAGgqiIEyefU4UCty4CGHQR632y+7c1
   RQ6xJ5oszxFn8WNlBJh0EiEslFPCuOy6zsISc5xKGw+50lOOydZReIeWf
   Q==;
X-CSE-ConnectionGUID: ZIkhZUG2TJGtjmLKp/f1kw==
X-CSE-MsgGUID: uBAa7mrnTSetmXz6KD8hsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74456169"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74456169"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 08:01:05 -0700
X-CSE-ConnectionGUID: 21TjuvBKTzu3CogEE/azjQ==
X-CSE-MsgGUID: jKCxOJ+oSIuNFajlZpVCnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223119640"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 23 Mar 2026 08:01:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2092499; Mon, 23 Mar 2026 16:01:00 +0100 (CET)
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
Subject: [PATCH v3 1/6] initramfs_test: add fill_cpio() format parameter
Date: Mon, 23 Mar 2026 15:54:17 +0100
Message-ID: <20260323150054.3587083-2-andriy.shevchenko@linux.intel.com>
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

From: David Disseldorp <ddiss@suse.de>

fill_cpio() uses sprintf() to write out the in-memory cpio archive from
an array of struct initramfs_test_cpio. This change allows callers to
override the cpio sprintf() format string so that future tests can
intentionally corrupt the header with non-hex values.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 init/initramfs_test.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 2ce38d9a8fd0..7b6ecab794c7 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -27,7 +27,10 @@ struct initramfs_test_cpio {
 	char *data;
 };
 
-static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
+#define CPIO_HDR_FMT "%s%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%s"
+
+static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *fmt,
+			char *out)
 {
 	int i;
 	size_t off = 0;
@@ -38,9 +41,7 @@ static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
 		size_t thislen;
 
 		/* +1 to account for nulterm */
-		thislen = sprintf(pos, "%s"
-			"%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x"
-			"%s",
+		thislen = sprintf(pos, fmt,
 			c->magic, c->ino, c->mode, c->uid, c->gid, c->nlink,
 			c->mtime, c->filesize, c->devmajor, c->devminor,
 			c->rdevmajor, c->rdevminor, c->namesize, c->csum,
@@ -102,7 +103,7 @@ static void __init initramfs_test_extract(struct kunit *test)
 	/* +3 to cater for any 4-byte end-alignment */
 	cpio_srcbuf = kzalloc(ARRAY_SIZE(c) * (CPIO_HDRLEN + PATH_MAX + 3),
 			      GFP_KERNEL);
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 
 	ktime_get_real_ts64(&ts_before);
 	err = unpack_to_rootfs(cpio_srcbuf, len);
@@ -177,7 +178,7 @@ static void __init initramfs_test_fname_overrun(struct kunit *test)
 	/* limit overrun to avoid crashes / filp_open() ENAMETOOLONG */
 	cpio_srcbuf[CPIO_HDRLEN + strlen(c[0].fname) + 20] = '\0';
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 	/* overwrite trailing fname terminator and padding */
 	suffix_off = len - 1;
 	while (cpio_srcbuf[suffix_off] == '\0') {
@@ -219,7 +220,7 @@ static void __init initramfs_test_data(struct kunit *test)
 	cpio_srcbuf = kmalloc(CPIO_HDRLEN + c[0].namesize + c[0].filesize + 6,
 			      GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -274,7 +275,7 @@ static void __init initramfs_test_csum(struct kunit *test)
 
 	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -284,7 +285,7 @@ static void __init initramfs_test_csum(struct kunit *test)
 
 	/* mess up the csum and confirm that unpack fails */
 	c[0].csum--;
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NOT_NULL(test, err);
@@ -330,7 +331,7 @@ static void __init initramfs_test_hardlink(struct kunit *test)
 
 	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -371,7 +372,7 @@ static void __init initramfs_test_many(struct kunit *test)
 		};
 
 		c.namesize = 1 + sprintf(thispath, "initramfs_test_many-%d", i);
-		p += fill_cpio(&c, 1, p);
+		p += fill_cpio(&c, 1, CPIO_HDR_FMT, p);
 	}
 
 	len = p - cpio_srcbuf;
@@ -425,7 +426,7 @@ static void __init initramfs_test_fname_pad(struct kunit *test)
 	} };
 
 	memcpy(tbufs->padded_fname, "padded_fname", sizeof("padded_fname"));
-	len = fill_cpio(c, ARRAY_SIZE(c), tbufs->cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, tbufs->cpio_srcbuf);
 
 	err = unpack_to_rootfs(tbufs->cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -481,7 +482,7 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	memcpy(tbufs->fname_oversize, "fname_oversize",
 	       sizeof("fname_oversize") - 1);
 	memcpy(tbufs->fname_ok, "fname_ok", sizeof("fname_ok") - 1);
-	len = fill_cpio(c, ARRAY_SIZE(c), tbufs->cpio_src);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, tbufs->cpio_src);
 
 	/* unpack skips over fname_oversize instead of returning an error */
 	err = unpack_to_rootfs(tbufs->cpio_src, len);
-- 
2.50.1

