Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C893FBB6F
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816935; cv=none; b=eNpVwXtQOWw08hvBi1yVTpbZnuIJP4wdYJC2D3Nk8Qx0DW5wyYn6FQ8qoUhaDbe0yQ+GeYqWx8Ku9BS6ypyVORgcpOuyQZZWYFGrDiJ6MIp8nVIo4scQbPONiY+2BPQAowubXr0ID/pC7nUD8C50Otasl9ml+NDFwnFMsoltycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816935; c=relaxed/simple;
	bh=hIxOC4lrSoj/pE2tWoAEeZGRzokKtWZHOCiKwvQ4s1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWIOMJRm3SapbKa4rr8Ln9YmLLBTSzJCvJlvnhRkF3BGlesUgUarIIaNbqxa6kLt5E1YVIpba+41tSFjI4dZprCXc9xVUaGll0Uvvt75PDVP/F1PotNgIsKOgJtQIY6LXBWg4ZlPLj0xwYZ5zM9JMQCbk6NhPnDBT2MxcGaPqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=eX1uS7cF; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="eX1uS7cF"
X-KPN-MessageId: 0ccb19de-7472-11f1-83b0-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0ccb19de-7472-11f1-83b0-005056ab378f;
	Tue, 30 Jun 2026 12:54:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=kyFdNrH6bUE3ALQlw5kbWDgxUIZIgommMNEiRLb7g+8=;
	b=eX1uS7cFkqMw0uz8TGiwtk+ZESQXcWQbOvAjUKMrtqGAvreLJsoszg502zsN9fnqjIXXIR0NDZYkh
	 qihoBDW71aUiO+5VmJuBpBx28HUV5O47H8ZsOGu3xcoLLV7csPsJV0ojtOdn5AsnscT1AdxLOjzjaI
	 s8MY1VQ94ajkhKaB6E2N5mYGi6UICU14MdVxOKV+Zz1VCBElz2YD8jOqQsdxIx6o8gCj2BxvbPfJi/
	 KGWhpUvx2DoXSDgtMuOGdiDD4Z+IWMT3OPG+OyED/h6m7tqeQKOtVJ6K0hllFSA9tnmzzFR6/ozzp+
	 l6n1LuZ6kS5NSDYYz5m3kpuZskdDipA==
X-KPN-MID: 33|XMCGT/B2nNg+H3/R2j/k9czwykW26Ga9bx5zfHuwywCfx2W+kuN5UV3GLF/En18
 PpGDtitAVS++ktgy9LrUWTg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3H8NqpjdeHVibsMr9cVJTcOd6kQy7ydd43S+KerbE2lm+p/gn+jile3LyJVCKe2
 Oqep9kcMTe8DsR6e/dllvKQ==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0c8bda2b-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:21 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 02/31] 9p: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:31 +0200
Message-ID: <20260630105400.68459-3-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in v9fs_vfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/9p/vfs_inode.c      | 2 +-
 fs/9p/vfs_inode_dotl.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 5783d0336f96..8abc88a20f00 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -689,7 +689,7 @@ static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
 	v9ses = v9fs_inode2v9ses(dir);
-	perm = unixmode2p9mode(v9ses, mode | S_IFDIR);
+	perm = unixmode2p9mode(v9ses, mode);
 	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, P9_OREAD);
 	if (IS_ERR(fid))
 		return ERR_CAST(fid);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index f7396d20cb6c..92d065609a8d 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -362,7 +362,6 @@ static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
 	v9ses = v9fs_inode2v9ses(dir);
 
-	omode |= S_IFDIR;
 	if (dir->i_mode & S_ISGID)
 		omode |= S_ISGID;
 
-- 
2.54.0

