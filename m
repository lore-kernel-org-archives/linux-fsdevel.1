Received: from mail-yx2-f26.google.com (mail-yx2-f26.google.com [74.125.224.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1233C547078
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776988; cv=none; b=PuFIn1YysEwE14/JhUNrbOrGfK1TXyT5ikZnsqiNDeiZsBGkhFI0kC849Jyc71TPM8QRps+Nw1uqRV/gV2/PASMdtqC3yIcZebIyS7r7Q+5+uXTNemhPzTus2XyphrLnRbndt+tw2dHyUFK8ZTuJQCDrvgsgkqTcXAyJtGjkgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776988; c=relaxed/simple;
	bh=MZL3rZqC+DBkxiAjwJgJY5B3EsbAWIY+cW0z6XtJK6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=da7vEvCA/UdbszShdsL2B+erPo6jgaZ/kVY9SVXDiSrsRK1+n63Q1Ft2NC9De28mtEYEQGQZ59zrE7fiHWk88YJE5T6WiEgEJl8IrbNa4BXDEuAlp5Rfm8hgnxrYPwNgvZDCqNP9yTin96z6GwZ33b9tsiaxjCd7F1d5IPYitgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=KpDm0DIw; arc=none smtp.client-ip=74.125.224.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="KpDm0DIw"
Received: by mail-yx2-f26.google.com with SMTP id 956f58d0204a3-6729c4030f0so133195d50.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 17:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789776985; x=1790381785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/SsPQ3asIVGbaaQIiPurL79IQ+gsyhimdLivK7DrT0=;
        b=KpDm0DIwQZd23exi56Pn5aFxvC8xpobfzhIBF1HGsuL0Lvsut4rnh7tsEESbewvelH
         8ft+G4FSeAzZoEi4H9f9mQ5yT/b4VSUftUp7u3lmYvdYblDSrKeW6ROs7E/0zBfN8k8Y
         87xpOb6ZvTBXRFio76OSHd9HO/iLo8m6p6PNaFP4GhraXg+1ID5vBdFaFW7noGA0np1k
         Q5rdNh1qWO8DoqvplpzjWqGPj656mnSMtMgTr7AqCdKJ/bsOiVWRSbCojmetN/n/EsUE
         gmGiTQ66UNVyFlqkTESdBEX8vEiFODKK0CbD3vXcp2c9QZKegPq463oj8zjpr/LuBK0B
         wImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789776985; x=1790381785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/SsPQ3asIVGbaaQIiPurL79IQ+gsyhimdLivK7DrT0=;
        b=r+iaYiNxiV8Jt0N1BJ5GTkoaKKJYyO1q5plCrdK5hRvd+uZ73ijAzrBGfS1zeWPdqJ
         koKoJpr89Zw3KF1yO6pJCd0ChE4QTTUcOBjHgQ4SzYsxwwkGa4auw8AZ9QmxeRLZCSCz
         eQNjgmqF9Ep0Gjt7cL8Q8CTidEQtLbJyGUSkiKL0416NFuerqliYXADKM9Y2+dMao823
         Dq2g2iIIWOE3R+enGTOMBe+HBQSmVp1zZqo/b8AxR7y2Fht/cGBJiehUc54t/Cd5296g
         GxP9+ncgE5/HKNk7F5DszBeSZ67J/+AMnnuoapX9J76Kjc3ews/LkVvHF1ggrKJqNoHp
         3FFw==
X-Gm-Message-State: AFuF++k2DHtlTZp9QOBKj5wtrZweRCLicnA9qevMiMNGpKjRb5bxk5sW
	aD9BDJnAad/GNbgUtm5y83/UuUbnDcnVVPbImR/MurVo5G0S0l6b4nsejcK4rUcuyFI=
X-Gm-Gg: AYBFou29iC2qujtW3ZVoiUWus1us5TQ/7T/t89dBAMu7MdD6zqwyrV3kuWrq4AJ6bxs
	BQrpyNnm4GKY0LF5G1M4BZQ28Y4Z2Em2crrIjYwOl1oICeTtR4QSItS6hVxoNhC3UUkZVSMu+8p
	zFdrkYXU0lyA9uR1Wx4B5LRhiDrKiKTfRVSSVQ1rUIfkhvFXOjGozYz/VhkmcqevTy+M3/zQtXZ
	hq0pSsRPv0Pg9mDZsIzZZV9xhgQ5N6lTSavqwEUxzLbDYiFtK83Kta23qSTs7AGKbnXOv11ZvPS
	cBwIfPQlpc9eI60m5KymZGQIDVtJ42zDrO2pVtgIg5oUrRzIk4tyb68Eexx00eKwIRW5GDlMTEB
	i0pCdiJo0UhobbYXLHp/NnPxQIAzulkoY49pg7YhFYqky5+H8oUQjSyivM+Ws8irxzMijeqUNqK
	WLfi+Gr455SOw3eEaVab5Szj6cHgJftZ2zJB6nPWcOt5BbV6xTqqPmkJ7ozjuBVwCjfkZtmI6eQ
	yTb/qGJHQLrJHP7wbs/hDcHnnA1GQvKaLT5HzNf576EkaJaII4XJnwHAci2NZsHdvmW2JOHsZmH
	3x4d577zaeCNXp9tw4tmpyZzry5Y
X-Received: by 2002:a53:d592:0:b0:66e:5fdb:98d with SMTP id 956f58d0204a3-6717fda6068mr991307d50.50.1789776984956;
        Fri, 18 Sep 2026 17:16:24 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:f1ff:bb02:6c7c:6979])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672990ab5desm642471d50.8.2026.09.18.17.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:16:24 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 2/3] hfsplus: canonicalize decomposed catalog names like fsck_hfs expects
Date: Fri, 18 Sep 2026 17:16:06 -0700
Message-ID: <20260919001607.2777138-3-slava@dubeyko.com>
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

hfsplus_decompose_table (Apple Technote #1150) decomposes each source
character entirely on its own. It never reorders the result, and it
predates a handful of later corrections to the decomposition standard.
Two concrete consequences, both of which macOS's own fsck_hfs treats as
"Illegal name" (CatalogCheck.c: CheckCatalogName(), FixDecomps()):

 - When combining marks contributed by two different source characters
   end up adjacent, this driver stores them in input order rather than
   ascending Unicode combining-class order.
 - A small, fixed set of characters either aren't decomposed at all,
   or are decomposed into a sequence macOS corrected back in
   Mac OS X 10.2 ("Jaguar").

This is reliably reproducible: xfstests generic/339 exercises dirhash
collisions by creating many files with randomized Unicode names, and
the resulting HFS+ volume fails _check_generic_filesystem afterward
with a long run of "Illegal name" reports from fsck.hfsplus.

Fix hfsplus_asc2uni() to store names the way current macOS does, using
the Unicode tables:

 - hfsplus_canonical_reorder() applies the Unicode Canonical Ordering
   Algorithm: each maximal run of nonzero-combining-class code units is
   stable-sorted into ascending class order.
 - decompose_unichar() falls back to hfsplus_legacy_decompose() for the
   characters missing from Apple Technote #1150's table.
 - hfsplus_fixup_legacy_sequences() substitutes any of fsck_hfs's known
   bad sequences with their corrected form.

hfsplus_decompose_str() ties these together and is now shared by
hfsplus_asc2uni(), hfsplus_hash_dentry() and hfsplus_compare_dentry(),
so hashing and comparison always agree with what actually gets stored -
otherwise two byte-for-byte different but canonically-equivalent
spellings of a name could hash differently or fail to compare equal
against the catalog entry a create() of either would produce.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/tables.c  |  99 +++++++++++
 fs/hfsplus/unicode.c | 389 ++++++++++++++++++++++++++++---------------
 fs/hfsplus/unicode.h |   4 +
 3 files changed, 360 insertions(+), 132 deletions(-)

diff --git a/fs/hfsplus/tables.c b/fs/hfsplus/tables.c
index 3bbdc83debb5..2101201ab973 100644
--- a/fs/hfsplus/tables.c
+++ b/fs/hfsplus/tables.c
@@ -3641,3 +3641,102 @@ struct hfsplus_legacy_seq_fixup hfsplus_legacy_seq_fixups[] = {
 	{ 3, { 0x0fb2, 0x0f80, 0x0f71 }, 1, { 0x0f77 } },
 	{ 3, { 0x0fb3, 0x0f80, 0x0f71 }, 1, { 0x0f79 } },
 };
+
+/*
+ * Look up the Unicode canonical combining class of a BMP code point.
+ * Returns 0 ("Not_Reordered") for any code point not listed in the table,
+ * which includes every ordinary base character.
+ */
+u8 hfsplus_combining_class(u16 c)
+{
+	int lo = 0, hi = ARRAY_SIZE(hfsplus_ccc_table) - 1;
+
+	while (lo <= hi) {
+		int mid = (lo + hi) / 2;
+		const struct hfsplus_ccc_range *r = &hfsplus_ccc_table[mid];
+
+		if (c < r->first)
+			hi = mid - 1;
+		else if (c > r->last)
+			lo = mid + 1;
+		else
+			return r->combining_class;
+	}
+
+	return 0;
+}
+
+/*
+ * Look up the corrected canonical decomposition for a single BMP code
+ * point that Apple Technote #1150's own decomposition table (above)
+ * lacks. Returns NULL (and leaves *size alone) if @uc isn't one of these.
+ */
+const u16 *hfsplus_legacy_decompose(u16 uc, int *size)
+{
+	int lo = 0, hi = ARRAY_SIZE(hfsplus_legacy_decomp_table) - 1;
+
+	while (lo <= hi) {
+		int mid = (lo + hi) / 2;
+		const struct hfsplus_legacy_decomp *e =
+				&hfsplus_legacy_decomp_table[mid];
+
+		if (uc < e->uc)
+			hi = mid - 1;
+		else if (uc > e->uc)
+			lo = mid + 1;
+		else {
+			*size = e->len;
+			return e->repl;
+		}
+	}
+
+	return NULL;
+}
+
+/*
+ * Scan an already decomposed and canonically-reordered code unit buffer
+ * for any of the short legacy sequences above and replace them in place
+ * with their corrected form. @len is updated to the buffer's new length.
+ */
+void hfsplus_fixup_legacy_sequences(u16 *buf, int *len)
+{
+	int i = 0;
+
+	while (i < *len) {
+		unsigned int j;
+		bool matched = false;
+
+		for (j = 0; j < ARRAY_SIZE(hfsplus_legacy_seq_fixups); j++) {
+			struct hfsplus_legacy_seq_fixup *f =
+						&hfsplus_legacy_seq_fixups[j];
+			u16 *src, *dst;
+			size_t copy_len;
+			int k;
+
+			if (i + f->match_len > *len)
+				continue;
+			for (k = 0; k < f->match_len; k++)
+				if (buf[i + k] != f->match[k])
+					break;
+			if (k != f->match_len)
+				continue;
+
+			dst = &buf[i + f->repl_len];
+			src = &buf[i + f->match_len];
+			copy_len = (*len - i - f->match_len) * sizeof(*buf);
+			memmove(dst, src, copy_len);
+
+			dst = &buf[i];
+			src = f->repl;
+			copy_len = f->repl_len * sizeof(*buf);
+			memcpy(dst, src, copy_len);
+
+			*len += f->repl_len - f->match_len;
+			matched = true;
+			break;
+		}
+
+		if (!matched)
+			i++;
+	}
+}
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 93d39481e477..59b8788a69a9 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -442,45 +442,264 @@ static u16 *decompose_unichar(wchar_t uc, int *size, u16 *hangul_buffer)
 	*size = hfsplus_try_decompose_hangul(uc, result);
 	if (*size == 0)
 		result = hfsplus_decompose_nonhangul(uc, size);
+	if (!result) {
+		/*
+		 * Not every character with a canonical decomposition is in
+		 * Apple Technote #1150's own table above; a small, fixed
+		 * set was only added to the decomposition standard (or had
+		 * its decomposition corrected) after that table was
+		 * generated. hfsplus_legacy_decompose() covers those.
+		 */
+		const u16 *legacy = hfsplus_legacy_decompose(uc, size);
+
+		if (legacy)
+			result = memcpy(hangul_buffer, legacy,
+					*size * sizeof(*legacy));
+	}
 	return result;
 }
 
-int hfsplus_asc2uni(struct super_block *sb,
-		    struct hfsplus_unistr *ustr, int max_unistr_len,
-		    const char *astr, int len, int name_type)
+/*
+ * Apply the Unicode Canonical Ordering Algorithm to a decomposed name held
+ * as plain host-order code units: within each maximal run of characters
+ * that have a nonzero combining class, stable-sort the run into ascending
+ * combining-class order. A character with combining class 0 always starts
+ * a new run and is never itself reordered.
+ *
+ * hfsplus_decompose_table decomposes each source character on its own; it
+ * says nothing about how the decompositions of two different source
+ * characters should be ordered relative to each other when both produce
+ * combining marks that end up adjacent. Without this pass, such a
+ * sequence can be stored in an order that macOS's own fsck_hfs
+ * (FixDecomps() in CatalogCheck.c) considers illegal, even though every
+ * individual character was decomposed correctly.
+ */
+static void hfsplus_canonical_reorder(u16 *ustr, int len)
 {
-	int size, dsize, decompose;
-	u16 *dstr, outlen = 0;
-	wchar_t c;
-	u16 dhangul[3];
+	int i;
+
+	for (i = 1; i < len; i++) {
+		u8 cls = hfsplus_combining_class(ustr[i]);
+		int j = i;
+
+		if (!cls)
+			continue;
+
+		while (j > 0) {
+			u8 prev_cls = hfsplus_combining_class(ustr[j - 1]);
+			u16 tmp;
+
+			if (!prev_cls || prev_cls <= cls)
+				break;
+
+			tmp = ustr[j];
+			ustr[j] = ustr[j - 1];
+			ustr[j - 1] = tmp;
+			j--;
+		}
+	}
+}
+
+#define HFSPLUS_HANGUL_MAX_JAMO		(3)       /* L + V + optional T */
+
+static_assert(HFSPLUS_HANGUL_MAX_JAMO >= HFSPLUS_LEGACY_DECOMP_MAX_LEN,
+		"hangul_buffer must fit the longest legacy decomposition too");
+
+/*
+ * Decompose and canonically reorder an entire Linux name, as plain
+ * host-order code units. hfsplus_asc2uni(), hfsplus_hash_dentry() and
+ * hfsplus_compare_dentry() all go through this so that storage, hashing
+ * and comparison always agree on what a given name canonicalizes to.
+ *
+ * @out must hold at least @max_len entries, which must not exceed
+ * HFSPLUS_MAX_STRLEN. Returns the number of code units written. If
+ * @consumed is non-NULL, it is set to the number of input bytes actually
+ * consumed, which is less than @len when @out fills up first.
+ */
+static int hfsplus_decompose_str(struct super_block *sb, const char *astr,
+				  int len, int max_len, int name_type,
+				  u16 *out, int *consumed)
+{
+	int decompose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
+	const char *start = astr;
+	int outlen = 0;
+
+	while (outlen < max_len && len > 0) {
+		u16 *dstr;
+		u16 dhangul[HFSPLUS_HANGUL_MAX_JAMO];
+		int dsize, size;
+		wchar_t c;
 
-	decompose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
-	while (outlen < max_unistr_len && len > 0) {
 		size = asc2unichar(sb, astr, len, &c, name_type);
 
-		if (decompose)
-			dstr = decompose_unichar(c, &dsize, dhangul);
-		else
-			dstr = NULL;
+		dstr = decompose ? decompose_unichar(c, &dsize, dhangul) : NULL;
 		if (dstr) {
-			if (outlen + dsize > max_unistr_len)
+			if (outlen + dsize > max_len)
 				break;
 			do {
-				ustr->unicode[outlen++] = cpu_to_be16(*dstr++);
+				out[outlen++] = *dstr++;
 			} while (--dsize > 0);
-		} else
-			ustr->unicode[outlen++] = cpu_to_be16(c);
+		} else {
+			out[outlen++] = c;
+		}
 
 		astr += size;
 		len -= size;
 	}
+
+	hfsplus_canonical_reorder(out, outlen);
+	hfsplus_fixup_legacy_sequences(out, &outlen);
+	if (consumed)
+		*consumed = astr - start;
+	return outlen;
+}
+
+int hfsplus_asc2uni(struct super_block *sb,
+		    struct hfsplus_unistr *ustr, int max_unistr_len,
+		    const char *astr, int len, int name_type)
+{
+	u16 buf[HFSPLUS_MAX_STRLEN];
+	int outlen, i, consumed;
+
+	if (max_unistr_len > HFSPLUS_MAX_STRLEN)
+		max_unistr_len = HFSPLUS_MAX_STRLEN;
+
+	outlen = hfsplus_decompose_str(sb, astr, len, max_unistr_len,
+				       name_type, buf, &consumed);
+	for (i = 0; i < outlen; i++)
+		ustr->unicode[i] = cpu_to_be16(buf[i]);
 	ustr->length = cpu_to_be16(outlen);
-	if (len > 0)
+
+	if (consumed < len)
 		return -ENAMETOOLONG;
 	return 0;
 }
 EXPORT_SYMBOL_IF_KUNIT(hfsplus_asc2uni);
 
+/*
+ * Maximum length of a single maximal run of nonzero-combining-class code
+ * units that hfsplus_decompose_iter_next() below will canonically
+ * reorder. Every code unit with combining class 0 starts a new run, so
+ * this only bounds how many *consecutive* combining marks between two
+ * base characters get sorted - real text, and even deliberately
+ * adversarial "Zalgo" text, essentially never approaches this. Keeping
+ * it small means hfsplus_hash_dentry() and hfsplus_compare_dentry() only
+ * ever need a tiny amount of lookahead state, rather than buffering an
+ * entire (up to 255-unit) name.
+ */
+#define HFSPLUS_CCC_RUN_MAX 32
+
+/*
+ * Iterator that produces the canonically-ordered, decomposed code units
+ * of a Linux name one at a time, without materializing the whole name.
+ * hfsplus_hash_dentry() and hfsplus_compare_dentry() use this so that
+ * hashing and comparison always agree with what hfsplus_asc2uni() would
+ * actually store, while still comparing lazily (stopping at the first
+ * difference) the way this code did before canonical reordering existed.
+ */
+struct hfsplus_decompose_iter {
+	struct super_block *sb;
+	const char *astr;
+	int len;
+	int name_type;
+	int decompose;
+
+	u16 run[HFSPLUS_CCC_RUN_MAX];
+	int run_len;
+	int run_pos;
+};
+
+static void hfsplus_decompose_iter_init(struct hfsplus_decompose_iter *it,
+					struct super_block *sb,
+					const char *astr, int len,
+					int name_type)
+{
+	it->sb = sb;
+	it->astr = astr;
+	it->len = len;
+	it->name_type = name_type;
+	it->decompose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
+	it->run_len = 0;
+	it->run_pos = 0;
+}
+
+/*
+ * Gather the next maximal run of nonzero-combining-class code units
+ * (starting with whatever character comes next, base or not) and
+ * canonically reorder just that run. A character is only included once
+ * we know the class of the first unit it produces, so decoding it is
+ * speculative until that's decided.
+ */
+static bool hfsplus_decompose_iter_refill(struct hfsplus_decompose_iter *it)
+{
+	it->run_pos = 0;
+	it->run_len = 0;
+
+	while (it->len > 0) {
+		u16 *dstr;
+		u16 dhangul[HFSPLUS_HANGUL_MAX_JAMO];
+		int dsize, size;
+		wchar_t c;
+
+		size = asc2unichar(it->sb, it->astr, it->len, &c,
+				   it->name_type);
+
+		dstr = it->decompose ?
+			decompose_unichar(c, &dsize, dhangul) : NULL;
+		if (!dstr) {
+			dhangul[0] = c;
+			dstr = dhangul;
+			dsize = 1;
+		}
+
+		if (it->run_len > 0 && !hfsplus_combining_class(dstr[0]))
+			break;
+
+		if (it->run_len + dsize > HFSPLUS_CCC_RUN_MAX)
+			break;
+
+		it->astr += size;
+		it->len -= size;
+
+		do {
+			it->run[it->run_len++] = *dstr++;
+		} while (--dsize > 0);
+	}
+
+	hfsplus_canonical_reorder(it->run, it->run_len);
+	hfsplus_fixup_legacy_sequences(it->run, &it->run_len);
+	return it->run_len > 0;
+}
+
+/* Returns the next code unit, or a negative value once @it is exhausted. */
+static int hfsplus_decompose_iter_next(struct hfsplus_decompose_iter *it)
+{
+	if (it->run_pos >= it->run_len && !hfsplus_decompose_iter_refill(it))
+		return -1;
+	return it->run[it->run_pos++];
+}
+
+/*
+ * Returns the next code unit that matters for comparison/hashing: folded
+ * if @casefold, with any character folding to 0 ("ignorable") skipped
+ * entirely. Returns a negative value once @it is exhausted.
+ */
+static int hfsplus_decompose_iter_next_folded(struct hfsplus_decompose_iter *it,
+					      int casefold)
+{
+	int c;
+
+	do {
+		c = hfsplus_decompose_iter_next(it);
+		if (c < 0)
+			return -1;
+		if (casefold)
+			c = case_fold(c);
+	} while (casefold && !c);
+
+	return c;
+}
+
 /*
  * Hash a string to an integer as appropriate for the HFS+ filesystem.
  * Composed unicode characters are decomposed and case-folding is performed
@@ -489,45 +708,17 @@ EXPORT_SYMBOL_IF_KUNIT(hfsplus_asc2uni);
 int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str)
 {
 	struct super_block *sb = dentry->d_sb;
-	const char *astr;
-	const u16 *dstr;
-	int casefold, decompose, size, len;
+	int casefold = test_bit(HFSPLUS_SB_CASEFOLD, &HFSPLUS_SB(sb)->flags);
+	struct hfsplus_decompose_iter it;
 	unsigned long hash;
-	wchar_t c;
-	u16 c2;
-	u16 dhangul[3];
+	int c;
 
-	casefold = test_bit(HFSPLUS_SB_CASEFOLD, &HFSPLUS_SB(sb)->flags);
-	decompose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
-	hash = init_name_hash(dentry);
-	astr = str->name;
-	len = str->len;
-	while (len > 0) {
-		int dsize;
-		size = asc2unichar(sb, astr, len, &c, HFS_REGULAR_NAME);
-		astr += size;
-		len -= size;
+	hfsplus_decompose_iter_init(&it, sb, str->name, str->len,
+				    HFS_REGULAR_NAME);
 
-		if (decompose)
-			dstr = decompose_unichar(c, &dsize, dhangul);
-		else
-			dstr = NULL;
-		if (dstr) {
-			do {
-				c2 = *dstr++;
-				if (casefold)
-					c2 = case_fold(c2);
-				if (!casefold || c2)
-					hash = partial_name_hash(c2, hash);
-			} while (--dsize > 0);
-		} else {
-			c2 = c;
-			if (casefold)
-				c2 = case_fold(c2);
-			if (!casefold || c2)
-				hash = partial_name_hash(c2, hash);
-		}
-	}
+	hash = init_name_hash(dentry);
+	while ((c = hfsplus_decompose_iter_next_folded(&it, casefold)) >= 0)
+		hash = partial_name_hash(c, hash);
 	str->hash = end_name_hash(hash);
 
 	return 0;
@@ -543,87 +734,21 @@ int hfsplus_compare_dentry(const struct dentry *dentry,
 		unsigned int len, const char *str, const struct qstr *name)
 {
 	struct super_block *sb = dentry->d_sb;
-	int casefold, decompose, size;
-	int dsize1, dsize2, len1, len2;
-	const u16 *dstr1, *dstr2;
-	const char *astr1, *astr2;
-	u16 c1, c2;
-	wchar_t c;
-	u16 dhangul_1[3], dhangul_2[3];
-
-	casefold = test_bit(HFSPLUS_SB_CASEFOLD, &HFSPLUS_SB(sb)->flags);
-	decompose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
-	astr1 = str;
-	len1 = len;
-	astr2 = name->name;
-	len2 = name->len;
-	dsize1 = dsize2 = 0;
-	dstr1 = dstr2 = NULL;
-
-	while (len1 > 0 && len2 > 0) {
-		if (!dsize1) {
-			size = asc2unichar(sb, astr1, len1, &c,
-					   HFS_REGULAR_NAME);
-			astr1 += size;
-			len1 -= size;
-
-			if (decompose)
-				dstr1 = decompose_unichar(c, &dsize1,
-							  dhangul_1);
-			if (!decompose || !dstr1) {
-				c1 = c;
-				dstr1 = &c1;
-				dsize1 = 1;
-			}
-		}
+	int casefold = test_bit(HFSPLUS_SB_CASEFOLD, &HFSPLUS_SB(sb)->flags);
+	struct hfsplus_decompose_iter it1, it2;
 
-		if (!dsize2) {
-			size = asc2unichar(sb, astr2, len2, &c,
-					   HFS_REGULAR_NAME);
-			astr2 += size;
-			len2 -= size;
-
-			if (decompose)
-				dstr2 = decompose_unichar(c, &dsize2,
-							  dhangul_2);
-			if (!decompose || !dstr2) {
-				c2 = c;
-				dstr2 = &c2;
-				dsize2 = 1;
-			}
-		}
+	hfsplus_decompose_iter_init(&it1, sb, str, len, HFS_REGULAR_NAME);
+	hfsplus_decompose_iter_init(&it2, sb, name->name, name->len,
+				    HFS_REGULAR_NAME);
 
-		c1 = *dstr1;
-		c2 = *dstr2;
-		if (casefold) {
-			c1 = case_fold(c1);
-			if (!c1) {
-				dstr1++;
-				dsize1--;
-				continue;
-			}
-			c2 = case_fold(c2);
-			if (!c2) {
-				dstr2++;
-				dsize2--;
-				continue;
-			}
-		}
-		if (c1 < c2)
-			return -1;
-		else if (c1 > c2)
-			return 1;
+	while (1) {
+		int c1 = hfsplus_decompose_iter_next_folded(&it1, casefold);
+		int c2 = hfsplus_decompose_iter_next_folded(&it2, casefold);
 
-		dstr1++;
-		dsize1--;
-		dstr2++;
-		dsize2--;
+		if (c1 < 0 || c2 < 0)
+			return c1 == c2 ? 0 : (c1 < 0 ? -1 : 1);
+		if (c1 != c2)
+			return c1 < c2 ? -1 : 1;
 	}
-
-	if (len1 < len2)
-		return -1;
-	if (len1 > len2)
-		return 1;
-	return 0;
 }
 EXPORT_SYMBOL_IF_KUNIT(hfsplus_compare_dentry);
diff --git a/fs/hfsplus/unicode.h b/fs/hfsplus/unicode.h
index 3957ebccc232..31cc7691c916 100644
--- a/fs/hfsplus/unicode.h
+++ b/fs/hfsplus/unicode.h
@@ -56,4 +56,8 @@ extern struct hfsplus_ccc_range hfsplus_ccc_table[];
 extern struct hfsplus_legacy_decomp hfsplus_legacy_decomp_table[];
 extern struct hfsplus_legacy_seq_fixup hfsplus_legacy_seq_fixups[];
 
+u8 hfsplus_combining_class(u16 c);
+const u16 *hfsplus_legacy_decompose(u16 uc, int *size);
+void hfsplus_fixup_legacy_sequences(u16 *buf, int *len);
+
 #endif /* _LINUX_HFSPLUS_UNICODE_H */
-- 
2.43.0

