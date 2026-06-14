Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3A3CAA50
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455494; cv=none; b=oQbSKFpJY+peHpnxOhvfPs3awe61wH1biN4l7XxNcVEQvsvz8HCn/e5nrtoMijV5hS4sbHGh9ukez+8JHvBgt23bqbLz7OC95jbivpgfCALD6BNqRQPMLTd/8pnsChSVuCqWGUBQK3ZE8Y55vyfFN3jk1JhQngxL9d6UyHDRiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455494; c=relaxed/simple;
	bh=e1D+dM1TgTgsXapziBhKKVtDhxUAn2uuGCOGx3IcCwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g82NT/wByE5oZzQGY1tcDMcjfMR6Qs5AXPov92NuboB44NHaG62PbX+U9B1+ZKCHE34Ee0k1r0dElDroZXwL1c3/sHdWrjwEnWU8oN/M+erJeYL5uN/YxWSWJOeqhY3ak3HAgXsU5HoNKXld0nzHe4m5Ho80IYP/Eis0vbhvk+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=FQyS3Uqo; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="FQyS3Uqo"
X-KPN-MessageId: 356d35db-6810-11f1-8aa6-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 356d35db-6810-11f1-8aa6-005056ab378f;
	Sun, 14 Jun 2026 18:43:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=q6c62azGeJKDIFqnSfeYpCk0T/oQcT1szeyz3izSPJE=;
	b=FQyS3Uqo7E+nX06/8RBSGKQJWZaTGwLzQiAsg7BTuaegGeUxSwUP/xOBbv2iSq/RqWlaDBYUlAygb
	 35mb/2vncouQK88Ohgeu6pRCgKnEnG8jTzGBW8fD1MJDviWmUEVfsqnAsXvCHG4/ERu8MDKm//SZQE
	 GpfVIq7NPLlssjapt7HnfFllA9FV4XAm1q1j4MJFw0yccrVAn4WEr5GATqTYU779ZF4TegHNLg+86p
	 ylmCWRajNtzng67Pwva71wWcpf8EtPtwLKjDnPGfXkq4SOHj4TU83CQjvqP3I98pRXwopkESxp1tup
	 867PjSQ4t/dYQ5WMPvJ7D1X8BtEhP9A==
X-KPN-MID: 33|GeCoIQ6kqIHfiqduDMszCo9r8sO1cWPBz81etEb63+mm0B1LklguyfhX275hmih
 yHiQq/lBseqoKw8+uLPvHJ1fza644ST00cjHkdVP2wvE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|GSobYP5oSdo3uX1yT38rDfhSWiePe67NM6onkoVsMjTK10H1QyRBAMutSRWe600
 YvyUe9rJVYrorbSKIOPp32g==
Received: from daedalus.home (unknown [178.230.193.94])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 3539b9c9-6810-11f1-8011-005056ab7447;
	Sun, 14 Jun 2026 18:43:44 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 04/12] fs/namei.c: lookup_open(): move audit_inode_child() up
Date: Sun, 14 Jun 2026 18:44:30 +0200
Message-ID: <20260614164438.2980769-5-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the mknod(2) path of calling vfs_create() we call audit_inode_child()
before permission checks in may_create_dentry() (but after path-based
LSM check). Copy this behaviour to lookup_open() and move
audit_inode_child() to may_o_create().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6bf1ded26377..a4a8cdbb48e2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4345,6 +4345,8 @@ static int may_o_create(struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
+	audit_inode_child(dir->dentry->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
+
 	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
 		return -EOVERFLOW;
 
@@ -4532,7 +4534,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			goto out_dput;
 
 		file->f_mode |= FMODE_CREATED;
-		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 		if (!dir_inode->i_op->create) {
 			error = -EACCES;
 			goto out_dput;
-- 
2.54.0

