Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D200C4AA3EA
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440426; cv=none; b=n75lpUF6v9V7W+8v4clSBNPGfl4hX10nFl9wA+UZ/9ABX0sLCAUGX1rMtpuDmchYsdGXbXABOk4KF4P/VGmRMd8QC5QggpWFF5krkjnRDkcEzsGCPEjprirF4B/fPYQcAQj6sO6Ua2X9AUmwUQ8Ud+2gvqnTmVDBxGmZAMKFIhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440426; c=relaxed/simple;
	bh=jIu+OlxanokFLSfiquBpo8YXaj6PW7O81zppVlD1xwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTqVu3uY3KlO577svGT+O+pw3jmrdl8YiAUoioMftj0ivnpVWsdIxFbwNPuEQC62E53Whj8+VsFTqeOb/8jadIAxLgmqorrLf8f5mSRCbKT3Vvi5j60NtmJX3ftOA8eoVVxMUH2jHs0jdGp4Qj6cfolr+l+QAAQ4szBE/Lx9wV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mma0Uzwk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mma0Uzwk"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso1890654b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788440419; x=1789045219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7QKH2r7d66SxSFJm8bjz6ZBcyuRFjzyujOBEDXlc4U=;
        b=Mma0UzwkG8xdTwfb5jJvwaqAGSgzGlon5iJSbIfZHE7aOiBS5BkrAAGIdtXw+ZZnJI
         bsMOnhT/8Dt4ESWQCNeabTfU6DJH6nDwYZfiAbp7doDCbdly05zXPw6Mt1DbWq2x168p
         9t1vu0CxqB8uhPQxRQIhW3U1HACEsgRD3FD5aJE8X2l+8uWcY2uCpTDO3BwkB4//R3Wk
         V8shx2IszUFho3C+p1s/mM5TpAxsN25aw6jXfKPxE1McPCSR+1BQmgFI0HvqEmQYf8Qg
         b0dkYmFG4cSwWOAJdxd6OKyj9gUYQlCEnCykWDfcgGTpYasySjS1TVHHgLGYtloWzShM
         EZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440419; x=1789045219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A7QKH2r7d66SxSFJm8bjz6ZBcyuRFjzyujOBEDXlc4U=;
        b=jh4jPZOrAC7rkL9W9jbmzd063UclHli5LFMHjN1xafImRa193JndUahiTJEAfFbjE6
         WCl00HQ5wnOl9qaNAmtOCrcr10pIdsn4OIlsN2UCkkz7Gefsqjmbww8lgTpxjktQgvmj
         EEbs/JwZljGsUIVht3XbbRbqqWqwsyBJYQBX1FJTzaRyl03Gh07euSF6yvedcplCVeKY
         Ws4Y+fsNSbBXIUFTQSwjSW7pt1qSdZVn6IVULmcFnUntc4dtGdCfJKOS9iYWsa+GKEtE
         YrZv8mQJrnmsfDQk9BTuUZUE82o+ocztIhBPwcNNkhLOq4KGUzZsOb+Vo+qdcL9jdqgt
         GXsw==
X-Forwarded-Encrypted: i=1; AKwUvBw8Mj3SZfdDYNE8tk2nQQlq+GUs8bvXV8eYvZoPKF4UeIP8rXrvURaQO59q2Ah2w8CE6KkUkXrlNGMyl7a3@vger.kernel.org
X-Gm-Message-State: AFuF++n9msANODNSBp6qkfYoGPNsVTFv/QSEdWVChJxbI6HcREMRj0u1
	NEnp/KEn6X+a1mbvluMCmqBwn16oobGhxgFaCjqZE8ss7j0Qw3A5kLrC
X-Gm-Gg: AYBFou0dq83w31Du4lA+qgQR9Pgod+YblfisPbd3soHHAja43WNPzi5uasISfSEeEU2
	7WG7q1vflllLZp/ar2nRXOHKJAxfOze3tyeLs5lr9/cVMkTZeTxgQ2Q9u068LSmkdyxH7ogAtjU
	LVrLfcoYj8VFYwPh7eYYJiHXMHoCoVicN0UNb31+N6XwjSi6Lib7YjindLn2HRJQ2rRPtzFpsZ4
	Ts4uQXJGtpLEROTjUaKB9Kly/XvUxZ0lH5ZlK8V30SzGSkNlt1/8sye5ahsKqUwzsu63y+p2pih
	Trp1tRPXTTdr7iv0n0RabHUZ3PkSrG9ZAETjVrENVzeyDjZOkNkDjLO850NlOMG2SEixqWTBgGx
	NvTzDX47rwLXt7lUro2hfqIjLgn4Ks0F7XVVtuLfZT89xVuQ77Wf06S6rAk2i3AhzXhaN4w++gp
	q251nQEidL61mGqplwmdo3WbP3Bxvk9PPXyFa5Ee8TYbfnnPqBGoC3HiKC9NmHWbxcWzmdO99TG
	rVmUQDR/iUIfaJyeIzgiJQ1
X-Received: by 2002:a05:6a00:1a0d:b0:85f:4255:59a8 with SMTP id d2e1a72fcca58-85f42557303mr14081961b3a.10.1788440419002;
        Thu, 03 Sep 2026 06:00:19 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db23f7bccsm2980946b3a.10.2026.09.03.06.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:00:16 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v4 2/2] f2fs: enable buffered RWF_DONTCACHE
Date: Thu,  3 Sep 2026 20:59:53 +0800
Message-ID: <cd5bc4fbb9000e5936dfc96e97ed1e8ab94d0a94.1788438786.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788438786.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass FGP_DONTCACHE to f2fs_filemap_get_folio() for IOCB_DONTCACHE writes
and advertise FOP_DONTCACHE.

Keep the F2FS-specific lookup because write_begin_get_folio() adds
FGP_STABLE, which can deadlock here.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 9 ++++++---
 fs/f2fs/file.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0fedacfd12..6e816c9349a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3884,11 +3884,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
+	fgf_t fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
+	if (iocb->ki_flags & IOCB_DONTCACHE)
+		fgp_flags |= FGP_DONTCACHE;
+
 	trace_f2fs_write_begin(inode, pos, len);
 
 	if (!f2fs_is_checkpoint_ready(sbi)) {
@@ -3934,9 +3938,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Do not use FGP_STABLE to avoid deadlock.
 	 * Will wait that below with our IO control.
 	 */
-	folio = f2fs_filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT,
-				mapping_gfp_mask(mapping));
+	folio = f2fs_filemap_get_folio(mapping, index, fgp_flags,
+				       mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
 		goto fail;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index edc352569e8..570244ae4fc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5909,6 +5909,6 @@ const struct file_operations f2fs_file_operations = {
 	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 	.setlease	= generic_setlease,
 };
-- 
2.43.0

