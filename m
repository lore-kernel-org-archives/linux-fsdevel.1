Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F9D30B53C
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Apr 2026 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775355103; cv=none; b=bainywv2klxrxprVHD684mQcwmTQuSLByyvRyu6qxBf1fsE7Yd3mqTU84M7JJ5kRUdCOM+rENcZ8Uvl/kw94ImRlTY4aKsJBWzfHevarsbMtts4o5r0dSoulVWv9n3Mv60fbx+KuFCWj+3CreAs3t4vA58fmcTOb8BNBXv1wIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775355103; c=relaxed/simple;
	bh=NEdNjJT2yPaKomWBTKycehho1fO5fNfxKNW+SAE2iQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4SrvxnH27ZqTKQtSTHhec0tGj3Q72xjOsZyiXdO5kwZP0s1lskpCF1/tQuc82KcnFZOqKWQa69SSf0G1GQX/CyCS4+ZhBQNEPa5oX/owbVfdA38bz0KIouVCn9ZsyeYPDUPMQX/KDiXJGvwZeLH1WysWTieVlkE4i2r7JDw3bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FIBbwVVr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FIBbwVVr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SiU6izdnw1nNqRtAAtKaKpEKRxxqbmA1JW5sx/vDeJg=; b=FIBbwVVrm3rO8WR0Eay/1rMDGS
	A2lRghl5yjCY/8cDC1nDzScchSs+uXSdaKx4gsn0k3cOdbXeVpA9gtG7+HibhD1p59/vuOixKpUls
	rkhKdEYQEzX9lBmBR5WPQKimrthfcMD614IuTgMPLtTCeLG+Z32KNcDZxZ+bO5+rEv0s6FXnn/oK7
	R9b8+ajYSV9wt+1dTVez9EH3StXQWw6SS8hGw+kqivW71ObvTUa2PBYduMHLng7cTwdc+pX0iwBcG
	5947p8dTIyYtVklN2T3fh4mCMUUTqIe6R8Vp/k/5rclsO/HOPUsYbOlBaw7KdIyRtW38yWoNE2elz
	kqbXPB1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9D1A-0000000C1gV-02Bi;
	Sun, 05 Apr 2026 02:15:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH 1/3] coda: is_bad_inode() is always false there
Date: Sun,  5 Apr 2026 03:15:13 +0100
Message-ID: <20260405021515.2866402-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405021515.2866402-1-viro@zeniv.linux.org.uk>
References: <20260405021515.2866402-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... since dbd822046445 ("[PATCH] Coda FS update") back in 2002

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/coda/dir.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index c64b8cd81568..799c3d3ea12c 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -449,8 +449,6 @@ static int coda_dentry_revalidate(struct inode *dir, const struct qstr *name,
 	inode = d_inode(de);
 	if (!inode || is_root_inode(inode))
 		goto out;
-	if (is_bad_inode(inode))
-		goto bad;
 
 	cii = ITOC(d_inode(de));
 	if (!(cii->c_flags & (C_PURGE | C_FLUSH)))
@@ -470,7 +468,6 @@ static int coda_dentry_revalidate(struct inode *dir, const struct qstr *name,
 	spin_lock(&cii->c_lock);
 	cii->c_flags &= ~(C_VATTR | C_PURGE | C_FLUSH);
 	spin_unlock(&cii->c_lock);
-bad:
 	return 0;
 out:
 	return 1;
@@ -489,7 +486,7 @@ static int coda_dentry_delete(const struct dentry * dentry)
 		return 0;
 
 	inode = d_inode(dentry);
-	if (!inode || is_bad_inode(inode))
+	if (!inode)
 		return 1;
 
 	cii = ITOC(inode);
-- 
2.47.3

