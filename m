Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5514A4F0
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 02:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972892; cv=none; b=C3kw5rXACxkq+aZAzpgxYH5NBtUjSkqNudhyWlpapqoA2RDwA1YDzP/sySf/QXcjc2x55rm+ayfD71sClRMhFAfnSEBPFl2995TKYwQIwO+M8P241tTt25RuwqdwlIfLCUdw9TNZd4QasMiLpD2xIv1PDudoE2NatzW1NvePpTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972892; c=relaxed/simple;
	bh=KiitXwm4WnvmpEFCt8x3xuXJ7S3tIGBBsWJsnhVjSNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhWStIKg8aeeyH+Wkp+51MmNfM145DcI2gpG4fdR11SN+cfnJ4ZPGJJiRKQzXgxEvUDObWQA/GU51JNNAs2rAht+XseyzuUICmNw6PW4qHKRZTQPlRfiICggovoo2uGqpBA1gC8R4AuMoCSZ0AzAcFgDRkBNcHoJiT1wI2DEiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b4096ba663ac11f1aa26b74ffac11d73-20260609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bb637b6f-be5d-4c39-84b4-d5696ffc9c25,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:5899f74d7f89f202f1a84ecdaf42d886,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b4096ba663ac11f1aa26b74ffac11d73-20260609
X-User: liuxixin@kylinos.cn
Received: from [192.168.122.73] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 219621544; Tue, 09 Jun 2026 10:41:23 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-fsdevel@vger.kernel.org
Cc: almaz.alexandrovich@paragon-software.com, kari.argillander@gmail.com, liuxixin@kylinos.cn
Subject: [PATCH v1 1/1] ntfs3: fix boundary check in ntfs_dir_count()
Date: Tue, 9 Jun 2026 10:29:04 +0800
Message-ID: <9211aa31fd02d45e42b4981497c6572ad8e26144.1780449274.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.ntfs3-b1-v1.1780449274.git.liuxixin@kylinos.cn>
References: <cover.ntfs3-b1-v1.1780449274.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: ntfs3/send-local.py

ntfs_dir_emit() skips index entries whose fname does not fit in e->size,
but ntfs_dir_count() still accepted them via de_get_fname() alone.
dir_is_empty() can then disagree with readdir: a malformed directory
appears empty in ls while rmdir fails with ENOTEMPTY.

Factor the fname/key bounds check into de_fname_fits() and use it from
ntfs_dir_emit() and de_countable_fname() so count/readdir share the same
entry acceptance rules.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 fs/ntfs3/dir.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 873d52233003..eda02b46e9ed 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -273,6 +273,13 @@ struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
 	return err == -ENOENT ? NULL : err ? ERR_PTR(err) : inode;
 }
 
+
+static inline bool de_fname_fits(const struct NTFS_DE *e, u32 e_size,
+				 const struct ATTR_FILE_NAME *fname)
+{
+	return sizeof(struct NTFS_DE) + fname_full_size(fname) <= e_size;
+}
+
 /*
  * returns false if 'ctx' if full
  */
@@ -305,9 +312,7 @@ static inline bool ntfs_dir_emit(struct ntfs_sb_info *sbi,
 	if (sbi->options->nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
 		return true;
 
-	if (sizeof(struct NTFS_DE) +
-	    offsetof(struct ATTR_FILE_NAME, name) +
-	    fname->name_len * sizeof(short) > le16_to_cpu(e->size))
+	if (!de_fname_fits(e, le16_to_cpu(e->size), fname))
 		return true;
 
 	name_len = ntfs_utf16_to_nls(sbi, fname->name, fname->name_len, name,
@@ -576,6 +581,23 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	return err;
 }
 
+
+/*
+ * Return fname when @e passes the same checks as ntfs_dir_emit() before
+ * exposing an entry (valid key, non-DOS, fname fits in e->size).
+ */
+static inline const struct ATTR_FILE_NAME *
+de_countable_fname(const struct NTFS_DE *e, u32 e_size)
+{
+	const struct ATTR_FILE_NAME *fname;
+
+	fname = de_get_fname(e);
+	if (!fname || fname->type == FILE_NAME_DOS || !de_fname_fits(e, e_size, fname))
+		return NULL;
+
+	return fname;
+}
+
 static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 			  size_t *files)
 {
@@ -615,13 +637,10 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 			if (de_is_last(e))
 				break;
 
-			fname = de_get_fname(e);
+			fname = de_countable_fname(e, e_size);
 			if (!fname)
 				continue;
 
-			if (fname->type == FILE_NAME_DOS)
-				continue;
-
 			if (is_empty) {
 				*is_empty = false;
 				if (!dirs && !files)
-- 
2.43.0

