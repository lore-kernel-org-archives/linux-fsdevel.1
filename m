Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A261403EA5
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816937; cv=none; b=gHxzroSe+OJBbdh1FabcZoMZMTxhNSc4sxdWnlod4jzt1OFLWK4ytg/oAdyzOFT0/I7I0GUYjyc0z76NNdnli1rQILplR3WkPdiNrh5pjfhBtQDDsUqOMtVeOFSGa6/VyxBkSbNfyl5prABfBaU/q/2qPL2ysQyIt3T7KX+oXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816937; c=relaxed/simple;
	bh=ksXcSwtlJ7ZbSZA3zNrT0Xu/97JLU1LEBn5fMuLtyfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0jozIqKFA5YENBw2JzUI8Jl/gb6wFkVlP4t6nqTS8DSxHgj1nTggB8GSSmpj8Dx+jhpd3lqVEefAGXkg/alBJjxVB+YOh+c154j2PwXRbivErsCgkpwAK/rW9DzCkl0jA5fO93ssRcGsIDMQJeLgMnqtcyYW3AqUn5rLv3ElqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=mvCngvEn; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="mvCngvEn"
X-KPN-MessageId: 0d8f56fc-7472-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0d8f56fc-7472-11f1-a055-005056abad63;
	Tue, 30 Jun 2026 12:54:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=toWOYEuk55LiM5qPjsujT2PhOH1tHSdhIe4pGuEOVTA=;
	b=mvCngvEnUwkieq8+HpTtCdMnDJFQe7V8SNPfBkksKvv3+D14j8Q0Mf4XmSdoeVa19texfRxkCBCAD
	 RkH06ZtghdP4Dn/3uvk0ja+ZW0jbhMMTSeXizXwrycqQ+srUGLziH/n42oU4Ic/8GLlAvblkiq70S4
	 qkRgGuiZGCPH6hjRuGD3tMsADNIMRqqLcP9lJqQaIAdONocRRxMgogp15DydCFAZQjU4eWFM2YxYhL
	 dDxdvssk0JGWoNtCI0OrK2fubDukVpQqqpwSTOpk1uhsCjJvr69819rT+ESx2sRPrnw1jg/GESAvas
	 dMLQenjp3+KCWMjoQKuOdDY6YHauHdg==
X-KPN-MID: 33|RDbBs5O5a1qEW0VNHvb8MtDbBDtU/P11DHeRk7kgPH6WXQOgAKpZzSq+Zwp74pr
 8oTSsRGMzY16jLJ0NQ8loaHPb9UiSccKYki6IGDuuXBM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|SagtnSW1m3PdDnSXKkaUy5QwvMhRIlzdDupkNSxTsYWSfgR4sgngrBwjZ+8cyW5
 yrK40gBCXdsO7Q3JdgUyoGw==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0d6bcff5-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:22 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 03/31] affs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:32 +0200
Message-ID: <20260630105400.68459-4-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in affs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/affs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index c3c6532da4b0..1a6b2492ab03 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -287,7 +287,7 @@ affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (!inode)
 		return ERR_PTR(-ENOSPC);
 
-	inode->i_mode = S_IFDIR | mode;
+	inode->i_mode = mode;
 	affs_mode_to_prot(inode);
 
 	inode->i_op = &affs_dir_inode_operations;
-- 
2.54.0

