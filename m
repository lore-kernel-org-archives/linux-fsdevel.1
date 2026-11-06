Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926177;
	b=iu9JVhDocFQ4U9wtG2h4L2PRtMSHa3ZeL9m1ylgqwbxDtjQCtQ20PZz9ccJoTHIEBN8t
	 T5flnRymK82eeNDVHVh9dR5HHqX49DbtdtkXADvUJKT2RTGDe4q5PkanCwK/O/JHQ4jwj
	 wVrt3tfwi5ZWKIa6ZOgnumAkWaLwnrwXB6DPK+D3k79XRtICkXR/Oucg9kBcDJieGvYfU
	 nFmFhmpFY7NtwndJx43UEqQ1dkU+R/Q2Y9LS7CSPOhwF99PFTsrc/kcip+yuelOFIaePm
	 MeVcLuFxEhPhHsCNbrFTH6lfnaArQfyOYpmT+ARpqVqL5ym/O2PtOnCfJ/rCWqshe0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pQEO01ciF970e+91pnP2bZpNYHOflDL1L7tQ/3yYlos=;
	b=RPUxlQphsinG3AtrRC7C+Ymh3hCo4wh8dRqtdLXhiOtDPEyq5r19G0LU3z2NocfxAE2v
	 vwvHZaVd1o3KwstFB9xMk+Xcuvz4+HxRnsXSr5a5ISTQby9JJdnG0Ab8qed44UymWeFUW
	 yEgA56niseBjLPV+v0MRWXZDZ9Z+uDiak+RTILDSa7mn6wpGsaO7nNGrtUXIosfdfK/Jq
	 ERgJRzyelFvggXpnze0rfUyR7TdZDyOvMb5aTZ3icfCi91Od1mkDRh0Kb8UpX8qN8bIwZ
	 YEW5iXveki5e+wHQaOYN4jUqlGXF5K/cqKxwsKvyUeL+FY3NPYCa7ZUMOpDmeB4zM/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SRvsCRRh;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60871606A334
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 00:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60871606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SRvsCRRh
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b331cad3cfso316567b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 16:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793926175; x=1794530975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQEO01ciF970e+91pnP2bZpNYHOflDL1L7tQ/3yYlos=;
        b=SRvsCRRh6RXZ6HSsP9hDVUOfGHTN2h+v6pEIzcaWNaMhUyl8R89A5rSdYFjSey0WBn
         LZ9CEd7glpe7Ucv1Ix7TF6OO5amWDz508ONNAilzMUEFPD6+DRKlc7xpa0+SEtDwcIRN
         qJlJ8Oga5cZHpIA4Wf1oPxKA1wx/ggWN96eKzaV7rfw0wK/Kaz8Id7ZBLbDJgtUZ5x11
         cUMIoJX0jgEa2aglKf1uPAai9na9bmmppDRSD7oHWWPBdJAFbEI/oqDMaFF2CacoPttw
         CojtyXcqHdeIZEUdKUFtVW5hEtkDNYgSlrhDB/D2vjeRMVV/QrA2eX6dctznoUoLM+im
         TXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793926175; x=1794530975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQEO01ciF970e+91pnP2bZpNYHOflDL1L7tQ/3yYlos=;
        b=jVG0aACu/28S2Lw5NdqQqwQJrc4Ui/1eRAgEZaoaHkwKT3/LXPkonozetAhQPNwfth
         6ptNxa7N+0vzmosJbaZTvsxA06hlvcLOLUjaqNCgBi1PgsNsADGvoHKtIvSY4isarnsR
         m/ejY9MhDsz8YjeWXEHBT2V7HTHnxfiezYvxyZJ1LuZ1sO+ChHmjhSsHB9xclq/AnTTk
         czB++ZMLu8RRXsB/qDRUaW6isZ0LM6hQc22hVS67nNa8ApEN1b2Is0CjCM0Bnck4cFqD
         ZC9YKnAnj/ue552dtvIL67fB6zES5Eq2tix5uiMSpyhPHA6lsJ8gRbx1vGxW/OqdqgiE
         5mMQ==
X-Gm-Message-State: APuU4Z/VPKArEhG88xENlp7BdAO0Z9ef/ZZWR2YU5AUxbMWp+Ixs8por
	zFVQ7IljinAQ7RoymIEn+VhMyhH8uvPrN4VrDF6nfvFhPemGMY9lrH113/GrsRCO5f4=
X-Gm-Gg: AYBFou318bQkUz9Gris6pQmNB25GAeSwEqVwhIiWPP4ooEsdHPsLRr2NbOfVmOSm4JM
	4/n6wAYN/3y989ALLFYqmQXbesa5yOVH6fXpcSysWwNrNwk7FFq78kwM7BbtHY452qQiYIM6+pe
	cmcmW5LIox3HM3vhtgheRMvidSVRnYL8J0hllYnqUTcaCM2veXDeKnNzBGsNtdkIKM+scessVcc
	I/jIn/ARzw/JtpdVcXFvNnd7soISI68lkw2fNiKHfU329LOmWfLwnuUh0cbFiFASqYG+DinV8UA
	7UumUKnVqULYu9j87uK+8nN6l0ToOHohvvV2UCuLREIL6l/MCirDSeGB9cD8eyHbzeC2mTePGlY
	DBGnRVF/McfKEKW1b72gXOOvGKyfGSp5b2oFVs82VdetWfalHzo2sBt45MwYOttvulzqpUMQ5El
	iaiUl7QFeOVVMakiDYwLT6mqmK2OAIGzvdWfkpnbiRxs2XvkNTGEgGJBaL9IJwR1eQg8cuPOP1B
	DHP0wzmM6B+tCseq9fUTxK43mupRWYJLt72+AxUQffE91UCLIIyyMcN+aGNBYEy9XpyuJYLbEpN
	prTW0xSM7y6DEYOgCcZ8ltWA3AwvLXuBz3m25SohM0LlyTngUOfYioDRDkSwA7UvFY64kInJDxw
	mcR9r/C+LQPFcl/CtqfU3sjvFJMZcU3sgw2M4oFyjAdm18keA/C4/1vcPEp0=
X-Received: by 2002:a05:690e:1443:b0:677:d023:49e3 with SMTP id 956f58d0204a3-67c1454bac8mr777734d50.65.1793926175279;
        Thu, 05 Nov 2026 16:49:35 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:62d1:9ddf:24f7:e87e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c134f0e5fsm851304d50.5.2026.11.05.16.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 16:49:34 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 1/2] hfsplus: set s_maxbytes from the volume capacity
Date: Thu,  5 Nov 2026 16:49:22 -0800
Message-ID: <20261106004923.1844283-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106004923.1844283-1-slava@dubeyko.com>
References: <20261106004923.1844283-1-slava@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/564 expects -EFBIG when
copy_file_range() targets a destination offset near 8EiB.
hfsplus_fill_super() sets s_maxbytes to MAX_LFS_FILESIZE,
so the VFS limit checks (generic_write_check_limits())
only trim the length instead of failing, and the request
reaches the file system. Because HFS+ does not support
holes, the driver then tries to zero-fill the whole gap
up to the target offset, and the operation fails with
-ENOSPC instead of -EFBIG.

This was previously worked around by a local check
against the volume capacity in hfsplus_write_begin().
That check only covered the write path and only the
start offset: truncate up, copy_file_range() and writes
that straddle the limit were not handled.

Every byte of an HFS+ file up to end-of-file must be
backed by an allocated block, so a file can never be
larger than the volume. Set s_maxbytes to the volume
capacity (total_blocks << alloc_blksz_shift, capped by
MAX_LFS_FILESIZE). The VFS then returns -EFBIG for
write(), copy_file_range(), truncate and fallocate
beyond that limit, and trims writes that straddle it.
Drop the now redundant local check from
hfsplus_write_begin().

Fixes: 56a4dbc90601 ("hfsplus: fix error code when writing beyond volume capacity")
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/inode.c |  7 -------
 fs/hfsplus/super.c | 10 +++++++++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index aed0866499b2..5fa72b465922 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -44,15 +44,8 @@ int hfsplus_write_begin(const struct kiocb *iocb,
 			void **fsdata)
 {
 	struct inode *inode = mapping->host;
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
-	loff_t total_capacity;
 	int ret;
 
-	total_capacity = (loff_t)sbi->total_blocks << sbi->alloc_blksz_shift;
-
-	if (pos >= total_capacity)
-		return -EFBIG;
-
 	ret = cont_write_begin(iocb, mapping, pos, len, foliop, fsdata,
 				hfsplus_get_block,
 				&HFSPLUS_I(inode)->phys_size);
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 4e878641fb59..f3283e9b42c8 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -672,7 +672,15 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Set up operations so we can load metadata */
 	sb->s_op = &hfsplus_sops;
-	sb->s_maxbytes = MAX_LFS_FILESIZE;
+
+	/*
+	 * HFS+ does not support sparse files, so every byte up to
+	 * the end-of-file has to be backed by an allocated block.
+	 * Therefore, a file can never be larger than the volume.
+	 */
+	sb->s_maxbytes = min_t(loff_t, MAX_LFS_FILESIZE,
+			       (loff_t)sbi->total_blocks <<
+					sbi->alloc_blksz_shift);
 
 	if (!(vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_UNMNT))) {
 		pr_warn("Filesystem was not cleanly unmounted, running fsck.hfsplus is recommended.  mounting read-only.\n");
-- 
2.43.0

