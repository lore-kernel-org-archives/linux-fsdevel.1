Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E5E40759C
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816875; cv=none; b=T7hePlalHXpCx0O1O4Sce3t7+EzuL4mI0PMIYeBXpRt0SyVJ9sP42+JPnrFHOyczex0Ef/IGXo4jpFAHN1voNVsFeGQw5gB9Os8jcbfjiENc6CueJQqxgYRSWIwX8X/azk8hmlWN78be4XQX9tTa8pT/ajVoBF9Om6Q6wTEz0gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816875; c=relaxed/simple;
	bh=gKiNRPqoNoAB/QrHxC+pVC9KVxyH5PHn6LICoYfDNSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CD3z07dAxSJYkREHTYS+PlTfrX65Jn01GZH6elnpGsF6z1k1h1k0MY0AFpHJobfMOj1twP9BmrAnV7Lol0TfCRHUt+cbJ0nemllf3xR/lJnP4/o0h/9VwnNjRVozcnNoI97m06qyd+ghXfhEssyn4L2tMRT6aoyElvb9/CJfmks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=nx0WecD3; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="nx0WecD3"
X-KPN-MessageId: 13456a98-7472-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 13456a98-7472-11f1-b2a8-005056abbe64;
	Tue, 30 Jun 2026 12:54:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Pp0MrW770l8PcPLM2g0e7XJFFe/97o+11ohZtgBQQH8=;
	b=nx0WecD3ESOAXsXvrh1dKdNWeDGuV/u9DzmYMLuZRuasTdzrvmFJfPzFsqkozn8RhMgp1AvCwdtmP
	 aTGrFHGlayOUEpuUvXLUEmC0nkC/1slJvsr3d5T1z7c/4PLuo8DZxm3csc/0GDQCrXW4AIanDw1iIU
	 8CRc7Z31eFSfruvD5qpIdYH2fg32AOfVRTqloTV5IZ8wtpp0lp5j8jwdXTjFI7LJ2eS750JmIx0avK
	 4rzCGjeWs1CaDHtpLu/+JVLDCWs8BQq/p7fQwHKC7VZnyOJAXvj5oUv3FjDT5RA4f4KKO5UB9rfjzU
	 /AolnS6p3jWyl/Mzw9LgZiOOdi4k9TQ==
X-KPN-MID: 33|NLSdSLJykOmJQKVr0fDZHNGS/993WoZrAUQNYIpQ2QGGicHFoMRHcVY94GGQjda
 dYy3Ol39l6/f0ZaHyfEDe7nTaEeH2MsLckrUU9/THs5E=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|u8m/I4+Xh/yLVvQif2oDlSCyGzsMRqLet1UevC4a0xaDZje9P7U5/F1SWNBAAn3
 gBD9Yx53ZSJLaAfmHXdYPmg==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 132849cc-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:32 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 13/31] hfsplus: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:42 +0200
Message-ID: <20260630105400.68459-14-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in hfsplus_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/hfsplus/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 8bf6c7cdd9a8..ec74de68b35f 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -570,7 +570,7 @@ static int hfsplus_create(struct mnt_idmap *idmap, struct inode *dir,
 static struct dentry *hfsplus_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				    struct dentry *dentry, umode_t mode)
 {
-	return ERR_PTR(hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0));
+	return ERR_PTR(hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode, 0));
 }
 
 static int hfsplus_rename(struct mnt_idmap *idmap,
-- 
2.54.0

