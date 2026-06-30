Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92BE3F1AB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816881; cv=none; b=CpxgWEDZdfceX6gwY72azu774YaanpKETwoSDXO+Fxsj9dp/9X8h8xnJ7/L6ow/LU/pASiEeHrNxhXyY6rzKmwViz1gjy6WNppOgf4meU+pC62PEbFeXBz9RQuoelVL3yLv/JECEKTPucEbaa+aWo92wg641I2R3pzTcjFaDQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816881; c=relaxed/simple;
	bh=bh6iu3JXNojdLlakTXXYAyj7bunzDfB2QHqbokAtnto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6j+J9JME421T0rsFdejktsp7TDzsR6UqKBBBPDgl33qUEmho6oshccgVsr9cPtz1PADydKHV551UkQJ8VGBV8ZvSNL2/6F1/zJdcEvt5kNTEX2M1WAxmKKjwm84BBwh2GJXi4rCb2J9oeD8R25SrvWSPCXgUmpXRN68nvzZDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=I823V83n; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="I823V83n"
X-KPN-MessageId: 1696c3c1-7472-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1696c3c1-7472-11f1-a055-005056abad63;
	Tue, 30 Jun 2026 12:54:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=NBZ8Aal1kpKE5gYDA2qUuOUHDzhisd9Ml2M20+/O9sg=;
	b=I823V83nQb/rV8yQ8isj3yTTD44U+EaOoXgbQ5XLtKVKN6tdPKjyiIa7tQu6+cGXbiVZs7RR7cdXj
	 nnNtHrR4Q5+LovaDPePzoZd/S2mZcLq6Xc+pQpMT1DRMGLRGwBzdd/h+j2w3GZKEROB4JM4nSjiEy1
	 nX9HKFWVCswYeWBmE0a5+xSSCCLbOTmjIis7TOAhr8J82NaV3KO6iqpln5NtpKLYNfHFXTur20ibTi
	 mxyn5HCaXIlWuHbeufidbbFb5ZvLhNwAMa273WTS1MMlZODy8okIzfQtM8AnbMbOI1qUqbg9WVgN8s
	 vDQXAdx74OzCYLiEKc+irvmp866X2IA==
X-KPN-MID: 33|H0PRqjgVPRT0zcgasmAXcjsJd2BWbsn7n6d2vTdvgUrueSEBmjK1ONgd8XXVzAt
 biLoB/mZ6aDAXBUSeYxL3UA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|lMU3ALGRWid4WvjIZv76vj3Vvj3b2vMF2TFkw3YajtYMlK32pZL49ZOT8lDSXVv
 u9lRMfuB9Aha6NeXfK5ULPA==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1673f193-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:37 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 18/31] minix: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:47 +0200
Message-ID: <20260630105400.68459-19-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in minix_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/minix/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 263e4ba8b1c8..19b03ee15c28 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -110,7 +110,7 @@ static struct dentry *minix_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode * inode;
 	int err;
 
-	inode = minix_new_inode(dir, S_IFDIR | mode);
+	inode = minix_new_inode(dir, mode);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-- 
2.54.0

