Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3B579827
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177507; cv=none; b=O5yZRXmBm1WCwIFDVXJhTm3RvcWWoVOGsmk6Zg+gGKD5/fV+oyPyVduFyq/6X0c8NPbI8JK0FjJxwsOY0m6+FP7UzoAddiy6Ul29EiIkYn6JOwk5mOW4PaTgP0yWKjstgQ9/cHBgW/PwFZHtJXVgHaQS6qudNy7Wap42ORfLTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177507; c=relaxed/simple;
	bh=c4fSvmtu7Xr+IOuG+yP2SKPkZ0AgLbmLXVE0NnIxaPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmejxHsDDuk5smDK2FIS31EfRMDCBugR6jHvue69HymgczL8exDhD5j2jVx297x0YasxE9FHIcLAyllWqjo8hsJA/0MKXbPhCTQBEpdqWWxmIG4IooPtjGE8GNjB6ZEJzBVRGwZcWXUD6gxqOOraCG2BiFkrOxwfXRlmdXwTg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abpFOBI8; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abpFOBI8"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469a34907so942608b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790177498; x=1790782298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wEwiqAHXgdK34IP3ClIlasGlROWIgPU+BU4xs4Mv2J4=;
        b=abpFOBI8eJh8t7/oKtqWabkYEDIUQm6uhgi23SKrCZTiTzLh27rA/Y5FZvi8E6vo0P
         uKY5AAIpe20XC2S0gBTDMNO958sjVuoTpHIaV/LWrMNB7A2BChuksvMJrxD05nzlPJ60
         uv5asnYtfNEvf8Uo7xY0y9vTtkBs8K+DN0Nzl1GmqcGQLfXn/4oJXJmGvbUXtFqtYuIs
         B+FLBXZLqW+ZgmDFZ23RicKpuYr0AHA9bDH51xuMo71CFHmWD2srQPXK8j0ekZ/IiWeB
         gbO2XX5mFrpcfeECeHyvbq2SL7TGjwsjyl0m87XSCfKaV1bi/uQRlPcaPnh3dxuuCsdU
         QbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177498; x=1790782298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wEwiqAHXgdK34IP3ClIlasGlROWIgPU+BU4xs4Mv2J4=;
        b=M+dN/YTnr4pTNYULfX0gatUztCzmO+JGr2lLrshyvFArik/Npn/QkSg7sawR1vcAV9
         Hf1FBtq7hq/Eqt4jVQh+b1niYanblmGU54cVRYASVncwdtWRJ+p5ZjqGjSeiO/9nqpLW
         3kwHQ8BT3EF9N73uya/roudeJIh+esQTFLsshzywDLYf5rRmctdakGRRcgq5xmH9gjRt
         bGjR8Zf3YeYFeapSsPL26Jv62KGJaGrQdJ4bG6jy3Chv6EcRnY3WiC2AS43ylGrStmRI
         moTfgtv+Zd8u9k0vvnmWTRCVOkYisWwKbC81IiyjNjwsNe/M2lkHEMcZ0m1kisLEA8kG
         iUhw==
X-Forwarded-Encrypted: i=1; AKwUvBymfeuUVM9ETU+YIQjJQxEaEx3+u3w+bYU5Lp6NE+aapOT7lVCe2xMM+2wZ+v2xbPKaoMjB0vb927pEs+jp@vger.kernel.org
X-Gm-Message-State: AFuF++kcBhWzSDj2RiAQCn72hYRJ8ZlujmHHiG0bWiWBRFLzsVqU1EO9
	o/TmIovMuaUc0k+cgPNDDf/gJfWZk/zJZSomRSOBflTBUR3e73SqqeVg
X-Gm-Gg: AYBFou1jil34UiOZNrQtM5ZV/lLoryLnsgFZRzLcVAFyCPxhyDlCJ+0MGoZlniisRgp
	ndKLJmv0Wq5p+ZDCpPlGHcYnXxPk1C7CPbvIyTau2QuhD7JPchFM+MCIpjS6jJsVNvuEwV2tl5R
	dgwoHJdsIR4LTyNumT/kD7tDs05fU3o31tJXq2yDmp3/xID02ANVmD5RvYpjA3f5WGGqM9+CS3q
	CM8LaqRdm3GLX3bvJiLtCE0KZNyzd5XhxxMDwIqwgUtpY5ohlZbNbXoPqOoZCShA/v00G78I4vS
	9Yr5vA8fGW+l9UZbzRUfZGR8xW2Te0plSXlSyxlJ/KW0jgOnpLuz1mnrk+pHfR9DdCkaaKCB+K0
	npsoGZ9l4470pNfVQDPonifGPwi5gIrFeUDZqIM+CZsNx9rURT+yZFsOjpv80U0Ndc/Sov5o6DV
	KM9iv8FKMAjul7/NTZawkZLHbQjwdRJyMeFe7K2joL5BG9BRjJ8wO0j8u7M9s02H7gEeT4K+fWo
	N/M6kGWqYmqc232WUbicWlyANoT2Z5eOqeiuijhmiAzCtTDVHArNKxNe5n1l0SIPHajN2tgo1vz
	gsJHy9w1EuMfk57x9294aZBvR6P9iuzPwpESRef3jeuQKOCnoi4fOUh7J4Mmgw==
X-Received: by 2002:a05:6a00:23c1:b0:84a:646f:193 with SMTP id d2e1a72fcca58-87d165d0a94mr2712742b3a.0.1790177497963;
        Wed, 23 Sep 2026 08:31:37 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c15b6sm1489821b3a.26.2026.09.23.08.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:31:37 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Thomas Schmitt <scdbackup@gmx.net>,
	linux-fsdevel@vger.kernel.org,
	Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH] isofs: Always advance to the next block in readdir and lookup
Date: Wed, 23 Sep 2026 23:31:34 +0800
Message-ID: <20260923153134.771632-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922121912.2258134-2-jack@suse.cz>
References: <20260922121912.2258134-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3c01d9263683 ("isofs: Fix handling of directories with tight
blocks") made do_isofs_readdir() and isofs_find_entry() move on to the
next block with pos = round_up(pos, bufsize) both when a record ends
exactly at the end of the block and when the next length byte is zero.
In the second case pos is already block aligned if the zero byte is the
first byte of a block, so round_up() leaves it unchanged, the same block
is read again, and the loop never terminates. There is no
fatal_signal_pending() check in either loop, so the task spins at 100%
CPU and cannot be killed, and a second lookup of the same name blocks in
d_alloc_parallel() and trips the hung task detector.

A block that starts with a zero byte inside a directory is reachable
with a single-byte change to an image made by xorrisofs, and without
any corruption when the logical block size is 512 or 1024 bytes:
ECMA-119 zero-pads a directory only up to the end of the 2048-byte
logical sector, so the later logical blocks of a sector that is less
than full start with zero bytes and lie within the directory's size.

In both walkers pos equals (block << bufbits) + offset, so the next
block is simply block + 1. Advance to it directly, which is right for
both cases.

Fixes: 3c01d9263683 ("isofs: Fix handling of directories with tight blocks")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
Jan, this is on top of your for_next; feel free to fold it into
3c01d9263683 instead if that is easier before you send it to Linus.

 fs/isofs/dir.c   | 4 ++--
 fs/isofs/namei.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 5e541e765f547..28741251d56e3 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -119,8 +119,8 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 		if (offset >= bufsize || de->length[0] == 0) {
 			brelse(bh);
 			bh = NULL;
-			ctx->pos = round_up(ctx->pos, bufsize);
-			block = ctx->pos >> bufbits;
+			block++;
+			ctx->pos = (loff_t)block << bufbits;
 			offset = 0;
 			continue;
 		}
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index e1c571478e8f5..4fba1bf7f0167 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -82,8 +82,8 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 		if (offset >= bufsize || de->length[0] == 0) {
 			brelse(bh);
 			bh = NULL;
-			f_pos = round_up(f_pos, bufsize);
-			block = f_pos >> bufbits;
+			block++;
+			f_pos = block << bufbits;
 			offset = 0;
 			continue;
 		}

base-commit: c8437ca3d4386af1ae1f2869643e82fdb9c1f0f5
-- 
2.55.0

