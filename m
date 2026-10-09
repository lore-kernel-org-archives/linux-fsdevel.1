Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B573D4101;
	Fri,  9 Oct 2026 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566247; cv=none; b=GAX+fLcDaYd69jG8jk/7n0NVSAzUG+9gMqFI6DsQ8Upce0vsgEE+YzgzbDhxf2gUS7lfcH97mhXgk7GCaBqA3rLd7HmFYxYqgnD6swl3aIO+vZq6wLvLTOkEVLxerqg5lQB1eCaNVEeWXZK0KhBYlSiF1Z9da5Re6Bbf2totvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566247; c=relaxed/simple;
	bh=vOY0+hAIlUjc1VVJAShao46ul7RuzReTbLwvK0bKscc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWNq3RDHmBGQgPgttDCP7tOyUOrQPLxzHPWgOQQ6Q16jjZ6HlIDB+knqK/8UOyphEQLksZBZDSNZioY2LPyp3FC6eYxfDnjrwmQ8TCO1tXZPIuTRpKjY6Y4BcgB+d4yU2gDh27fWBaISz9ozTQp0La6zeBpRjI8kf0lZUEPgrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=MKrjiwFc; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="MKrjiwFc"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1A2EA1D60;
	Fri,  9 Oct 2026 17:18:15 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=MKrjiwFc;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D5B1121AD;
	Fri,  9 Oct 2026 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791566243;
	bh=YI0nVom7Bj8DOL2rIoC2m1aMIW3du/6BlO2vrwiYnmU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MKrjiwFcicR7Xa1pvp3t+Vg4U8qp3PU/ajeXtponEwY/X83fFcDsgAvXTqh2qP1go
	 l981E3cG1vO2n2Kg0jazMCiQpOrFkpX7PM5rhxNUAhi+TkkcoYQ4G28GcPLApf6hyO
	 wECnZpxoNnZ1ZAOqPnqKI9nel/XsuIHzjs+4mwYY=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Oct 2026 20:17:22 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 03/11] fs/ntfs3: drop unused new_size argument from attr_make_nonresident()
Date: Fri, 9 Oct 2026 19:16:56 +0200
Message-ID: <20261009171704.11379-4-almaz.alexandrovich@paragon-software.com>
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

attr_make_nonresident() takes new_size but never uses it: the
attribute's size is read from the record it is converting, and all
three callers pass either the value already stored there or, in
attr_set_size_res(), a size that the function ignores.

Remove the argument.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  | 13 ++++++-------
 fs/ntfs3/frecord.c |  5 ++---
 fs/ntfs3/ntfs_fs.h |  4 ++--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index cd6d4b75d328..254037763a86 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -258,8 +258,8 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
  */
 int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			  struct ATTR_LIST_ENTRY *le, struct mft_inode *mi,
-			  u64 new_size, struct runs_tree *run,
-			  struct ATTRIB **ins_attr, struct page *page)
+			  struct runs_tree *run, struct ATTRIB **ins_attr,
+			  struct page *page)
 {
 	struct ntfs_sb_info *sbi;
 	struct ATTRIB *attr_s;
@@ -401,8 +401,8 @@ static int attr_set_size_res(struct ntfs_inode *ni, struct ATTRIB *attr,
 
 	if (new_size > sbi->record_size ||
 	    (dsize > 0 && used + dsize > sbi->max_bytes_per_attr)) {
-		return attr_make_nonresident(ni, attr, le, mi, new_size, run,
-					     ins_attr, NULL);
+		return attr_make_nonresident(ni, attr, le, mi, run, ins_attr,
+					     NULL);
 	}
 
 	if (dsize < 0) {
@@ -2832,9 +2832,8 @@ int attr_force_nonresident(struct ntfs_inode *ni)
 	}
 
 	down_write(&ni->file.run_lock);
-	err = attr_make_nonresident(ni, attr, le, mi,
-				    le32_to_cpu(attr->res.data_size),
-				    &ni->file.run, &attr, NULL);
+	err = attr_make_nonresident(ni, attr, le, mi, &ni->file.run, &attr,
+				    NULL);
 	up_write(&ni->file.run_lock);
 
 	return err;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index fc4ddbcf844f..1e3f78b77a48 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2573,9 +2573,8 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 
 	if (!attr->non_res) {
 		down_write(&ni->file.run_lock);
-		err = attr_make_nonresident(ni, attr, le, mi,
-					    le32_to_cpu(attr->res.data_size),
-					    &ni->file.run, &attr, pages[0]);
+		err = attr_make_nonresident(ni, attr, le, mi, &ni->file.run,
+					    &attr, pages[0]);
 		up_write(&ni->file.run_lock);
 		if (err)
 			goto out;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 5811d89d67b3..9321b2608e84 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -464,8 +464,8 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 			   CLST *new_len);
 int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			  struct ATTR_LIST_ENTRY *le, struct mft_inode *mi,
-			  u64 new_size, struct runs_tree *run,
-			  struct ATTRIB **ins_attr, struct page *page);
+			  struct runs_tree *run, struct ATTRIB **ins_attr,
+			  struct page *page);
 int attr_set_size_ex(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		     const __le16 *name, u8 name_len, struct runs_tree *run,
 		     u64 new_size, const u64 *new_valid, bool keep_prealloc,
-- 
2.43.0

