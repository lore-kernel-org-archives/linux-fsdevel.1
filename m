Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E5344DA8
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839776; cv=none; b=MEqiDkP6dURhac/XTSo4zccVWPf+kFb6bn6BU32bevLKj2t+jtQhqyHiVlBCKqTuk0zMUsET7MtFw3EWKtmwpMD02FfYn8gPaI8QLmtxspEQ2UcYUUT2Z0AVHadnYr84DIhiuwrbSKYcXXMwmPRnBAdXfGlEJsVg5vpgi+hukoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839776; c=relaxed/simple;
	bh=xF23A56s+3D6NRTLDK2xRJOhzghX3Tn1Neio0fVKNxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7+JVgF918vn0/C2ltPhLqU2rbDhVaajX7taou12GOboyM2SJvFdHC6rFeQIjjW/EMgsyIeNPnFpp0wgW2CeVqS4Qv5jEptZU9njeO4hSQMd8ow03hjemAssPNLe2DCRZ5LSEyhRmY5eZqBMeXsovMdzP1pBoi9oWc1Se+B0Vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7TPsm+H; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7TPsm+H"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d715f4a587so58033375ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 20:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788839765; x=1789444565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wHuXN+TozonanTrHY2nOVJpLzPnOvGV5cbx8xr3LhCY=;
        b=H7TPsm+HG7j4HxWtWxy9NQVwAeL0Y6QQWRSEMQcdidjYaks/6yy6wbb273/7xH+OUo
         L36Rg8DcCQVkew4nkFDibK9OzZg+2FvkI/4yGpf6N5R/6sy+fok0LOuRNCZLTDLff2Q6
         bkuf9KtZHDAeoRu9Xjz8FUUQcaxalkIL7OUQ5OKTkbMh1qKWNty7tYvv6b3vyzsiAng1
         bZDiwqOf+ceQDXtWT0OaciW9NoXnf/DW86tnTOzVrk2o4T3V3GCCjNFjs54+Svkss6Ec
         8q1zcZk9QXsKifcSqZ7/iVG3gD1sMkdD8cJWS3LhltKzTUpOlB/TNo3OvNqZLn8U9rpV
         ofrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788839765; x=1789444565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wHuXN+TozonanTrHY2nOVJpLzPnOvGV5cbx8xr3LhCY=;
        b=bvvUFCdPsuiJNc8hWZ1mQMDPU3xDxF5NetgYfAkR+8KjwT5gd8Z+w+6lko1N+esnuH
         CpkRWIn9ncJtaTXp1mr4Wh4BLwY3kmCFlOVWNQyiBK7VVX0+/rqrK6bDvpu/Z3xxQStZ
         5WLCVcJ4QoaNYFERwp8LaoqLPqrRNn6ikuvtkOt0bJeUmEph9hbXNrMa66rx+qISupi5
         +M68a8PW/KIMZvGi2x1Wyr4PzaptCpXnkdUcmYQF/vMEVccDeSID0+g0ivBdThbJtxMn
         CYNESmHdVFGjXfL5OyLok7rGP17f6gPxpfeE5hxHE1qA5jPk7vOyNmhZDVfDxTtm32ZD
         Asow==
X-Forwarded-Encrypted: i=1; AKwUvBwU5ngOl4r/jOgGcudxqqepoc7tFLm8mks3vCz24dbdZDJkjZW8oBa+8l45lmq4B+zbTCIUuvetMpfHrHHY@vger.kernel.org
X-Gm-Message-State: AFuF++k0rQ+iMEVPLvJP0UKYULLXoG9aYuYqnaDXuovqJP0kvyzGIYgG
	HjhigJwps4rf2D7/MANjqBHMnjZAb4EUcrdayVblhyvmuvKJpI5qpa3Q
X-Gm-Gg: AYBFou2nuV7vEIx+dEIiK4OKAYFJ3I5pcyQo2YFrJE4cogn+aj2A28mY1iOyZcy9qxZ
	i07ELTbF7FXIOWfwja6haOLvih5Bc5PHFdo066y9EApfCuUlt+5Ee+WjVs1US8wNZF3CxaIBrvT
	Ce5Rxc0q8W3xpCebBpb6OzR2l85wDKLR8t2kmZgwPdQD98L9ybCMFF8ZfZZlm78lHKFZYH1t8hK
	zZ4prB2XQLbwfpm/3aPYn7QZKgurcTacw1aRhwTiff4YWaskGjOFVC9qn1tjdF/FcxB5kmVaioX
	2jZycyP92b6k+VNPS+w/YhQdCbuE+RTiqNzeTgR5rNJW6LwL6xMBB90NFaxkQ1ayACfGD8AfQwr
	d59E50fXl2jkIpiWiJtJo3ncOHC6j+PWIThPES/7KEeE0mYvqhON2NNuyzfrLpKMaIMNphwMHtH
	sflst5k/l/jj4KIqivAYSKaHqsbsQ3J0LWM/dr4ctltLD8GiP5wNve7mVpsYC9LdPGUpvCXTg0B
	oAmwURSM2j9Wl/nLkE+E/eo
X-Received: by 2002:a17:902:f70f:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2db1225b297mr394667095ad.0.1788839765501;
        Mon, 07 Sep 2026 20:56:05 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14aeaf74sm51899295ad.81.2026.09.07.20.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 20:56:05 -0700 (PDT)
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
	qwjhust@gmail.com,
	syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Subject: [PATCH v5 2/2] f2fs: enable buffered RWF_DONTCACHE
Date: Tue,  8 Sep 2026 11:55:43 +0800
Message-ID: <1cd46ad6e0e566c283dd70be7864248f504b1997.1788795700.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788795700.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <cover.1788795700.git.qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass FGP_DONTCACHE to f2fs_filemap_get_folio() for
IOCB_DONTCACHE writes and advertise FOP_DONTCACHE.

The address-space write_begin callback is also used by internal
callers that pass a NULL kiocb, including page_symlink(). Check iocb before
inspecting its flags.

Keep the F2FS-specific lookup because write_begin_get_folio() adds
FGP_STABLE, which can deadlock here.

Reported-by: syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Closes: https://ci.syzbot.org/series/cbb9ded8-1388-4a7b-bfa7-44082b04025b
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v4:

- handle internal write_begin callers that pass a NULL kiocb;
- add syzbot report attribution.

 fs/f2fs/data.c | 9 ++++++---
 fs/f2fs/file.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fc48a752fe9..c9b29882f07 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3883,11 +3883,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
+	fgf_t fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
+		fgp_flags |= FGP_DONTCACHE;
+
 	trace_f2fs_write_begin(inode, pos, len);
 
 	if (!f2fs_is_checkpoint_ready(sbi)) {
@@ -3933,9 +3937,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
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
index c763fb972e8..92f916ca8b9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5920,6 +5920,6 @@ const struct file_operations f2fs_file_operations = {
 	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 	.setlease	= generic_setlease,
 };
-- 
2.43.0
