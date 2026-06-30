Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6740681C
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816874; cv=none; b=g827YmYaj67LqlZtxBEmjFMTm8OoNHim/xhfyCRGSOQX2YprNafSwrDTo/iF2dihZQo5aWRocinNlGrsPMnulpRRaBtXOlV4XIdz4HiRI9hF4JuoY31YbNKRwls5u3i+EOn+naNpgBKR1ZxUczo8kkPFHfNCk66HgonG5Vs/mIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816874; c=relaxed/simple;
	bh=ItAmIU/R6ivHBsA6oOqWL0T/Wxy2UmCgUWrE8dxEVKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvn8H8l2TWdx8gZnhr8KwHkGVMXDTTn4Mqmj4CW05SCLaIXPlCU3C/3KrXsGBEBdu1Y8ZSJu0dKlCBlpht6yBgFkZ7hg2bQyaYQIRIeug//qaWv0z2+0nWsfZCjBddc9XAEH+dQhv3T9xDLjIndUtQcsQKzenwXIKtjhycq5qJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=gdwdwElL; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="gdwdwElL"
X-KPN-MessageId: 1271ccd5-7472-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1271ccd5-7472-11f1-a055-005056abad63;
	Tue, 30 Jun 2026 12:54:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=6WQhaf2Dz6+E3E7MTSZRh9q32VavYyLl7pC+bU6TYxA=;
	b=gdwdwElL0geZ/AUjexaI3cRCVu9JZZJQZ7O1lVTtHApepoRLiU2KdfsjZBKuP1YIdCsXBkjvcuDAB
	 YVxz34mgcmMfxmqs7W8sQXYZKVUj8l37wmGlXhnaMOB54MMOsoNBe+e7MinUT/dpTH3eDkV4GXltY2
	 nxDqWJavdVt6Z8J+BeDAej/4oh/ElB4prrj2BEaqKz2QsePKNhc23VMBk37kzYtuNklsfent1k5+Xw
	 kyJe/yhuDQxtrpBuWPkptTlCIYgkb4CYbRBdqfLSymRSDjDDzvbGBfpX9VueOAtAuxEc+KZ0ZnYDLb
	 fR/WH+jdWYbS6inAzsLLlCKnu/WEWFA==
X-KPN-MID: 33|D+VeZB+j49nunb+KFYpXZzazb4RiwLKxlpGyJZROGazR9XtBBtmoe4wIY2AIOi1
 f897IEHeX+hgEwot1ncV22pLFMazIa9v8y1Psp1jn6iw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|IrmLb7yM2gKOyCOagoq9KGagcAwSGVO23b1W83A7pf7g6PehW4WiQVa4nPPN0NX
 /wOOxmk8QyKf74JSvx8lauA==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 122f0417-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:30 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 11/31] gfs2: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:40 +0200
Message-ID: <20260630105400.68459-12-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in gfs2_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/gfs2/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8a77794bbd4a..62926d8e997a 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1351,7 +1351,7 @@ static struct dentry *gfs2_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 {
 	unsigned dsize = gfs2_max_stuffed_size(GFS2_I(dir));
 
-	return ERR_PTR(gfs2_create_inode(dir, dentry, NULL, S_IFDIR | mode, 0, NULL, dsize, 0));
+	return ERR_PTR(gfs2_create_inode(dir, dentry, NULL, mode, 0, NULL, dsize, 0));
 }
 
 /**
-- 
2.54.0

