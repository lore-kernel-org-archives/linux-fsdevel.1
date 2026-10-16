Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C8DF72
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151937; cv=none; b=Xblf6xrjtVgci2o7MJr3sER0A38mH0YtWp9SaGIGua6wN6HxpNUmrjrGchR9X5qmzRR0ZwrHJUtmjIQB922WSbBLSeecic7OwxRPwmF8SjrvlH1eEOPc8LXTiwWH238x8etugSu0UbKcsCNNaxqjB3piMF6iIBR2RphAPm5XpFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151937; c=relaxed/simple;
	bh=XWJhrf9bPy7m8cTmjHd5g/ZCR9ncCcb2WG8cntVMrec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUlfEvovyZUwQmzt4gpuJ1WP5+502VzhmrscrJUe5IfhGn5EMh7PAUvypzkxNwtUqTKCUau8gxT+t8cID8uenxwqH1fvAtHwtNeGFYfjPu+QwZKVDw9ZD/usvkDA1v/dwrHT51KIS47h4ps0+wFt23BfhuZpjLckpA/KcrdZf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQR5Oq3I; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQR5Oq3I"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so2103025a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 04:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792151936; x=1792756736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LxdDa/5ciMRdv/9eQf773tGBdimu+xTTwUw9N85FYNg=;
        b=eQR5Oq3IKe36xyZUQSIaGUGIzHWJeVvUouccQhE8vVX2Va99zYuojLNNa9qoBDaGzC
         tWvJP+GnK8MZQHPSuxkhkx3F2Q7aIa3z4INm52ENnemu6B0j+w+3gfcDe4gh42D3B0xM
         YulcUWDfFdHXMJuLReGgUV2vgIn1dZUhom2oxqD9lx9z2FxRsjs1uwsWjJGRWgcZ4WfQ
         IBE+OGPc9jG7+J10hf58a5B++JW1rXffjDpEc8JobJn7dVp8LA3HNSPND6kjAoOxGptM
         XNFzFq52eHLpuuFnTfk4ySZO/n+Gr61pVK2Aie3hg5RIOZtNyJ1wQKRDO8DAuC/S3TN2
         11+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151936; x=1792756736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LxdDa/5ciMRdv/9eQf773tGBdimu+xTTwUw9N85FYNg=;
        b=FthFsf4GGKnDTSx83fQ+WFl7WY8MuXFKHac78UDIvjGL7GJOEjZxkPVbNec4xw7XKe
         VjxbvoYwpn62GhYSW9P18TPXyTQRdHl3nD6bcXOjqr0O36qtruR0SnD4SvtFNk+EjHyQ
         xSFytuz7z8eTO9x+nQRf3bx+6KF48MVPXOFqxjbWxyVvUQ7kWMlf83lBTVkUrvzjEzV+
         WO88gou5LvSHYD7kMy+Ld5Dzxex2kqUMKuI2x9L6wk+1dimLhbd/MRs7Sg+wp+ZHwfBl
         oOb7OuO3a52gWNjt3i828M8MSg1T/eQn8MzJQaT41Fb5FV90BmD4qON9CSO/TzCQ8F73
         gdAg==
X-Gm-Message-State: AFq9FYIFQvdZmrYHNBx0Z4DFvUDvUf9YmvY8HtRJ7a2nBh7Sec1Gjo/K
	mTIh9pWxqV7Lh810rsYItuZwmuDimdAINgDH2tyaZ28hsfCqFa3EVofB
X-Gm-Gg: AYBFou2Lb5GOem559iPnGC46CwbzmBPncG9jFusifwz4cRckqURuLpljV8vzAqEw31W
	VW8CRABrQs/uZPlXXGi469IMunaln8e/aLSSkQTkWA+ysTYTiTa+BMVBvHSvolemnXcNfjbiTok
	a8Rzft/0t78Khez41WKQhfk25D0t/A2vXsP0QcDnV6AGz+FGe80vrbfqqGBpqiQQ6tS5otyzsZ+
	skue0AWBhibfNsEaGhirTBxS8+0N3u1RAWMxdMgNOm3bwhQVCGUsze45yo8YIrihS5si8fu/sHP
	c++eOS7BkocFGQBL51EXMZ5w6l3KF4KfYWiag8dRXeimobYe/nSpW8T9Al+Cl5dBAK1ZnXjn/6w
	OkQQEkWNE1lqiceH7QRyuWg5lkPI2GBWUExZ0fddnrgugQhurFV+HwF3AO+7riOLz7ccoQZMLvp
	29I1EI/YV4A/nDtFeB/NRzDVztcszH9o95Nd3GkQQPZ2Or3/GW4Z1T6PgBWeoWh++HPIaMAqcny
	g==
X-Received: by 2002:a17:90b:58ec:b0:3ac:17c:6e8a with SMTP id 98e67ed59e1d1-3ac017c707cmr13397731a91.51.1792151935956;
        Fri, 16 Oct 2026 04:58:55 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:16dc::247:b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd9c4b4eesm1809055a91.2.2026.10.16.04.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:58:55 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8420e667af06b1709c00@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH] minix: reject rmdir of a directory with a corrupted link count
Date: Fri, 16 Oct 2026 18:58:51 +0700
Message-ID: <20261016115851.14276-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

minix_rmdir() calls minix_unlink(), which drops the victim's link
count once, and then drops it a second time for the "." entry. An
image where an empty directory has i_nlink < 2 makes the second drop
hit drop_nlink() with i_nlink == 0:

  WARNING: fs/inode.c:408 at drop_nlink
   minix_rmdir+0xe9/0x150
   vfs_rmdir
   filename_rmdir
   __do_sys_unlinkat

The parent's link count is already validated; do the same for the
directory being removed and fail with -EFSCORRUPTED.

Reported-by: syzbot+8420e667af06b1709c00@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8420e667af06b1709c00
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 fs/minix/namei.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 5525ba367ed7..344cc70ba878 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -172,6 +172,10 @@ static int minix_rmdir(struct inode * dir, struct dentry *dentry)
 		minix_error_inode(dir, "inode has corrupted nlink");
 		goto out;
 	}
+	if (inode->i_nlink < 2) {
+		minix_error_inode(inode, "inode has corrupted nlink");
+		goto out;
+	}
 
 	err = -ENOTEMPTY;
 	if (!minix_empty_dir(inode))
-- 
2.43.0

