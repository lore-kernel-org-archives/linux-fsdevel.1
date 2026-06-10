Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F523F888F
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099683; cv=none; b=hky08ZmdQkyK7c0+YQJw7qTO+8aSs355vCkmitaovXzIhUbv0sB2V3r3foaz48L9oWMi/We5vwRovYJJplZEwkSlTJsZC5wWyz6vvN0wGQvPvZQOZujPPc+raFHKlkucQ8SzH8nGMB6Newa+fQxJpQHYetraZQ4N0Bc9BixV3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099683; c=relaxed/simple;
	bh=+OvxpUxb/yc2KRXdpihsQYmyjKxndoJZmAJSFt8DJKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CZ2nr4n044vgXXgurJNm67PZedAPmr9yAV+/X2Dmp7P/axvZqgurMLDSjrri3sMAFcGbauNPqMi5DYClQSFtvPDyuMIM0Zvw2gVxjmDtGJN4uGsMmhvwr2+NrX8UmyZYRVeXM0hWtLCKqCMblNQzBiJHCf447Qx6Iu1FZC4gcZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIC6YYG2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIC6YYG2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c3546924so45335025ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099682; x=1781704482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kUJSh7m2tD1ctWZqelvlULB2Kc9ck8NW3F7cgB3hxc=;
        b=CIC6YYG2y6VNdBRPaOHldmBv0PwXwvc+c4fNkerHn1BfAwMfAhzqdmfrx5Rf/ut567
         V08dds99Q+Bjg92E5s44nyweIoC5Dxi+Zv/pOcvqqo9ZCZYCz2hYALoWdYV0i8S6WSMa
         MTuqoD4WXW7vSlA232+p/+Xjbp8sxJHDhy0ErLkXAcwIQN0a+P9pyxNMrj9ZkkJ5t11X
         DW7eC9tnAvnBSacOpAmC6usPI4th6l7laEDEng253snAuWIkpgio38zkBIN9R8LM99cJ
         dSj2Lfch8tNdizwmMVRxJMORfppO4EIGMHck9KtAuFK/8aJ2dzyZ9tZHtDFppUB5yx6D
         4GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099682; x=1781704482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kUJSh7m2tD1ctWZqelvlULB2Kc9ck8NW3F7cgB3hxc=;
        b=JvBvw9wf/RQWtl6R0lfERU5ikJ9hPPE5yUiZ4vfjpdZN2fYKWRXTX39SaEYSo4r/g5
         oNgVVo47ZRjQXEjrLiJVoNHyCH14OxCGIqzPkuu5hlVN6PXnHoivW+iIq3B8OQ2LErvH
         vnSBs2A76Ngv+9iA+MvuUDlIDjTr2MM93YDo15AW4M6ljy2zX+9mN1QSABHlL6xMcN3V
         8gbyi9HIX8eFL7nHx0b6pXDKt7s/TYYeVo4y+QuFv2U8U2d+OwU2qyy9DJOO8O5f/Dc7
         OF48mKvrOoXObwPp0Fv5Pe/hhFU9kLjbTLILkEcc8XDR5d6YUzwflOkmJUUnAaPtHrDM
         Hl/g==
X-Forwarded-Encrypted: i=1; AFNElJ+ABuS6oNUcA/VRP6x3VkfFqZr0ndWpm5lfiS5ZDSWnueTX6kTAjEkoggY2yyH5WThYPN6/ydp2GChg4Ba6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlxl+WsxH+52kM0TYPTY+ppzN+abr+o4rICu/8M0GoO02nnmDq
	1c9H+QmqWSw0TLkRtbPnuXFD6GFdTijQc3d/INfsOl3i7gEtLbpGoa9IXSXyuSRtK1aWaA==
X-Gm-Gg: Acq92OE+azP6yXu3Wa5whrIvMB/9JRuttCLnZJAmo07FE8QbIp9LAwcaeTgh3NDWDa7
	BN8FTPK3J292QnQiOfiN6rO7XH32ChdHj2S+V5uMlVbX5tm1ZnQ3wir9kKH4oZd0EGKFAlWf56S
	wjREPiUNc5ldo/vhk+q3NFR7nXgEkRjxtexk/8ILRtUOuSkztZMNyM6XfNOsDzY8rVZQ3uDzlpF
	OGrpGi6jzG23ur/kFoP2z3tpH+Em9Egy+bP7yWl+QD+VBlx2mjfK9vS7p4v9QhAPuINYITgOk9y
	Cb7+RowH/ZsCed7qtN4pqw7EKY++tL+dTUsA5Q/nom3cKlJ82NriID3JC0YszRQcaAXqq2HwCBB
	LeUORvQ79s/aElyyBcvPOw46fkF7nMgeTFCe8WW2ieJ+ziCkLwZrobJRjcKiBDX5sXTpaGptl5f
	lZCvf1sXZAkafSStPlDFzMAmrlOeCToCsgqxtnIKkN+fBzqXk=
X-Received: by 2002:a17:903:2b04:b0:2c0:aef8:23eb with SMTP id d9443c01a7336-2c1e881ff85mr260240815ad.25.1781099682040;
        Wed, 10 Jun 2026 06:54:42 -0700 (PDT)
Received: from localhost.localdomain ([47.100.192.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa213asm261413945ad.35.2026.06.10.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:54:41 -0700 (PDT)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Wen <anmuxixixi@gmail.com>
Subject: [PATCH 1/2] exfat: reuse valid negative dentries for file creation
Date: Wed, 10 Jun 2026 21:54:23 +0800
Message-Id: <20260610135423.202730-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

exfat does not generate FAT-style 8.3 aliases, so LOOKUP_CREATE does not
need to unconditionally invalidate negative dentries.

Use the parent i_version check instead, avoiding a redundant directory
scan when an existence check is followed by file creation.  Keep
LOOKUP_RENAME_TARGET unchanged.

Signed-off-by: Yang Wen <anmuxixixi@gmail.com>
---
 fs/exfat/namei.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index b7d5e44ad38e..fe26fbf6a0f2 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -24,12 +24,9 @@ static inline void exfat_d_version_set(struct dentry *dentry,
 }
 
 /*
- * If new entry was created in the parent, it could create the 8.3 alias (the
- * shortname of logname).  So, the parent may have the negative-dentry which
- * matches the created 8.3 alias.
- *
- * If it happened, the negative dentry isn't actually negative anymore.  So,
- * drop it.
+ * exFAT has no FAT-style 8.3 alias entries. A negative dentry can therefore
+ * be reused for creation as long as the parent directory version did not
+ * change since the lookup that created it.
  */
 static int exfat_d_revalidate(struct inode *dir, const struct qstr *name,
 			      struct dentry *dentry, unsigned int flags)
@@ -54,7 +51,7 @@ static int exfat_d_revalidate(struct inode *dir, const struct qstr *name,
 	 * Drop the negative dentry, in order to make sure to use the case
 	 * sensitive name which is specified by user if this is for creation.
 	 */
-	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
+	if (flags & LOOKUP_RENAME_TARGET)
 		return 0;
 
 	return inode_eq_iversion(dir, exfat_d_version(dentry));
-- 
2.34.1

