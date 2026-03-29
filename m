Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E66A2D5A01
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774781622; cv=none; b=bQKysBwdOueFrb4931pJksVuefHRAq283PfcE2rRM52qtOA12cUHgs+ApnXbnC9z88S7jNZtvyMVmuaohlt13hQf4w7q1Eci/KYyA/YmyTKdHo5M1mYIoFjMcsD8YjX71LE+APnU3hvIEx3guk32c9q8JqPGlioTdRcHavYtJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774781622; c=relaxed/simple;
	bh=yu0ekuKmhk6KF+b7EWZ4s/+CJEGCU1mvDVfuH++T5ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbE71o80uP3WqyKyeUP4LnRt7e2F5ejtz453Tw+XSyslHkM7MRLkv0n36qBFOLx0hWu/s0bvzBYYYFdxFSBfPnE9+zT6RF5gUcznNBcYWRehzYUsrmPdnx1uO6TAyhqWKzAPBrjN81wf9jzH3o3TDin7IhASEaEBBrQhgVnLM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GQ02T1Zd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F8h4+0fk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GQ02T1Zd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F8h4+0fk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GQ02T1Zd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F8h4+0fk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GQ02T1Zd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F8h4+0fk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E351D5BDD2;
	Sun, 29 Mar 2026 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774781615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nM9vHfJigvCbxE7p4g2bM2ijYKPlux51hII50TNosU=;
	b=GQ02T1Zd/zcn4ZJnddsfTgjzwiNSoWPH5ZcIk8TWj2REttIubVep2WI8omnzIzQpvCPkfY
	3eZQrrN6uCg/tvx7wj8FssRNhKRVFcc0hPQmiX+luWgEYut39bi1AAOgygaZhvAy472E83
	xUT/dxq5QqbbHSkE1sAEdT69nTVDCKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774781615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nM9vHfJigvCbxE7p4g2bM2ijYKPlux51hII50TNosU=;
	b=F8h4+0fkfKkw/ntLs+AMzjju+1S//fe2CaZTrZNt/lryZkz5VtizfmQ1g8w3bO69Bq2rRv
	WLmAFk4kM3mx9oAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774781615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nM9vHfJigvCbxE7p4g2bM2ijYKPlux51hII50TNosU=;
	b=GQ02T1Zd/zcn4ZJnddsfTgjzwiNSoWPH5ZcIk8TWj2REttIubVep2WI8omnzIzQpvCPkfY
	3eZQrrN6uCg/tvx7wj8FssRNhKRVFcc0hPQmiX+luWgEYut39bi1AAOgygaZhvAy472E83
	xUT/dxq5QqbbHSkE1sAEdT69nTVDCKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774781615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nM9vHfJigvCbxE7p4g2bM2ijYKPlux51hII50TNosU=;
	b=F8h4+0fkfKkw/ntLs+AMzjju+1S//fe2CaZTrZNt/lryZkz5VtizfmQ1g8w3bO69Bq2rRv
	WLmAFk4kM3mx9oAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E99D24A0A2;
	Sun, 29 Mar 2026 10:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oMYqKKsEyWkqcwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Sun, 29 Mar 2026 10:53:31 +0000
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
Subject: [PATCH v4 2/6] initramfs_test: test header fields with 0x hex prefix
Date: Sun, 29 Mar 2026 21:30:24 +1100
Message-ID: <20260329105307.2876-3-ddiss@suse.de>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

cpio header fields are 8-byte hex strings, but one "interesting"
side-effect of our historic simple_str[n]toul() use means that a "0x"
(or "0X") prefixed header field will be successfully processed when
coupled alongside a 6-byte hex remainder string.

"0x" prefix support is contrary to the initramfs specification at
Documentation/driver-api/early-userspace/buffer-format.rst which states:

  The structure of the cpio_header is as follows (all fields contain
  hexadecimal ASCII numbers fully padded with '0' on the left to the
  full width of the field, for example, the integer 4780 is represented
  by the ASCII string "000012ac"):

Test for this corner case by injecting "0x" prefixes into the uid, gid
and namesize cpio header fields. Confirm that init_stat() returns
matching uid and gid values.

This test can be modified in future to expect unpack_to_rootfs() failure
when header validation is changed to properly follow the specification.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs_test.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 3ec7591660e03..4a7a85560ee50 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -503,6 +503,61 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	kfree(tbufs);
 }
 
+static void __init initramfs_test_hdr_hex(struct kunit *test)
+{
+	char *err;
+	size_t len;
+	struct kstat st0, st1;
+	char fdata[] = "this file data will be unpacked";
+	struct initramfs_test_bufs {
+		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)) * 2];
+	} *tbufs = kzalloc(sizeof(struct initramfs_test_bufs), GFP_KERNEL);
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFREG | 0777,
+		.uid = 0x123456,
+		.gid = 0x123457,
+		.nlink = 1,
+		.namesize = sizeof("initramfs_test_hdr_hex_0"),
+		.fname = "initramfs_test_hdr_hex_0",
+		.filesize = sizeof(fdata),
+		.data = fdata,
+	}, {
+		.magic = "070701",
+		.ino = 2,
+		.mode = S_IFDIR | 0777,
+		.uid = 0x000056,
+		.gid = 0x000057,
+		.nlink = 1,
+		.namesize = sizeof("initramfs_test_hdr_hex_1"),
+		.fname = "initramfs_test_hdr_hex_1",
+	} };
+
+	/* inject_ox=true to add "0x" cpio field prefixes */
+	len = fill_cpio(c, ARRAY_SIZE(c), true, tbufs->cpio_src);
+
+	err = unpack_to_rootfs(tbufs->cpio_src, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st0, 0), 0);
+	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st1, 0), 0);
+
+	KUNIT_EXPECT_TRUE(test,
+		uid_eq(st0.uid, make_kuid(current_user_ns(), (uid_t)0x123456)));
+	KUNIT_EXPECT_TRUE(test,
+		gid_eq(st0.gid, make_kgid(current_user_ns(), (gid_t)0x123457)));
+	KUNIT_EXPECT_TRUE(test,
+		uid_eq(st1.uid, make_kuid(current_user_ns(), (uid_t)0x56)));
+	KUNIT_EXPECT_TRUE(test,
+		gid_eq(st1.gid, make_kgid(current_user_ns(), (gid_t)0x57)));
+
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_rmdir(c[1].fname), 0);
+
+	kfree(tbufs);
+}
+
 /*
  * The kunit_case/_suite struct cannot be marked as __initdata as this will be
  * used in debugfs to retrieve results after test has run.
@@ -516,6 +571,7 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
 	KUNIT_CASE(initramfs_test_many),
 	KUNIT_CASE(initramfs_test_fname_pad),
 	KUNIT_CASE(initramfs_test_fname_path_max),
+	KUNIT_CASE(initramfs_test_hdr_hex),
 	{},
 };
 
-- 
2.51.0

