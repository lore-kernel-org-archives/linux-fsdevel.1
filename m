Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E993115AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099743; cv=none; b=Ji1zRNgBz+hstFAhJFujk4f0KphNBctNbr/xupyv4kRipYMDEh2MZKBL4Z4WMGjR9ogP5514aDrP/6n2IzTiZNgldqc0za5uw2EV9BqLGj2BlPL+ukjZeyxa9cpm5aZAd7YiyQGApjxwBSx3eSgjwvi35dEpfGqrjiZkAXbLRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099743; c=relaxed/simple;
	bh=ZpmKwRFTaVDRpEG+RAi47QlgioLtD3fzRnZknrzZESo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GNB4cgwtq9fstimKVy2wNTAfLBbqNmuZnxEsr461+zqsbwYJ5cO93nqi4/j3wRJidE/+Hs3igTSigShgRruFmoHNdq2uY43NwsGS1fR5kNiQiyRXgKbBG8IM2bBUL20u6X09Zixnye97xMqCNMlSwe7nHl711bGOeYTex7S5yXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeVOAe3F; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeVOAe3F"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c35980fdso67850835ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099739; x=1781704539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQb/iqJQzpo10orrqM+glo+MDt0vouj2eWi6LDZfVHY=;
        b=YeVOAe3FFx0Yv5n4d0WNkUjBx2HMPFXK/GcCBm1BTLAs6gIVZRZmgbQPHcgNxEoN8A
         xvs6Z6Sqhr+rojJkBKoPbIvw501BpD7rhTn+pdnOgrJjWVfbV0IGmKDvsJ3iyyPH7fyY
         vtNBcXYKDgpHZ3nfetpG4dlsQSf02/gPpvG1tt5GgNfeh/qwqTtVTbdtF53CKEzWHphQ
         MfH4sY4jybjn+DgcWmATwTEcCQOVOep/lcKrq9SztcVwM24awvvzWEZauASuiSK4gcRd
         MlsNHYV6BtEksNiXEEeve+NYLUs3XxVYwK6xBuCiYctBphLyZaMlQOx4zDD16ZpT+P87
         DOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099739; x=1781704539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQb/iqJQzpo10orrqM+glo+MDt0vouj2eWi6LDZfVHY=;
        b=TO1vvGrupBs4LRdqmAX+aG+GTdzRi3ZNg+2Q/mOqVpFuHJcPcbsOF5EFV9tPWJyy97
         FiD1LrWMLPCrc9U1lfgZv009E3vAz14dkm61YFeF3OUbs+R8JVVhSRZeVNzSHWKjtS0H
         heCEp62zrdKrLeLP28lKSTvFO2D4iwWqcSTwpQfVUzVe8QhStlb3WvFcJCDiu2jR8FhA
         1ynw5oPnJ19i6+jfQOUQxvBSslV+1SfS7KoAdbbqFIjAAwJJ+p3+CthmeTCSm919BXlg
         U9c8nkN07lVxIDCGADxb6FLLgVigqEPE6hBqY/4YP2LH8uAxt3icugVIArkdvAqWdoK5
         QeVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hv27NeQ+PJ/S4Zif/fV8ioiwbYSntXZ96xT1XHBpTxhr1iVhmmaViPJbDmY/IgQjX1pDymKJE1nDvX5oV@vger.kernel.org
X-Gm-Message-State: AOJu0YxYTGA2Lzd/hhIrqX9geyArWQMBjA5o6MKgmzDXg8VJR7GRdodF
	6kJ4EhDnUoRExVRH6OqtLus9+YH33+j0T0iD2gXOVEuywNGRrsuuE3Go
X-Gm-Gg: Acq92OEWu0Rf3RG7Zw6b1+l91/7LeLcVBmkNtn95qL6GJugoHgBJYHNxFdEWqsF/eqD
	k6J0uM/s12uHKDvfbLxMHGzqPZqpRKUfWqhyUwLv3+lTT6qXgd27SY5LGeE2q7TbGG/zGIN9+0X
	lPUI83m6+AtAUytG4ITLlZKFCeOzOZMvk060DMs1VuEQb6kqwXLzqoTqzKA6WKos7EFO6jhQEip
	fWYFQwbYqtUL90cEdeQxcdnz/6/ZSttLLQJepX029YgztK4CYbc/3jJG2aRjKsvxj24bmJt3Hbu
	hY0eXI2U43/wH+GtNN2eFQtqxD9Xv6GXdAAdnXGCT/D0OjmU5hftFPnG1c1lSIH9qAG00tCJvuP
	bSsBFsf0XV7kCfCzTp22cvuGu1/kRt+/RyiYzbqBDlviPNCCGeJ/kg561ZAjqsJxrHmTyJysZJw
	fAbVNFGDI2SMoBNFO7sLdOn1J3u2v43LxFnfqDLyBuzQjRJ2Y=
X-Received: by 2002:a17:902:e883:b0:2c0:ca93:1303 with SMTP id d9443c01a7336-2c1e80e4313mr290888175ad.6.1781099739147;
        Wed, 10 Jun 2026 06:55:39 -0700 (PDT)
Received: from localhost.localdomain ([47.100.192.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166495203sm239619245ad.70.2026.06.10.06.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:55:38 -0700 (PDT)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Wen <anmuxixixi@gmail.com>
Subject: [PATCH 2/2] preserve the next empty-entry hint after allocation
Date: Wed, 10 Jun 2026 21:55:11 +0800
Message-Id: <20260610135511.203041-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advance and preserve the empty-entry hint when only part of a contiguous
empty range is consumed.

This allows the next file creation to reuse the remaining range without
scanning the directory again.

Signed-off-by: Yang Wen <anmuxixixi@gmail.com>
---
 fs/exfat/namei.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index fe26fbf6a0f2..10c58bb7f422 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -273,6 +273,34 @@ static int exfat_check_max_dentries(struct inode *inode)
 	return 0;
 }
 
+static int exfat_cache_next_empty_entry(struct super_block *sb,
+		struct exfat_inode_info *ei, struct exfat_hint_femp *hint_femp,
+		int dentry, int num_entries)
+{
+	int next, cur_clu, next_clu;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_hint_femp next_hint;
+
+	if (hint_femp->eidx == EXFAT_HINT_NONE ||
+	    hint_femp->eidx != dentry ||
+	    hint_femp->count <= num_entries)
+		return 0;
+
+	next = dentry + num_entries;
+	next_hint = *hint_femp;
+	next_hint.eidx = next;
+	next_hint.count -= num_entries;
+
+	cur_clu = dentry / sbi->dentries_per_clu;
+	next_clu = next / sbi->dentries_per_clu;
+	if (next_clu > cur_clu &&
+	    exfat_chain_advance(sb, &next_hint.cur, next_clu - cur_clu))
+		return -EIO;
+
+	ei->hint_femp = next_hint;
+	return 0;
+}
+
 /*
  * Find an empty directory entry set.
  *
@@ -302,6 +330,7 @@ int exfat_find_empty_entry(struct inode *inode,
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct exfat_hint_femp hint_femp;
+	struct exfat_hint_femp prev_hint_femp;
 
 	hint_femp.eidx = EXFAT_HINT_NONE;
 
@@ -314,8 +343,13 @@ int exfat_find_empty_entry(struct inode *inode,
 			exfat_bytes_to_cluster(sbi, i_size_read(inode)),
 			ei->flags);
 
-	while ((dentry = exfat_search_empty_slot(sb, &hint_femp, p_dir,
-					num_entries, es)) < 0) {
+	for (;;) {
+		prev_hint_femp = hint_femp;
+		dentry = exfat_search_empty_slot(sb, &hint_femp, p_dir,
+				num_entries, es);
+		if (dentry >= 0)
+			break;
+
 		if (dentry != -ENOSPC)
 			return dentry;
 
@@ -382,6 +416,13 @@ int exfat_find_empty_entry(struct inode *inode,
 		inode->i_blocks += sbi->cluster_size >> 9;
 	}
 
+	ret = exfat_cache_next_empty_entry(sb, ei, &prev_hint_femp, dentry,
+			num_entries);
+	if (ret) {
+		exfat_put_dentry_set(es, false);
+		return ret;
+	}
+
 	p_dir->dir = exfat_sector_to_cluster(sbi, es->bh[0]->b_blocknr);
 	p_dir->size -= dentry / sbi->dentries_per_clu;
 
-- 
2.34.1

