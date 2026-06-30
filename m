Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D66403AE8
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816940; cv=none; b=T5HUP5OsE43wLLQtnMVgUeWGGPmWM8LLrhe/SwOkbvIXkQmFmo+LL0PqfnNfHgtGd9bRzuKG4St9YY/WzP5mCcTRTncwWev1cCK6A9eSJfVYTbgP7v/DfPW+WmbR+QsUsfUCpSIwzP8O5hQYWfM7hcIVnN4WR0vdlOgECEUAfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816940; c=relaxed/simple;
	bh=YiEDxOqWPuvXDZH2473qenOl/et2/5JO7ObLVud0AA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TU2XxetbNAPImqaFqZRzok569VySc/np5jMia6OdF7B0jiftGmzKP7UPzj6X6m740h32PyBGF5Vm/aDHSdxrYqaPccodKwzaj5RHcrz+stP5uYEI9BmbhXIJQ9CO6fnQ1lZopgSuElY7BrLtwXS1W4DZqyClb3IOpRjn1spKvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=I8bDMWOU; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="I8bDMWOU"
X-KPN-MessageId: 0f76cf38-7472-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0f76cf38-7472-11f1-b2a8-005056abbe64;
	Tue, 30 Jun 2026 12:54:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=vDMa4pXtij53ElPL0RMeXy9CPhBiphegQ36OEtP67sc=;
	b=I8bDMWOUP12vCJQsuaZA7eOmi7s5sqprN8L2W2Y0C9acCWXzx3rIFrcm2mQ3hzYxdrFmyvyt8gFxY
	 OWUK9FEpi4IYcuT1UF2bZtmkmsilWAh8VR6v1q8Hk8UTzn3GZHdjpHm+RvE9U8Yj44HrSvmTMNFoRB
	 O8J2rjczehzI6Y/KL5E4R62EH46Y6u8ZL5+U3+9IaQyk/lXOBc22IW4lBSOPMp/JcRCFRMn71vL+kO
	 L85E9TUkO2AqxPW1d3RYHnbTYdKFQNFktUO6pFwjvpgUOep73dQQ3jFfpSbOlt5BXrAIMjeBzQsd2U
	 fm88hBIEiS8dD1CrUGsAwVGnoxMnlxA==
X-KPN-MID: 33|q2ocEZNBPVQZyw8bNQWAN9j04YczFSULalSWjO248I0cekN4tvCMSvYYZ2dZ9+h
 gzgt1VCBiKciJh4fL5BB70xk0u2uj/NX43Whz8XE/2wg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|LI1rNMWq2bN8pxqTSfg5uGKY5TKkwe3gC5xM/gU3jFD2I0oAaO2YIKVAQ0n/Dj9
 HWG3+QwyprJy0yLxKUQ4frw==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0f594e45-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:25 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 06/31] btrfs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:35 +0200
Message-ID: <20260630105400.68459-7-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in btrfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 272598f6ae77..c19f75cc3e7c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6936,7 +6936,7 @@ static struct dentry *btrfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	inode = new_inode(dir->i_sb);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	inode_init_owner(idmap, inode, dir, S_IFDIR | mode);
+	inode_init_owner(idmap, inode, dir, mode);
 	inode->i_op = &btrfs_dir_inode_operations;
 	inode->i_fop = &btrfs_dir_file_operations;
 	return ERR_PTR(btrfs_create_common(dir, dentry, inode));
-- 
2.54.0

