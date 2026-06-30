Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65DE40C5AE
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816884; cv=none; b=CdsX8J0JXflaU3KliGr7+smv5kH59pzJLWxAuRy9Jqe6JVIkmEEek9cdcssNWszKcfanv8CH36XreFwJFQw0gKi4cSN5+9WwMU2azET92xWtG3fODecoNP6gqUb2GsPKFBKsdYFi+vGmn2zaICCoOJey+HX60XFIjvOlixRWgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816884; c=relaxed/simple;
	bh=ZV/Odsdjgsbnjni7cumb6Z7fYrpQdMaqN5014WA8qzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqaMlskStSx2ruwWnf4kPPzARk0VkCfu67YvJof1ryNTo3HjsgAthJ1QswXd1YhfUmJKwaNQLk04/Nzek0MKCv10ldPKIA6bxYSVqe6qE6tuPf0syXj5K1dcUIFGbyh92Or5waOs9DU+Kgyu+A9AQZPJwet9uM67Jdb0RdGQILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=cuKcWqSy; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="cuKcWqSy"
X-KPN-MessageId: 186c1185-7472-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 186c1185-7472-11f1-b2a8-005056abbe64;
	Tue, 30 Jun 2026 12:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=tna/6sH/sVpY/csgA37PDQiSYuNb4UfiGjZyPwRv5rw=;
	b=cuKcWqSyzlQjN30C7qtm5+rs53SzUwwTHV2reRQhDceuomxNWDHr+3mxiFE1mwo/HmDU0LOtscOW0
	 2tUac5/I/7JjK61i4wQjvj05Ge9uemOukbIBlokEOsD5JXXzrwmx7JLC9USOm4kzvGRN8g5Vs8mVWK
	 mO69AW8onpE939G4UrhCebuMuFR/gyDiEfVmYRNvM2y8WsQI+U3564icTTIeMbYrVcWBYPJv3Jufn/
	 HurtgfofYC8rF+FhRAbiF06MYAinn8mFwkLyGRHMmg1O3R+SK0Q63e3Y324A6LwvwMHa6ACmvs+tXH
	 ZkvyPwVEOeeSlh0V3psyR+JW89KxrLw==
X-KPN-MID: 33|RnkZlvwMFYlu4rdh8+v6r7MvA93sri2Lr+FotScXBBarAYhT/AN1sfLJJ+RE8gT
 sLC55+SDd7Uo9LAjap8ztuiuLXmxEcLYodVd8IgobZuI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|1MOCyopzi9YDCK6mVckpZ/LEI3VNAh7bBgUBZWBTdA/+FcQgb85DZXdUXHV2W7p
 ONBqJSRFUyZNVcMjFLuorNA==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 182a5a98-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:40 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 21/31] ocfs2: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:50 +0200
Message-ID: <20260630105400.68459-22-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in ocfs2_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/ocfs2/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 1277666c77cd..b87eb6a2fa38 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -657,7 +657,7 @@ static struct dentry *ocfs2_mkdir(struct mnt_idmap *idmap,
 
 	trace_ocfs2_mkdir(dir, dentry, dentry->d_name.len, dentry->d_name.name,
 			  OCFS2_I(dir)->ip_blkno, mode);
-	ret = ocfs2_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
+	ret = ocfs2_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
 	if (ret)
 		mlog_errno(ret);
 
-- 
2.54.0

