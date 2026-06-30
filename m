Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC640FDAA
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816889; cv=none; b=Ta46bcdnnVi2Ax4I7rONToC0mgPH+GGotvlF1E2Zy3yF+tt3H8NHT99WFY8qIuL3Ham7KvT2rgjkezjrQyQGV1A9TCj1YLYJnvBFmq9nrc/Cezht8Sw6VwOvJT1LZPA4GoqWKZbuX0w94/JkBbfdxymOv/97eDqy1I1pnbx+hJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816889; c=relaxed/simple;
	bh=srwLlZ7QSbbTiOiHsVlWQmOakXB3Dukl030LvHZMBQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fErF9kG88T3mo6Ei+V2V9bItcPWhIyeNHRmB01NoIF72QaJ2qYzhCQsVlMCRe3IPy+PLfWAV+SCWscv435Kjop1sTStcE6r3sXvDoSaWzkKVnn/EDvJgAG0qugh2Xcn/X2sfIXIJTdOU/1U31L0Qtaqss61tuYogqAx1z0iy/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ij98iPhw; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ij98iPhw"
X-KPN-MessageId: 1b1a3a05-7472-11f1-83b0-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1b1a3a05-7472-11f1-83b0-005056ab378f;
	Tue, 30 Jun 2026 12:54:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=4ai3S/8j0hftats0FBQks+bY7HomEan6nWuTmQaEq+8=;
	b=ij98iPhw7qXmbcv8af38eqMzjEJjFyWVaK/5L1DoXM9WG4O0sQNeeLLGycaIv1VSzxwLqMGpShhHZ
	 J2P0La5AP8xPrgux0nGCYVJ7cwXytLSLt98vDnnj4huS8/LL1Fh7iwH3+gjH4tNhShJfUFAS81+1pC
	 A7N6xFt2CEtECuBqz3o30Kr+TX15nEmvh9So/N1+cNbBKZ5b5WB4NLP/PGlZxLgHl9tDB4vsDHdEuo
	 28y6thgxCjxaU38fjdjKUhmWmJBWIwFnPZUWe3ypDSsPg3k9SBmv9nkGLzmAXlTKavP1+vG356bHPC
	 6T1bj0DZdMHYv7yKEDsgyJBLR8yJKWA==
X-KPN-MID: 33|WspE+KO447PUs8y9FVmBVbR0NeDyLPlFfd7rEvymn4Hz+P+Q+tZ4hxAVlWr4X6l
 JpdtUDG9LUDYJwv+IkiRjH2mWNkXW3wsydYsbg5jZN4s=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|yUlSS9gqVsayz21WPMVWReklCtKkkesXx+dlQX/7VikB6mB6REBhOVwK1zJOdpH
 0Qva8ugMgKB0OLEVPtBZ9fA==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1af4cc0d-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:45 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 26/31] udf: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:55 +0200
Message-ID: <20260630105400.68459-27-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in udf_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/udf/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 9a3b7cef3606..849762a7d14e 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -428,7 +428,7 @@ static struct dentry *udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct udf_inode_info *dinfo = UDF_I(dir);
 	struct udf_inode_info *iinfo;
 
-	inode = udf_new_inode(dir, S_IFDIR | mode);
+	inode = udf_new_inode(dir, mode);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-- 
2.54.0

