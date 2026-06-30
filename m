Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037D407572
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816874; cv=none; b=RwdmlVj+fqoSK3cSzff6KgkzBxuHq1BILpnj3tews4fnW/HfaqFuMAhgxsIu1VcXdyFdlis2dMZ1YeL/aO12ZAIi9QJ5k8q/NuAlZU75FC2QrGf+vOJQkTk+iDr5kaswyKi8bUVjmmv9wNIJJjdT+bW7YiXXe3L6Vn4dJ/XRs/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816874; c=relaxed/simple;
	bh=kNuI5l/vzJpA9IfxuuNRzMwkPxxZBWeOH1Q2FTSjdvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgvc0QXx7S2qoQrqtuzPaGO4TiS1kkicb+8NKCYiuiWC4TKS29ATHSUqcv8RMd+KJYXQibyLxD+INVN8fY7C2qY9b9sQT0g0SBo/c6vn4hvOvx9ShWadW+RSoWKFsfIf6IKEUmAsoQsGpBWMQw8WcBO0zwuIuHlRV+2ptyr0gO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=u06vg6xs; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="u06vg6xs"
X-KPN-MessageId: 12b896dd-7472-11f1-83b0-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 12b896dd-7472-11f1-83b0-005056ab378f;
	Tue, 30 Jun 2026 12:54:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=StufZU52b9KVMNueQNU407+hUKmDAu9Ffui/5k9MUDQ=;
	b=u06vg6xsPTaGtR8ZSfirWxPoTuUwwMdcxZyecEEXg+j8Mbs5gcMO8IrywJfbkdZDfTakgWcnTXcmE
	 VdrpmJ7t2ZKmEQzIjwmEEaD3IigC4bWf69/HAsFisKa40Te01LmYxvHQaA3dd9ICZ0FlKRHSKLNYGz
	 sVYVZa0xmt4xhRTG5pguNIocSsh+YlRrZMi3FKWyXxfdUVrhj3sZCTMKzQhiQzxK6qJiDAiCDSf+Oc
	 6cCOFEWDqIxLR8fqBuv8AwS9LR4T6abj2XVzLI+JQG8JYTs7t2Fri0Zi+RffsNOESG+NZSHrQXB1+s
	 V8GHig3E9XN8ajliO1fJH7FSqYmqzjQ==
X-KPN-MID: 33|YPzG0lb2/u45dCe8C3gVLkh03oG1vhgUg8M6hF0pSNODMZxfPmj7Sn/wymQbVsq
 rg3Hic7vRtewkMPrA1dMkJkLEjpO4FwsDNSZ6JmcZHMU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|laLQsdkeV3eS0Je7SSrRi5qYDAR1NcYDpPsxZh+Hlry/AQ1Z5UjrdBRx1V5gZ2V
 6iHJ2/HmxcvDSzayZ2FRueQ==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1293c4f5-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:31 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 12/31] hfs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:41 +0200
Message-ID: <20260630105400.68459-13-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630105400.68459-1-jkoolstra@xs4all.nl>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
->mkdir(), so OR-ing S_IFDIR into the mode again in hfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/hfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index e13450bb933e..a7bb9009c5ee 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -219,7 +219,7 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *inode;
 	int res;
 
-	inode = hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
+	inode = hfs_new_inode(dir, &dentry->d_name, mode);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-- 
2.54.0

