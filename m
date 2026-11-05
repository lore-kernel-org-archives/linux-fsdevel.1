Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877461;
	b=c4pdm7DC/WrAvA+m5AHn99B6/q0ZK8rniT4oTKlX+EBTm8ivEFAuNMTUa9Bo/VLy8HWJ
	 9jCVhlJgBmnHxzD5bD06QxrVqfz0S3qY2JFuN8+7b3ueAu1vM5fUv0WAYFXGTyXEc1Ach
	 r/0z/1u7cctXW7KpG1P6PF/M3gKqlgWOhyqU8I7INkicsHBIbCUrEieXOD+xZhXHJKdVZ
	 yfGg7cJ9/TOBmJ311pSSDLbmUkTkE9XxKM74NTzttRrWTzwjaoitb7KLAk70HFVnKBUEQ
	 cVUcQn+IqBKS1KvfiRpbmhaUqZYBCoeFqZMQGY3Jt2gvlscpopEY2calr/cqymt4DNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877461;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=msp994urLwWxZ+8aYsZyEqhRjD4sYQdz1y2nQk5mPq4=;
	b=U11cZD3RNY66WqB8ay+VVrRVq3mu6l2lAWmQWdzoc+rc4MwhrRoDrdz6xm1p2sq9s6Nr
	 B8hVZMaKYQSXsE7138HhoNBldKmTrMpNJ6RcWOUU1R1MsT0/+j4Pc4AZ1+1supQdmE9n3
	 nLe+pQbO5r5wUjpkdRW3WkiNCHdWMTWZrHvTG0XbIYG9gw+fT9PTE41kAr23hIbS56G1p
	 KE3sHCx7ClEBsXOLRei/YbSpLAap5x77d8bRMdndrVeOWgsTCZdChCm0B1j42Ye7sCX8s
	 u18+rR3tn93q2mnvedoHH3xhkcH3McTRn+McDcr0exYlMe9RSlf3JuQQMRDaufcrW6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eGgRAWHu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAoGLGsF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eGgRAWHu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAoGLGsF;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C65606A333
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 11:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C65606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eGgRAWHu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAoGLGsF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eGgRAWHu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAoGLGsF
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE1F41F387;
	Thu,  5 Nov 2026 11:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793877459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msp994urLwWxZ+8aYsZyEqhRjD4sYQdz1y2nQk5mPq4=;
	b=eGgRAWHugwcD81/MIon8cosx7yQKkZfHQGU/MtDuAQfw5cFJTjll9ZH+FvjRslBzeAMtKB
	VAcHhy2ZfJsLzkxsmaEFp3CXQTIfFJFBlxbDLPxM0OJ8FO3+16CsAezMOpRzaw3CW4Vyza
	8Ozo+55DOgg1z5JryW+V6PtHGMzhfZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793877459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msp994urLwWxZ+8aYsZyEqhRjD4sYQdz1y2nQk5mPq4=;
	b=pAoGLGsFQkmWFSVeNDIZS06OfRA3GRGhyCOPwdfqrRhAzX1J3xukAMIbyhmXb5cko0PbA8
	9wZgQhP8LWq9S3AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793877459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msp994urLwWxZ+8aYsZyEqhRjD4sYQdz1y2nQk5mPq4=;
	b=eGgRAWHugwcD81/MIon8cosx7yQKkZfHQGU/MtDuAQfw5cFJTjll9ZH+FvjRslBzeAMtKB
	VAcHhy2ZfJsLzkxsmaEFp3CXQTIfFJFBlxbDLPxM0OJ8FO3+16CsAezMOpRzaw3CW4Vyza
	8Ozo+55DOgg1z5JryW+V6PtHGMzhfZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793877459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msp994urLwWxZ+8aYsZyEqhRjD4sYQdz1y2nQk5mPq4=;
	b=pAoGLGsFQkmWFSVeNDIZS06OfRA3GRGhyCOPwdfqrRhAzX1J3xukAMIbyhmXb5cko0PbA8
	9wZgQhP8LWq9S3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21806134F4;
	Thu,  5 Nov 2026 11:17:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j89PKbpl7GruWwAAD6G6ig:T4
	(envelope-from <ddiss@suse.de>); Thu, 05 Nov 2026 11:17:37 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 3/3] initramfs_test: test clean_path collisions
Date: Thu,  5 Nov 2026 22:10:01 +1100
Message-ID: <20261105111654.214569-4-ddiss@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105111654.214569-1-ddiss@suse.de>
References: <20261105111654.214569-1-ddiss@suse.de>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80

initramfs unpack handles path collisions by removing an existing path
if S_IFMT flags differ from a subsequent cpio entry with the same name.
These tests exercise some of the corner cases.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs_test.c | 173 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index b6ed4490f018c..2d17c158b94d5 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -585,6 +585,176 @@ static void __init initramfs_test_dir_dataseg(struct kunit *test)
 	kfree(tbufs);
 }
 
+static void __init initramfs_test_overwrite(struct kunit *test)
+{
+	char *err;
+	size_t len;
+	struct kstat st = {};
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFDIR | 0777,
+		.nlink = 1,
+		.namesize = sizeof("dir_to_file"),
+		.fname = "dir_to_file",
+	}, {
+		.magic = "070701",
+		.ino = 2,
+		/* S_IFDIR->S_IFREG: rmdir(existing) and replace */
+		.mode = S_IFREG | 0766,
+		.nlink = 1,
+		.namesize = sizeof("dir_to_file"),
+		.fname = "dir_to_file",
+	}, {
+		.magic = "070701",
+		.ino = 3,
+		.mode = S_IFREG | 0777,
+		.nlink = 1,
+		.namesize = sizeof("file_to_dir"),
+		.fname = "file_to_dir",
+	}, {
+		.magic = "070701",
+		.ino = 4,
+		/* S_IFREG->S_IFDIR: unlink(existing) and replace */
+		.mode = S_IFDIR | 0766,
+		.nlink = 1,
+		.namesize = sizeof("file_to_dir"),
+		.fname = "file_to_dir",
+	} };
+	struct initramfs_test_bufs {
+		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3) * ARRAY_SIZE(c)];
+	} *tbufs = kzalloc_obj(struct initramfs_test_bufs);
+
+	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_src);
+
+	err = unpack_to_rootfs(tbufs->cpio_src, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	KUNIT_EXPECT_EQ(test, init_stat("dir_to_file", &st, 0), 0);
+	KUNIT_EXPECT_EQ(test, st.mode, S_IFREG | 0766);
+	KUNIT_EXPECT_EQ(test, init_unlink("dir_to_file"), 0);
+	KUNIT_EXPECT_EQ(test, init_stat("file_to_dir", &st, 0), 0);
+	KUNIT_EXPECT_EQ(test, st.mode, S_IFDIR | 0766);
+	KUNIT_EXPECT_EQ(test, init_rmdir("file_to_dir"), 0);
+	kfree(tbufs);
+}
+
+static void __init initramfs_test_overwrite_trunc(struct kunit *test)
+{
+	char *err;
+	size_t len;
+	struct kstat st = {};
+	struct file *file;
+	char fdata_long[] = "loooooooooooooooong";
+	char fdata_short[] = "short";
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFREG | 0766,
+		.nlink = 1,
+		.namesize = sizeof("file_to_file"),
+		.fname = "file_to_file",
+		.filesize = sizeof(fdata_long),
+		.data = fdata_long,
+	}, {
+		.magic = "070701",
+		.ino = 2,
+		/* S_IFREG->S_IFREG: chmod/truncate/fill */
+		.mode = S_IFREG | 0755,
+		.nlink = 1,
+		.namesize = sizeof("file_to_file"),
+		.fname = "file_to_file",
+		.filesize = sizeof(fdata_short),
+		.data = fdata_short,
+	} };
+	struct initramfs_test_bufs {
+		char iobuf[sizeof(fdata_short)];
+		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3) * ARRAY_SIZE(c)];
+	} *tbufs = kzalloc_obj(struct initramfs_test_bufs);
+
+	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_src);
+
+	err = unpack_to_rootfs(tbufs->cpio_src, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	KUNIT_EXPECT_EQ(test, init_stat("file_to_file", &st, 0), 0);
+	KUNIT_EXPECT_EQ(test, st.mode, S_IFREG | 0755);
+	if (st.size != sizeof(fdata_short)) {
+		KUNIT_FAIL(test, "unexpected st.size");
+		goto out;
+	}
+
+	file = filp_open("file_to_file", O_RDONLY, 0);
+	if (IS_ERR(file)) {
+		KUNIT_FAIL(test, "open failed");
+		goto out;
+	}
+	len = kernel_read(file, tbufs->iobuf, st.size, NULL);
+	KUNIT_EXPECT_EQ(test, len, st.size);
+	KUNIT_EXPECT_MEMEQ(test, tbufs->iobuf, fdata_short, len);
+	fput(file);
+	KUNIT_EXPECT_EQ(test, init_unlink("file_to_file"), 0);
+out:
+	kfree(tbufs);
+}
+
+static void __init initramfs_test_overwrite_parent(struct kunit *test)
+{
+	char *err;
+	size_t len;
+	struct kstat st = {};
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 5,
+		.mode = S_IFDIR | 0777,
+		.nlink = 1,
+		.namesize = sizeof("parent_dir_to_file"),
+		.fname = "parent_dir_to_file",
+	}, {
+		.magic = "070701",
+		.ino = 6,
+		.mode = S_IFDIR | 0777,
+		.nlink = 1,
+		.namesize = sizeof("parent_dir_to_file/child"),
+		.fname = "parent_dir_to_file/child",
+	}, {
+		.magic = "070701",
+		.ino = 7,
+		/* S_IFDIR->S_IFREG ignored: rmdir(parent) fails */
+		.mode = S_IFREG | 0666,
+		.nlink = 1,
+		.namesize = sizeof("parent_dir_to_file"),
+		.fname = "parent_dir_to_file",
+	}, {
+		.magic = "070701",
+		.ino = 8,
+		.mode = S_IFREG | 0777,
+		.nlink = 1,
+		.namesize = sizeof("last"),
+		.fname = "last",
+	} };
+	struct initramfs_test_bufs {
+		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3) * ARRAY_SIZE(c)];
+	} *tbufs = kzalloc_obj(struct initramfs_test_bufs);
+
+	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_src);
+
+	err = unpack_to_rootfs(tbufs->cpio_src, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	KUNIT_EXPECT_EQ(test, init_stat("parent_dir_to_file", &st, 0), 0);
+	KUNIT_EXPECT_EQ(test, st.mode, S_IFDIR | 0777);
+	KUNIT_EXPECT_EQ(test, init_stat("parent_dir_to_file/child", &st, 0), 0);
+	KUNIT_EXPECT_TRUE(test, S_ISDIR(st.mode));
+	KUNIT_EXPECT_EQ(test, init_rmdir("parent_dir_to_file/child"), 0);
+	KUNIT_EXPECT_EQ(test, init_rmdir("parent_dir_to_file"), 0);
+	KUNIT_EXPECT_EQ(test, init_stat("last", &st, 0), 0);
+	KUNIT_EXPECT_TRUE(test, S_ISREG(st.mode));
+	KUNIT_EXPECT_EQ(test, init_unlink("last"), 0);
+
+	kfree(tbufs);
+}
+
 /*
  * The kunit_case/_suite struct cannot be marked as __initdata as this will be
  * used in debugfs to retrieve results after test has run.
@@ -600,6 +770,9 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
 	KUNIT_CASE(initramfs_test_fname_path_max),
 	KUNIT_CASE(initramfs_test_hdr_hex),
 	KUNIT_CASE(initramfs_test_dir_dataseg),
+	KUNIT_CASE(initramfs_test_overwrite),
+	KUNIT_CASE(initramfs_test_overwrite_trunc),
+	KUNIT_CASE(initramfs_test_overwrite_parent),
 	{},
 };
 
-- 
2.56.0

