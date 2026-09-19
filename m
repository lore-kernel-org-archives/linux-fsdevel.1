Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DFD286D56
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776991; cv=none; b=NKN97m1Ee+0F0V0rSdCyLCMFPiZZZnQOPEdYFBnX4jkCgt71+ZRloHKTVjek0JxIJWhI36IKVEMufppp4QzI7Xd0B8FOvlSavySDjbVee/+0ejNBqXo55OvTFj44UnrMC770o2PY6OVwIL1QhchdV05JrtgYyGcvaZHOkPqQSvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776991; c=relaxed/simple;
	bh=lA5D8uGD+rdpJRB6BHWOqauw7eQS19GqjnoOeakpZIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcPPjOras2nziJSq+UnfmP02t6oNiSHwU4bjyhlyfCGsSqxH4RpiJE4KV0fAekzYMvrMNAhC9SYbHnYhqeg2VVsxTgNgRJ4P6ZD8VUEDCE3hud8e4lC5IAHHv4MDZ+x5EeZyXcCKQpLzX0C76O2IrE4b1bbLYFuwKVTkQrocSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=i4a5Osy6; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="i4a5Osy6"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aa8d882so1540676d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789776989; x=1790381789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xDMeg6wMw9Amy2mQeG1YV9PkoyHZTDfQZnNcipdMNwk=;
        b=i4a5Osy6UODNqQ9gteRg06JUIDfVWHZKOcY6I0RcJUUt7BuiEbSe76GTpSjavEg+dg
         4k9Oue47bK9zuPuuIqVQbigFrM2qCjI16YybPRCiUJ0OUpkTyjqSTGXW/v15r0ey0Dog
         RKPY1vNR4O59uw7JaLWfi1IcwLMFpyEO4Lq0DuTAZTOE0Cysts7NZGJEj/EY9SmGfALN
         BL4pML1oHXtEM1DxphyZ2zSpJny5aqDpB5vFbSNG/ArQq1QmM8ZnN5OOX6yheTYtme99
         IOWHMJafrcqlzc7cxb6RJoY0TzScXgUEE4rVjUyD3PhyJZAeEXdn2bRX7qDGMIbtvEcX
         S6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789776989; x=1790381789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xDMeg6wMw9Amy2mQeG1YV9PkoyHZTDfQZnNcipdMNwk=;
        b=Uiksun3AlD5eld28WueROjxCvTEBQ/NZvLARismaCKYIyWx28srBprJEfa0JExS6PD
         ixhrJZ7Ju/VSvv1ygElXkThRAE90NIx035aGwjuiOLWPTG07u2dEPzdROctn3XVzojdK
         P26iuqGCbKQ/tIuG6FkRVxn5wRN0RniuQQ7H7L0HgmA/2fa8cFNB8GBusJKTWiTE+EyA
         fL4vJGaxwrWXSqsGYIeV3jgh/7R0cXmECGuMMJjXa0XXUCynMEqnzshqZJd7XK3z3PHK
         5tTAKAnTwb5eByMUPkndi1LuhQRPmu3QFMvgnMnFJ7vP8zdbyeSIR0nvqw7zR80cq3vj
         +IuA==
X-Gm-Message-State: AFuF++nv8GPBC3GQdZvEZ8BmzSimlFR85Qc4V6V9fvIwrXAIregmDrKY
	VUIAjGfjqNcgOMUWPbTku0lMd/ZoSUKVZ5f5IFtK9wyndNmyYdnriK77REbxoIECi/s=
X-Gm-Gg: AYBFou3+GMVgjyl3ikSTTSuJXbkfxjy3HTNc19zKIe8IvVhFMGae8c+jwepIwTa8f5+
	FoDFvJm66nolIEbBwQ8wNBP0IYZGIG4lElkOoezgRarjFIivr6yPiU7AgM0YROYTAmA01J2jez3
	KtzVXtWzTaASbdc2Lwd+nxZ36svs/pc4sreJqfa1lzQSJ24bnefsNaMXcTlkIMlU7FBofbQmHcL
	NmZX6STrVwmLKXUdRqD9ITMc6y4RIYM5LVs69JrCtkCTaXSrMbPORSK10d+eubEEjYg55U4o/V4
	b1Yy7ZGKQDxWHVnwOW2x7gkdUxV7xlS7Savgqeef3E2H8X8/gaU+OUGj3fExcRteDX7lCIKdqWX
	iF7QR4g5Ab5lCm9aTzO//IX0D9UenuxPTNx7GThl5V/BBsdrnMAmnuOjljupwokIQNrnTbZ08Ru
	E//viRQybZRCDQCwPT4/HyWFbiQLQO9bYx39UROj57QbdJQSn8Xlrdn7f5vFmT7+H/Zsb4179Ij
	dFwQBDnDUyeTNzhSU49cuLQKybQuDbyTn16T/ITp4dXDp0bLd3nuL9ehW48/OpYAGKyz9sF/C/O
	rbkp/XacIqys9oWun9eSF8g2XbBO
X-Received: by 2002:a05:690e:4508:10b0:66f:9cdc:2b09 with SMTP id 956f58d0204a3-6717fd9080emr1039698d50.47.1789776988986;
        Fri, 18 Sep 2026 17:16:28 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:f1ff:bb02:6c7c:6979])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672990ab5desm642471d50.8.2026.09.18.17.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:16:28 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 3/3] hfsplus: add KUnit coverage for canonical reordering and legacy fixups
Date: Fri, 18 Sep 2026 17:16:07 -0700
Message-ID: <20260919001607.2777138-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919001607.2777138-1-slava@dubeyko.com>
References: <20260919001607.2777138-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add regression tests for checking that decomposed catalog names
get canonically reordered and legacy-decomposition corrected
before storage, matching what macOS's own fsck_hfs requires and
previously flagged as "Illegal name" (reproducible via xfstests
generic/339).

Two small helpers, test_char2uni_utf8()/test_uni2char_utf8(), wrap the
real utf8_to_utf32()/utf32_to_utf8() codec: the existing
test_char2uni()/test_uni2char() stand-ins only handle one raw byte per
character and can't represent the multi-byte combining marks (U+0301,
U+0323, ...) these tests need.

New cases:

 - hfsplus_asc2uni_combining_reorder_test: two independently-typed
   combining marks (U+0301 class 230, U+0323 class 220) end up stored
   in ascending combining-class order regardless of typed order, are
   left alone when already canonical, and keep their relative order
   when their classes are equal (the sort must be stable).
 - hfsplus_unicode_combining_reorder_roundtrip_test: a name stored with
   marks reordered still reads back as the same, valid UTF-8.
 - hfsplus_asc2uni_legacy_decomp_test: U+01F8 decomposes to "N" +
   U+0300 even though Apple Technote #1150's table has no entry for it.
 - hfsplus_asc2uni_legacy_seq_fixup_test: a Greek letter + U+030D
   becomes that letter + U+0301, and Bengali BA + NUKTA collapses to
   the single letter RA WITH MIDDLE DIAGONAL.
 - hfsplus_hash_dentry_combining_reorder_test: two names differing only
   in typed mark order hash identically, since both canonicalize to the
   same stored form.
 - hfsplus_compare_dentry_combining_reorder_test and
   hfsplus_compare_dentry_legacy_decomp_test: likewise, both compare
   equal - a precomposed U+01F8 and its already-decomposed "N" + U+0300
   spelling must be found as the same catalog entry.

All 34 cases in the hfsplus_unicode KUnit suite (27 existing + 7 new)
pass under tools/testing/kunit/kunit.py.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/unicode_test.c | 308 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 308 insertions(+)

diff --git a/fs/hfsplus/unicode_test.c b/fs/hfsplus/unicode_test.c
index 32a64029d77b..a683c6d5fc22 100644
--- a/fs/hfsplus/unicode_test.c
+++ b/fs/hfsplus/unicode_test.c
@@ -948,6 +948,223 @@ static void hfsplus_asc2uni_decompose_test(struct kunit *test)
 	free_mock_sb(mock_sb);
 }
 
+/*
+ * Real UTF-8 <-> wchar_t conversion, mirroring what the "utf8" NLS table
+ * actually does (see char2uni()/uni2char() in fs/nls/nls_utf8.c). The
+ * test_char2uni()/test_uni2char() stand-ins above only handle one raw
+ * byte per character, which cannot represent the combining marks (e.g.
+ * U+0301, U+0323) the canonical-reordering tests below need.
+ */
+static int test_char2uni_utf8(const unsigned char *rawstring, int boundlen,
+			      wchar_t *uni)
+{
+	unicode_t u;
+	int n = utf8_to_utf32(rawstring, boundlen, &u);
+
+	if (n < 0 || u > MAX_WCHAR_T) {
+		*uni = 0x3f; /* ? */
+		return -EINVAL;
+	}
+	*uni = (wchar_t)u;
+	return n;
+}
+
+static int test_uni2char_utf8(wchar_t uni, unsigned char *out, int boundlen)
+{
+	int n = utf32_to_utf8(uni, out, boundlen);
+
+	if (n < 0) {
+		*out = '?';
+		return -EINVAL;
+	}
+	return n;
+}
+
+/*
+ * Test that hfsplus_asc2uni() brings combining marks contributed by
+ * different source characters into Unicode canonical (combining-class)
+ * order, instead of just storing them in whatever order they were typed.
+ *
+ * U+0301 (COMBINING ACUTE ACCENT) has combining class 230; U+0323
+ * (COMBINING DOT BELOW) has combining class 220. Since 220 < 230,
+ * canonical order requires the dot-below before the acute. A name
+ * created with them typed in the "wrong" order must still end up stored
+ * in canonical order - this is exactly what macOS's own fsck_hfs
+ * (FixDecomps() in CatalogCheck.c) requires and flags as "Illegal name"
+ * when it isn't true.
+ */
+static void hfsplus_asc2uni_combining_reorder_test(struct kunit *test)
+{
+	struct test_mock_sb *mock_sb;
+	struct hfsplus_unistr ustr;
+	/* "e" + COMBINING ACUTE ACCENT (U+0301) + COMBINING DOT BELOW (U+0323) */
+	static const char wrong_order[] = "e\xcc\x81\xcc\xa3";
+	/* "e" + COMBINING DOT BELOW (U+0323) + COMBINING ACUTE ACCENT (U+0301) */
+	static const char canonical_order[] = "e\xcc\xa3\xcc\x81";
+	/* Two class-230 marks: GRAVE (U+0300) then ACUTE (U+0301) */
+	static const char same_class[] = "e\xcc\x80\xcc\x81";
+	int result;
+
+	mock_sb = setup_mock_sb();
+	KUNIT_ASSERT_NOT_NULL(test, mock_sb);
+
+	mock_sb->nls.char2uni = test_char2uni_utf8;
+
+	/* Typed out of canonical order: must be reordered on storage. */
+	result = hfsplus_asc2uni(&mock_sb->sb, &ustr, HFSPLUS_MAX_STRLEN,
+				 wrong_order, strlen(wrong_order),
+				 HFS_REGULAR_NAME);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 3, be16_to_cpu(ustr.length));
+	KUNIT_EXPECT_EQ(test, 'e', be16_to_cpu(ustr.unicode[0]));
+	KUNIT_EXPECT_EQ(test, 0x0323, be16_to_cpu(ustr.unicode[1]));
+	KUNIT_EXPECT_EQ(test, 0x0301, be16_to_cpu(ustr.unicode[2]));
+
+	/* Already in canonical order: must come out unchanged. */
+	result = hfsplus_asc2uni(&mock_sb->sb, &ustr, HFSPLUS_MAX_STRLEN,
+				 canonical_order, strlen(canonical_order),
+				 HFS_REGULAR_NAME);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 3, be16_to_cpu(ustr.length));
+	KUNIT_EXPECT_EQ(test, 'e', be16_to_cpu(ustr.unicode[0]));
+	KUNIT_EXPECT_EQ(test, 0x0323, be16_to_cpu(ustr.unicode[1]));
+	KUNIT_EXPECT_EQ(test, 0x0301, be16_to_cpu(ustr.unicode[2]));
+
+	/* Two marks of equal combining class must keep their relative
+	 * (input) order - the sort must be stable, not just "sorted".
+	 */
+	result = hfsplus_asc2uni(&mock_sb->sb, &ustr, HFSPLUS_MAX_STRLEN,
+				 same_class, strlen(same_class),
+				 HFS_REGULAR_NAME);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 3, be16_to_cpu(ustr.length));
+	KUNIT_EXPECT_EQ(test, 'e', be16_to_cpu(ustr.unicode[0]));
+	KUNIT_EXPECT_EQ(test, 0x0300, be16_to_cpu(ustr.unicode[1]));
+	KUNIT_EXPECT_EQ(test, 0x0301, be16_to_cpu(ustr.unicode[2]));
+
+	free_mock_sb(mock_sb);
+}
+
+/*
+ * Test that a name written with combining marks in non-canonical order
+ * still reads back as valid, correct UTF-8 once reordered - i.e. that
+ * hfsplus_asc2uni() and hfsplus_uni2asc_str() stay consistent with each
+ * other across the reordering.
+ *
+ * NODECOMPOSE is set so hfsplus_uni2asc_str() doesn't also recompose
+ * "e" + COMBINING DOT BELOW back into the precomposed U+1EB9 ("e"): that
+ * composition behavior is real (and already covered elsewhere), but it
+ * would obscure what this test is actually checking.
+ */
+static void hfsplus_unicode_combining_reorder_roundtrip_test(struct kunit *test)
+{
+	struct test_mock_sb *mock_sb;
+	struct hfsplus_unistr ustr;
+	static const char wrong_order[] = "e\xcc\x81\xcc\xa3";
+	static const char expected[] = "e\xcc\xa3\xcc\x81"; /* canonical order */
+	char buf[32];
+	int len = sizeof(buf);
+	int result;
+
+	mock_sb = setup_mock_sb();
+	KUNIT_ASSERT_NOT_NULL(test, mock_sb);
+
+	set_bit(HFSPLUS_SB_NODECOMPOSE, &mock_sb->sb_info.flags);
+	mock_sb->nls.char2uni = test_char2uni_utf8;
+	mock_sb->nls.uni2char = test_uni2char_utf8;
+
+	result = hfsplus_asc2uni(&mock_sb->sb, &ustr, HFSPLUS_MAX_STRLEN,
+				 wrong_order, strlen(wrong_order),
+				 HFS_REGULAR_NAME);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	result = hfsplus_uni2asc_str(&mock_sb->sb, &ustr, buf, &len);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, (int)strlen(expected), len);
+	KUNIT_EXPECT_MEMEQ(test, expected, buf, len);
+
+	free_mock_sb(mock_sb);
+}
+
+/*
+ * Test that hfsplus_asc2uni() decomposes a character using the corrected
+ * (post-2002/"Jaguar") canonical decomposition even when Apple Technote
+ * #1150's own decomposition table doesn't have an entry for it.
+ *
+ * U+01F8 (LATIN CAPITAL LETTER N WITH GRAVE) is exactly one of the
+ * characters macOS's own fsck_hfs (FixDecomps() in CatalogCheck.c) has
+ * flagged "Illegal name" for since 2002 when found stored undecomposed.
+ */
+static void hfsplus_asc2uni_legacy_decomp_test(struct kunit *test)
+{
+	struct test_mock_sb *mock_sb;
+	struct hfsplus_unistr ustr;
+	static const char input[] = "\xc7\xb8"; /* U+01F8 */
+	int result;
+
+	mock_sb = setup_mock_sb();
+	KUNIT_ASSERT_NOT_NULL(test, mock_sb);
+
+	mock_sb->nls.char2uni = test_char2uni_utf8;
+
+	result = hfsplus_asc2uni(&mock_sb->sb, &ustr, HFSPLUS_MAX_STRLEN,
+				 input, strlen(input), HFS_REGULAR_NAME);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 2, be16_to_cpu(ustr.length));
+	KUNIT_EXPECT_EQ(test, 'N', be16_to_cpu(ustr.unicode[0]));
+	KUNIT_EXPECT_EQ(test, 0x0300, be16_to_cpu(ustr.unicode[1]));
+
+	free_mock_sb(mock_sb);
+}
+
+/*
+ * Test that hfsplus_asc2uni() corrects two more of fsck_hfs's known
+ * legacy decomposition sequences once combining marks from independently
+ * typed characters end up adjacent:
+ *
+ *  - GREEK SMALL LETTER ALPHA (U+03B1) + COMBINING VERTICAL LINE ABOVE
+ *    (U+030D) must become U+03B1 + COMBINING ACUTE ACCENT (U+0301).
+ *  - BENGALI LETTER BA (U+09AC) + BENGALI SIGN NUKTA (U+09BC) must become
+ *    the single character BENGALI LETTER RA WITH MIDDLE DIAGONAL (U+09B0).
+ */
+static void hfsplus_asc2uni_legacy_seq_fixup_test(struct kunit *test)
+{
+	struct test_mock_sb *mock_sb;
+	struct hfsplus_unistr ustr;
+	static const char greek_input[] = "\xce\xb1\xcc\x8d"; /* U+03B1 U+030D */
+	static const char bengali_input[] = "\xe0\xa6\xac\xe0\xa6\xbc"; /* U+09AC U+09BC */
+	int result;
+
+	mock_sb = setup_mock_sb();
+	KUNIT_ASSERT_NOT_NULL(test, mock_sb);
+
+	mock_sb->nls.char2uni = test_char2uni_utf8;
+
+	result = hfsplus_asc2uni(&mock_sb->sb, &ustr, HFSPLUS_MAX_STRLEN,
+				 greek_input, strlen(greek_input),
+				 HFS_REGULAR_NAME);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 2, be16_to_cpu(ustr.length));
+	KUNIT_EXPECT_EQ(test, 0x03b1, be16_to_cpu(ustr.unicode[0]));
+	KUNIT_EXPECT_EQ(test, 0x0301, be16_to_cpu(ustr.unicode[1]));
+
+	result = hfsplus_asc2uni(&mock_sb->sb, &ustr, HFSPLUS_MAX_STRLEN,
+				 bengali_input, strlen(bengali_input),
+				 HFS_REGULAR_NAME);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	KUNIT_EXPECT_EQ(test, 1, be16_to_cpu(ustr.length));
+	KUNIT_EXPECT_EQ(test, 0x09b0, be16_to_cpu(ustr.unicode[0]));
+
+	free_mock_sb(mock_sb);
+}
+
 /* Mock dentry for testing hfsplus_hash_dentry */
 static struct dentry test_dentry;
 
@@ -1231,6 +1448,37 @@ static void hfsplus_hash_dentry_edge_cases_test(struct kunit *test)
 	free_mock_sb(mock_sb);
 }
 
+/*
+ * Test that hfsplus_hash_dentry() hashes two names identically when they
+ * differ only in the (non-canonical) typed order of the same combining
+ * marks - both must canonicalize to the same stored form, so they must
+ * hash the same or dcache lookups would spuriously miss.
+ */
+static void hfsplus_hash_dentry_combining_reorder_test(struct kunit *test)
+{
+	struct test_mock_sb *mock_sb;
+	struct qstr str1, str2;
+	int result;
+
+	mock_sb = setup_mock_sb();
+	KUNIT_ASSERT_NOT_NULL(test, mock_sb);
+
+	setup_mock_dentry(&mock_sb->sb);
+	mock_sb->nls.char2uni = test_char2uni_utf8;
+
+	create_qstr(&str1, "e\xcc\x81\xcc\xa3"); /* acute, then dot-below */
+	result = hfsplus_hash_dentry(&test_dentry, &str1);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	create_qstr(&str2, "e\xcc\xa3\xcc\x81"); /* dot-below, then acute */
+	result = hfsplus_hash_dentry(&test_dentry, &str2);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	KUNIT_EXPECT_EQ(test, str1.hash, str2.hash);
+
+	free_mock_sb(mock_sb);
+}
+
 /* Test hfsplus_compare_dentry basic functionality */
 static void hfsplus_compare_dentry_basic_test(struct kunit *test)
 {
@@ -1553,6 +1801,59 @@ static void hfsplus_compare_dentry_combined_flags_test(struct kunit *test)
 	free_mock_sb(mock_sb);
 }
 
+/*
+ * Test that hfsplus_compare_dentry() treats two names as equal when they
+ * differ only in the (non-canonical) typed order of the same combining
+ * marks, since both refer to the same canonically-ordered catalog entry.
+ */
+static void hfsplus_compare_dentry_combining_reorder_test(struct kunit *test)
+{
+	struct test_mock_sb *mock_sb;
+	struct qstr name;
+	int result;
+
+	mock_sb = setup_mock_sb();
+	KUNIT_ASSERT_NOT_NULL(test, mock_sb);
+
+	setup_mock_dentry(&mock_sb->sb);
+	mock_sb->nls.char2uni = test_char2uni_utf8;
+
+	create_qstr(&name, "e\xcc\xa3\xcc\x81"); /* dot-below, then acute */
+	result = hfsplus_compare_dentry(&test_dentry, 5, "e\xcc\x81\xcc\xa3",
+					&name); /* acute, then dot-below */
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	free_mock_sb(mock_sb);
+}
+
+/*
+ * Test that a precomposed character using one of fsck_hfs's known legacy
+ * decompositions compares equal to the already-decomposed form of the
+ * same character - i.e. that hfsplus_compare_dentry() applies the same
+ * legacy-decomposition correction as hfsplus_asc2uni() does on storage,
+ * so a lookup finds the entry regardless of which form was typed.
+ */
+static void hfsplus_compare_dentry_legacy_decomp_test(struct kunit *test)
+{
+	struct test_mock_sb *mock_sb;
+	struct qstr name;
+	int result;
+
+	mock_sb = setup_mock_sb();
+	KUNIT_ASSERT_NOT_NULL(test, mock_sb);
+
+	setup_mock_dentry(&mock_sb->sb);
+	mock_sb->nls.char2uni = test_char2uni_utf8;
+
+	/* "N" + COMBINING GRAVE ACCENT (U+0300), already decomposed */
+	create_qstr(&name, "N\xcc\x80");
+	/* U+01F8, precomposed */
+	result = hfsplus_compare_dentry(&test_dentry, 2, "\xc7\xb8", &name);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	free_mock_sb(mock_sb);
+}
+
 static struct kunit_case hfsplus_unicode_test_cases[] = {
 	KUNIT_CASE(hfsplus_strcasecmp_test),
 	KUNIT_CASE(hfsplus_strcmp_test),
@@ -1568,12 +1869,17 @@ static struct kunit_case hfsplus_unicode_test_cases[] = {
 	KUNIT_CASE(hfsplus_asc2uni_buffer_limits_test),
 	KUNIT_CASE(hfsplus_asc2uni_edge_cases_test),
 	KUNIT_CASE(hfsplus_asc2uni_decompose_test),
+	KUNIT_CASE(hfsplus_asc2uni_combining_reorder_test),
+	KUNIT_CASE(hfsplus_unicode_combining_reorder_roundtrip_test),
+	KUNIT_CASE(hfsplus_asc2uni_legacy_decomp_test),
+	KUNIT_CASE(hfsplus_asc2uni_legacy_seq_fixup_test),
 	KUNIT_CASE(hfsplus_hash_dentry_basic_test),
 	KUNIT_CASE(hfsplus_hash_dentry_casefold_test),
 	KUNIT_CASE(hfsplus_hash_dentry_special_chars_test),
 	KUNIT_CASE(hfsplus_hash_dentry_decompose_test),
 	KUNIT_CASE(hfsplus_hash_dentry_consistency_test),
 	KUNIT_CASE(hfsplus_hash_dentry_edge_cases_test),
+	KUNIT_CASE(hfsplus_hash_dentry_combining_reorder_test),
 	KUNIT_CASE(hfsplus_compare_dentry_basic_test),
 	KUNIT_CASE(hfsplus_compare_dentry_casefold_test),
 	KUNIT_CASE(hfsplus_compare_dentry_special_chars_test),
@@ -1581,6 +1887,8 @@ static struct kunit_case hfsplus_unicode_test_cases[] = {
 	KUNIT_CASE(hfsplus_compare_dentry_decompose_test),
 	KUNIT_CASE(hfsplus_compare_dentry_edge_cases_test),
 	KUNIT_CASE(hfsplus_compare_dentry_combined_flags_test),
+	KUNIT_CASE(hfsplus_compare_dentry_combining_reorder_test),
+	KUNIT_CASE(hfsplus_compare_dentry_legacy_decomp_test),
 	{}
 };
 
-- 
2.43.0

