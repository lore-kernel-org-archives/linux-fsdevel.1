Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1DD30F958
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783157943; cv=none; b=tqSQS0vTYue/PvEOcbx+tK3bpIraJp+LARteutGQXCQfSZdMoI8ZsqIK0NpkxCQ+OB+BnmChJv6LDa9QaH7smiekwYlBQ0nXsGm4zLjK+Cu4OZf89sQyIedMYLYh2bDbLuBJ/V8uLlU+EEr+HrKMV33+kSSk1lyKoD4fpKu2EBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783157943; c=relaxed/simple;
	bh=0WY4lujUoW+8t9RPZRyrWC9DAATMKinYMCIbcmBY9IY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VkK14IC0VB8QVlXKubazhFu7q/pYcIO3HTn/B39PEx2tK2SzbHA9TDIVzDJRORBIDBiI5uSR5Q3FFCKMh/dekbwTiFSbYO1AZ2uqPSwNriv5AxNybLTyZL4owa29owQz1rRzcIDm5rl9GItjLzG3HUFPBNWqwPBpq6BE7Nhb3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9QfppNY; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9QfppNY"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-804e46366d7so19991867b3.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2026 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783157941; x=1783762741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+wFC810afrczCAEG00O7cfnbSsokPgX0e3PuC6Ayj8=;
        b=L9QfppNYlpC5gVzeFf41XMnBCkW7KsKe2auo4u9Xf0+WLRlkFC7Qv6ixFeVUS34gQq
         ywoVehvbGk+zk3/Nh1SEakM0DcGCoya0JeYt+SxPKJlW03gqfz6nqSiTeLN680P/1sbM
         JuLeJddk2UPnO2gIeA19gkOJ5heaDxXtRmYEuu17Fm9f/0jH4iCuETdlMZDvh8qc+fyB
         Qcci81n+jtWeHypcs/Ni2ITUl6kQtC+rypTz/ULx1EZvkneTkLNpoaZyZz/agzPMwYpG
         nF/3eLBhdGMB34vL87rWTJAVJ/uosTNWYnNjp5zs+iSAZ3kx78X5YDVHzMY2EvQ/fX2R
         yVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783157941; x=1783762741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+wFC810afrczCAEG00O7cfnbSsokPgX0e3PuC6Ayj8=;
        b=hJq5NcEtX3Jtr/Rt7VrfBRcsWAr3JqFFEXuo/TVJC4RowjgxnNjvbXKEUbQReNMuOQ
         BcIJ1Jbf1tjmariY/MChUPIWOKLQtBL6McXAjTIw77huLHtFOefIQKUHqkO6X0SkzDea
         pX6Fj57gZ1IKDtQWUBwcoFQNFtC6G1l/WD1Ow7U0q9yl1kwC2xz71HSum6Y7Fe+XgYU1
         qnKm1yMHxNfD71EV26WOwPNBPRiRlQpSNRdz9NtftopOk+siu3DF6/UbuYM9DEp+Bvws
         58VB9DMgRgt7umPMlL0m1w0DuNProYApI6mT4izYpFYdUyuhRhhZDNQ0js7jwVR0Bbs2
         YQiA==
X-Forwarded-Encrypted: i=1; AHgh+RpoutYXG82HDnVsnUg4TZDKSaUzD36Ygqo103RoV4HHbbdbLuoLWWp/UECBySq6I2m/T5RWwUCbHU/hdRuu@vger.kernel.org
X-Gm-Message-State: AOJu0YwoMK2pFanugWxiBvsMuAPrelzx+veV0T6Bkv8yFUwlO0fgpGk2
	jC4WfkMYrBP47T9TV96aVH+8HHoLDbNFYWxo4azCmrcm8XDo9RQmNmyC
X-Gm-Gg: AfdE7cnMyQKwL9PD7dXRhKtXr7kYMd1vfHHUXzDbwztB8M0Ox13zzH3pxibmUSVtHXP
	fsBmwLpaXzjTX3jkRcS6YiO0iFiBynQrc18sMYCLLQGgriuOzmzxEclF6EajOtCb9jcWNFO9E8a
	yr/gs2cKfyvPt8JJJqlP3OjBCwYUryE6E2rupLJA4KIafIo2VZyPG2Ab37DuBFYTVguWquQO1d3
	t2GxHA65eCjCw1TJWsdJ4PHKguJTK1RRl5naDSxTIPR3xa7thfyvYMNbqltrqiYthW6fU0Cq/bV
	TPaa3jSgn4WEa4+Dq55AcYikAAQW8Qdpnk/LMU8PwNwy1DjZRAnBxFP89ZCfEPNTQC6sK8AomYc
	HI60Sod6NNLclvngIPHnYZyJveGLE951V/QOKr+P6SDfcGa6XzZeGEUp4gTEMzbm3GUwo50IUDp
	YztnoOTpbNJqRN4cQ78E+yBpFmOCix8FdsfIFn
X-Received: by 2002:a05:690c:6513:b0:812:d768:72c4 with SMTP id 00721157ae682-817398edff9mr27380027b3.58.1783157941447;
        Sat, 04 Jul 2026 02:39:01 -0700 (PDT)
Received: from localhost ([109.110.46.40])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b049939sm33421027b3.32.2026.07.04.02.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 02:39:01 -0700 (PDT)
From: Valeriy Yashnikov <yashnikov.valeriy@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yashnikov.valeriy@gmail.com
Subject: [PATCH] ntfs: avoid calling post_write_mst_fixup() for invalid index_block
Date: Sat,  4 Jul 2026 19:38:57 +1000
Message-ID: <20260704094007.426882-1-yashnikov.valeriy@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_icx_ib_sync_write() calls post_write_mst_fixup() when ntfs_ib_write()
returns an error, intending to restore the buffer after a failed write.

However, ntfs_ib_write() returns an error immediately if
pre_write_mst_fixup() validation fails. The caller,
ntfs_icx_ib_sync_write(), interprets any error as a write failure
requiring rollback. It does not differentiate between I/O errors and
validation failures, and calls post_write_mst_fixup() anyway.

Since post_write_mst_fixup() assumes that the index_block contents is
correct, it doesn't perform the boundary checks, which results in
out-of-bounds memory access.

An attacker can craft a malicious NTFS image with:
  - large index_block.usa_ofs offset, pointing outside the ntfs_record
  - index_block.usa_count = 0, causing integer underflow
  - or index_block.usa_count larger than actual number of sectors in the
    ntfs_record, causing out-of-bounds access

KASAN reports describing the memory corruption:
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in post_write_mst_fixup+0x19c/0x1d0
  Read of size 2 at addr ffff8881586c9018 by task p/9428
  Call Trace:
   <TASK>
   dump_stack_lvl+0x100/0x190
   print_report+0x139/0x4ad
   ? post_write_mst_fixup+0x19c/0x1d0
   ? __virt_addr_valid+0x262/0x500
   ? post_write_mst_fixup+0x19c/0x1d0
   kasan_report+0xe4/0x1d0
   ? post_write_mst_fixup+0x19c/0x1d0
   post_write_mst_fixup+0x19c/0x1d0
   ntfs_icx_ib_sync_write+0x179/0x220
   ntfs_inode_sync_filename+0x83d/0x1080
   __ntfs_write_inode+0x1049/0x1480
   ntfs_file_fsync+0x131/0x9b0
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in post_write_mst_fixup+0x1aa/0x1d0
  Write of size 2 at addr ffff8881586c91fe by task p/9428
  Call Trace:
   <TASK>
   dump_stack_lvl+0x100/0x190
   print_report+0x139/0x4ad
   ? post_write_mst_fixup+0x1aa/0x1d0
   ? __virt_addr_valid+0x262/0x500
   ? post_write_mst_fixup+0x1aa/0x1d0
   kasan_report+0xe4/0x1d0
   ? post_write_mst_fixup+0x1aa/0x1d0
   post_write_mst_fixup+0x1aa/0x1d0
   ntfs_icx_ib_sync_write+0x179/0x220
   ntfs_inode_sync_filename+0x83d/0x1080
   __ntfs_write_inode+0x1049/0x1480
   ntfs_file_fsync+0x131/0x9b0
  ==================================================================

Let's move the post_write_mst_fixup() call to ntfs_ib_write().
The ntfs_ib_write() function calls pre_write_mst_fixup() at the beginning.
If the index_block contents is invalid, pre_write_mst_fixup() fails and
ntfs_ib_write() returns early without calling post_write_mst_fixup() on
bad index_block.

Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Cc: stable@vger.kernel.org
Signed-off-by: Valeriy Yashnikov <yashnikov.valeriy@gmail.com>
---
 fs/ntfs/index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index c5f2cf75b750..faa7ee920a3a 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -110,6 +110,10 @@ static int ntfs_ib_write(struct ntfs_index_context *icx, struct index_block *ib)
 	ret = ntfs_inode_attr_pwrite(VFS_I(icx->ia_ni),
 			ntfs_ib_vcn_to_pos(icx, vcn), icx->block_size,
 			(u8 *)ib, icx->sync_write);
+
+	/* Perform data restoration before returning */
+	post_write_mst_fixup((struct ntfs_record *)ib);
+
 	if (ret != icx->block_size) {
 		ntfs_debug("Failed to write index block %lld, inode %llu",
 				vcn, (unsigned long long)icx->idx_ni->mft_no);
@@ -147,7 +151,6 @@ int ntfs_icx_ib_sync_write(struct ntfs_index_context *icx)
 		icx->ib = NULL;
 		icx->ib_dirty = false;
 	} else {
-		post_write_mst_fixup((struct ntfs_record *)icx->ib);
 		icx->sync_write = false;
 	}
 
-- 
2.54.0

