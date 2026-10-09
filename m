Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589673CC7EB;
	Fri,  9 Oct 2026 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566264; cv=none; b=kgg4ZtjdM1x1CrBPF433L3c1d3HLby6Sr77r9ggjm9Iv/rWLs8e8GH552+PL+14TEx5JSq+zDWtTmMEFfEoJNwSz4o7QEcaIAYmxu2FALI5TGKDmD65iShGRwa/X16wQYx4w9BCboUZyuW0ZomYk5o0B8I9lncmYz02gM0cNhDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566264; c=relaxed/simple;
	bh=a/eaC1r4gSGU9FjqH5xHS/HCJbT6qMORMouJKNToTdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqIR75fKU8qIJ6vpAuQs8ClgH0AWlhII11dpsOOtAcwhMh4qW7DFLbxhF9GTfxCZKtPWpmguzPRUHmtbtDTorFqAIBaVxZSdWu1Hv1X0CLYFWC4F6tVMvPGVRLHOdk2ZqBWBU4wCjapOWOoqcqATLfZVsroPzbwIKV2zN6zlIeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=eFgpw0sy; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="eFgpw0sy"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8ACC51D60;
	Fri,  9 Oct 2026 17:18:31 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=eFgpw0sy;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 52B4E21AD;
	Fri,  9 Oct 2026 17:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791566260;
	bh=lAJTVEFpuhHuqhJesuDoPbnrSQQ8nLmUjYGAQDLrQsE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eFgpw0sy93ASmPPt2fUAi8y84jIqr1i7hxNaozSS19qLnolW7Y2uECu82V6DePEqu
	 S2aoFzd9cymZRXsnXIaYOEVX7SkbHhKj/xgiGMFuy5psnEkSHfPjIdcmvVBUc4jkxf
	 vZt9ggIGCz1QBByEeHpZUvWjf91qI2En9SzINmlI=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Oct 2026 20:17:38 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 09/11] fs/ntfs3: take ni_lock() once in ntfs_readdir()
Date: Fri, 9 Oct 2026 19:17:02 +0200
Message-ID: <20261009171704.11379-10-almaz.alexandrovich@paragon-software.com>
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

ntfs_readdir() took ni_lock() to load subrecords, dropped it, and then
took it again for the index walk. The double-checked pattern around
ni_load_all_mi() and the separate out_unlock label exist only because
of that split.

Take the lock once for the whole function and drop the second
acquisition, the inner re-check and the duplicate error label.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/dir.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 328c9a29df89..0998c98eb49c 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -519,34 +519,29 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	if (!name)
 		return -ENOMEM;
 
+	/*
+	 * Keep directory metadata stable for the whole walk. Loading subrecords
+	 * once is not enough if concurrent writeback can still compact ATTR_LIST
+	 * entries and free the record that ntfs_read_hdr() is currently walking.
+	 */
+	ni_lock(ni);
+
 	if (!ni->mi_loaded && ni->attr_list.size) {
 		/*
 		 * Directory inode is locked for read.
 		 * Load all subrecords to avoid 'write' access to 'ni' during
 		 * directory reading.
 		 */
-		ni_lock(ni);
-		if (!ni->mi_loaded && ni->attr_list.size) {
-			err = ni_load_all_mi(ni);
-			if (!err)
-				ni->mi_loaded = true;
-		}
-		ni_unlock(ni);
+		err = ni_load_all_mi(ni);
 		if (err)
 			goto out;
+		ni->mi_loaded = true;
 	}
 
-	/*
-	 * Keep directory metadata stable for the whole walk. Loading subrecords
-	 * once is not enough if concurrent writeback can still compact ATTR_LIST
-	 * entries and free the record that ntfs_read_hdr() is currently walking.
-	 */
-	ni_lock(ni);
-
 	root = indx_get_root(&ni->dir, ni, NULL, NULL);
 	if (!root) {
 		err = -EINVAL;
-		goto out_unlock;
+		goto out;
 	}
 
 	if (pos >= sbi->record_size) {
@@ -557,7 +552,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 		 */
 		err = ntfs_read_hdr(sbi, ni, &root->ihdr, 0, pos, name, ctx);
 		if (err)
-			goto out_unlock;
+			goto out;
 		bit = 0;
 	}
 
@@ -568,7 +563,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 		/* Get the next used index. */
 		err = indx_used_bit(&ni->dir, ni, &bit);
 		if (err)
-			goto out_unlock;
+			goto out;
 
 		if (bit == MINUS_ONE_T) {
 			/* no more used indexes. end of dir. */
@@ -578,13 +573,13 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 		if (bit >= max_bit) {
 			/* Corrupted directory. */
 			err = -EINVAL;
-			goto out_unlock;
+			goto out;
 		}
 
 		err = indx_read_ra(&ni->dir, ni, bit << ni->dir.idx2vbn_bits,
 				   &node, &file->f_ra);
 		if (err)
-			goto out_unlock;
+			goto out;
 
 		/*
 		 * Add each name from index in 'ctx'.
@@ -593,13 +588,12 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 				    ((u64)bit << index_bits) + sbi->record_size,
 				    pos, name, ctx);
 		if (err)
-			goto out_unlock;
+			goto out;
 	}
 
-out_unlock:
+out:
 	ni_unlock(ni);
 
-out:
 	kfree(name);
 	put_indx_node(node);
 
-- 
2.43.0

