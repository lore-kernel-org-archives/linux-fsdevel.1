Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAED403B0E
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816871; cv=none; b=iC9H1RT+NMUWnOm6T/vRmLwG3zglpc/644iS5NVTxwvNznl+KCRxDxs2JBnrI8H5UvkAbXqym5cdtmB6HeL/1A6Wdt8qNoLVL2DjsQknNFXShOE2jBhfyH/8r1bc6aevAWqSLvQBIgMeDu/XLb4SCi7Vrdg7nSppauWQ275VZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816871; c=relaxed/simple;
	bh=EYcOhw2kvyrGFBBQamGgYhFFel5oqeBoQdFXVHg8KsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgXpe484NNiSXKa0EaLjHP+N9WjeYkynjE+vkJKkw6/wm2axHsJS0XYPLquuAKzTv+7hyH92LLfDp6Sug9XLMqn3oEEfs1Wz+kWyn2EXN5d+j8tK1CjBBIVHnDSyJ+bmBpm8wFzHkJSADNNdFhKnSuLtPhdv0XHRlJsgQCSzYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=btn0mJIT; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="btn0mJIT"
X-KPN-MessageId: 104a43a9-7472-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 104a43a9-7472-11f1-a055-005056abad63;
	Tue, 30 Jun 2026 12:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=TNvonxCE6qZpOcyoPpWi7WFJ4eAuTt9sEJT36mNvBu0=;
	b=btn0mJITQGgegoL9VBZj0G5d+UjFNT40A8yPzleW8MbMATwwvtMnlfgc/PHa45FmyTtELtQm2/3RM
	 CycTW9o01WEzORtxRxkAwby2zrf1Cu78lxJrwTfKuzCnaZxWdBjz8EJUGp58rfcpI0xO+jAz/39Srk
	 r1K7p33sojy2IzfeDVRKzTKIa5ALqM0K2Gy7PFtLQjEul/+ZTb0oIi2M4nBwvDsPVZrhkZZ1FTe2um
	 pWhzREHaGI+6ug1QPmTpcxfk/IMs5Rjor6+UNp7abwmaEKl4dcYWGZ936qSrbMd9gS1qJ4RH5B40uU
	 WLP+GekrAdREdTAxfMXoMMy70WpioJg==
X-KPN-MID: 33|Xsw0/XKGOXZIKyChf5FZ+Bnkhb1R2AK69VpGb6sEU6s1D3r1AQKN+ngNNq7YpCP
 a3mB4C1JKe+T6eD6e3dak8mMOHNSqsJYaOxUB5y7S0pM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3/g5IohxKO8BdyweUnsjwzzXP3JqQ3ZAQfIWWZAD61MlHBxEG1vRrU2iGiLpCSC
 s44Tq6EiV8Ey2VHmOtW62WA==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0fe1565d-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:27 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 07/31] ceph: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:36 +0200
Message-ID: <20260630105400.68459-8-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in ceph_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/ceph/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 27ce9e55e947..32a48550eacf 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1142,7 +1142,6 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 	}
 
-	mode |= S_IFDIR;
 	req->r_new_inode = ceph_new_inode(dir, dentry, &mode, &as_ctx);
 	if (IS_ERR(req->r_new_inode)) {
 		ret = ERR_CAST(req->r_new_inode);
-- 
2.54.0

