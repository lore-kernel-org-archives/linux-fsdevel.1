Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E940B6FB
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816882; cv=none; b=qC+d5/h2AnRLGWXBXTezUQy3hYnOB0KLWTjYTzWRkzkji6oLzpM6tT9haw50ekqAqOoSvnS/ECQXYujN3iLUfunnrx6n8YqVjfyn/ZNlDQx2BRD3ZDa3l2MazH61szYC86gOdohBoYw7X2Kpja8H0UYSmZiNjC3+7fydvk4Jz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816882; c=relaxed/simple;
	bh=3hk5HOM5F6A3pLsEh9hVs5NpJY5FLzk7XQGFKUQpCSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg9OnzK0DDEqT8CWwdo30xtVUtWymU2wHCyJO/L93/G6hab76uQdmPOE29MEl0ouQD+lsMmpxwt/WSW9DUZKmR758HGx1eyL3DVTnFWhYUuQjzGOu+a10T5LoBFUK/NLF6aSZy7vaYonXtgghQJbT7ljl4wJ3/7tLw70aqKfA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=gknpsmdb; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="gknpsmdb"
X-KPN-MessageId: 172d706d-7472-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 172d706d-7472-11f1-b2a8-005056abbe64;
	Tue, 30 Jun 2026 12:54:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=A3+waIbBjaplHQNL0v6HcJdtLABavtsCUIktV6JbT1c=;
	b=gknpsmdbXzc2bl1Bfo7mlI7QnVZi+NF1v7y5I9MXtA80qohwKCLV2wRtlJaJ93PDi7cTHXoMNP3Dy
	 +7EYV7T2Nu9iXWEelui0eC42/g/uLf6YgaL4Ik39a8ALzF/TCJodI6IVOAfEuhQNwSwWXMrd0zxwXE
	 Eg6JjktGcuRjDiE72qqeb413LmbPDy0nF4JYiNmgEmoIBjgGdPTkMr6LLd6+pCHzZCZMKwJR54/FsS
	 aiXM0dX1SAzfiWGmQ8aW6q75UTh3pRNQBGevqtMsUCFgpRmirFkp0IFnia6csxTjtb9P+TPT5YrQWB
	 NJrfHIwbhhZpFgTrpFmpfZpOA49u2Qg==
X-KPN-MID: 33|+KoOYbZzTAiegFN5ISUEE/7WBWoISgA3ijxXMgosqxoZcd2R5+eB31Yh1vw5Bxq
 iUXqKKMioPueUdJCOBgJlCEmOKrb29lo/LO4SftySB5Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|S3CI8ItVBaEHqCXgMsshJ83GUeIcGijrlbnjDZiRa75kw6a0G16X59stUlBRMEI
 SV4aGp/vQs6ECHbGj71vnHg==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1704f3f9-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:38 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 19/31] nilfs2: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:48 +0200
Message-ID: <20260630105400.68459-20-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in nilfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/nilfs2/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index e2fe95de3d71..d7d4f4d9a4e8 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -231,7 +231,7 @@ static struct dentry *nilfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	inc_nlink(dir);
 
-	inode = nilfs_new_inode(dir, S_IFDIR | mode);
+	inode = nilfs_new_inode(dir, mode);
 	err = PTR_ERR(inode);
 	if (IS_ERR(inode))
 		goto out_dir;
-- 
2.54.0

