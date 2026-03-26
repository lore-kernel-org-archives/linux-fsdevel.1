Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC83F7899
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525878; cv=none; b=ffSGTFcOK4Kid9AOAw++i5gJT8yyHGL7vrmmF/ltBMaZi73F0LgfBvkVGFzxq1Nsb0WKnVdMK98idV6YFi+vgvtzpo4kHpyP31AW6HTyzjemKLUs8GfsFGON7+gh0wsDbllnFyrtuLv3NqPSm86KDfxlEM3QxHFFOJ3jk+Dx6eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525878; c=relaxed/simple;
	bh=GBK04y2Lq7a4JOxnYV8EpoG1+rl6AoJrBGkzd33lDAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AXYsMykHuk8kusaC7ZQjOw16S7y4W/oW9yGSRLafJohw4UKpMmbxyAcbkOlDPAO/2LE9TIeOBnlnIYRVuu4hF6mc+JsBjlZBagC3z7BIc17LKqQy+a4YK/f5xq3R8CkYtCw8YAZVsJlwClu6dytNfIwPN23rPzSXrpam6PZKkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad21f437eeso5146395ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 04:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774525875; x=1775130675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mWJmWp2/OwGK/fsGs+gcW4OmwWnHDPLoCTyrEFLexWE=;
        b=SWOCsz9QQ8ClYali4Sb1IvdxE64DCqIv+fEMPojzd7edoo8zBDwbgOuP+IZLwU0k/s
         zslz4vnmPAa1kOulH69dU1MP43vFevxnSAhHpWkXmvu+aPt0eSXTd3727tv376fWW/Xs
         9xDqHEZ43ehD/iGhLbHMdkFjRSl2oydN1V/5F8EuIygkJ2BbNrqpkbCeJSB6JwY5Pmds
         85O3wdZ/Hd7JWlX7Wfo2FLWlPZIO1BRjQ/FbrOW8z/a36Qw7r5hkeo7ky2An/SX71CWs
         dOlTgxDeI/XtLjV/RFcWzf7F1DMFP4vRjcbOVBCxR91FXeNKPZvHPP0TmmUq/M5yG23m
         G7DQ==
X-Gm-Message-State: AOJu0YwENePefhM9y5yg/+FDs9DJpgQkX8Y+CbwUatCoIMB6uv5i/Ri7
	w384jo6CN3ON1ygPSw5nUzFseTljBwVrsucGj+IIJtpS9u7CaI1O3HpQ
X-Gm-Gg: ATEYQzzGf83LRNroua+KKsrPu804Ogg0Maede8TsA21qPy58jSe4kjeYC6CrZLyU8ns
	ikDCyW0tvNJj1VSnmaL58Jb4x+9x6omCMiuhQ1OruiysTt776OT7Ns+KlIAnuL35vV4ZiOM0j4B
	gVXrI7vO8Qtk5gyz869bXtBVcL1971bgTaN6/JVmcA0JYkfnBkfnJndRE1Ay0rxPIMAklTB6wlI
	sGfPRcJapB0cT+ZYZkdk9RNeXA07LUb9TfCK6FLRd5VQA0+jetTYXzc8bmcQLPWCbiwRwNwC8cS
	XvWuYnSgdsZgnmAMhIdHcmkBZUbzRpaoH70cmjBdYFQWrSWLHP1LPOCN8h+KwJdBLBlSgmR0hsg
	VJYT9YeuyCUjWVT9tLvCYDmX49UKRD1+w2p5NE/ZgTx+Nx+/ZGB6LJ6CmBlBTVcSRoioKh1Hb1U
	HP/u0GGBa55YP2IXQ6YXwdGMzA8Jfnw5cDLvVmkw==
X-Received: by 2002:a17:903:ac4:b0:2b0:b557:6fe5 with SMTP id d9443c01a7336-2b0c4a6416emr13143425ad.30.1774525874881;
        Thu, 26 Mar 2026 04:51:14 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm28425285ad.2.2026.03.26.04.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 04:51:14 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	hch@lst.de,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 2/5] exfat: add iomap direct I/O support
Date: Thu, 26 Mar 2026 20:50:42 +0900
Message-Id: <20260326115045.9525-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260326115045.9525-1-linkinjeon@kernel.org>
References: <20260326115045.9525-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iomap-based direct I/O support to the exfat filesystem. This replaces
the previous exfat_direct_IO() implementation that used
blockdev_direct_IO() with the modern iomap_dio_rw() interface.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/file.c  | 30 ++++++++++++++++++++++++++++--
 fs/exfat/inode.c | 45 +--------------------------------------------
 2 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 756846b774c4..2a9263b4433b 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -698,7 +698,13 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto unlock;
 	}
 
-	ret = __generic_file_write_iter(iocb, iter);
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		ret = iomap_dio_rw(iocb, iter, &exfat_write_iomap_ops,
+				&exfat_write_dio_ops, 0, NULL, 0);
+		if (ret == -ENOTBLK)
+			ret = 0;
+	} else
+		ret = __generic_file_write_iter(iocb, iter);
 	if (ret < 0)
 		goto unlock;
 
@@ -725,11 +731,31 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
 
 	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
-	return generic_file_read_iter(iocb, iter);
+	inode_lock_shared(inode);
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		size_t count = iov_iter_count(iter);
+
+		if ((iocb->ki_pos | count) & (inode->i_sb->s_blocksize - 1)) {
+			ret = -EINVAL;
+			goto inode_unlock;
+		}
+
+		file_accessed(iocb->ki_filp);
+		ret = iomap_dio_rw(iocb, iter, &exfat_read_iomap_ops, NULL, 0,
+				NULL, 0);
+	} else {
+		ret = generic_file_read_iter(iocb, iter);
+	}
+
+inode_unlock:
+	inode_unlock_shared(inode);
+
+	return ret;
 }
 
 static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index cc54cce65a31..2985b5d736f6 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -478,49 +478,6 @@ static int exfat_write_end(const struct kiocb *iocb,
 	return err;
 }
 
-static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
-	struct inode *inode = mapping->host;
-	struct exfat_inode_info *ei = EXFAT_I(inode);
-	loff_t pos = iocb->ki_pos;
-	loff_t size = pos + iov_iter_count(iter);
-	int rw = iov_iter_rw(iter);
-	ssize_t ret;
-
-	/*
-	 * Need to use the DIO_LOCKING for avoiding the race
-	 * condition of exfat_get_block() and ->truncate().
-	 */
-	ret = blockdev_direct_IO(iocb, inode, iter, exfat_get_block);
-	if (ret < 0) {
-		if (rw == WRITE && ret != -EIOCBQUEUED)
-			exfat_write_failed(mapping, size);
-
-		return ret;
-	}
-
-	size = pos + ret;
-
-	if (rw == WRITE) {
-		/*
-		 * If the block had been partially written before this write,
-		 * ->valid_size will not be updated in exfat_get_block(),
-		 * update it here.
-		 */
-		if (ei->valid_size < size) {
-			ei->valid_size = size;
-			mark_inode_dirty(inode);
-		}
-	} else if (pos < ei->valid_size && ei->valid_size < size) {
-		/* zero the unwritten part in the partially written block */
-		iov_iter_revert(iter, size - ei->valid_size);
-		iov_iter_zero(size - ei->valid_size, iter);
-	}
-
-	return ret;
-}
-
 static sector_t exfat_aop_bmap(struct address_space *mapping, sector_t block)
 {
 	sector_t blocknr;
@@ -552,7 +509,7 @@ static const struct address_space_operations exfat_aops = {
 	.writepages	= exfat_writepages,
 	.write_begin	= exfat_write_begin,
 	.write_end	= exfat_write_end,
-	.direct_IO	= exfat_direct_IO,
+	.direct_IO	= noop_direct_IO,
 	.bmap		= exfat_aop_bmap,
 	.migrate_folio	= buffer_migrate_folio,
 };
-- 
2.25.1

