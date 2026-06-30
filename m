Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2014416D18
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816892; cv=none; b=Wo27h4JMRtKQ/YfXoiVuA61zwsjHe+yyQmmx3+DR5sRFmnEIdRDfDCm04iOM7EU45uoO+zDQ0DUi3SgI8O2CLVi1osqgdmg5TA6rhMnxHOnt/zsrr0vkWhxivx4kiuSm/LyT0pXGrOuNg0pDht0kgiEvOrlcGntYC4V0V2GnPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816892; c=relaxed/simple;
	bh=dqONuo7vs2IyAuYkDDVaxSbF+tCcBYjoSgv979qXQ4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxA7+o+yrM4Cnj06G5UapNF9P5FHG02xqwkQDJgmVgft0FD0+QdqeMmvrxQE6UDlTzbwEJMR4++RSJTo226ycjtLfnBtUDqjPijf6LtdrNbq++Jrreb0nVxwcuZBVEysVH+c4idvHE9187AwD5i4bWnmyN5xrV1KdDE5kdPasnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=MQWlI24d; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="MQWlI24d"
X-KPN-MessageId: 1dce5cbc-7472-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1dce5cbc-7472-11f1-b2a8-005056abbe64;
	Tue, 30 Jun 2026 12:54:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=JZPvg/FHE8XEODSgswk3dSJkMZ/Gwtju/fEgIISMmkc=;
	b=MQWlI24dyEdnqq0RPLwJfPHsPr2FVnevCNelIKkvADojF6W4olPILxqTJ+1cMrgH4IKgRVkq8/CwH
	 awaYXNwVCSSDSBvY4e/zpjG4ZgEXBzFT2Mpj8u75etr2kxFzldrEYMDj71GYJpQazrfXlkj1Xp4b3h
	 rzm2by9a9TPRaWi1MQNA4DohLqhgzJ2BFXw9aCFX+VJgE/OvztVFlZZBQ8pfw6T2YtP9n5lGkuVRF2
	 nvq1NCpLT5bkIFusNfSCJt6DU2vQPJFxDqvV+FCLTo0JdBCQvrb4QZKZK6eR1cexA2QegbAS4t/reQ
	 nh5MoRjK5VgRZQ72ym/DVGWmLVxrRTQ==
X-KPN-MID: 33|EWlNKS6+SQYW0cqo9DC7PrIWBP1mBK4qJNiphCIcodvM7tLVoJUw4pRSKv5WwXs
 6ew3F8N/+7KzTspWmSbwe169DhYkbTcDR1aYRSGKBEg8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|FYOKVvVHKHg0c3gznd4N0isG+zg3fzHC7l9Ql0VTFzEUCv9WxTJVw6iPIkrOXBu
 VoS1Ftn5N8wX1ibfqMQ0Mzw==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1d8d944b-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:49 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 31/31] ntfs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:54:00 +0200
Message-ID: <20260630105400.68459-32-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in ntfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/ntfs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index a19626a135bd..ef4c52b2b7b9 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -1082,7 +1082,7 @@ static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
 		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
-	ni = __ntfs_create(idmap, dir, uname, uname_len, S_IFDIR | mode, 0, NULL, 0);
+	ni = __ntfs_create(idmap, dir, uname, uname_len, mode, 0, NULL, 0);
 	kmem_cache_free(ntfs_name_cache, uname);
 	if (IS_ERR(ni)) {
 		err = PTR_ERR(ni);
-- 
2.54.0

