Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EBA3451A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774431285; cv=none; b=bNBcIH0TYptmPkffsFvt3FSvmpxjI3PQH+SNoZR3nqBQJ8WqkLQabrQ8nigDyi62lG385jeaFfSsXit5kglJ83S+joUNfNZI2Oko1YPGw7x5/RxE50wOpcxJHexGXtSInwKGdnHC3Bs0EbXfDQsNaZD3aAL9sAJRVoKGuKHF6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774431285; c=relaxed/simple;
	bh=au2v8Zj1g2gTa/qYyAEVaRCf5QQU9rUKjFNpk5w+uaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LEv0Op/FxtdYlnysRJbXl0hHtd+0rDNX1S9eVEeQCNZ8fFlUDHEQ7vLnsQNoSsALS5cQFFTc4sftW4xaqwZBaOuA02rHD9Iu6DFN0j3heeNNkuFkk6yoctkvsxIE1ah8Po2I4Toh5uM8Ga2Fa+E7BOXrnVt4z8UZzMkqku/qreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrSRf3WT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrSRf3WT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b062069f80so32564965ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774431283; x=1775036083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2kZEGfm9VSl1YrM5qslWXevfM/VbQjjSaf7BnkuDjI=;
        b=jrSRf3WT+DDpx5fcz/kXm0Rlfo6tOWG+ws6WM6zZyV9qNq1yST4Vp+Bnuo9vOUXpTX
         2RugBghwntS/dHehzmGENwhYSXibhDqLqij594StYHIYH5DMfPF5spuBU2ueFf4rk5RZ
         hYJN/gzKPPG1a5WVogL2HjfflGJSiR/MB3r1ik83ndLqxLe8HzG3CtjAC9V2muS6sNZ4
         HGp7CxldlQzBeVfiaa72B+I4LOSvJZFlMaClNmDa6qNEoXTU1ztVVPynAsaPU3vJWBra
         9MquIfkEfEx5Gq7br4SJYlmrH/cyHLi1h4UoX9IsZZ68435r6S3Qa6M8Abv9Tf0yZFJC
         SWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774431283; x=1775036083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2kZEGfm9VSl1YrM5qslWXevfM/VbQjjSaf7BnkuDjI=;
        b=rqjPKcOiargSaOORKnmBciWl2aMs6ETQnD9+vv/vr7yLvFKawrIwAI2PxpSc5OZdfx
         mznaaWhm7AVqIP04slS7481lo2TSVug9XWDfBaPy+P8Tr3o3Y2evv8ac51GZLMHpafpj
         RNIRRqn94MyXexfDdCDpHNxk4D9fVGOx3f51Z1BSn/QLZs85XjjjPeJwWejK+2laGmF9
         vlraJkTow+2uF5HazPuIwPGtxWJGx6cTThnXNmIu70xNrH3d2XTgqBj25eFIA0i3iffh
         w3Q56L/zrIYR8t6JI8pNVl5EmWepz1pB4VPPo3/vlw4/WSlmS8rtk9hLdViiB0bV78Xp
         aZ+A==
X-Forwarded-Encrypted: i=1; AJvYcCVOYN9vemcolhkWhavorkV5FmQFA/rQweavx/jyZZ0BeJ9BTPJT52c6+Y4NXzB2rHUEN1I+tahIvu4C5yu2@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGNrGDzwSqh/RhbW9KSkTvylLw4AZZBJY7ZtsW+7T+ZaQ6MG2
	OtI7RKemFFAC1VIV2hjxBQjPxwRwkoGe5wob7KfPT8c2szerAigCupB7
X-Gm-Gg: ATEYQzxoaNTLLvtBr8kmP495MMI3EXRsJDJoy9EbME8J8qkpgj9JBrNQRpr/5KcUZWT
	9k8XlfjXGjPYzvOP4ygDSFfLP/CX2KW+JKRAHwvG+Qpa7eUkTwtTyo4Ikf2dFu6Mfddd1ptaecN
	e0ZBc9W8fy8S88gqIi0kA25d5xcMDzSbY8PEHmpegLxruPPJtD1dFG3t3drbqyyEseSuyYvBF6o
	1JDxBuF7FlSU+U1Bj3LTSXq45PnugxnPpAiRmXRzFL8gsFVQAuUdym2tuRJ86ZbnzQglcieO3mz
	1YTCnA41VjxKvIFu0D1ld6/T4YTSMcCEJD/4jxcVB2c+kO43L0hE2jWBNdmHnCoWRHp8icBQ2Mn
	Zch3cOfkZ+zGU/vxfeL8Y6RCXtv9FyVAGWU6GoI2KMdspMa6Un7dadQacmLyNumxl8WBoLoOGuY
	IKMhPxU/9hujpOgi5LpLyTdbsGendOciMVun9I
X-Received: by 2002:a17:903:1b45:b0:2ae:6259:5aff with SMTP id d9443c01a7336-2b0b09a69b6mr29408665ad.6.1774431283311;
        Wed, 25 Mar 2026 02:34:43 -0700 (PDT)
Received: from n37-098-250.byted.org ([115.190.40.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516ae1sm164266245ad.13.2026.03.25.02.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:34:42 -0700 (PDT)
From: Diangang Li <diangangli@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	changfengnan@bytedance.com,
	Diangang Li <lidiangang@bytedance.com>
Subject: [RFC 1/1] ext4: fail fast on repeated metadata reads after IO failure
Date: Wed, 25 Mar 2026 17:33:49 +0800
Message-Id: <20260325093349.630193-2-diangangli@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260325093349.630193-1-diangangli@gmail.com>
References: <20260325093349.630193-1-diangangli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Diangang Li <lidiangang@bytedance.com>

ext4 metadata reads serialize on BH_Lock (lock_buffer). If the read fails,
the buffer remains !Uptodate. With concurrent callers, each waiter can
retry the same failing read after the previous holder drops BH_Lock. This
amplifies device retry latency and may trigger hung tasks.

In the normal read path the block driver already performs its own retries.
Once the retries keep failing, re-submitting the same metadata read from
the filesystem just amplifies the latency by serializing waiters on
BH_Lock.

Remember read failures on buffer_head and fail fast for ext4 metadata reads
once a buffer has already failed to read. Clear the flag on successful
read/write completion so the buffer can recover. ext4 read-ahead uses
ext4_read_bh_nowait(), so it does not set the failure flag and remains
best-effort.

Example hung stacks:

  INFO: task toutiao.infra.t:3760933 blocked for more than 327 seconds.
  Call Trace:
   __schedule
   io_schedule
   __wait_on_bit_lock
   bh_uptodate_or_lock
   __read_extent_tree_block
   ext4_find_extent
   ext4_ext_map_blocks
   ext4_map_blocks
   ext4_getblk
   ext4_bread
   __ext4_read_dirblock
   dx_probe
   ext4_htree_fill_tree
   ext4_readdir
   iterate_dir
   ksys_getdents64

  INFO: task toutiao.infra.t:2724456 blocked for more than 327 seconds.
  Call Trace:
   __schedule
   io_schedule
   __wait_on_bit_lock
   ext4_read_bh_lock
   ext4_bread
   __ext4_read_dirblock
   htree_dirblock_to_tree
   ext4_htree_fill_tree
   ext4_readdir
   iterate_dir
   ksys_getdents64

Signed-off-by: Diangang Li <lidiangang@bytedance.com>
Reviewed-by: Fengnan Chang <changfengnan@bytedance.com>
---
 fs/buffer.c                 |  2 ++
 fs/ext4/super.c             | 12 +++++++++++-
 include/linux/buffer_head.h |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 2d2e3ecec6b2b..b41d54b8b1f4d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -145,6 +145,7 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
 {
 	if (uptodate) {
 		set_buffer_uptodate(bh);
+		clear_buffer_read_io_error(bh);
 	} else {
 		/* This happens, due to failed read-ahead attempts. */
 		clear_buffer_uptodate(bh);
@@ -167,6 +168,7 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 {
 	if (uptodate) {
 		set_buffer_uptodate(bh);
+		clear_buffer_read_io_error(bh);
 	} else {
 		buffer_io_error(bh, ", lost sync page write");
 		mark_buffer_write_io_error(bh);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 781c083000c2e..89a99851864a0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -198,7 +198,13 @@ int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
 {
 	BUG_ON(!buffer_locked(bh));
 
+	if (!buffer_write_io_error(bh) && buffer_read_io_error(bh)) {
+		unlock_buffer(bh);
+		return -EIO;
+	}
+
 	if (ext4_buffer_uptodate(bh)) {
+		clear_buffer_read_io_error(bh);
 		unlock_buffer(bh);
 		return 0;
 	}
@@ -206,8 +212,12 @@ int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
 	__ext4_read_bh(bh, op_flags, end_io, simu_fail);
 
 	wait_on_buffer(bh);
-	if (buffer_uptodate(bh))
+	if (buffer_uptodate(bh)) {
+		clear_buffer_read_io_error(bh);
 		return 0;
+	}
+	if (!buffer_write_io_error(bh))
+		set_buffer_read_io_error(bh);
 	return -EIO;
 }
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index b16b88bfbc3e7..be8bedcde379e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -29,6 +29,7 @@ enum bh_state_bits {
 	BH_Delay,	/* Buffer is not yet allocated on disk */
 	BH_Boundary,	/* Block is followed by a discontiguity */
 	BH_Write_EIO,	/* I/O error on write */
+	BH_Read_EIO,	/* I/O error on read */
 	BH_Unwritten,	/* Buffer is allocated on disk but not written */
 	BH_Quiet,	/* Buffer Error Prinks to be quiet */
 	BH_Meta,	/* Buffer contains metadata */
@@ -132,6 +133,7 @@ BUFFER_FNS(Async_Write, async_write)
 BUFFER_FNS(Delay, delay)
 BUFFER_FNS(Boundary, boundary)
 BUFFER_FNS(Write_EIO, write_io_error)
+BUFFER_FNS(Read_EIO, read_io_error)
 BUFFER_FNS(Unwritten, unwritten)
 BUFFER_FNS(Meta, meta)
 BUFFER_FNS(Prio, prio)
-- 
2.39.5
