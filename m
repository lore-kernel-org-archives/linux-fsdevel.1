Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7A386425
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774804821; cv=none; b=gclm4yvS8tN2POAoV3LJLxprfP+TbWvG4mxHTGwycFcSUz9LAEGRWunC0pshHaCN2eg2p6asgqHvJrueH5k6vuTgA0CXgy84ZAcSFhihl/uf5E+od3Nw2F0ythA/mtVshsI0Hx0uT2bcHFH3P5LQ6iZqoeGurUHwwAs8Q9u1Vkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774804821; c=relaxed/simple;
	bh=hYUpnp+Ac15RiBQCN2Hkk4rhsctI+fBGp2S/cJmDxI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCr5Oo/rL7OVp0+F8+tmgf4OfyMRtffByrG4Nk/JxPwUtiE227YOKTI4O+PUAcHK1lN8Le9bHbd/j9IZ41P4VVChGurA4nxC8XEFeceNiDZUaOGZcstVVJUs+jCrwSz+GYBuX3O1GGu4Gj7wR9XMJrtWF4KxATUiFwCROc3fFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=raaOPlLd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raaOPlLd"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439d8df7620so2608156f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774804819; x=1775409619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeU9c3QhXSSwwCUTOdTttCtE5NyIfRbHvJK3GzoFu3E=;
        b=raaOPlLd7vgz+OjLQW6oZ0jdtNEMbgCwYLnrI7OfKCCphjK9CwMGbYz3Eq4ICqaIoK
         yDaQ7xpj1aF7NFaX+lURMG3wtu8rL0zLpyINXljp3uPfzeUSViA95Mz3xvNX8JKQ7wJJ
         WKttx3OE7rGuVXz6PD76uNqa8N0OOjHdepELVHsFuzb/p3W/qIvfecdPOqinOGSa4jyO
         D/O7ervLQBLdFtYZinKbw+11V2w0ROUGBqtzBRjVNf9R096VYAOWhQPfm8uatZBOssCu
         j5aUpOGgH+YAniM/cblICixkeiRx/9vboORBZNmMH7HEITFKdaDzi4xsy0sBHwoW1d47
         WUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774804819; x=1775409619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eeU9c3QhXSSwwCUTOdTttCtE5NyIfRbHvJK3GzoFu3E=;
        b=lx/WXNllXWwAVkBB5MxQyV91oNVTMn5ptbSwIp2zCrf37GhoqRBYVf86/yBTACTDPX
         +44oy9BOJ/0kGaGypGbJITa3cDUkjz6gRMprbxO0olE+y9DlPHPn1JC/bsinPyBuvqiI
         rLDxUIplTKJLndaPeDKkJCmo46Fpf8q8Tn9gGcKHS8MKdO3VBq9rjCrqEEryzUMWVJry
         P/lw9ka90PQU9qS5urG+jMtXxPEB7tCB9tigthMuRDK6F5EChK3mznyntScvqrIFQXlc
         WaaRwUJKW6WQRLAoXQo3vDB53rA+YYhu2P6uYiilVBv42JFqKXl30SjjSD9CKi15IQj1
         TCkg==
X-Forwarded-Encrypted: i=1; AJvYcCV355pbmUPJEoIcSuSogh1DmdDCU+F5qD1Lk4Y3zJW+3oUUHDxpXyM5IN39Vt9tX+W8+SLAhRxS1sNPvkug@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgzl2zsHeu8eNyTp7Tn1+5+/sxDPp7QrFQl79PbwNrDG1TwHnQ
	SncscI3WU0SCa1jyi96BdMfWSm1JJ0XvVF45uoCHpX8lYVxy36yTq402
X-Gm-Gg: ATEYQzxLx30psn+MvN5JL6MbQEy7o+5IMRcOGyLvEwNLggqyWCAiuSQq2WMwdffL/t4
	z46nrKTHMWV2yaS8Zp19tmLvvNqVk691iwSGteviLhQndaWrnS3FO4cY8GhTiHNfR6Zlxc4NrlP
	q/Efrb+1F0VFefOAHY/5y+Wt14PgUC2rJ8l1r5JtLWqUQ0B7yxglY1c6yKTVSEP5vJBt+7kFjb3
	M+ypdpUMRyu6MOGm0/SrKl+T6PllwVM3ZNuRC2SEXBaKUktCdEr7bVoy0X3xxIYMo452MqS4rFr
	9HfvWOnKfO6Rr2zg6Lp2SbezRs/zc45/maFgghiTIbpW9rvajqoK0YfGrPNPnShxZE5vTP9Jff9
	cWA5kyLefRCQorsJE68yEiuIdl//9VzsFrNkvql7M6J+PQP8XbYWc1SXuILB3wyUY/4Q9SV2xAg
	3K2MR5+B+MlaWdjM1xVHwSNt1VmPKk41T69vPTDDz+Xs6izqO5CIPUAHOSJDu1FTIaWoclXr+bM
	g==
X-Received: by 2002:a05:600c:6287:b0:485:469f:5320 with SMTP id 5b1f17b1804b1-48727ef6865mr171642215e9.30.1774804818460;
        Sun, 29 Mar 2026 10:20:18 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873cd7d039sm9776805e9.15.2026.03.29.10.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 10:20:17 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 4/7] fs: relocate and tidy up ihold()
Date: Sun, 29 Mar 2026 19:19:59 +0200
Message-ID: <20260329172002.3557801-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329172002.3557801-1-mjguzik@gmail.com>
References: <20260329172002.3557801-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The placement was illogical, move it next to igrab().

Take this opportunity to add docs and an assert on the refcount. While
its modification remains gated with a WARN_ON, the new assert will also
dump the inode state which might aid debugging.

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1f5a383ccf27..0050eca6d83f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -522,15 +522,6 @@ static void init_once(void *foo)
 	inode_init_once(inode);
 }
 
-/*
- * get additional reference to inode; caller must already hold one.
- */
-void ihold(struct inode *inode)
-{
-	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
-}
-EXPORT_SYMBOL(ihold);
-
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
 					    struct inode *inode, u32 bit)
 {
@@ -1578,6 +1569,17 @@ ino_t iunique(struct super_block *sb, ino_t max_reserved)
 }
 EXPORT_SYMBOL(iunique);
 
+/**
+ * ihold - get a reference on the inode provided you already have one
+ * @inode:	inode to operate on
+ */
+void ihold(struct inode *inode)
+{
+	VFS_BUG_ON_INODE(icount_read(inode) < 1, inode);
+	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
+}
+EXPORT_SYMBOL(ihold);
+
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-- 
2.48.1

