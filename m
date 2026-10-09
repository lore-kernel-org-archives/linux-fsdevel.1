Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7A45198D;
	Fri,  9 Oct 2026 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566271; cv=none; b=imi4RllZgh17hjPqy5SNgcx6G8PTeCdcz++nJWUy/jHMIMVwygBoiZaprBhjnnPc73xVqr7l3gKc0PFVThgW+pBzI3xPV0I3AoYp1UY2Nz/Foxafgdza9asLkirvpObiVZFYZ1j6RJofl0VSI5aY2Ps0GPztelOJ76S4xqpvvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566271; c=relaxed/simple;
	bh=+qM3b5oxHoWu610qHJf4r6M+GwLJBJWIf8bDwhOxdxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErXmrUOmAfzYZXNMJFFLUmCAf1v5oeVs7jOYoZZy5OwZMd7TPSYSsrf2S5Sre+LJgu+WbhS5vPozWgSo0YYeSq9GqQw9urwdsT9MryT/Qf0GIYnuO0ntoytlykSfw3lRwHuhK3mIYFv8zb8qZ1Ala70+TtdyWRYRrweNh+5mlVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=XkuykikU; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="XkuykikU"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 004181D60;
	Fri,  9 Oct 2026 17:18:39 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=XkuykikU;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B6E4421AD;
	Fri,  9 Oct 2026 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791566264;
	bh=AP7BO+WZjKz2CxLk2K061kr8jiua275jMWfkPrCEMJY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XkuykikUOXrvB5p6KC4iYQTILhYfVj7G+itQnqIxrx58GKsJKQlPL1evd2T5fXuTh
	 u1DenGWoj57cMiWUGqaPA67IlXSPsjJ8NOiA9kJvx8+vPces3RllGEvqVln0Gu8G1t
	 yQpRzVU4tbcfBPLxNGzU69iKl7XYDEFFVsVq6zR0=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Oct 2026 20:17:43 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 11/11] fs/ntfs3: fix stale attr_b in attr_allocate_frame()
Date: Fri, 9 Oct 2026 19:17:04 +0200
Message-ID: <20261009171704.11379-12-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
References: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
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

ni_insert_nonresident() can create an attribute list and move the base
$DATA attribute to another MFT record, which invalidates attr_b and
mi_b. attr_allocate_frame() kept using the stale pointers afterwards
to update valid_size, writing into a record that no longer holds the
attribute. The same situation is already handled in
attr_data_get_block_locked(), which re-reads the base attribute after
the layout changes.

Look up attr_b again after the insertion, and read valid_size from the
attribute before the layout can change.

While here, flatten the 'if (attr)' block in attr_allocate_frame() by
returning early to ins_ext, and simplify an empty-bodied if in
attr_data_get_block_locked().

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c | 109 ++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 928c91b57da5..922134cabb05 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1019,11 +1019,8 @@ int attr_data_get_block_locked(struct ntfs_inode *ni, CLST vcn, CLST clen,
 	int step;
 
 again:
-	if (run_lookup_entry_da(run, da ? &ni->file.run_da : NULL, vcn, lcn,
-				len)) {
-	} else {
+	if (!run_lookup_entry_da(run, da ? run_da : NULL, vcn, lcn, len))
 		*len = 0;
-	}
 
 	if (*len) {
 		if (*lcn != SPARSE_LCN || !new)
@@ -1812,7 +1809,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 	struct ATTR_LIST_ENTRY *le, *le_b;
 	struct mft_inode *mi, *mi_b;
 	CLST svcn, evcn1, next_svcn, len;
-	CLST vcn, end, clst_data;
+	CLST vcn, end, clst_data, alloc, evcn;
 	u64 total_size, valid_size, data_size;
 
 	le_b = NULL;
@@ -1830,6 +1827,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 	svcn = le64_to_cpu(attr_b->nres.svcn);
 	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
 	data_size = le64_to_cpu(attr_b->nres.data_size);
+	valid_size = le64_to_cpu(attr_b->nres.valid_size);
 
 	if (svcn <= vcn && vcn < evcn1) {
 		attr = attr_b;
@@ -1949,63 +1947,63 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 	attr = ni_find_attr(ni, attr, &le, ATTR_DATA, ni->file.ads.name,
 			    ni->file.ads.len, &svcn, &mi);
 
-	if (attr) {
-		CLST alloc = bytes_to_cluster(
-			sbi, le64_to_cpu(attr_b->nres.alloc_size));
-		CLST evcn = le64_to_cpu(attr->nres.evcn);
-
-		if (end < next_svcn)
-			end = next_svcn;
-		while (end > evcn) {
-			/* Remove segment [svcn : evcn). */
-			mi_remove_attr(NULL, mi, attr);
-
-			if (!al_remove_le(ni, le)) {
-				err = -EINVAL;
-				goto out;
-			}
+	if (!attr)
+		goto ins_ext;
 
-			if (evcn + 1 >= alloc) {
-				/* Last attribute segment. */
-				evcn1 = evcn + 1;
-				goto ins_ext;
-			}
+	alloc = bytes_to_cluster(sbi, le64_to_cpu(attr_b->nres.alloc_size));
+	evcn = le64_to_cpu(attr->nres.evcn);
 
-			if (ni_load_mi(ni, le, &mi)) {
-				attr = NULL;
-				goto out;
-			}
+	if (end < next_svcn)
+		end = next_svcn;
+	while (end > evcn) {
+		/* Remove segment [svcn : evcn). */
+		mi_remove_attr(NULL, mi, attr);
 
-			attr = mi_find_attr(ni, mi, NULL, ATTR_DATA,
-					    ni->file.ads.name, ni->file.ads.len,
-					    &le->id);
-			if (!attr) {
-				err = -EINVAL;
-				goto out;
-			}
-			svcn = le64_to_cpu(attr->nres.svcn);
-			evcn = le64_to_cpu(attr->nres.evcn);
+		if (!al_remove_le(ni, le)) {
+			err = -EINVAL;
+			goto out;
 		}
 
-		if (end < svcn)
-			end = svcn;
+		if (evcn + 1 >= alloc) {
+			/* Last attribute segment. */
+			evcn1 = evcn + 1;
+			goto ins_ext;
+		}
 
-		err = attr_load_runs(attr, ni, run, &end);
-		if (err)
+		if (ni_load_mi(ni, le, &mi)) {
+			attr = NULL;
 			goto out;
+		}
 
-		evcn1 = evcn + 1;
-		attr->nres.svcn = cpu_to_le64(next_svcn);
-		err = mi_pack_runs(mi, attr, run, evcn1 - next_svcn);
-		if (err)
+		attr = mi_find_attr(ni, mi, NULL, ATTR_DATA, ni->file.ads.name,
+				    ni->file.ads.len, &le->id);
+		if (!attr) {
+			err = -EINVAL;
 			goto out;
+		}
+		svcn = le64_to_cpu(attr->nres.svcn);
+		evcn = le64_to_cpu(attr->nres.evcn);
+	}
 
-		le->vcn = cpu_to_le64(next_svcn);
-		ni->attr_list.dirty = true;
-		mi->dirty = true;
+	if (end < svcn)
+		end = svcn;
+
+	err = attr_load_runs(attr, ni, run, &end);
+	if (err)
+		goto out;
+
+	evcn1 = evcn + 1;
+	attr->nres.svcn = cpu_to_le64(next_svcn);
+	err = mi_pack_runs(mi, attr, run, evcn1 - next_svcn);
+	if (err)
+		goto out;
+
+	le->vcn = cpu_to_le64(next_svcn);
+	ni->attr_list.dirty = true;
+	mi->dirty = true;
+
+	next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
 
-		next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
-	}
 ins_ext:
 	if (evcn1 > next_svcn) {
 		err = ni_insert_nonresident(ni, ATTR_DATA, ni->file.ads.name,
@@ -2014,6 +2012,14 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 					    &attr, &mi, NULL);
 		if (err)
 			goto out;
+		/* Layout of records is changed. */
+		attr_b = ni_find_attr(ni, NULL, NULL, ATTR_DATA,
+				      ni->file.ads.name, ni->file.ads.len, NULL,
+				      &mi_b);
+		if (!attr_b) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 ok:
 	run_truncate_around(run, vcn);
@@ -2022,7 +2028,6 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 		if (new_valid > data_size)
 			new_valid = data_size;
 
-		valid_size = le64_to_cpu(attr_b->nres.valid_size);
 		if (new_valid != valid_size) {
 			attr_b->nres.valid_size = cpu_to_le64(new_valid);
 			mi_b->dirty = true;
-- 
2.43.0

