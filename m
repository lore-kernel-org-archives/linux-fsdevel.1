Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C798406269
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472907; cv=none; b=A7EfNvsbyz89lPa/Xg81MDj4BKZ4rnj+LzgubEPWDOPMaoRApCIh+VF1031OlpqMbiuZ09B3hEdXlJiZVMlbZDxeXeSm16cD47ljgnOPIB5fcmwpCgLfPFiTVAbCxCgLxOeyag9AKqAApfvV1TaeNsow89UoaQj0jUUdogrC9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472907; c=relaxed/simple;
	bh=dHPfon/rAdRMDh3WmHbwvzEs13jv8NZtEwWYk6nnMU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6gkcEl7RBfvoaeFQ4KsKj2cKd1JHcUr/49uz9Srj2JlLMwe3NTjAhy6mE5lpVCz/qBy1IMnxmUHBU4pCVfOsg/wXUFKi53mNc8GIxU5QKXkaazDQ3PUM8XlQ7LNuorl+M3OPYB7UAkVY7NyHxg6cNUIe7ESb3tZQB5wCbnT6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=U5kbwe+P; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="U5kbwe+P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aEHP6cO8n7KOX/5hc01ief8EAJdJwHXoQG+zI6EDnI8=; b=U5kbwe+PgDSH1626//BDvASBvS
	bej8ZJAPyvtNAOy1BmkfxplAhF73Yqp25iyhZc6c47aLw3mW+lCn2l9LngJ86w1CM7rCBvl8GxeWW
	mArQHwja293jPbrSMkqa/wQiIac4TangklpSQ5Ln1JplMBeKj6gCLadXubNLa6Ewt+Dju5Xm97H6R
	D7n6aiwjIkpLgMgrhsLIcLQMRDOd8yscPdV48pNvsh+HknXplhbAWtSFrT6mRGqJb5J/K/Dt2QMHM
	N168J1S8nTFcIvE9IQldj4FnA96SvOAGWEVvyxYlejpJwLoED8eepbEt0pF0d24P7/FymPECFoCqr
	5liIRUNA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKl-0000000CjED-3lbq;
	Wed, 03 Jun 2026 07:48:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 2/3] configfs_detach_item(): victim is never negative
Date: Wed,  3 Jun 2026 08:47:57 +0100
Message-ID: <20260603074815.3033766-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

it's been positive when created and had been pinned all along...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 515f41e7dba2..273e43adc8b7 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -773,9 +773,7 @@ static void configfs_detach_item(struct config_item *item)
 	parent = dget(dentry->d_parent);
 
 	configfs_remove_dirent(dentry);
-
-	if (d_really_is_positive(dentry))
-		simple_rmdir(d_inode(parent),dentry);
+	simple_rmdir(d_inode(parent), dentry);
 
 	dput(parent);
 	/**
-- 
2.47.3

