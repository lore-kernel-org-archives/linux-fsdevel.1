Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D8266B72
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338138; cv=none; b=YOMfoYwRldWvPZdn6CYM0KYEOV3Nqu+oNkN0NezCv8SS7qKOLaT2CvL4MCCDX5ZtVoNXBnYBSbehWM4qvVfQJCnZp9qNvOKiY6KBXcyfigZwXEerTln2bkFCo5TG6WPInM1ZpqpC5x8bxEUbz9+BLuFyfkbjT4JltgMTD4GYvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338138; c=relaxed/simple;
	bh=q3H93oLj8BsXMEEymm+eqTeAcXI0R4qYdkcypr1sD+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovCZacL3SDTyvi8eFbPyA3JsbSD1ELa9CS2hDk1qyAFxmjFdhRQKRvg5mdRYyne9cR8Yp+Ym8KxBQLqPYIP5RFg5ag+S2K1kfJXJ8MDgNPoSXrYgHGtdzRn36sMFUw6SL/YAWaLTo5bYRCt7cg48wfg8Hw5EbIgoO10fgJDFZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KsHY/iBH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+29bi9Rm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mYgYvALV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q+BLmyxx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KsHY/iBH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+29bi9Rm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mYgYvALV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q+BLmyxx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC4AD3DFB;
	Wed, 29 Jul 2026 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785338130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=koLhMxy+YuJ/8H2x9zHM6glRY93gfjLZAal6V9dfBoY=;
	b=KsHY/iBHk3349gUA3Cke0KiSqJT0uKKaamMvIffk5zflwwQ5+ZxjXdwyThpvqiq09Q7gkW
	AZN+uPKQ6LrhJRhMpw4fqEJ25mhnrkR2sY1x1DtrTwoyamAFF7gc44qUH5kTnsh8G8O2zi
	q/mU4w8Hx0DWHoIq94aB/08WMMVa4J8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785338130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=koLhMxy+YuJ/8H2x9zHM6glRY93gfjLZAal6V9dfBoY=;
	b=+29bi9Rmgg7PW3B1Zc74QpugWuLBn2vqEAA42ZjHD/4AkWm8phWf90vxW3N/arwe9adCHv
	fZsiYm3RtnF7w3DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785338125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=koLhMxy+YuJ/8H2x9zHM6glRY93gfjLZAal6V9dfBoY=;
	b=mYgYvALVx3rpG/QKUd35XXWt9TfDf4+IraIcAa4ZjgKvVIkBWYpFynJPhKWUeNQOtfqvNN
	igrq1T9NacVniQ4ySYHBJmexnW2sYb5mB8IFOPvKdskcrlSly7GS3XPaTy1ktZtH5ab4Zw
	u0yXCQFO8eTnphPusRjaolmqC68iO1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785338125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=koLhMxy+YuJ/8H2x9zHM6glRY93gfjLZAal6V9dfBoY=;
	b=Q+BLmyxx9KxLhVGvqwTbUEdLtvyBKdIP1Qu4ugt+FrOGCpGWgUxRpt2eeiQgNWhBjxYM4B
	o9VX38AXBhx/EdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88F83779A1;
	Wed, 29 Jul 2026 15:15:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k9HoEAwZamq1ZAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 29 Jul 2026 15:15:24 +0000
From: David Disseldorp <ddiss@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH vfs-7.3.kthread] initramfs_test: use test init/exit hooks to override init fs
Date: Thu, 30 Jul 2026 01:13:21 +1000
Message-ID: <20260729151320.21001-2-ddiss@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Most initramfs kunit tests interact with initramfs via
unpack_to_rootfs() and subsequently init_stat(), init_unlink(), etc.

Commit 804dd204728c9 ("kunit: use scoped_with_init_fs() in tests that
resolve paths") added scoped_with_init_fs() wrappers around the
initramfs I/O calls, but it's cleaner and less error-prone to override
current->fs with userspace_init_fs for all initramfs_test_suite tests.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
Christian: feel free to squash this in with your 804dd204728c9 commit
if you think it makes sense.

 init/initramfs_test.c | 239 ++++++++++++++++++++----------------------
 1 file changed, 113 insertions(+), 126 deletions(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 1fc990a66563e..9cf316c13ffa5 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -117,41 +117,38 @@ static void __init initramfs_test_extract(struct kunit *test)
 			      GFP_KERNEL);
 	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
-	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
-	scoped_with_init_fs() {
-		ktime_get_real_ts64(&ts_before);
-		err = unpack_to_rootfs(cpio_srcbuf, len);
-		ktime_get_real_ts64(&ts_after);
-		if (err) {
-			KUNIT_FAIL(test, "unpack failed %s", err);
-			goto out;
-		}
-
-		KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st, 0), 0);
-		KUNIT_EXPECT_TRUE(test, S_ISREG(st.mode));
-		KUNIT_EXPECT_TRUE(test, uid_eq(st.uid, KUIDT_INIT(c[0].uid)));
-		KUNIT_EXPECT_TRUE(test, gid_eq(st.gid, KGIDT_INIT(c[0].gid)));
-		KUNIT_EXPECT_EQ(test, st.nlink, 1);
-		if (IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME)) {
-			KUNIT_EXPECT_EQ(test, st.mtime.tv_sec, c[0].mtime);
-		} else {
-			KUNIT_EXPECT_GE(test, st.mtime.tv_sec, ts_before.tv_sec);
-			KUNIT_EXPECT_LE(test, st.mtime.tv_sec, ts_after.tv_sec);
-		}
-		KUNIT_EXPECT_EQ(test, st.blocks, c[0].filesize);
-
-		KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st, 0), 0);
-		KUNIT_EXPECT_TRUE(test, S_ISDIR(st.mode));
-		if (IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME)) {
-			KUNIT_EXPECT_EQ(test, st.mtime.tv_sec, c[1].mtime);
-		} else {
-			KUNIT_EXPECT_GE(test, st.mtime.tv_sec, ts_before.tv_sec);
-			KUNIT_EXPECT_LE(test, st.mtime.tv_sec, ts_after.tv_sec);
-		}
-
-		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-		KUNIT_EXPECT_EQ(test, init_rmdir(c[1].fname), 0);
+	ktime_get_real_ts64(&ts_before);
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	ktime_get_real_ts64(&ts_after);
+	if (err) {
+		KUNIT_FAIL(test, "unpack failed %s", err);
+		goto out;
 	}
+
+	KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st, 0), 0);
+	KUNIT_EXPECT_TRUE(test, S_ISREG(st.mode));
+	KUNIT_EXPECT_TRUE(test, uid_eq(st.uid, KUIDT_INIT(c[0].uid)));
+	KUNIT_EXPECT_TRUE(test, gid_eq(st.gid, KGIDT_INIT(c[0].gid)));
+	KUNIT_EXPECT_EQ(test, st.nlink, 1);
+	if (IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME)) {
+		KUNIT_EXPECT_EQ(test, st.mtime.tv_sec, c[0].mtime);
+	} else {
+		KUNIT_EXPECT_GE(test, st.mtime.tv_sec, ts_before.tv_sec);
+		KUNIT_EXPECT_LE(test, st.mtime.tv_sec, ts_after.tv_sec);
+	}
+	KUNIT_EXPECT_EQ(test, st.blocks, c[0].filesize);
+
+	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st, 0), 0);
+	KUNIT_EXPECT_TRUE(test, S_ISDIR(st.mode));
+	if (IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME)) {
+		KUNIT_EXPECT_EQ(test, st.mtime.tv_sec, c[1].mtime);
+	} else {
+		KUNIT_EXPECT_GE(test, st.mtime.tv_sec, ts_before.tv_sec);
+		KUNIT_EXPECT_LE(test, st.mtime.tv_sec, ts_after.tv_sec);
+	}
+
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_rmdir(c[1].fname), 0);
 out:
 	kfree(cpio_srcbuf);
 }
@@ -201,11 +198,8 @@ static void __init initramfs_test_fname_overrun(struct kunit *test)
 		suffix_off--;
 	}
 
-	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
-	scoped_with_init_fs() {
-		err = unpack_to_rootfs(cpio_srcbuf, len);
-		KUNIT_EXPECT_NOT_NULL(test, err);
-	}
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NOT_NULL(test, err);
 
 	kfree(cpio_srcbuf);
 }
@@ -240,25 +234,22 @@ static void __init initramfs_test_data(struct kunit *test)
 
 	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
-	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
-	scoped_with_init_fs() {
-		err = unpack_to_rootfs(cpio_srcbuf, len);
-		KUNIT_EXPECT_NULL(test, err);
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NULL(test, err);
 
-		file = filp_open(c[0].fname, O_RDONLY, 0);
-		if (IS_ERR(file)) {
-			KUNIT_FAIL(test, "open failed");
-			goto out;
-		}
+	file = filp_open(c[0].fname, O_RDONLY, 0);
+	if (IS_ERR(file)) {
+		KUNIT_FAIL(test, "open failed");
+		goto out;
+	}
 
-		/* read back file contents into @cpio_srcbuf and confirm match */
-		len = kernel_read(file, cpio_srcbuf, c[0].filesize, NULL);
-		KUNIT_EXPECT_EQ(test, len, c[0].filesize);
-		KUNIT_EXPECT_MEMEQ(test, cpio_srcbuf, c[0].data, len);
+	/* read back file contents into @cpio_srcbuf and confirm match */
+	len = kernel_read(file, cpio_srcbuf, c[0].filesize, NULL);
+	KUNIT_EXPECT_EQ(test, len, c[0].filesize);
+	KUNIT_EXPECT_MEMEQ(test, cpio_srcbuf, c[0].data, len);
 
-		fput(file);
-		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-	}
+	fput(file);
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
 out:
 	kfree(cpio_srcbuf);
 }
@@ -298,28 +289,25 @@ static void __init initramfs_test_csum(struct kunit *test)
 
 	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
-	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
-	scoped_with_init_fs() {
-		err = unpack_to_rootfs(cpio_srcbuf, len);
-		KUNIT_EXPECT_NULL(test, err);
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NULL(test, err);
 
-		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-		KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), 0);
 
-		/* mess up the csum and confirm that unpack fails */
-		c[0].csum--;
-		len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
+	/* mess up the csum and confirm that unpack fails */
+	c[0].csum--;
+	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
-		err = unpack_to_rootfs(cpio_srcbuf, len);
-		KUNIT_EXPECT_NOT_NULL(test, err);
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NOT_NULL(test, err);
 
-		/*
-		 * file (with content) is still retained in case of bad-csum abort.
-		 * Perhaps we should change this.
-		 */
-		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-		KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), -ENOENT);
-	}
+	/*
+	 * file (with content) is still retained in case of bad-csum abort.
+	 * Perhaps we should change this.
+	 */
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), -ENOENT);
 	kfree(cpio_srcbuf);
 }
 
@@ -357,20 +345,17 @@ static void __init initramfs_test_hardlink(struct kunit *test)
 
 	len = fill_cpio(c, ARRAY_SIZE(c), false, cpio_srcbuf);
 
-	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
-	scoped_with_init_fs() {
-		err = unpack_to_rootfs(cpio_srcbuf, len);
-		KUNIT_EXPECT_NULL(test, err);
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NULL(test, err);
 
-		KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st0, 0), 0);
-		KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st1, 0), 0);
-		KUNIT_EXPECT_EQ(test, st0.ino, st1.ino);
-		KUNIT_EXPECT_EQ(test, st0.nlink, 2);
-		KUNIT_EXPECT_EQ(test, st1.nlink, 2);
+	KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st0, 0), 0);
+	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st1, 0), 0);
+	KUNIT_EXPECT_EQ(test, st0.ino, st1.ino);
+	KUNIT_EXPECT_EQ(test, st0.nlink, 2);
+	KUNIT_EXPECT_EQ(test, st1.nlink, 2);
 
-		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-		KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), 0);
-	}
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), 0);
 
 	kfree(cpio_srcbuf);
 }
@@ -403,15 +388,12 @@ static void __init initramfs_test_many(struct kunit *test)
 	}
 
 	len = p - cpio_srcbuf;
-	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
-	scoped_with_init_fs() {
-		err = unpack_to_rootfs(cpio_srcbuf, len);
-		KUNIT_EXPECT_NULL(test, err);
-
-		for (i = 0; i < INITRAMFS_TEST_MANY_LIMIT; i++) {
-			sprintf(thispath, "initramfs_test_many-%d", i);
-			KUNIT_EXPECT_EQ(test, init_unlink(thispath), 0);
-		}
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	for (i = 0; i < INITRAMFS_TEST_MANY_LIMIT; i++) {
+		sprintf(thispath, "initramfs_test_many-%d", i);
+		KUNIT_EXPECT_EQ(test, init_unlink(thispath), 0);
 	}
 
 	kfree(cpio_srcbuf);
@@ -458,25 +440,22 @@ static void __init initramfs_test_fname_pad(struct kunit *test)
 	memcpy(tbufs->padded_fname, "padded_fname", sizeof("padded_fname"));
 	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_srcbuf);
 
-	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
-	scoped_with_init_fs() {
-		err = unpack_to_rootfs(tbufs->cpio_srcbuf, len);
-		KUNIT_EXPECT_NULL(test, err);
+	err = unpack_to_rootfs(tbufs->cpio_srcbuf, len);
+	KUNIT_EXPECT_NULL(test, err);
 
-		file = filp_open(c[0].fname, O_RDONLY, 0);
-		if (IS_ERR(file)) {
-			KUNIT_FAIL(test, "open failed");
-			goto out;
-		}
+	file = filp_open(c[0].fname, O_RDONLY, 0);
+	if (IS_ERR(file)) {
+		KUNIT_FAIL(test, "open failed");
+		goto out;
+	}
 
-		/* read back file contents into @cpio_srcbuf and confirm match */
-		len = kernel_read(file, tbufs->cpio_srcbuf, c[0].filesize, NULL);
-		KUNIT_EXPECT_EQ(test, len, c[0].filesize);
-		KUNIT_EXPECT_MEMEQ(test, tbufs->cpio_srcbuf, c[0].data, len);
+	/* read back file contents into @cpio_srcbuf and confirm match */
+	len = kernel_read(file, tbufs->cpio_srcbuf, c[0].filesize, NULL);
+	KUNIT_EXPECT_EQ(test, len, c[0].filesize);
+	KUNIT_EXPECT_MEMEQ(test, tbufs->cpio_srcbuf, c[0].data, len);
 
-		fput(file);
-		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-	}
+	fput(file);
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
 out:
 	kfree(tbufs);
 }
@@ -517,16 +496,13 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	memcpy(tbufs->fname_ok, "fname_ok", sizeof("fname_ok") - 1);
 	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_src);
 
-	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
-	scoped_with_init_fs() {
-		/* unpack skips over fname_oversize instead of returning an error */
-		err = unpack_to_rootfs(tbufs->cpio_src, len);
-		KUNIT_EXPECT_NULL(test, err);
+	/* unpack skips over fname_oversize instead of returning an error */
+	err = unpack_to_rootfs(tbufs->cpio_src, len);
+	KUNIT_EXPECT_NULL(test, err);
 
-		KUNIT_EXPECT_EQ(test, init_stat("fname_oversize", &st0, 0), -ENOENT);
-		KUNIT_EXPECT_EQ(test, init_stat("fname_ok", &st1, 0), 0);
-		KUNIT_EXPECT_EQ(test, init_rmdir("fname_ok"), 0);
-	}
+	KUNIT_EXPECT_EQ(test, init_stat("fname_oversize", &st0, 0), -ENOENT);
+	KUNIT_EXPECT_EQ(test, init_stat("fname_ok", &st1, 0), 0);
+	KUNIT_EXPECT_EQ(test, init_rmdir("fname_ok"), 0);
 
 	kfree(tbufs);
 }
@@ -564,11 +540,8 @@ static void __init initramfs_test_hdr_hex(struct kunit *test)
 	/* inject_ox=true to add "0x" cpio field prefixes */
 	len = fill_cpio(c, ARRAY_SIZE(c), true, tbufs->cpio_src);
 
-	/* Tests run in a nullfs kthread; borrow the init fs for path resolution. */
-	scoped_with_init_fs() {
-		err = unpack_to_rootfs(tbufs->cpio_src, len);
-		KUNIT_EXPECT_NOT_NULL(test, err);
-	}
+	err = unpack_to_rootfs(tbufs->cpio_src, len);
+	KUNIT_EXPECT_NOT_NULL(test, err);
 
 	kfree(tbufs);
 }
@@ -590,7 +563,7 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
 	{},
 };
 
-static int __init initramfs_test_init(struct kunit_suite *suite)
+static int __init initramfs_suite_init(struct kunit_suite *suite)
 {
 	/*
 	 * unpack_to_rootfs() uses module-static state (victim, byte_count,
@@ -602,9 +575,23 @@ static int __init initramfs_test_init(struct kunit_suite *suite)
 	return 0;
 }
 
+/* Tests run in a nullfs kthread; always use the init fs for path resolution. */
+static int __init initramfs_test_init(struct kunit *test)
+{
+	test->priv = __override_init_fs();
+	return 0;
+}
+
+static void __init initramfs_test_exit(struct kunit *test)
+{
+	__revert_init_fs(test->priv);
+}
+
 static struct kunit_suite __refdata initramfs_test_suite = {
 	.name = "initramfs",
-	.suite_init = initramfs_test_init,
+	.suite_init = initramfs_suite_init,
+	.init = initramfs_test_init,
+	.exit = initramfs_test_exit,
 	.test_cases = initramfs_test_cases,
 };
 kunit_test_init_section_suites(&initramfs_test_suite);
-- 
2.55.0

