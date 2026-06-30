Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221C40F8D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816887; cv=none; b=G3+6yDU1PtlXKiV7leKm38iqXQocHXyFbBGQhyT1v6R1fKeUD8jmOXVbxMN8o6+ww5BpSFo3p47ND/tKtHZGqdSY8/M/tedO0zZokQDwrO9GNRtX3opIln999ET8+VG0SC6ub1lrP0W/ny8GSZ3JFFhdUduXOwyukZ6RiBCX5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816887; c=relaxed/simple;
	bh=fE+pPOxBZcyBdUfottto06oZT0eQ2tzk3Ztv3DyIqvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuANNWjM8Nv/DoGopvu6I4J6ZtfTkG0sEIwcbbfgxrdjqkVznFMFkNuH14UuYDXgFw2PXWAuMPuNYs1FLucRXLdDcwhnDkWdCk7S0gSGF+N5aCOjIAr+WIzsYkGBKw6eAUhKIC62kDfLE+bVC1YKO+wPfYAqGele+vDYxtzTRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=RfOfM3UM; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="RfOfM3UM"
X-KPN-MessageId: 1ad666c1-7472-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1ad666c1-7472-11f1-861c-005056aba152;
	Tue, 30 Jun 2026 12:54:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=fWirIIq+kawwQSB88aFYqXg/aA7fTkeu7o9CkqytfUI=;
	b=RfOfM3UMZM1FdCr/0XLtt1pJXxYrRBZO359HXZ4Tth7GTRUd/HfKZBvpghENPdrhSrgENoPsYesZD
	 y5Rp8ExLZE/d1UrUUu3pZLHwqVXlR1uLLztwVMQBEBkspe7x4KnRpk70+Gkgu2Hh+awba1u1jOApmy
	 6UuBOZlngQxbxu0nGJKmTdiOFpJKLpTA49/3TVWPpxWZv4LKCrCxhYVtop4jDFVjuBQncNWnxSyZ18
	 MQPApMUmWk+520Z2WXcdc88Pli2NVQPkF9qEgS0Ks72W6UIToN+aK+LKyM091nBj5EihKaq3Bdrc0E
	 27AESDaxDLa/h2udHDL7kXuy4IC7xdg==
X-KPN-MID: 33|Zk6lh1kAMUOdAw8OuSFgO5gQ5Db9NvwFfsgZAGl5Fb4+48LJbU36oJHNC7n+E0v
 iR5kPtnh1zHDKv3HtzRMAZ8MHb3XeDw1JFKqCOf31n80=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|G5yG3VnmH7xhuxBvptca3t8gB9c3MttxHVEWcznc0GZpvSLC2EPp+ASMd4SsVqR
 lOktpwhWZ2Trlv8x97SIaDg==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1ab7d8d1-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:45 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 25/31] ramfs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:54 +0200
Message-ID: <20260630105400.68459-26-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in ramfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/ramfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 3987639ed132..e884ebc58a33 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -121,7 +121,7 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 static struct dentry *ramfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				 struct dentry *dentry, umode_t mode)
 {
-	int retval = ramfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
+	int retval = ramfs_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
 	if (!retval)
 		inc_nlink(dir);
 	return ERR_PTR(retval);
-- 
2.54.0

