Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4A640DFDE
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816885; cv=none; b=kUUJjBvhjYSlHKqjt+a+wwqWnqhx7IQzMTWQH27d2BmMYPjYyDg6q+S/jyz+QHe9EYAXsuLdef90116NhyRQFnJzYOQrtjIk8v5oxG8I9vDieD/lCVWV5ewjDR9C6+AHk4/Q4T+d0WIvjVJLbkCvJ/Wqk8Erm6fiTvfUWZcFmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816885; c=relaxed/simple;
	bh=M7CZJTlmt7BsqeWX+ctxHE+2OmDDTXHDSdxTb9Th9wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UW9itb0bwkAXD7wUlTI0SeZh0IZq5R1Xk4zL+1iWyrp+it4s6NQ3a8PZljH7QHW43IW/UXUwSlnzTEfI64rKSh62fbD8QmyGHSd9zccC/pnLIg5Nyl7Bo1OawsCEy+8/kGo6P6F/tsnuLk/tUzuawyxIcL/kq152mKa6dx6uHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=qAehY/de; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="qAehY/de"
X-KPN-MessageId: 18f3c8da-7472-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 18f3c8da-7472-11f1-861c-005056aba152;
	Tue, 30 Jun 2026 12:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=19BYtVRSR0vlWIVrElhGH+ffJzuAauYtQZavDi5uK80=;
	b=qAehY/degT9J5+hsyBDlmxEQwYTbxCiZWeyKWppX3Ik4GB40sptkQM+mjRya9JPNa2thciZTIjl0i
	 VBKpDaE0RCzMXseNOulNAX6PD9QTIZ+4iQe1bkTYHc1jOyGAd2vuGldvf737AGXzAE4AXLTedBBDN3
	 a0gqvU6luMSCChvUj9ql1G5ft9Rw40WEJ/nWXXayRmBHIn+ZBIbAy4FVCqxXPZsglVEbEHs6bRjJU1
	 v5YSGVxUvml+eQEMmJm70+zcvannZQjareZIiaQXkOxXmG17MFYy5rs8airEUh1GQbZVcJ1q8u8oYs
	 1qRPfvDT40DEYqHSm5Xqppl87Ehq1Vw==
X-KPN-MID: 33|xQGwY7jtNyTqalbxAOxNVyiz4aBoQqulqfd8iP/kXY78p4qPxOTppp+dPRZ1Dc1
 6abrppyR37Ib7s9Rr5sRFgZ99Rip9gTauvY6u69J5wH8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|I49FbqWHZ5zgRrsEsR1LyCfgrSE2pYuMBDcI4pg0xbeu0gRKOWeaKNeaXKATRy5
 +NGSpfqcNBfXDmPtXLY9XMw==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 18ca0ee6-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:41 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 22/31] ocfs2: dlmfs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:51 +0200
Message-ID: <20260630105400.68459-23-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in dlmfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/ocfs2/dlmfs/dlmfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 5821e33df78f..dc538fd8d9f8 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -422,7 +422,7 @@ static struct dentry *dlmfs_mkdir(struct mnt_idmap * idmap,
 		goto bail;
 	}
 
-	inode = dlmfs_get_inode(dir, dentry, mode | S_IFDIR);
+	inode = dlmfs_get_inode(dir, dentry, mode);
 	if (!inode) {
 		status = -ENOMEM;
 		mlog_errno(status);
-- 
2.54.0

