Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877460;
	b=w+qulk3hU6QOUK8rCbFfowsvu26nNgJhLPtvQsMx9i7OKV4/P9IooRolX0kYlTUgUMLS
	 WETmayGg9ErDZVdSLxTfgdFDe6JaDxx5PEGFBoo1FdCOFbEdwdSodtNrDwrLRf2/7S+mi
	 6trAP5rsDhl2nt3E99ApTC7NkVPMRV+VhThmhcYLEI3tm4lCSiOvOd/WbJxZoGNxkRdko
	 /2xUZIflp/uwU3briPYAyTanLiTKPZUSVlsgGrkwn+95GZQkgtQkyuCW67V40/MXefsqt
	 R/dS93CpJi7DjtNTSYTSU/fDJg3nDiwhUQNfKxOB5FAggPur7NDYcIg8GyqdvSjX5NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877460;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=8S9XUVMzqc/Tv1i/ioHxDSTQ+R2MJ62vXiLgI6jk4KE=;
	b=2iojfO/fcqeGs3fi7mu7mcBBeBk6x7OZ/I/a8hqgq6Wns3UaIIua/VErjzJ8htoDPOeg
	 524TN+apj7QwqAEMMNWRmsUoQv/0IH6fWXd58WzPt9khvSpivgaOlNMNMUJNch8GxLpJJ
	 h2qDBwmLVfeXnPOY/2mLqtyAavr1TDyi6ctFjSfD4yzVfp0clusMlye4tRFQOCfiADHru
	 309t0wg2hrZdRlOuYtRm+zoARiVBHCaJlfnyryR3MfGxX/IfKtTs8Xp73ZOIugMBK5A4E
	 WHegRq0vVwZqIBqzeHZqp6JIic8BpTx21jOC4g9MuR2sRyDQTxxdcR/e/Bbwyyd+B4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LAmm8CWT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gGD1Zvrm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PV3z3QCL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Pdaip3qE;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98451606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 11:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98451606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LAmm8CWT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gGD1Zvrm;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PV3z3QCL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Pdaip3qE
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AAD4B21E98;
	Thu,  5 Nov 2026 11:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793877458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8S9XUVMzqc/Tv1i/ioHxDSTQ+R2MJ62vXiLgI6jk4KE=;
	b=LAmm8CWTdUykTd1Q2TXx+fsoZX6Lo++u7Vln690E7e51YXnoLrfd9vcGzQksixCrCNbeqs
	aRp5dx5OBdYUpQPW3NtMB2/j5EkNEEgUVYplRk8M/3U4rxI+7aSV75frVDsui6c1uXyqtG
	qFLc+Glc/738UOHbWMqnHjDuhA52Eug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793877458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8S9XUVMzqc/Tv1i/ioHxDSTQ+R2MJ62vXiLgI6jk4KE=;
	b=gGD1Zvrmb5KK5/R0mefsgqrfxj/gopoO+h3Em4Bb6v5QZB32KBjvSG01XSgEnNqcXx90ok
	EXj6FuJV3chbGQDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PV3z3QCL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Pdaip3qE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793877457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8S9XUVMzqc/Tv1i/ioHxDSTQ+R2MJ62vXiLgI6jk4KE=;
	b=PV3z3QCL0PdWtY5cLbPsK56WvVuTatIbnzAC+X36cu2YyXy6+zrov8F8EVQ+csS51VFLOK
	gNXUJuvG4iNpAmdDCErCUgumf9IZydXgqTEuUxkLW0WpFmeb6CDLTuXJhfh9pWiz2mnfll
	c2aQr8dxtMgF4C076yUPzpnGozc4WOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793877457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8S9XUVMzqc/Tv1i/ioHxDSTQ+R2MJ62vXiLgI6jk4KE=;
	b=Pdaip3qErl6ZiXxRb8dOwRBQv9EHH+21OYP+RdYHWYj3W/EfRTtjp/kViuqpPNraxOcHoV
	6adcXFGmtdktofCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1154134F4;
	Thu,  5 Nov 2026 11:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j89PKbpl7GruWwAAD6G6ig:T3
	(envelope-from <ddiss@suse.de>); Thu, 05 Nov 2026 11:17:35 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/3] initramfs_test: test unpack of dir with data segment
Date: Thu,  5 Nov 2026 22:10:00 +1100
Message-ID: <20261105111654.214569-3-ddiss@suse.de>
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
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: AAD4B21E98

initramfs unpacking only processes data segments attached to S_ISLNK
or S_ISREG entries, other file types are skipped. Add an explicit test
for this.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs_test.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index a1e88336ca3a9..b6ed4490f018c 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -543,6 +543,48 @@ static void __init initramfs_test_hdr_hex(struct kunit *test)
 	kfree(tbufs);
 }
 
+static void __init initramfs_test_dir_dataseg(struct kunit *test)
+{
+	char *err;
+	size_t len;
+	struct kstat st0 = {};
+	char fdata[] = "dir with data segment will not be unpacked";
+	struct initramfs_test_bufs {
+		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3) * 2 + sizeof(fdata)];
+	} *tbufs = kzalloc_obj(struct initramfs_test_bufs);
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFDIR | 0777,
+		.nlink = 1,
+		.namesize = sizeof("initramfs_test_dir_dataseg"),
+		.fname = "initramfs_test_dir_dataseg",
+		.filesize = sizeof(fdata),
+		.data = fdata,
+	}, {
+		.magic = "070701",
+		.ino = 2,
+		.mode = S_IFDIR | 0777,
+		.nlink = 1,
+		.namesize = sizeof("initramfs_test_dir_no_dataseg"),
+		.fname = "initramfs_test_dir_no_dataseg",
+	} };
+
+	len = fill_cpio(c, ARRAY_SIZE(c), false, tbufs->cpio_src);
+
+	/* no error: unpack skips non-file/symlink entries with data segment */
+	err = unpack_to_rootfs(tbufs->cpio_src, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	KUNIT_EXPECT_EQ(test, init_stat("initramfs_test_dir_dataseg", &st0, 0),
+			-ENOENT);
+	KUNIT_EXPECT_EQ(test,
+			init_stat("initramfs_test_dir_no_dataseg", &st0, 0), 0);
+	KUNIT_EXPECT_EQ(test, init_rmdir("initramfs_test_dir_no_dataseg"), 0);
+
+	kfree(tbufs);
+}
+
 /*
  * The kunit_case/_suite struct cannot be marked as __initdata as this will be
  * used in debugfs to retrieve results after test has run.
@@ -557,6 +599,7 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
 	KUNIT_CASE(initramfs_test_fname_pad),
 	KUNIT_CASE(initramfs_test_fname_path_max),
 	KUNIT_CASE(initramfs_test_hdr_hex),
+	KUNIT_CASE(initramfs_test_dir_dataseg),
 	{},
 };
 
-- 
2.56.0

