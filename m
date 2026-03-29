Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA3274B39
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774781616; cv=none; b=Ixr/tjwqc6yzz6xY9TEbOXN3xZT9vRr/WXwKqQqeOgXY2Qsy4/guPcEaaoEit5VTbD5KuKWNgyBNqeERHvTRHj1arI+ulnBsm+b/8zW7o8Th+0MezLZimj30JCp9IfjQXwt9xcqy8Rm3GsBunUXIORP1EJEYKmBXax2D9w/a65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774781616; c=relaxed/simple;
	bh=Ya6zLoKlFgYC44o3rc8HUO2twEzsCTjzlk0GqAXeJ8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rym+2ThQlBO8W4+ujyk9DkXvjMWxctou2eR6W0cI3o3I+wCTryG8COLEMakI+v7SdePAPby8TPb7A22lXO2bvwiKX+gib86EjilxPhNVco3ExGYwymKINKXGizzV3gue4wHXIuy0gDE8VCGS0cd9C6iP24SIvaivlkxOQmYMnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 638FB5BDD1;
	Sun, 29 Mar 2026 10:53:31 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 683DB4A0A2;
	Sun, 29 Mar 2026 10:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6HaiCKcEyWkqcwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Sun, 29 Mar 2026 10:53:27 +0000
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
Subject: [PATCH v4 1/6] initramfs_test: add fill_cpio() inject_ox parameter
Date: Sun, 29 Mar 2026 21:30:23 +1100
Message-ID: <20260329105307.2876-2-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260329105307.2876-1-ddiss@suse.de>
References: <20260329105307.2876-1-ddiss@suse.de>
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
X-Rspamd-Queue-Id: 638FB5BDD1
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
---
 init/initramfs_test.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 2ce38d9a8fd0f..3ec7591660e03 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -27,7 +27,17 @@ struct initramfs_test_cpio {
 	char *data;
 };
 
-static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
+/* regular newc header format */
+#define CPIO_HDR_FMT "%s%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%s"
+/*
+ * bogus newc header with "0x" prefixes on the uid, gid and namesize values.
+ * parse_header()/simple_str[n]toul() accept this.
+ */
+#define CPIO_HDR_OX_INJECT \
+	"%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s"
+
+static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz,
+			bool inject_ox, char *out)
 {
 	int i;
 	size_t off = 0;
@@ -38,9 +48,8 @@ static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
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
@@ -102,7 +111,7 @@ static void __init initramfs_test_extract(struct kunit *test)
 	/* +3 to cater for any 4-byte end-alignment */
 	cpio_srcbuf = kzalloc(ARRAY_SIZE(c) * (CPIO_HDRLEN + PATH_MAX + 3),
 			      GFP_KERNEL);
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
 	ktime_get_real_ts64(&ts_before);
 	err = unpack_to_rootfs(cpio_srcbuf, len);
@@ -177,7 +186,7 @@ static void __init initramfs_test_fname_overrun(struct kunit *test)
 	/* limit overrun to avoid crashes / filp_open() ENAMETOOLONG */
 	cpio_srcbuf[CPIO_HDRLEN + strlen(c[0].fname) + 20] = '\0';
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 	/* overwrite trailing fname terminator and padding */
 	suffix_off = len - 1;
 	while (cpio_srcbuf[suffix_off] == '\0') {
@@ -219,7 +228,7 @@ static void __init initramfs_test_data(struct kunit *test)
 	cpio_srcbuf = kmalloc(CPIO_HDRLEN + c[0].namesize + c[0].filesize + 6,
 			      GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -274,7 +283,7 @@ static void __init initramfs_test_csum(struct kunit *test)
 
 	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -284,7 +293,7 @@ static void __init initramfs_test_csum(struct kunit *test)
 
 	/* mess up the csum and confirm that unpack fails */
 	c[0].csum--;
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NOT_NULL(test, err);
@@ -330,7 +339,7 @@ static void __init initramfs_test_hardlink(struct kunit *test)
 
 	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -371,7 +380,7 @@ static void __init initramfs_test_many(struct kunit *test)
 		};
 
 		c.namesize = 1 + sprintf(thispath, "initramfs_test_many-%d", i);
-		p += fill_cpio(&c, 1, p);
+		p += fill_cpio(&c, 1, false, p);
 	}
 
 	len = p - cpio_srcbuf;
@@ -425,7 +434,7 @@ static void __init initramfs_test_fname_pad(struct kunit *test)
 	} };
 
 	memcpy(tbufs->padded_fname, "padded_fname", sizeof("padded_fname"));
-	len = fill_cpio(c, ARRAY_SIZE(c), tbufs->cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_srcbuf);
 
 	err = unpack_to_rootfs(tbufs->cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -481,7 +490,7 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	memcpy(tbufs->fname_oversize, "fname_oversize",
 	       sizeof("fname_oversize") - 1);
 	memcpy(tbufs->fname_ok, "fname_ok", sizeof("fname_ok") - 1);
-	len = fill_cpio(c, ARRAY_SIZE(c), tbufs->cpio_src);
+	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_src);
 
 	/* unpack skips over fname_oversize instead of returning an error */
 	err = unpack_to_rootfs(tbufs->cpio_src, len);
-- 
2.51.0

