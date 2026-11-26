Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709268;
	b=f/zVdnZ5Os3j2i8J9WKE+hj5uJB1ENYFs0Hkx0V5G61hZF5mHanzllYKCvQ52DQPBOoX
	 VcWtd5pYHa4Jtrx3REoQBqDpBMzThpc1wPP8TxCUvkM/V4icAPtywhJzeuF8XOeU/7uE7
	 Osbh091cAUN3hCepSBWtx5xJ9RbfwErcEvCUL/vWZa5o76GhFxIGIu8jPRImd3a4zOf3J
	 TKRIHwPq0JK7FAvKdYgXvl1DQHAQc+AzzFyuiMi/qpis/9ygHauPuI2UVI2TtwlJleXsk
	 WCqE6MlXM3AQ6oM+rDPTOO1T3WKn3l1dTlVLFF+sXPNNTpVCTW5VThkxY+o9fjFn22Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709268;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Ol+xtVQ8x84qhmHAyLzeeqLY/hav6oBMjj9R04KAVmI=;
	b=k7K+k7Uc1C/1IeQMAnj6VeyAQ/QSGkf/L9lwbKnEnNQqy7nRTKFFgLEKCWrzOUITMJ/C
	 nrzjt8EbqmlmqfA/u/i5FKu5qxjFmZ/93gJXIMvzM5VDtga/dAIYf3WXioDF54VEDkM+C
	 2sq7ikxwyO4h0f0I3YBrl0rGm1DI32mMNyYG6uZRlGRJXvvzRmotkjwQiO3xd21aZzkmC
	 eQo6aL9ZUAwCVimc5BKyRcQoi4TTJa9fMgHYHJ3kGxqcP8qwuJE9EwCwgo287Ip1ftZvA
	 RGSA8IOOIC7hcsulBuda+SDq381fy0pG6nCe2rSoPhirlBGu2MAUMXFFtXmzu1M5clg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Qstm9Aja;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5358606A321;
	Thu, 26 Nov 2026 16:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5358606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Qstm9Aja
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ol
	+xtVQ8x84qhmHAyLzeeqLY/hav6oBMjj9R04KAVmI=; b=Qstm9Aja3Iz+aXmTEr
	mBVWMJoP8IvMP+UrwJo0RBE6Px3LDqiDXhkErpz665QrXxQTV8phkqIcFaNAMZl+
	XnhygCrzwNiB1F/0hDtgd528Aw5+PjvWY1YR/k0k2H5jo7K5ZXXGzpCqvJYbdzO/
	h13dMlFEYAOzXXKvvfmh7ujXg=
Received: from shaos.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXdUA5WQhrZWimIQ--.14037S2;
	Fri, 27 Nov 2026 00:07:21 +0800 (CST)
From: shaos <shawnq1@163.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hfsplus: reorder complete combining runs for dentry keys
Date: Thu, 26 Nov 2026 16:07:20 +0000
Message-Id: <20261126160720.3007837-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:PigvCgAXdUA5WQhrZWimIQ--.14037S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gry3JFyfCFW8Ar4UGw18Grg_yoW3XryxpF
	Z2qa1ayr1rtFsF934fWrW8XF1Yvwn7JF45tr98Gr10vw43J3W0yrZIv345CFWUXr4kXrZ8
	C3WYy3W7uan8uFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnsqXUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0BlBT2sIWTm42wAA3n

Hello,

HFS+ catalog names are decomposed and canonically reordered as a complete
string. The dentry iterator reorders a combining run in chunks of 32 code
units. With a 33-mark run, two spellings can produce the same catalog key
but different dentry hashes and comparisons. After creating one spelling,
lookup of the other returns ENOENT until remount.

Use the maximum decomposed HFS+ name length for the iterator buffer so a
representable combining run is reordered as a whole. Add a KUnit regression
test covering dentry hashes, dentry comparison, and the stored Unicode form
of two spellings with a 33-mark run.

The issue affects name lookup on a mounted HFS+ filesystem. The reproducer
shows a stale negative dentry, not a kernel crash or memory-safety violation.

Tested source:
HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
source version: Linux 7.4.0-rc4
compiler:       gcc 11.4.0, GNU ld 2.38
QEMU:           6.2.0

Reproducer bundle (PoC, image builder, configurations, console output,
QEMU scripts, and KUnit results):
https://gist.github.com/shaos26/bf0227a0628804407940c14be25e4208
Reproduction guide:
https://gist.githubusercontent.com/shaos26/bf0227a0628804407940c14be25e4208/raw/9fdd6f6d081f7b772a03589367a0da955c811ee5/reproduce.md
Baseline console output:
https://gist.githubusercontent.com/shaos26/bf0227a0628804407940c14be25e4208/raw/95967671db4b687ea5305865f3c167e580ed4395/console-output.txt
Kernel configuration:
https://gist.githubusercontent.com/shaos26/bf0227a0628804407940c14be25e4208/raw/120b0b771aeca1f299a6cbc505b25c84c0725b78/kernel-config.txt
Userspace reproducer:
https://gist.githubusercontent.com/shaos26/bf0227a0628804407940c14be25e4208/raw/463437cdfc959b30109c7a2b5ce1871653a55509/poc.c

The unpatched kernel reproduced the lookup failure in two fresh QEMU boots;
the 31-mark control resolved immediately. With the patch, the alternate
spelling resolved immediately in two fresh boots. The hfsplus_unicode KUnit
suite passed all 35 tests. Restoring the old 32-unit limit made the new test
fail on hash equality and dentry comparison (34 passed, 1 failed). The
x86-64 bzImage build completed without warnings. checkpatch.pl with --strict,
git diff --check, and git apply --check all passed.

Fixes: bbe5ebcbc006 ("hfsplus: canonicalize decomposed catalog names like fsck_hfs expects")
Assisted-by: OpenAI Codex
Signed-off-by: shaos <shawnq1@163.com>
---
 fs/hfsplus/unicode.c      | 16 ++++-------
 fs/hfsplus/unicode_test.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 59b8788a69a9e..585f3fd089aac 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -577,21 +577,15 @@ int hfsplus_asc2uni(struct super_block *sb,
 EXPORT_SYMBOL_IF_KUNIT(hfsplus_asc2uni);
 
 /*
- * Maximum length of a single maximal run of nonzero-combining-class code
- * units that hfsplus_decompose_iter_next() below will canonically
- * reorder. Every code unit with combining class 0 starts a new run, so
- * this only bounds how many *consecutive* combining marks between two
- * base characters get sorted - real text, and even deliberately
- * adversarial "Zalgo" text, essentially never approaches this. Keeping
- * it small means hfsplus_hash_dentry() and hfsplus_compare_dentry() only
- * ever need a tiny amount of lookahead state, rather than buffering an
- * entire (up to 255-unit) name.
+ * A maximal combining run can contain every code unit in an HFS+ catalog
+ * name. Keep the iterator limit aligned with the name limit so it can
+ * reorder the complete run like hfsplus_decompose_str().
  */
-#define HFSPLUS_CCC_RUN_MAX 32
+#define HFSPLUS_CCC_RUN_MAX HFSPLUS_MAX_STRLEN
 
 /*
  * Iterator that produces the canonically-ordered, decomposed code units
- * of a Linux name one at a time, without materializing the whole name.
+ * of a Linux name one combining run at a time.
  * hfsplus_hash_dentry() and hfsplus_compare_dentry() use this so that
  * hashing and comparison always agree with what hfsplus_asc2uni() would
  * actually store, while still comparing lazily (stopping at the first
diff --git a/fs/hfsplus/unicode_test.c b/fs/hfsplus/unicode_test.c
index a683c6d5fc221..2e88697bc4e71 100644
--- a/fs/hfsplus/unicode_test.c
+++ b/fs/hfsplus/unicode_test.c
@@ -1479,6 +1479,73 @@ static void hfsplus_hash_dentry_combining_reorder_test(struct kunit *test)
 	free_mock_sb(mock_sb);
 }
 
+static void hfsplus_dentry_combining_reorder_long_test(struct kunit *test)
+{
+	static const char acute[] = "\xcc\x81";
+	static const char dot_below[] = "\xcc\x96";
+	enum { NR_ACUTE = 32, NAME_LEN = 1 + (NR_ACUTE + 1) * 2 + 1 };
+	char acute_first[NAME_LEN], dot_first[NAME_LEN];
+	struct hfsplus_unistr stored1, stored2;
+	struct test_mock_sb *mock_sb;
+	struct qstr str1, str2;
+	char *p;
+	int i, result;
+
+	mock_sb = setup_mock_sb();
+	KUNIT_ASSERT_NOT_NULL(test, mock_sb);
+
+	setup_mock_dentry(&mock_sb->sb);
+	mock_sb->nls.char2uni = test_char2uni_utf8;
+
+	p = acute_first;
+	*p++ = 'e';
+	for (i = 0; i < NR_ACUTE; i++) {
+		memcpy(p, acute, sizeof(acute) - 1);
+		p += sizeof(acute) - 1;
+	}
+	memcpy(p, dot_below, sizeof(dot_below) - 1);
+	p += sizeof(dot_below) - 1;
+	*p = '\0';
+
+	p = dot_first;
+	*p++ = 'e';
+	memcpy(p, dot_below, sizeof(dot_below) - 1);
+	p += sizeof(dot_below) - 1;
+	for (i = 0; i < NR_ACUTE; i++) {
+		memcpy(p, acute, sizeof(acute) - 1);
+		p += sizeof(acute) - 1;
+	}
+	*p = '\0';
+
+	create_qstr(&str1, acute_first);
+	create_qstr(&str2, dot_first);
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+	KUNIT_ASSERT_EQ(test, 0, result);
+	result = hfsplus_hash_dentry(&test_dentry, &str2);
+	KUNIT_ASSERT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, str1.hash, str2.hash);
+
+	KUNIT_EXPECT_EQ(test, 0,
+			hfsplus_compare_dentry(&test_dentry, str1.len,
+					       str1.name, &str2));
+
+	result = hfsplus_asc2uni(&mock_sb->sb, &stored1, HFSPLUS_MAX_STRLEN,
+				 str1.name, str1.len, HFS_REGULAR_NAME);
+	KUNIT_ASSERT_EQ(test, 0, result);
+	result = hfsplus_asc2uni(&mock_sb->sb, &stored2, HFSPLUS_MAX_STRLEN,
+				 str2.name, str2.len, HFS_REGULAR_NAME);
+	KUNIT_ASSERT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, be16_to_cpu(stored1.length),
+			be16_to_cpu(stored2.length));
+	KUNIT_EXPECT_EQ(test, 34, be16_to_cpu(stored1.length));
+	KUNIT_EXPECT_EQ(test,
+			memcmp(stored1.unicode, stored2.unicode,
+			       be16_to_cpu(stored1.length) * sizeof(stored1.unicode[0])),
+			0);
+
+	free_mock_sb(mock_sb);
+}
+
 /* Test hfsplus_compare_dentry basic functionality */
 static void hfsplus_compare_dentry_basic_test(struct kunit *test)
 {
@@ -1880,6 +1947,7 @@ static struct kunit_case hfsplus_unicode_test_cases[] = {
 	KUNIT_CASE(hfsplus_hash_dentry_consistency_test),
 	KUNIT_CASE(hfsplus_hash_dentry_edge_cases_test),
 	KUNIT_CASE(hfsplus_hash_dentry_combining_reorder_test),
+	KUNIT_CASE(hfsplus_dentry_combining_reorder_long_test),
 	KUNIT_CASE(hfsplus_compare_dentry_basic_test),
 	KUNIT_CASE(hfsplus_compare_dentry_casefold_test),
 	KUNIT_CASE(hfsplus_compare_dentry_special_chars_test),

