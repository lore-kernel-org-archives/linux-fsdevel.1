Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406523BCE3
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312839; cv=none; b=sqvIu5j7EzSoSd2fIJNb4jtxuF7Q1SbCCndYbWemPFudSYnGhuJPUJqfpk18ED8lYqumAFwwjn9rG41H3TgN9vLRPIl4CNVWggsPwlt69fiMGMXoqAgsHphjnD5zHwGbJ38vXSqze6+TuVSrLKeHyPl9/BbQ8oKv2o8N3TfAqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312839; c=relaxed/simple;
	bh=E/ayNYH6/fOE2Hj6nb52hP0J8D+smROaSO8Q73IBW40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQKNKRdVrFjol7G8OvrJqYhsPlk2J1AjaakMXnT+kL/7Nsr0w0ob2573zrpz9CvSGGeedV8d20f9U3DXdQqBoNyQ6OtvP2X8fLmONKt2tqiu34e4Gh5WKfgD/RpmbgF6EJo24jRpbdfREI4SWs1ikMGTQhGvxCFf9Y/kyJE+ZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=TTo2w+Ts; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="TTo2w+Ts"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ea87939b3so797068d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1774312836; x=1774917636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sfri2Ry1Z4CnKkcUO1ox/pgkB5ibSjdGLvxPxnv448=;
        b=TTo2w+TshmvkZm3cObyZTkR2LD6Uwjj6yqz7cweXEaYUDwov5BwNIFJ5POEdx4Fxdo
         VuJFqNUW1P72vz7E+HrX+0DbuY9USXp502+6tXMrpzgRWOZTIrTcYnSqHaNfHX97eI3i
         nrDwhyCk9UALUI5mwHFwSs3XXhbU9xkdpUI/NdGHQeyFG1lX3bEo8bcNrDYYwaOEROvz
         2eInXY4FjM8+qxMLjCyiCaAcsgZ6siM0OwI54NQ2wVTH+xPhWv2B11SsIod/DGZY+Vgd
         /ubXQ1KVN0hF3yx9UfEYn8fQxteq1spFeyA0Y3d6pa7BRduCSZXp/QE7as2s9+TXifvz
         DabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312836; x=1774917636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sfri2Ry1Z4CnKkcUO1ox/pgkB5ibSjdGLvxPxnv448=;
        b=smWG9FcOWDUKCcHJUbBj/U94QYEi/CWvyG0iCgCQAFhJSM0QeU/RsAMyGj+BFf+zVr
         oMxGVXRjfCR/H2VYDAfjfynuHo9rmh/9p1ZGpr4s4W5eWQI+HY0HKwQpVpPVqXOOcSHH
         g7sW0NB9wIqndMi/yUcIrxLdO69sBOi7mJxM87ZigYxZAclOY94/fuSTMKgCeGPTplN1
         Xh0QdJJbUvqC7gFNtJbA+Nw6Zou80Swq6tLg126Ie/5SC65CBOwhV3eX6WTTxLr+mflF
         YKw21BJ5rEaAt1pW62RXcQHgRrmud+kdMElGrqEM6SIC9g+5yPMepxFJoFcCq5A24krs
         kHyw==
X-Forwarded-Encrypted: i=1; AJvYcCUOlTTcd69Eu+a+DjmH0q75a+aaHDaifnYK3ivCJbbcuAs1uxg/ogPRm2b+jPTepcOzoMGz/t2uBYLE63vc@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJAt220XTg8nSGUu6PAsXQMIyJStpaICsL0d1GEru0q27241H
	dSXUtIRDrXAAHIJ1TgDlozpyHGtd+VvYxdDc5k3zrRTF97FzZsHqEFfdDzeQElKDLCM=
X-Gm-Gg: ATEYQzzssamJSoUDGKXhtQkM+UIwiEIii23PJsRUApqmdsW2qAJw5IcH/Ayztn5F2rf
	kI0OmpO4TS6vB4MO9y17j4T5cmEb6mNOA3V4nxxhMPRrptXDIHmGDYQbZ+m4/khPgxOFqA/AmT8
	LP/jmWIOJck9yn9p9T6YYg8kgTNjVSkAWzhHm0NWi0EQiYX33YFMMrSr/8MSB5Ka3nNZzR1oEA9
	z0XHNOm5rsnsGJqzNC3nsdNRxfbHx1aO0Hojh9jRS22jziGtud4aeLp7kpYyWcFLL9qTLCwU9XE
	PfXT4IF5wAPeE0cRHS7JmTtgq27/TixeuvhKg3vq7CIamQqGllelRzBx5da2FYCu7llICdyryW2
	/tBjI95+MWBNLGhKUzLRW2p1X93TnQfxD11pEwnB2B90gEZ8S57N5vKWUz+QpIyjzPLQS2dpQVJ
	tenD4qB1pWslNMiPyowigbVg6j/UQAYTipNq6psfhpoxyUu7rqjXLq3SfoYifkw5IS6ZciezwMz
	l8DJipRV0UwCoIJsDMdLW6l
X-Received: by 2002:a05:690e:1188:b0:64d:29a3:ebbf with SMTP id 956f58d0204a3-64eaa698267mr13690852d50.16.1774312835770;
        Mon, 23 Mar 2026 17:40:35 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:68fb:d1e0:d08a:3cf0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabecf140sm6959657d50.17.2026.03.23.17.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:40:35 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix generic/523 test-case failure
Date: Mon, 23 Mar 2026 17:39:50 -0700
Message-ID: <20260324003949.417048-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/523 fails to execute
correctly:

FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP PREEMPT_DYNAMIC Thu May 1 16:43:22 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/523 - output mismatch (see xfstests-dev/results//generic/523.out.bad)

The test-case expects to have '/' in the xattr name.
However, HFS+ unicode logic makes conversion of '/'
into ':'. In HFS+, a filename can contain '/' because
':' is the separator. The slash is a valid filename
character on macOS. But on Linux, / is the path separator
and it cannot appear in a filename component. But xattr
name can contain any of these symbols. It means that
this unicode logic conversion doesn't need to be executed
for the case of xattr name.

This patch adds distinguishing the regular and xattr names.
If we have a regular name, then this conversion of special
symbols will be executed. Otherwise, the conversion is skipped
for the case of xattr names.

sudo ./check -g auto
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.0.0-rc1+ #24 SMP PREEMPT_DYNAMIC Fri Mar 20 12:36:49 PDT 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

<skipped>
generic/523 33s ...  25s
<skipped>

Closes: https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/178
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/attributes.c    |   3 +-
 fs/hfsplus/catalog.c       |   4 +-
 fs/hfsplus/hfsplus_fs.h    |   3 +-
 fs/hfsplus/unicode.c       | 121 ++++++++++++++++++++++++++-----------
 fs/hfsplus/unicode_test.c  |  51 ++++++++++------
 include/linux/hfs_common.h |   5 ++
 6 files changed, 132 insertions(+), 55 deletions(-)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index 704635c65e9a..fa87496409c9 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -57,7 +57,8 @@ int hfsplus_attr_build_key(struct super_block *sb, hfsplus_btree_key *key,
 	if (name) {
 		int res = hfsplus_asc2uni(sb,
 				(struct hfsplus_unistr *)&key->attr.key_name,
-				HFSPLUS_ATTR_MAX_STRLEN, name, strlen(name));
+				HFSPLUS_ATTR_MAX_STRLEN, name, strlen(name),
+				HFS_XATTR_NAME);
 		if (res)
 			return res;
 		len = be16_to_cpu(key->attr.key_name.length);
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 708046c5dae6..1f7ef61fc318 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -47,7 +47,7 @@ int hfsplus_cat_build_key(struct super_block *sb,
 
 	key->cat.parent = cpu_to_be32(parent);
 	err = hfsplus_asc2uni(sb, &key->cat.name, HFSPLUS_MAX_STRLEN,
-			str->name, str->len);
+			      str->name, str->len, HFS_REGULAR_NAME);
 	if (unlikely(err < 0))
 		return err;
 
@@ -183,7 +183,7 @@ static int hfsplus_fill_cat_thread(struct super_block *sb,
 	entry->thread.reserved = 0;
 	entry->thread.parentID = cpu_to_be32(parentid);
 	err = hfsplus_asc2uni(sb, &entry->thread.nodeName, HFSPLUS_MAX_STRLEN,
-				str->name, str->len);
+				str->name, str->len, HFS_REGULAR_NAME);
 	if (unlikely(err < 0))
 		return err;
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index caba698814fe..3545b8dbf11c 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -506,7 +506,8 @@ int hfsplus_uni2asc_xattr_str(struct super_block *sb,
 			      const struct hfsplus_attr_unistr *ustr,
 			      char *astr, int *len_p);
 int hfsplus_asc2uni(struct super_block *sb, struct hfsplus_unistr *ustr,
-		    int max_unistr_len, const char *astr, int len);
+		    int max_unistr_len, const char *astr, int len,
+		    int name_type);
 int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str);
 int hfsplus_compare_dentry(const struct dentry *dentry, unsigned int len,
 			   const char *str, const struct qstr *name);
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index d3a142f4518b..008fec186382 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -147,9 +147,44 @@ static u16 *hfsplus_compose_lookup(u16 *p, u16 cc)
 	return NULL;
 }
 
+/*
+ * In HFS+, a filename can contain / because : is the separator.
+ * The slash is a valid filename character on macOS.
+ * But on Linux, / is the path separator and
+ * it cannot appear in a filename component.
+ * There's a parallel mapping for the NUL character (0 -> U+2400).
+ * NUL terminates strings in C/POSIX but is valid in HFS+ filenames.
+ */
+static inline
+void hfsplus_mac2linux_compatibility_check(u16 symbol, u16 *conversion,
+					   int name_type)
+{
+	*conversion = symbol;
+
+	switch (name_type) {
+	case HFS_XATTR_NAME:
+		/* ignore conversion */
+		return;
+
+	default:
+		/* continue logic */
+		break;
+	}
+
+	switch (symbol) {
+	case 0:
+		*conversion = 0x2400;
+		break;
+	case '/':
+		*conversion = ':';
+		break;
+	}
+}
+
 static int hfsplus_uni2asc(struct super_block *sb,
 			   const struct hfsplus_unistr *ustr,
-			   int max_len, char *astr, int *len_p)
+			   int max_len, char *astr, int *len_p,
+			   int name_type)
 {
 	const hfsplus_unichr *ip;
 	struct nls_table *nls = HFSPLUS_SB(sb)->nls;
@@ -217,14 +252,8 @@ static int hfsplus_uni2asc(struct super_block *sb,
 					hfsplus_compose_table, c1);
 			if (ce1)
 				break;
-			switch (c0) {
-			case 0:
-				c0 = 0x2400;
-				break;
-			case '/':
-				c0 = ':';
-				break;
-			}
+			hfsplus_mac2linux_compatibility_check(c0, &c0,
+							      name_type);
 			res = nls->uni2char(c0, op, len);
 			if (res < 0) {
 				if (res == -ENAMETOOLONG)
@@ -257,16 +286,8 @@ static int hfsplus_uni2asc(struct super_block *sb,
 			}
 		}
 same:
-		switch (c0) {
-		case 0:
-			cc = 0x2400;
-			break;
-		case '/':
-			cc = ':';
-			break;
-		default:
-			cc = c0;
-		}
+		hfsplus_mac2linux_compatibility_check(c0, &cc,
+						      name_type);
 done:
 		res = nls->uni2char(cc, op, len);
 		if (res < 0) {
@@ -288,7 +309,10 @@ inline int hfsplus_uni2asc_str(struct super_block *sb,
 			       const struct hfsplus_unistr *ustr, char *astr,
 			       int *len_p)
 {
-	return hfsplus_uni2asc(sb, ustr, HFSPLUS_MAX_STRLEN, astr, len_p);
+	return hfsplus_uni2asc(sb,
+				ustr, HFSPLUS_MAX_STRLEN,
+				astr, len_p,
+				HFS_REGULAR_NAME);
 }
 EXPORT_SYMBOL_IF_KUNIT(hfsplus_uni2asc_str);
 
@@ -297,22 +321,32 @@ inline int hfsplus_uni2asc_xattr_str(struct super_block *sb,
 				     char *astr, int *len_p)
 {
 	return hfsplus_uni2asc(sb, (const struct hfsplus_unistr *)ustr,
-			       HFSPLUS_ATTR_MAX_STRLEN, astr, len_p);
+				HFSPLUS_ATTR_MAX_STRLEN, astr, len_p,
+				HFS_XATTR_NAME);
 }
 EXPORT_SYMBOL_IF_KUNIT(hfsplus_uni2asc_xattr_str);
 
 /*
- * Convert one or more ASCII characters into a single unicode character.
- * Returns the number of ASCII characters corresponding to the unicode char.
+ * In HFS+, a filename can contain / because : is the separator.
+ * The slash is a valid filename character on macOS.
+ * But on Linux, / is the path separator and
+ * it cannot appear in a filename component.
+ * There's a parallel mapping for the NUL character (0 -> U+2400).
+ * NUL terminates strings in C/POSIX but is valid in HFS+ filenames.
  */
-static inline int asc2unichar(struct super_block *sb, const char *astr, int len,
-			      wchar_t *uc)
+static inline
+void hfsplus_linux2mac_compatibility_check(wchar_t *uc, int name_type)
 {
-	int size = HFSPLUS_SB(sb)->nls->char2uni(astr, len, uc);
-	if (size <= 0) {
-		*uc = '?';
-		size = 1;
+	switch (name_type) {
+	case HFS_XATTR_NAME:
+		/* ignore conversion */
+		return;
+
+	default:
+		/* continue logic */
+		break;
 	}
+
 	switch (*uc) {
 	case 0x2400:
 		*uc = 0;
@@ -321,6 +355,23 @@ static inline int asc2unichar(struct super_block *sb, const char *astr, int len,
 		*uc = '/';
 		break;
 	}
+}
+
+/*
+ * Convert one or more ASCII characters into a single unicode character.
+ * Returns the number of ASCII characters corresponding to the unicode char.
+ */
+static inline int asc2unichar(struct super_block *sb, const char *astr, int len,
+			      wchar_t *uc, int name_type)
+{
+	int size = HFSPLUS_SB(sb)->nls->char2uni(astr, len, uc);
+
+	if (size <= 0) {
+		*uc = '?';
+		size = 1;
+	}
+
+	hfsplus_linux2mac_compatibility_check(uc, name_type);
 	return size;
 }
 
@@ -395,7 +446,7 @@ static u16 *decompose_unichar(wchar_t uc, int *size, u16 *hangul_buffer)
 
 int hfsplus_asc2uni(struct super_block *sb,
 		    struct hfsplus_unistr *ustr, int max_unistr_len,
-		    const char *astr, int len)
+		    const char *astr, int len, int name_type)
 {
 	int size, dsize, decompose;
 	u16 *dstr, outlen = 0;
@@ -404,7 +455,7 @@ int hfsplus_asc2uni(struct super_block *sb,
 
 	decompose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
 	while (outlen < max_unistr_len && len > 0) {
-		size = asc2unichar(sb, astr, len, &c);
+		size = asc2unichar(sb, astr, len, &c, name_type);
 
 		if (decompose)
 			dstr = decompose_unichar(c, &dsize, dhangul);
@@ -452,7 +503,7 @@ int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str)
 	len = str->len;
 	while (len > 0) {
 		int dsize;
-		size = asc2unichar(sb, astr, len, &c);
+		size = asc2unichar(sb, astr, len, &c, HFS_REGULAR_NAME);
 		astr += size;
 		len -= size;
 
@@ -510,7 +561,8 @@ int hfsplus_compare_dentry(const struct dentry *dentry,
 
 	while (len1 > 0 && len2 > 0) {
 		if (!dsize1) {
-			size = asc2unichar(sb, astr1, len1, &c);
+			size = asc2unichar(sb, astr1, len1, &c,
+					   HFS_REGULAR_NAME);
 			astr1 += size;
 			len1 -= size;
 
@@ -525,7 +577,8 @@ int hfsplus_compare_dentry(const struct dentry *dentry,
 		}
 
 		if (!dsize2) {
-			size = asc2unichar(sb, astr2, len2, &c);
+			size = asc2unichar(sb, astr2, len2, &c,
+					   HFS_REGULAR_NAME);
 			astr2 += size;
 			len2 -= size;
 
diff --git a/fs/hfsplus/unicode_test.c b/fs/hfsplus/unicode_test.c
index 26145bf88946..83737c9bafa0 100644
--- a/fs/hfsplus/unicode_test.c
+++ b/fs/hfsplus/unicode_test.c
@@ -715,28 +715,32 @@ static void hfsplus_asc2uni_basic_test(struct kunit *test)
 
 	/* Test simple ASCII string conversion */
 	result = hfsplus_asc2uni(&mock_sb->sb, &mock_env->str1,
-				 HFSPLUS_MAX_STRLEN, "hello", 5);
+				 HFSPLUS_MAX_STRLEN, "hello", 5,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	check_unistr_content(test, &mock_env->str1, "hello");
 
 	/* Test empty string */
 	result = hfsplus_asc2uni(&mock_sb->sb, &mock_env->str1,
-				 HFSPLUS_MAX_STRLEN, "", 0);
+				 HFSPLUS_MAX_STRLEN, "", 0,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	KUNIT_EXPECT_EQ(test, 0, be16_to_cpu(mock_env->str1.length));
 
 	/* Test single character */
 	result = hfsplus_asc2uni(&mock_sb->sb, &mock_env->str1,
-				 HFSPLUS_MAX_STRLEN, "A", 1);
+				 HFSPLUS_MAX_STRLEN, "A", 1,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	check_unistr_content(test, &mock_env->str1, "A");
 
 	/* Test null-terminated string with explicit length */
 	result = hfsplus_asc2uni(&mock_sb->sb, &mock_env->str1,
-				 HFSPLUS_MAX_STRLEN, "test\0extra", 4);
+				 HFSPLUS_MAX_STRLEN, "test\0extra", 4,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	check_unistr_content(test, &mock_env->str1, "test");
@@ -762,7 +766,8 @@ static void hfsplus_asc2uni_special_chars_test(struct kunit *test)
 
 	/* Test colon conversion (should become forward slash) */
 	result = hfsplus_asc2uni(&mock_sb->sb, &mock_env->str1,
-				 HFSPLUS_MAX_STRLEN, ":", 1);
+				 HFSPLUS_MAX_STRLEN, ":", 1,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	KUNIT_EXPECT_EQ(test, 1, be16_to_cpu(mock_env->str1.length));
@@ -770,7 +775,8 @@ static void hfsplus_asc2uni_special_chars_test(struct kunit *test)
 
 	/* Test string with mixed special characters */
 	result = hfsplus_asc2uni(&mock_sb->sb, &mock_env->str1,
-				 HFSPLUS_MAX_STRLEN, "a:b", 3);
+				 HFSPLUS_MAX_STRLEN, "a:b", 3,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	KUNIT_EXPECT_EQ(test, 3, be16_to_cpu(mock_env->str1.length));
@@ -780,7 +786,8 @@ static void hfsplus_asc2uni_special_chars_test(struct kunit *test)
 
 	/* Test multiple special characters */
 	result = hfsplus_asc2uni(&mock_sb->sb, &mock_env->str1,
-				 HFSPLUS_MAX_STRLEN, ":::", 3);
+				 HFSPLUS_MAX_STRLEN, ":::", 3,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	KUNIT_EXPECT_EQ(test, 3, be16_to_cpu(mock_env->str1.length));
@@ -811,7 +818,8 @@ static void hfsplus_asc2uni_buffer_limits_test(struct kunit *test)
 	memset(mock_env->buf, 'a', HFSPLUS_MAX_STRLEN);
 	result = hfsplus_asc2uni(&mock_sb->sb,
 				 &mock_env->str1, HFSPLUS_MAX_STRLEN,
-				 mock_env->buf, HFSPLUS_MAX_STRLEN);
+				 mock_env->buf, HFSPLUS_MAX_STRLEN,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	KUNIT_EXPECT_EQ(test, HFSPLUS_MAX_STRLEN,
@@ -821,7 +829,8 @@ static void hfsplus_asc2uni_buffer_limits_test(struct kunit *test)
 	memset(mock_env->buf, 'a', HFSPLUS_MAX_STRLEN + 5);
 	result = hfsplus_asc2uni(&mock_sb->sb,
 				 &mock_env->str1, HFSPLUS_MAX_STRLEN,
-				 mock_env->buf, HFSPLUS_MAX_STRLEN + 5);
+				 mock_env->buf, HFSPLUS_MAX_STRLEN + 5,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, -ENAMETOOLONG, result);
 	KUNIT_EXPECT_EQ(test, HFSPLUS_MAX_STRLEN,
@@ -829,13 +838,15 @@ static void hfsplus_asc2uni_buffer_limits_test(struct kunit *test)
 
 	/* Test with smaller max_unistr_len */
 	result = hfsplus_asc2uni(&mock_sb->sb,
-				 &mock_env->str1, 5, "toolongstring", 13);
+				 &mock_env->str1, 5, "toolongstring", 13,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, -ENAMETOOLONG, result);
 	KUNIT_EXPECT_EQ(test, 5, be16_to_cpu(mock_env->str1.length));
 
 	/* Test zero max length */
-	result = hfsplus_asc2uni(&mock_sb->sb, &mock_env->str1, 0, "test", 4);
+	result = hfsplus_asc2uni(&mock_sb->sb, &mock_env->str1, 0, "test", 4,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, -ENAMETOOLONG, result);
 	KUNIT_EXPECT_EQ(test, 0, be16_to_cpu(mock_env->str1.length));
@@ -859,28 +870,32 @@ static void hfsplus_asc2uni_edge_cases_test(struct kunit *test)
 
 	/* Test zero length input */
 	result = hfsplus_asc2uni(&mock_sb->sb,
-				 &ustr, HFSPLUS_MAX_STRLEN, "test", 0);
+				 &ustr, HFSPLUS_MAX_STRLEN, "test", 0,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	KUNIT_EXPECT_EQ(test, 0, be16_to_cpu(ustr.length));
 
 	/* Test input with length mismatch */
 	result = hfsplus_asc2uni(&mock_sb->sb,
-				 &ustr, HFSPLUS_MAX_STRLEN, "hello", 3);
+				 &ustr, HFSPLUS_MAX_STRLEN, "hello", 3,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	check_unistr_content(test, &ustr, "hel");
 
 	/* Test with various printable ASCII characters */
 	result = hfsplus_asc2uni(&mock_sb->sb,
-				 &ustr, HFSPLUS_MAX_STRLEN, "ABC123!@#", 9);
+				 &ustr, HFSPLUS_MAX_STRLEN, "ABC123!@#", 9,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	check_unistr_content(test, &ustr, "ABC123!@#");
 
 	/* Test null character in the middle */
 	result = hfsplus_asc2uni(&mock_sb->sb,
-				 &ustr, HFSPLUS_MAX_STRLEN, test_str, 3);
+				 &ustr, HFSPLUS_MAX_STRLEN, test_str, 3,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	KUNIT_EXPECT_EQ(test, 3, be16_to_cpu(ustr.length));
@@ -909,7 +924,8 @@ static void hfsplus_asc2uni_decompose_test(struct kunit *test)
 	/* Test with decomposition disabled (default) */
 	clear_bit(HFSPLUS_SB_NODECOMPOSE, &mock_sb->sb_info.flags);
 	result = hfsplus_asc2uni(&mock_sb->sb, &mock_env->str1,
-				 HFSPLUS_MAX_STRLEN, "test", 4);
+				 HFSPLUS_MAX_STRLEN, "test", 4,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	check_unistr_content(test, &mock_env->str1, "test");
@@ -917,7 +933,8 @@ static void hfsplus_asc2uni_decompose_test(struct kunit *test)
 	/* Test with decomposition enabled */
 	set_bit(HFSPLUS_SB_NODECOMPOSE, &mock_sb->sb_info.flags);
 	result = hfsplus_asc2uni(&mock_sb->sb, &mock_env->str2,
-				 HFSPLUS_MAX_STRLEN, "test", 4);
+				 HFSPLUS_MAX_STRLEN, "test", 4,
+				 HFS_REGULAR_NAME);
 
 	KUNIT_EXPECT_EQ(test, 0, result);
 	check_unistr_content(test, &mock_env->str2, "test");
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index be24c687858e..9e71b9a03b60 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -166,6 +166,11 @@ struct hfsplus_attr_unistr {
 	hfsplus_unichr unicode[HFSPLUS_ATTR_MAX_STRLEN];
 } __packed;
 
+enum {
+	HFS_REGULAR_NAME,
+	HFS_XATTR_NAME,
+};
+
 struct hfs_extent {
 	__be16 block;
 	__be16 count;
-- 
2.43.0

