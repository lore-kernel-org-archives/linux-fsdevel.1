Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DEC2AD35
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781358001; cv=none; b=rKE5Naz4GPYIasdxcY5fccPvcsWk+IWAGZ6hzBx4dAbXXKjT9kH6ovXaadH5pUDo0nD8f3B2RsLAZfMhx94iy8MkBlJXye4zAHoyMlhFMphU0nPh/El5JRs0au0US1x7Gl1/5uXV/ue84aObWarT1595uPTO4j0iCwI5N+IpuGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781358001; c=relaxed/simple;
	bh=2upQt3JXPJAvu0Gl9BVEWHAsTYvu/ma57ixupLFD12A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DIF/qP008qq6iQh6hNSPaQKti1M1rXCE+AVGC3mslnOhRZcrDuqlsFLTfRL55DmcvhC8iTOogIRumP1TwKnrfOAgd05jxovJKoHdt+R5A283ovyu6llIT/RdMSNFk8tt/aoRPKKv6cF6d//bZQ1DL7XudJZovkkXTXXUIZH7F3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGakjMaH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGakjMaH"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c855599a77aso969842a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781357996; x=1781962796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VOjrQIL8lTJVyD7ofYxRG9x+6BL2/fYDQnguoI00Zo=;
        b=CGakjMaHILF5yFsbch28axa+b2VPWq93kxZjQeCFRHZ1ETSbKt/CfkmIMrP6MBN1PP
         zzE3Sc2rucRZzZl8r5hUCqSWhbDBLzs76KILJbxOxmdv9e+emE4iu8dyAava/teJoZTf
         6kww/CTPJE5UoJBppPRN3wA7A2ZY3q/g/DTw/DzzZED7PSE3+o/qvMAPwiZw1EVeSo7y
         2UnPyZ5qhrk/d37sBmq587TGXOlKmCLU5KghhC3uZgaR2Q2ZzN7mGH8kIrmLeaslUZ+6
         hsSH18Gc0yjShyPRyIr9Usm66TrXTFCcOWs0OqRRRCpRmQuYdD0m03WjlKOuqtOExxqu
         CHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781357996; x=1781962796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VOjrQIL8lTJVyD7ofYxRG9x+6BL2/fYDQnguoI00Zo=;
        b=oD5ji7rowXG2NTL2RG3MbDtwuEqA6RxzZgqqoayM4e09/1yRDDicg1b0m4+graCzrS
         +49TJjBgjsbN7vsp3xnhQvy1PfEHR0HrTvH+nD8fe4pBtZAK/5Z0PvOWvNYzQGFvNPIZ
         nt8S9PMu15Bro6I1jO5Cyt5176CJNpv/kDDv/siKGij4cMhiWfoiJOJlE24QqQPBr5UL
         8LTCE44HKk5awZl4HUlDnKS7ZZMNKWI6OIEb7qVCwH7imINCIgTaT4Fmr5rlDCitUSd7
         su4MZZ3TpwlpNUo1ysOJvsjFKUv+zqEN4thTM8MDxYA8C2VwuIoN+a9AgIJSIyLyDBnM
         eBDA==
X-Forwarded-Encrypted: i=1; AFNElJ+ajNnG9ca53aoDyFytHj6TSswEdEQiwRQ82Tjeq23ue8zvKJGy4Oseeu81vY+tbyMv+WXFfjQ+sXK5U9sY@vger.kernel.org
X-Gm-Message-State: AOJu0YzHZh+tjYkoUmEWUVt0VYXUsSWFqPuibu+PV+AJRGJnEkh+bJUk
	euOQZb59GliPMc3pHoN8XWWGcOhxUziUvwFNAoDp3gMuoUIaLdAzhsuK
X-Gm-Gg: Acq92OE7hpB4M+QLtyGQyJ7KuHrJD2rU8fadGWywuz6asVYeIJQFloSM7Q2vi4jaTgm
	7fRq2CRMhkeT/6vuRavUkiz2N4Uel5MWUyjFbBpKVn2jP7kB7UyTZheJru7B7SB0JL38f9gP6VD
	aGBzdGtYpnW84w/BM712OB1YUwY5Q8k/z9Wz3gL0Qi5bQSZg9rXxoUfCDUN2FxmQmz9v+xO0c5k
	lOLDFTsbbylKOxH/8rzfoxJTGQGGYupXXfkhytgCH/p/FXfmg+SGgDgg+tW2RJrhas5woaHXuhQ
	ZOvuk9coMvVICCyLIr4pAH30J8JZDhb30NDqtXRdrm4OUnnekLvK3ZbuzvLvJTNcyEUvTJ6r6C7
	xcnkQptNKFwWzaKW6fhlubgKg69Mtt+beIim54UdVKqfMbcRd+6g4hq19UsyCpG0Xxk7RDC8vDG
	kmcrvNiHlVwZ6KZgcrADWRBIlRFrUoPBc8miEX
X-Received: by 2002:a05:6a21:9208:b0:3b5:489c:7bb5 with SMTP id adf61e73a8af0-3b783f19280mr8456699637.28.1781357995791;
        Sat, 13 Jun 2026 06:39:55 -0700 (PDT)
Received: from localhost.localdomain ([47.100.192.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866518677dsm4590536a12.19.2026.06.13.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:39:55 -0700 (PDT)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Wen <anmuxixixi@gmail.com>
Subject: [PATCH v2 1/1] exfat: preserve the next empty-entry hint after allocation
Date: Sat, 13 Jun 2026 21:39:38 +0800
Message-Id: <20260613133938.239009-1-anmuxixixi@gmail.com>
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
 fs/exfat/namei.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index b7d5e44ad38e..403e47bde9d6 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -276,6 +276,33 @@ static int exfat_check_max_dentries(struct inode *inode)
 	return 0;
 }
 
+static void exfat_cache_next_empty_entry(struct super_block *sb,
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
+		return;
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
+		return;
+
+	ei->hint_femp = next_hint;
+}
+
 /*
  * Find an empty directory entry set.
  *
@@ -317,8 +344,13 @@ int exfat_find_empty_entry(struct inode *inode,
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
 
@@ -385,6 +417,9 @@ int exfat_find_empty_entry(struct inode *inode,
 		inode->i_blocks += sbi->cluster_size >> 9;
 	}
 
+	exfat_cache_next_empty_entry(sb, ei, &prev_hint_femp, dentry,
+			num_entries);
+
 	p_dir->dir = exfat_sector_to_cluster(sbi, es->bh[0]->b_blocknr);
 	p_dir->size -= dentry / sbi->dentries_per_clu;
 
-- 
2.34.1

