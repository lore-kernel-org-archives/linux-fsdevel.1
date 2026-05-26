Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DABB3FCB1C;
	Tue, 26 May 2026 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803371; cv=none; b=R56q56yaM52BkGIoYvdU+k/s0Vn6Gb2rLm2rj/ki67htOWSF5FY70OD7LnGcT8xQZj5DDXjK8j/Js1RzmlgFtmrzl+7ui73cvtv73wvPo1cWBJR9iHQy2JpgEVp8cU99V8kDyxHfyvp2yf1qUJZh67GE3vumW/O8mis9Rr2N0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803371; c=relaxed/simple;
	bh=BpStdpV4/JUm60l+jox3W1V7wvsjq5QV+XLdbXR9Av0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSd8Or5YVMkfvoMLSxz6BGL2MnMxYUFexDVXEp4u8lWQlBWFN3yD24g2C0xxXwUaD0TiTrwFQSffTWmPfoseEk9P377UmPWxkv6aBaFzzlqaf74z1yIxxsNtwoG2dhBgKrCsmahNDm9ZOLRVDpKm85H0WMirGZSLsYmeB1YWkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=GQdM979+; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="GQdM979+"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 9C91A1D40;
	Tue, 26 May 2026 13:49:30 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=GQdM979+;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id DBD8E2126;
	Tue, 26 May 2026 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1779803363;
	bh=UDW3N+JMgIi5Lg8BefOGc5Qm2j1OWOeUYRlefObcR+g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GQdM979+x/2LW0ehY4znUpE1pY7jsmwSKFUjYuOp5OY8au7qOz5XMxhwSIoavd0gn
	 mbwXDhxiihbYtsb0qpb2+1DCX+xZQePE9N91cUcWNDpayuSbOJJugf1FLkSBpHtgJG
	 hDwN6KCvweU0+Uvk/CJKHkdI9N9rkEdgNpw4x7lI=
Received: from localhost.localdomain (172.30.20.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 May 2026 16:49:22 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 3/6] fs/ntfs3: handle delayed allocation overlap in run lookup
Date: Tue, 26 May 2026 15:49:04 +0200
Message-ID: <20260526134907.11402-4-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526134907.11402-1-almaz.alexandrovich@paragon-software.com>
References: <20260526134907.11402-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Introduce run_lookup_entry_da() to look up data runs while taking
delayed allocation into account.

ntfs3 may have both committed extents and delayed allocation extents for
the same VCN range.  The new helper checks delayed allocation first and
falls back to the real run, then corrects the returned range when a real
run overlaps with a delayed allocation run.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  | 17 +++++--------
 fs/ntfs3/ntfs_fs.h |  3 +++
 fs/ntfs3/run.c     | 61 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index e61c5bf7e27e..0caf2f8a8c1e 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -962,11 +962,8 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 
 	/* Try to find in cache. */
 	down_read(&ni->file.run_lock);
-	if (!no_da && run_lookup_entry(&ni->file.run_da, vcn, lcn, len, NULL)) {
-		/* The requested vcn is delay allocated. */
-		*lcn = DELALLOC_LCN;
-	} else if (run_lookup_entry(&ni->file.run, vcn, lcn, len, NULL)) {
-		/* The requested vcn is known in current run. */
+	if (run_lookup_entry_da(&ni->file.run, !no_da ? &ni->file.run_da : NULL,
+				vcn, lcn, len)) {
 	} else {
 		*len = 0;
 	}
@@ -1011,11 +1008,8 @@ int attr_data_get_block_locked(struct ntfs_inode *ni, CLST vcn, CLST clen,
 	int step;
 
 again:
-	if (da && run_lookup_entry(run_da, vcn, lcn, len, NULL)) {
-		/* The requested vcn is delay allocated. */
-		*lcn = DELALLOC_LCN;
-	} else if (run_lookup_entry(run, vcn, lcn, len, NULL)) {
-		/* The requested vcn is known in current run. */
+	if (run_lookup_entry_da(run, da ? &ni->file.run_da : NULL, vcn, lcn,
+				len)) {
 	} else {
 		*len = 0;
 	}
@@ -1100,7 +1094,8 @@ int attr_data_get_block_locked(struct ntfs_inode *ni, CLST vcn, CLST clen,
 	}
 
 	if (!*len) {
-		if (run_lookup_entry(run, vcn, lcn, len, NULL)) {
+		if (run_lookup_entry_da(run, da ? run_da : NULL, vcn, lcn,
+					len)) {
 			if (*lcn != SPARSE_LCN || !new)
 				goto ok; /* Slow normal way without allocation. */
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 9939556dcdc1..d98d7e474476 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -858,6 +858,9 @@ static inline void mi_get_ref(const struct mft_inode *mi, struct MFT_REF *ref)
 /* Globals from run.c */
 bool run_lookup_entry(const struct runs_tree *run, CLST vcn, CLST *lcn,
 		      CLST *len, size_t *index);
+bool run_lookup_entry_da(const struct runs_tree *run,
+			 const struct runs_tree *run_da, CLST vcn, CLST *lcn,
+			 CLST *len);
 void run_truncate(struct runs_tree *run, CLST vcn);
 void run_truncate_head(struct runs_tree *run, CLST vcn);
 void run_truncate_around(struct runs_tree *run, CLST vcn);
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index ad7db67514ef..3ebf0154eda3 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -223,6 +223,66 @@ bool run_lookup_entry(const struct runs_tree *run, CLST vcn, CLST *lcn,
 	return true;
 }
 
+/*
+ * run_overlaps
+ *
+ * true if run overlaps with range [svcn, svcn + len)
+ */
+static bool run_overlaps(const struct runs_tree *run, CLST svcn, CLST len,
+			 CLST *vcn, CLST *clen)
+{
+	size_t i;
+	const struct ntfs_run *r = run->runs;
+	CLST end = svcn + len;
+
+	for (i = 0; i < run->count; i++, r++) {
+		/* Check if [r->vcn, r->vcn+r->len) overlaps [svcn, end). */
+		if (r->vcn < end && svcn < r->vcn + r->len) {
+			if (vcn)
+				*vcn = r->vcn;
+			if (clen)
+				*clen = r->len;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * run_lookup_entry_da
+ *
+ * - lookup vcn in delalloc run
+ * - lookup vcn in real run
+ * - correct result if real run overlaps with delalloc
+ */
+bool run_lookup_entry_da(const struct runs_tree *run,
+			 const struct runs_tree *run_da, CLST vcn, CLST *lcn,
+			 CLST *len)
+{
+	CLST vcn1, len1;
+
+	if (run_da && run_lookup_entry(run_da, vcn, lcn, len, NULL)) {
+		*lcn = DELALLOC_LCN;
+		return true;
+	}
+
+	if (!run_lookup_entry(run, vcn, lcn, len, NULL))
+		return false;
+
+	if (run_da && run_overlaps(run_da, vcn, *len, &vcn1, &len1)) {
+		/* Correct return value. */
+		if (vcn1 > vcn) {
+			*len = vcn1 - vcn;
+		} else {
+			*lcn = DELALLOC_LCN;
+			*len = len1;
+		}
+	}
+
+	return true;
+}
+
 /*
  * run_truncate_head - Decommit the range before vcn.
  */
@@ -1286,7 +1346,6 @@ bool run_remove_range(struct runs_tree *run, CLST vcn, CLST len, CLST *done)
 		return true;
 	}
 
-
 	e = run->runs + run->count;
 	r = run->runs + index;
 	end = vcn + len;
-- 
2.43.0

