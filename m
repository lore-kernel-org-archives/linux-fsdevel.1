Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790B3A9850
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412024; cv=none; b=DwAcilYSfUEbsZCzmgY6/mAvlaQztUcWaDZonzUGy6sO+vvyrVLy/Z6pnjGP48IFi9TutgpUqGTvbKpErZ5gXAZBo9pPV+QlwTug1fGLbSE034CFbE+y3qMsfXSgEWBgjka68EN05v/6x6hS8pt+3njUb1CClvj55Mn9GQcDs10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412024; c=relaxed/simple;
	bh=1IEJMlGAIYVWIyCpVTvFsjv9mqTl9ZIrhLv8OC00Sjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSPx2m0nUvD+289aaiuVguMjlA5CN9iOD5c8t4dHHe16t6G4BzLMsvKOpx8dbREAFivRZbI5qhdt9/F5oz7F/8PybhCAwXkfdYQGKVzfm2Chd53o4GW4oEvv99XaBd0sdPBXFhnd3c9nCzNPrxbISwyW9/IWWGeKpUlVj+BVHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDS4uO8C; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDS4uO8C"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab18so1726124c88.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790412019; x=1791016819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mVOD72O7nP3D+t7jG+Ciq4o1ZIEF31Fn6i5vDIyMLpo=;
        b=bDS4uO8CczKZAkaJ+vONeD4ckpOPpqcv3SZOcVBQSDuefWAtkuLNWUgF3XrKWJ8cyS
         /VlNpPh0PTZg5KsPEXWkmaP3IDxqQL+LCfY817Mt7CIpGIQ28YQZh1y+BG0hsPVF3zUv
         f0IzJ7p0SjTf1soTy4ZnkK2aAhDVJGF0DVXG0CA73BDlz/AwrXoHu3IHVl3KNvl7omED
         XTIPyOiLcDFZu6YydQoyO+iNihCHIwBLxEQdYJnoaTBcpfwlPS3ScR4GmT7A+WuHG9qp
         Ppbz2sv5ggVTpXffF6MHD8ngMZQS4cytMx+Xyai5utuwg2YgdgHJMYSkg8d3ehi1dwMu
         /jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790412019; x=1791016819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mVOD72O7nP3D+t7jG+Ciq4o1ZIEF31Fn6i5vDIyMLpo=;
        b=rqAc0WF9tDLD7fLaCm5jShxujzzoVO4TdQkBvUhNNoJ218c+mIVTlgcsZPwOC4KzRj
         nVi63un3tk34Qir7+QNSN3NxySMx0YRt2fAeP5GZVrrGkCQxZoj7Nvb8xmk/I0ezDZym
         3e2x8Stis1PnLzsM9tEYNNVrfqr4XMoJUTZ6sxZML9dwaBanuIi31ROQKnqXctlV/qsa
         FtrG2DYGk15hokhZBfLSmW/9+nFvNJ2CfEwSuuS19wh7WjGrFPPSU9ryBiy+sbsIkXne
         p95TyVGY4Lwt9DUpnmmGNfE+52hseAqcRSjYtzaGudJDlABxXMi0bK4M7A/T7lY0HfQz
         oYiw==
X-Forwarded-Encrypted: i=1; AKwUvBwNtQMio7vIujcMaYHT7aHp0YeK1SWfpYq8AvySPTxMP2BIc95KR/uWW6bghBvc++ZXx+d9WF0vzFfQK4y3@vger.kernel.org
X-Gm-Message-State: AFuF++mRpLNY+cmTNAJ9H1yT9EH6uXbTrDu38M/+cUoz+kR0h9z9nttk
	v5D//qOA36/GHWDmlhMfwBJvIkgWVGTp3sSMsu1BTHf3/gXbOrEILTeE
X-Gm-Gg: AYBFou04WqB1lJy/ejiaRqdouURjOFLvfrR5n9ht441DBtND8mPY/P7G+gSFQlXAPhy
	kWm5jYmbGl9S/9aGDz4PTfUUqBiyODdVqmcN/Yx6yZbuHOOsUkRo4GHOku036lHnBZqIzGbfEXa
	fvxpIZEI4PkM9R850PbDs5yiulTdlH6VpXaPur1pMCcBotzGxeABg1wyJZkkH8g91D+0xWbv5ug
	c4gmwBHNrfM85MvNzkHoc3DXuZkZIgJg798T0tqNJ/89mxirDo1Ir8YrlRC0zJce2gxz8l3EhyQ
	Kgnh0ihyGEZ8fixGvMdzgfNYwAifF33ihP7uJGkuV/t4aEO0HFn/iImSwKBOLfjfWahQdXHQhzo
	5e5Q3QXHPn63pC/GPpKg3n/uWnv9IkE2lquivbdcbpOi5uBmulpDmMnJl0H5SD/Lo/S8ipjElGQ
	9jL5j/3zdXRuziqTm230d9hbkjz0YZ6LQTwArzK3Mz2ygCJNbrN6VuipnHaHVFp7K0zNF9Cky1V
	amOmrIlX0jaFse6lKdgoDxaBcfCXVHUgUPt6+nt4/mPov9pi15/WaiO8HVihb/g4Gr8JOw3vUWk
	mM9UussY2gNA0XvjQTEHDoFOfRcES49ChMyXMAmZ6zG6I4jHRmpSoqBBUWM=
X-Received: by 2002:a05:701b:4589:b0:13f:c741:a4f1 with SMTP id a92af1059eb24-146d00b7369mr2602300c88.23.1790412018623;
        Sat, 26 Sep 2026 01:40:18 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm10487044c88.0.2026.09.26.01.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 01:40:18 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hfsplus: bound the wrapper and partition-table hops in hfsplus_read_wrapper()
Date: Sat, 26 Sep 2026 16:40:10 +0800
Message-ID: <20260926084010.569552-3-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926084010.569552-1-matthias.goergens@gmail.com>
References: <20260926084010.569552-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsplus_read_wrapper() rereads the volume header through a bare "goto
reread", following an HFS wrapper's embedded-volume descriptor or, if
the header matches neither signature, the partition-table fallback it
shares with hfs, with no bound on either.  A descriptor or partition
entry with a zero offset leaves part_start where it was, and the mount
loops forever.

TN1150 ("HFS Plus Volume Format") requires a wrapper's embedded volume
to be HFS Plus: "When an HFS Plus volume is embedded, drEmbedSigWord
must be kHFSPlusSigWord ('H+')".  So there is at most one wrapper hop,
and Apple's hfs code, GRUB and 7-Zip all follow it once.  A partition
map sits at the start of the raw device (previous patch), so a
partition-table hop only makes sense before any wrapper hop.  Allow one
of each, in that order, and fail with -EINVAL otherwise.  A zero offset
is caught on the second pass.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
A wrapper whose embedded-volume descriptor points back at itself
hangs the mount forever without this patch and fails at once with it:

  img=hfsplus-wrapper-loop.img
  put() { printf "$2" | dd of=$img bs=1 seek=$1 conv=notrunc status=none; }
  truncate --size=64K $img
  put $((1024 + 0x00)) '\x42\x44'          # drSigWord 'BD'
  put $((1024 + 0x0a)) '\x82\x00'          # drAtrb: SLOCK | SPARED
  put $((1024 + 0x14)) '\x00\x00\x02\x00'  # drAlBlkSiz 512
  put $((1024 + 0x7c)) '\x48\x2b'          # drEmbedSigWord 'H+'
  put $((1024 + 0x7e)) '\x00\x00\x00\x64'  # drEmbedExtent: start 0, count 100
  mount -o ro,loop -t hfsplus $img /mnt

The same partition-table entry as the hfs patch hangs an hfsplus mount
the same way:

  img=hfsplus-partmap-loop.img
  put() { printf "$2" | dd of=$img bs=1 seek=$1 conv=notrunc status=none; }
  truncate --size=64K $img
  put $((512+0x00)) '\x50\x4d'          # pmSig 'PM'
  put $((512+0x04)) '\x00\x00\x00\x01'  # pmMapBlkCnt 1
  put $((512+0x08)) '\x00\x00\x00\x00'  # pmPyPartStart 0 (self)
  put $((512+0x0c)) '\x00\x00\x00\x64'  # pmPartBlkCnt 100
  put $((512+0x30)) 'Apple_HFS'         # pmPartType
  mount -o ro,loop -t hfsplus $img /mnt
---
 fs/hfsplus/wrapper.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 30cf4fe78b3d..df8079a4d8f5 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -137,6 +137,7 @@ int hfsplus_read_wrapper(struct super_block *sb)
 	struct hfsplus_wd wd;
 	sector_t part_start, part_size;
 	u32 blocksize;
+	bool part_hop_done = false, wrapper_hop_done = false;
 	int error = 0;
 
 	error = -EINVAL;
@@ -172,21 +173,35 @@ int hfsplus_read_wrapper(struct super_block *sb)
 	case cpu_to_be16(HFSPLUS_VOLHEAD_SIG):
 		break;
 	case cpu_to_be16(HFSP_WRAP_MAGIC):
+		/*
+		 * The embedded volume must be HFS Plus (TN1150), so a
+		 * second wrapper is corrupt; a descriptor pointing at
+		 * itself would otherwise loop forever.
+		 */
+		if (wrapper_hop_done)
+			goto out_free_backup_vhdr;
 		if (!hfsplus_read_mdb(sbi->s_vhdr, &wd))
 			goto out_free_backup_vhdr;
 		wd.ablk_size >>= HFSPLUS_SECTOR_SHIFT;
 		part_start += (sector_t)wd.ablk_start +
 			       (sector_t)wd.embed_start * wd.ablk_size;
 		part_size = (sector_t)wd.embed_count * wd.ablk_size;
+		wrapper_hop_done = true;
 		goto reread;
 	default:
 		/*
 		 * Check for a partition block.
 		 *
 		 * (should do this only for cdrom/loop though)
+		 *
+		 * The partition map is at the start of the device: follow
+		 * it at most once, and not from inside a wrapper.
 		 */
+		if (part_hop_done || wrapper_hop_done)
+			goto out_free_backup_vhdr;
 		if (hfs_part_find(sb, &part_start, &part_size))
 			goto out_free_backup_vhdr;
+		part_hop_done = true;
 		goto reread;
 	}
 
-- 
2.55.0

