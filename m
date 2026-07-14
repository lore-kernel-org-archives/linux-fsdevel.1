Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE337271456;
	Tue, 14 Jul 2026 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047681; cv=none; b=sel/DZ9rpvs2nwjp5TIhzFhbR294TQpnHtTUp47I/dMck2Z54B5zFHqOBCR0NuAX8Ntb+QC9S6AuTO8hBdm/1pPkRXHhRD2Ya8PcWVDy/WNyzB6KWyKRj8wWFjIVwMScqk1gUtBufs77E19QfTHNL08GplSRghw2oDrDuDpdECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047681; c=relaxed/simple;
	bh=Vhe901sVkBiogG7QJjr+75wBCw+Stl59oG9fOaQ2L3o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VMG/IPrhwmCxFf2k6fn1IP5SPWtOHeFiVrjD1LqLmDVd37CUG5dzqkO3XDAzfdsqhC3FQDuAVI5kIpGIGEpdhtM5rM7p0XP4sWDkCtOfzs2A1XatfGGFhMVeSPU8p6CJL4XWITch2Opb8H7zipQWlhpTbFqfMFu60bFVfflGw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=IkroXJpo; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="IkroXJpo"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 44D8B42B;
	Tue, 14 Jul 2026 16:39:11 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=IkroXJpo;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 08B3B1F9F;
	Tue, 14 Jul 2026 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1784047142;
	bh=JyYeSKzJorI4gF7RGPUhdxBHqeZQSfWh+GW1OI+PBmk=;
	h=From:To:CC:Subject:Date;
	b=IkroXJpoL6yf/b8DZL1AOExy70hMsflyTbQY+jzvaBDK2pOOcFu9kIDrU382eklU5
	 8b1Et+3I7NaSL+Bl5LSwXBTOw2rVEuK1g30SVNBbNOAl/Mce/WCEVoQH4sxdXk9/Xm
	 c2aOyG5tSfeCwo75m9ibhDuYXxrGt0ImRVQVLLNE=
Received: from localhost.localdomain (172.30.20.173) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 14 Jul 2026 19:39:00 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: widen inode/record number storage to u64
Date: Tue, 14 Jul 2026 18:38:50 +0200
Message-ID: <20260714163850.32007-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
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

NTFS inode and MFT record numbers are inherently 64-bit values, but
several places stored them in 'unsigned long' (or CLST, a u32). On 32-bit
architectures 'unsigned long' is only 32 bits wide, so the upper bits of
a record reference are truncated. Store these values in u64 and update
the associated format specifiers (%lx -> %llx) accordingly.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/dir.c     |  4 ++--
 fs/ntfs3/frecord.c | 10 +++++-----
 fs/ntfs3/inode.c   |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 873d52233003..1a96289a1b94 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -281,7 +281,7 @@ static inline bool ntfs_dir_emit(struct ntfs_sb_info *sbi,
 				 u8 *name, struct dir_context *ctx)
 {
 	const struct ATTR_FILE_NAME *fname;
-	unsigned long ino;
+	u64 ino;
 	int name_len;
 	u32 dt_type;
 
@@ -313,7 +313,7 @@ static inline bool ntfs_dir_emit(struct ntfs_sb_info *sbi,
 	name_len = ntfs_utf16_to_nls(sbi, fname->name, fname->name_len, name,
 				     PATH_MAX);
 	if (name_len <= 0) {
-		ntfs_warn(sbi->sb, "failed to convert name for inode %lx.",
+		ntfs_warn(sbi->sb, "failed to convert name for inode %llx.",
 			  ino);
 		return true;
 	}
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 2b49bc077558..9b979e55adf8 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -169,7 +169,7 @@ int ni_load_mi_ex(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
 int ni_load_mi(struct ntfs_inode *ni, const struct ATTR_LIST_ENTRY *le,
 	       struct mft_inode **mi)
 {
-	CLST rno;
+	u64 rno;
 
 	if (!le) {
 		*mi = &ni->mi;
@@ -2961,8 +2961,8 @@ int ni_write_parents(struct ntfs_inode *ni, int sync)
 		if (IS_ERR(dir)) {
 			ntfs_inode_warn(
 				&ni->vfs_inode,
-				"failed to open parent directory r=%lx to write",
-				(long)ino_get(&fname->home));
+				"failed to open parent directory r=%llx to write",
+				(u64)ino_get(&fname->home));
 			continue;
 		}
 
@@ -3081,8 +3081,8 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 		if (IS_ERR(dir)) {
 			ntfs_inode_warn(
 				&ni->vfs_inode,
-				"failed to open parent directory r=%lx to update",
-				(long)ino_get(&fname->home));
+				"failed to open parent directory r=%llx to update",
+				(u64)ino_get(&fname->home));
 			continue;
 		}
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index c43101cc064d..666addbd808e 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -36,7 +36,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	bool is_match = false;
 	bool is_root = false;
 	bool is_dir;
-	unsigned long ino = inode->i_ino;
+	u64 ino = inode->i_ino;
 	u32 rp_fa = 0, asize, t32;
 	u16 roff, rsize, names = 0, links = 0;
 	const struct ATTR_FILE_NAME *fname = NULL;
@@ -79,7 +79,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		;
 	} else if (ref->seq != rec->seq) {
 		err = -EINVAL;
-		ntfs_err(sb, "MFT: r=%lx, expect seq=%x instead of %x!", ino,
+		ntfs_err(sb, "MFT: r=%llx, expect seq=%x instead of %x!", ino,
 			 le16_to_cpu(ref->seq), le16_to_cpu(rec->seq));
 		goto out;
 	} else if (!is_rec_inuse(rec)) {
-- 
2.43.0

