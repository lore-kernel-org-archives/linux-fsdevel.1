Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC143955F5;
	Sat,  1 Aug 2026 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785624996; cv=pass; b=V9xq/jJsvFWtpuGcSRxfmIc/Qrc8XMKCZuKK2Ppdxgg6RpiAg5Vj0beLilSMffiFFMlhKj77LzmJr5v05YFvbKNlL9GpPguoSNE8z90SbCQ29hHf6WUXR4Rj2S9J0GhodFciyPmGv4hL80n+9vglshhpYy8rILN5Tcsrl3efggI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785624996; c=relaxed/simple;
	bh=Q7dj7BQprXlnZbjS0SsRoqo1cWqGisRdNcocbERTD7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqzXNExJWDLUv/AENdZ1WhRQPaMTlBqhw/wNF49wAhl0GGLXl8JCoVhZ0gCLCc5SBBYfh72udpi2f7Y6Yy6Bwcjr5DSGnd+zqJeAc+DWYo0BSbxKTXB5nRf7fSX8glhZ7+lUqSItiCyMa7E6NVb1cDCNnS67mSMySVgx5e2D9SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=YPEbllBh; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="YPEbllBh"
ARC-Seal: i=1; a=rsa-sha256; t=1785624970; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=iTszdlM8eB8EaxMOs+QUd+Gh6tjj9ChUNHUeHNoQCzhopZyfKxDeX2GBtHMgtmv35gfX/2wYawzCDUw8uKyb7pGIPILFd8l2YXVe0uMl5Wj2dPA45JfeW8GCbWUs5py7Kh4LukTBXkNPeiB2Hp+OTN8esgppcID9m0o9EuYAFN4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785624970; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=viKdxApTKU/QG20WA2d1bHFxKpleUTdUSspfk9OhC+8=; 
	b=GvPkGn0SESeB8rOfTnwSLlZIDWmh/Hk6AghpPRN8GiV8wdgXRPLtselQ2jHzWXZclOl5Pz3nrGNWHdE2tVuWPwc2z8D6Bgg4DMs90DvSBqMwfQbJ054GhlwVF9i2NBrMrnY25qjxvgvIfYQ4Y6tlVdpNgpGLQrlU7KdlETa4v8o=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785624970;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=viKdxApTKU/QG20WA2d1bHFxKpleUTdUSspfk9OhC+8=;
	b=YPEbllBhDooOgnj/IdbcPiL0LQ9VzseD7CmybI/KkK3XS1Fv/6pz9DHoE4jyHc3s
	gje4xUXWFdEJLjZiy3p+6xdoUX0Q/BkpmZLrj8sAPJAE1CGCWge4wrwn/rzbYZTBFIt
	RYm7YDxo0pebx/ol9MszSlzUw37PHWESwPki2pGs=
Received: by mx.zoho.eu with SMTPS id 1785624968196832.0307099448886;
	Sun, 2 Aug 2026 00:56:08 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] ufs: do not inherit file flags from the parent directory
Date: Sat,  1 Aug 2026 22:55:24 +0000
Message-ID: <20260801225530.148386-5-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801225530.148386-1-ali@iusegentoo.com>
References: <20260801225530.148386-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ufs_new_inode() starts a new inode off with the parent directory's
on-disk flags:

	ufsi->i_flags = UFS_I(dir)->i_flags;

These are BSD chflags, and they have no inheritance semantics. FreeBSD's
ufs_makeinode() leaves di_flags at zero and only ever sets UF_OPAQUE, and
only for a whiteout. The line comes from the ext2 code fs/ufs/ialloc.c
was derived from, where the flags are Linux inode flags that do have an
inherited subset.

The result is that a file created on Linux inside a directory FreeBSD
marked with chflags schg or sappnd is written out carrying SF_IMMUTABLE
or SF_APPEND itself. Linux does not act on those bits, so nothing looks
wrong at the time, but back on FreeBSD the new file is immutable or
append-only and cannot be removed without lowering the securelevel.
Nothing asked for that.

Start new inodes with no flags set.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/ialloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index 4c3c76c4e7ff..dc3eeb415876 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -293,7 +293,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	inode->i_blocks = 0;
 	inode->i_generation = 0;
 	simple_inode_init_ts(inode);
-	ufsi->i_flags = UFS_I(dir)->i_flags;
+	ufsi->i_flags = 0;
 	ufsi->i_extsize = 0;
 	memset(ufsi->i_extb, 0, sizeof(ufsi->i_extb));
 	ufsi->i_lastfrag = 0;
-- 
2.55.0

