Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD0A3B8406;
	Tue, 28 Jul 2026 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785224726; cv=none; b=V4mmh3jlDm9l1nFD2VmwiEsj/xlT16R3OKUxDRVBLC4wq94dA4YTxfaEocrEvKZRmtGGBdlDxqSwlhWdqgGV1oyi7H3JQ4/DEK6jjKCbT2VCroZO6+RKv1v99ZxEn/U0I3xIrUE9goxjIoVGszg3PryEEqjDVHNRXkUEn991VB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785224726; c=relaxed/simple;
	bh=ly1FRrt4btobd6hIZCecIJTs6tPvVGsm4MQ0bWnNvVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0JYBipvf70iu9+grq/IMQqY7x0+xEEA7JMu45lwS10XBhwJAzwBRuWCLrRPxkl4Ccld+0XoZTSVGb0W4vDkiR7mbSsSzW4UK/p1ncQIMwx4CI9JRvsAO93KfjSvX/lA6pL9oH4G5uEOk4/1wv3j2/laT7oBC5jRQLybcD4MZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NfaNLNLP; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NfaNLNLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785224647;
	bh=tETJcvCq2Am2KsRyT683GbO12+VIkEgbycDqYDEfng4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=NfaNLNLPlsrC4n9nC4lShfDF+8kzlIMsbXV2opYg6q2gbSPG6Gw2WV3dSuHwMiU+A
	 1BQ71wybQuUSYyGUsS0u0+4fbzMJt3PuV5VjWS6Ueo2bYc5lC1XBI/hFbQ32EnH3ij
	 LxpTE5otApZbHmwRoTOc2LfeDIBLABebtGdn8CG4=
X-QQ-mid: esmtpgz11t1785224632t21d0cd85
X-QQ-Originating-IP: t0oPbhwF6uy3rSguoen8JaDLJ0CKFjHRKyq3M4bkgk8=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Jul 2026 15:43:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2137586152499823141
EX-QQ-RecipientCnt: 4
From: Yichong Chen <chenyichong@uniontech.com>
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH v2] isofs: validate directory records consistently
Date: Tue, 28 Jul 2026 15:43:49 +0800
Message-Id: <20260728074349.417508-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <h422u6iqz6faysofnomlcqizkqjrsgqw6ooo4jdhfyjuttkqou@p6frlkumlpmd>
References: <h422u6iqz6faysofnomlcqizkqjrsgqw6ooo4jdhfyjuttkqou@p6frlkumlpmd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MKAXChAiZNd4YZaj4jDt+10qW2C/9uBwb9S7wMm3gLeLWdwcOFsIrE10
	adNL2E6dsF6TDax8ozLLzMPiF5H3BZSNwgcUgpypowzr746bDxM5vcLssqbOcg3KdsMC4TB
	iDyyC+HZxzJ0CmBtK257WdCWun6sDC1IldOP7hIj6M5zCWfoDOLBlKEuTKdTrZvG80/LqsZ
	l9O47XbQ4Fge2iB5IYKRI21gx5vWTcFKtY4+I4j+yZA6TtjhObs5s8w/uGk9lY3K4ENuzYS
	b4I1dw9QeJs+tiq+iu0rNw7c4mfzW6zEb1gWif3BqJoFZ4/j+/WvWNuAx73Jg2zXXnB9qc3
	F1UpeyjJk/IvmhmG7Dpss07KH842UvuKlKo8JTI4D4qRPi4+eznxIqlfM9PfVumo2sym9q9
	QIw7385XYpc8VVnBNLVe6l+v5DbADmua7N7T0bd7Wxinb7d61H02WTkqfI8e/3wAMbneXJv
	RDhS7sn+ZRwa6cqEo3AzRwiDa+Y8TcxVYEux5C9cznfQBR76Ax6olGp4D/jzG75szQPU9Ir
	cm4uhdWPJlraNsqSljc6X4Du93D56h3w1OsH/5sq2YsP0SOCklMZR+IGYhm06j2W1xlNzen
	bVnfPaTA9cBji/xqCUAx9QAxCsZpSbl75vQCuAftbuO9dzFsjQ+sO3OVRCwPeSZNtivPmNN
	S2aBtArf4iYXhnl6SotKRG/21CpDJModWSLP0ivgdmSKZf19QyeDF0kyTkyQvQoExoF/aVN
	xLvyfltR1saQdn+Nss2NJW3ZWuyCNLot6sPI6Q6dfn7DEAMgwej+MkwCXdrTRtm+5iQaLl8
	YEapWoE33ZumKGrNWcecGTiUf1RGw35Hp9ES9wQmoWJ62YZB8PB2oaQGF06qp0Htfy1Ocd/
	0YyEZM+1nEnlI21HWRTXBknmQc6EZWs2vlR3xSMkSVhxPZDd21Dvc0jKm70fKhEI7ZNCIpA
	KvrG+/Tii9kJYjKEnKdg6TDRfNiEjgd8aAQlhGJtNds6BPJ1J05rq9wG1ulzstIJo52Oui+
	PHq5AUkpYtsG+kZg9xDE+jpcPGhFGc04rfc4/vag/jnNqPjE61e31C/TdeSOs=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

isofs_export_get_parent() assumes that the first two directory records
are valid "." and ".." entries.  A malformed image can provide an
invalid length for the first entry, causing the computed ".." offset to
point outside the received block.

Add a shared directory record validator and use it in NFS get_parent,
readdir and lookup.  This keeps the basic directory record length checks
consistent across all directory users before they consume the name field
or use one record length to find the next entry.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
v2:
- Move the directory record validator to namei.c.
- Share the validator with NFS get_parent, readdir and lookup.
- Replace duplicate directory record length checks.

 fs/isofs/dir.c    |  7 ++-----
 fs/isofs/export.c | 10 +++++++++-
 fs/isofs/isofs.h  |  3 +++
 fs/isofs/namei.c  | 28 ++++++++++++++++++++++++----
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index cc587cd25162..a96268c9ca41 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -149,10 +149,8 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 			}
 			de = tmpde;
 		}
-		/* Basic sanity check, whether name doesn't exceed dir entry */
-		if (de_len < sizeof(struct iso_directory_record) ||
-		    de_len < de->name_len[0] +
-					sizeof(struct iso_directory_record)) {
+		if (!isofs_dir_record_valid(de, de == tmpde ? 0 : offset_saved,
+					    de == tmpde ? de_len : bufsize)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
 			       " in block %lu of inode %llu\n", block,
 			       inode->i_ino);
@@ -300,4 +298,3 @@ const struct inode_operations isofs_dir_inode_operations =
 	.fileattr_get = isofs_fileattr_get,
 };
 
-
diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 78f80c1a5c54..4f7fa1d508a1 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -83,13 +83,21 @@ static struct dentry *isofs_export_get_parent(struct dentry *child)
 
 	/* This is the "." entry. */
 	de = (struct iso_directory_record*)bh->b_data;
+	if (!isofs_dir_record_valid(de, 0, child_inode->i_sb->s_blocksize) ||
+	    isonum_711(de->name_len) != 1 || de->name[0] != 0) {
+		printk(KERN_ERR "isofs: Unable to find the \".\" directory for NFS.\n");
+		rv = ERR_PTR(-EACCES);
+		goto out;
+	}
 
 	/* The ".." entry is always the second entry. */
 	parent_offset = (unsigned long)isonum_711(de->length);
 	de = (struct iso_directory_record*)(bh->b_data + parent_offset);
 
 	/* Verify it is in fact the ".." entry. */
-	if ((isonum_711(de->name_len) != 1) || (de->name[0] != 1)) {
+	if (!isofs_dir_record_valid(de, parent_offset,
+				    child_inode->i_sb->s_blocksize) ||
+	    isonum_711(de->name_len) != 1 || de->name[0] != 1) {
 		printk(KERN_ERR "isofs: Unable to find the \"..\" "
 		       "directory for NFS.\n");
 		rv = ERR_PTR(-EACCES);
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index 0ec8b24a42ed..dacb9cdae4fd 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -115,6 +115,9 @@ struct inode;		/* To make gcc happy */
 extern int parse_rock_ridge_inode(struct iso_directory_record *, struct inode *, int relocated);
 extern int get_rock_ridge_filename(struct iso_directory_record *, char *, struct inode *);
 extern int isofs_name_translate(struct iso_directory_record *, char *, struct inode *);
+bool isofs_dir_record_valid(struct iso_directory_record *de,
+			    unsigned long offset,
+			    unsigned long bufsize);
 
 int get_joliet_filename(struct iso_directory_record *, unsigned char *, struct inode *);
 int get_acorn_filename(struct iso_directory_record *, char *, struct inode *);
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index 3ace3d6a55e7..a161b28893d6 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -10,6 +10,26 @@
 #include <linux/gfp.h>
 #include "isofs.h"
 
+bool isofs_dir_record_valid(struct iso_directory_record *de,
+			    unsigned long offset,
+			    unsigned long bufsize)
+{
+	unsigned int len;
+	unsigned int name_len;
+	unsigned long min_len = offsetof(struct iso_directory_record, name);
+
+	if (offset > bufsize || bufsize - offset < min_len)
+		return false;
+
+	len = isonum_711(de->length);
+	name_len = isonum_711(de->name_len);
+	if (len < min_len || name_len > len - min_len)
+		return false;
+	if (len > bufsize - offset)
+		return false;
+	return true;
+}
+
 static int
 isofs_cmp(struct dentry *dentry, const char *compare, int dlen)
 {
@@ -88,16 +108,16 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 			de = tmpde;
 		}
 
-		dlen = de->name_len[0];
-		dpnt = de->name;
-		/* Basic sanity check, whether name doesn't exceed dir entry */
-		if (de_len < dlen + sizeof(struct iso_directory_record)) {
+		if (!isofs_dir_record_valid(de, de == tmpde ? 0 : offset_saved,
+					    de == tmpde ? de_len : bufsize)) {
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
 			       " in block %lu of inode %llu\n", block,
 			       dir->i_ino);
 			brelse(bh);
 			return 0;
 		}
+		dlen = de->name_len[0];
+		dpnt = de->name;
 
 		if (sbi->s_rock &&
 		    ((i = get_rock_ridge_filename(de, tmpname, dir)))) {
-- 
2.51.0
