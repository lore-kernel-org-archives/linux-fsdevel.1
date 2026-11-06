Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926178;
	b=08igoq9In7CHvBuUNF4F4jrxJYgc7/qBnyflXkMVebRBJ9rEHDm+md47rltj3Q9y6YUa
	 yefLwuPuR0LZt7JyYHpQesJ5BIC98+6edQcqevEGqoDy70jiUJfOARBoiK+FoKPlWZyxZ
	 LU67jo/UFthecXL2frsaRkcIlMM0wqStryzSag+s3myIbVh1P35pIqTpGXLELUjE6Z/x6
	 fhDG9Fh8ChkQJg+LIgWHQBN9DMOI9mu/r+C0TKaLZw0vtbRm/yShzx9Y2RwOGOBZhA/9y
	 XD9QIcvTUJMDtkg1Zrr2973Ja19lCea/zRXx970A4yTGzPraB57e1T6JU+IP0jOvfVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vy39PjWOWbG+QrSRDXaAzGUP/r3sGf5HzC8FZEBUydY=;
	b=qzRAjWYtJCX9+WVnw6FyxIHX9TrAa4raVeKT2tIRa05zUVwogayCpGL1omDmS5neviys
	 WKGF37anxZ2+4isaCcH25xwfEzd//G0/cSuiLZv3gIfNhCp5IgqBZCd0/ef8l/CqPcBmY
	 XbWTOh5O6sUMpMzh0ZiwV597fiIRehlLIJqiap/E9uNVUYG+FBm3mL91NmFDUevPBWWur
	 HmhzqVbvViok4dMvZQm0/8Dhi2daQdkE2AeKB/FP19mInIF4glN/ccEPH0KCeWdKfJ4rm
	 2TK/8eKaT6FVAs46ZjQmHgqcxu2iB56bjNUPaVfiMGcylw0nL4HuXqbVqG/cOZjHrbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UnLZtKM8;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD34606A337
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 00:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDD34606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UnLZtKM8
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b30ff12f84so225917b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 16:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793926177; x=1794530977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vy39PjWOWbG+QrSRDXaAzGUP/r3sGf5HzC8FZEBUydY=;
        b=UnLZtKM8UTbER3LHVPfZKyk1EUnt+cvT68sEceFoFgL2Fk6sNsZRMsWEHoC5BbusuG
         BByYUONFr2FMV9MyGkUEns1+0UNUT3hSIJAmvtYkeebjMQzUuqgsqWHRpE/GSIn8heCq
         fPs5KLdjDUvvkRE9AT5TSADhIpAag8+R8AolyHbl+TnbWcpTbU5A42rnEMorvAeG0yZr
         VeSyFXSEL7mlO4W92oz5zoNVLGOkCQUYvww+PJmX3flh1GexAXM5DvxvBP3PQTP5WkUj
         Wr/mq963kxABtCb50HNmoUq4uOftBEPtPbiHKdNBKSeErDoP6A8tLjTqm04HdayBm9vx
         cdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793926177; x=1794530977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vy39PjWOWbG+QrSRDXaAzGUP/r3sGf5HzC8FZEBUydY=;
        b=w2rmcup7gUqtsUHCzEkvqlM+EoDydqKG36R8g06be0QCshhJTFTgku8zSm1Mutj/XT
         8ClQGmxu5G3zK8xGu8ld7RMakOoq24QJjLbLuze2ZJX3L6CHbKgqRoo4Tu+V/paF9FBD
         t7XZMRBF7tWAB58YZicWH3/RBgq8O7hjcGUwr8BHwg0HmHt4IcoszKZjxmYqm4byFo7w
         Ke9oMFob5/jQ++V41IUkELWWPCKskK4+Hm5/AbNOxmGtoN3y2TdP0vIdlBgqR5umSGel
         FWRVp+iDIr+Q0Nsr37I+JtXo6l9oJVcDzb0Y4wntPyG4paluY1JF2vtDM/2Ssz0S54KU
         I9BQ==
X-Gm-Message-State: APuU4Z88U7tZcwGGZoRC4GuhaXgzW1CQBlNjGBuYpZzDmEHnMHuZIGrw
	LE5NIRlvLcuKU7s5dElfB+dNYvahg/MXsOjWXwMYSSX+Js8SA1yWrdUzbdgaYovxFlw=
X-Gm-Gg: AYBFou1uHIzEGkzySLKugQzsmRvQ8MCr8hInZJ7JJ6sJeF6xbHENjZ+JgZJFbvdBYoY
	dzTgCbDIN5j2IV7UtBY5DUcdGdFa3/uCSStI6635Xc+/WCuK2LdgQPBPCU3IsTNFqikpGVIPeQ1
	MKKYkrs9JxwR4Vt3zkMuWwK9b7Vq1/liIm604FHSWptGcfMlvK3in5DmTaeVDb79yKSdEdxhHi3
	Vz+XPDFMWylI/0XZnlKwGQwzm5nUFGcL3D709MzkS8t3qJySXwf/2yUwMJ6gLpgnp7GdLAwy46i
	a27au4sYeypI9CqHg+9/qVeOD0MREUmYwKnGxZqEMTTsXR91zbkgG7isPxELTYiqPOXQRXTi3Lc
	7yrCe44PTGLVjoDL5aaoiq0vffntzAlpoQRkkKpRS/3ctT9A6myHSl1hmLbv80EdHG3A3VOlYLw
	bpVZHtpnGpLSFy9+RTMhuG0PqRS/8OjOsC3a3brUavH43t2BiBJez593UTysiwa4+lLRYjUbh2l
	Dw145LU1MN35O8lyRi811cF7TsiBo/d91rvU/k+N2lA4REqOazI3VM/hE6R3d7D/h2oydJfnb//
	ObNJGew8Eg7Gzzvn+OHnlz3dxCM86Z22Ax296vu5pJSM2Lz32DlhpRFTNjb1Ab6v7Os902wzx9A
	7VMtP+Slk/jmnmCuJSoKbjqKOZ4v/xnjJWetKF80yI2UNcK7lJKC6tVNhPmM=
X-Received: by 2002:a53:acd3:0:20b0:66d:1877:121b with SMTP id 956f58d0204a3-67c14289dddmr546185d50.32.1793926176685;
        Thu, 05 Nov 2026 16:49:36 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:62d1:9ddf:24f7:e87e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c134f0e5fsm851304d50.5.2026.11.05.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 16:49:36 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 2/2] hfs: set s_maxbytes from the volume capacity
Date: Thu,  5 Nov 2026 16:49:23 -0800
Message-ID: <20261106004923.1844283-3-slava@dubeyko.com>
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

Likewise HFS+, HFS returned -ENOSPC instead of -EFBIG when
a write targets an offset beyond the capacity of the volume.
hfs_fill_super() does not set s_maxbytes, so it keeps the
VFS default of MAX_NON_LFS (2GiB - 1). On a volume smaller
than that, the VFS limit checks consider the position valid
and the request reaches the file system. Because HFS does
not support holes, cont_write_begin() then tries to zero-fill
the whole gap up to the target offset, and the operation
fails with -ENOSPC.

This was previously worked around by a local check against
the volume capacity in hfs_write_begin(). That check only
covered the write path and only the start offset: truncate
up, copy_file_range() and writes that straddle the limit
were not handled.

Every byte of an HFS file up to end-of-file must be backed
by an allocated block, so a file can never be larger than
the volume. Set s_maxbytes to the volume capacity
(fs_ablocks * alloc_blksz, capped by MAX_NON_LFS). The VFS
then returns -EFBIG for write(), copy_file_range(), truncate
and fallocate beyond that limit, and trims writes that
straddle it. Drop the now redundant local check from
hfs_write_begin().

Fixes: c6decf13bf90 ("hfs: fix error code when writing beyond volume capacity")
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/inode.c | 7 -------
 fs/hfs/super.c | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index e7a8a5350216..ef1275bbbcbb 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -50,15 +50,8 @@ int hfs_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 		    void **fsdata)
 {
 	struct inode *inode = mapping->host;
-	struct hfs_sb_info *sbi = HFS_SB(inode->i_sb);
-	loff_t total_capacity;
 	int ret;
 
-	total_capacity = (loff_t)sbi->fs_ablocks * sbi->alloc_blksz;
-
-	if (pos >= total_capacity)
-		return -EFBIG;
-
 	ret = cont_write_begin(iocb, mapping, pos, len, foliop, fsdata,
 				hfs_get_block,
 				&HFS_I(inode)->phys_size);
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index d20150277eb3..fb8c6c0ba212 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -359,6 +359,14 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto bail;
 	}
 
+	/*
+	 * HFS does not support sparse files, so every byte up to
+	 * the end-of-file has to be backed by an allocated block.
+	 * Therefore, a file can never be larger than the volume.
+	 */
+	sb->s_maxbytes = min_t(loff_t, MAX_NON_LFS,
+			       (loff_t)sbi->fs_ablocks * sbi->alloc_blksz);
+
 	/* try to get the root inode */
 	res = hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
 	if (res)
-- 
2.43.0

