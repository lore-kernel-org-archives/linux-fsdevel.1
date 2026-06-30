Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382941C31B
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816940; cv=none; b=KIGvkch6GIPWHv1WkiW5abVEPdWyDknvz9nwZnUPg2inQeDB9wCls6IBaqERR0PxrtaYxIlMH6jH8B1ksfbjFOskqF9FZIzeS8JXghq6TEChiNtejBIneW5AQBdUglafgQ7/CoB9axYj6xT9khoS2ofIisL4tmERClonkne68qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816940; c=relaxed/simple;
	bh=vn7JoE0pXIABUZzjQ2KORhJNXTvjpd1dx+9twiASris=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCCwI603RojjcM7Cgn/bNw3rOIMvETpAFCEZoU3dxHoi0T8aQRyV3TEYF6TELJ9HCPZkxLscWzg3dfqt8kEalyhCVSdTXmkcEhIDN/YhZrxv0DNjpzgYnKmVQ5qrpTbPDmzMWUnq9PqhA+/bCLFTBTXFt4CogbOJjQc74d57buw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=JiPhUVgF; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="JiPhUVgF"
X-KPN-MessageId: 0e42eb41-7472-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0e42eb41-7472-11f1-a055-005056abad63;
	Tue, 30 Jun 2026 12:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ZY3MxC14ItlyC2FUQiU4+o2obsHgpQJBzJbz52AmcH8=;
	b=JiPhUVgFVzZtmzhL6V2zswYArsz5bPZjcUkbT2Ia4+yLhSGIARt6Osk95WDhDrdE6ES3S6H8gkKYW
	 TFm5KWVqEgmue+jpUW3c5e2a0NcBpGOX1trpBdLDmHP+p4AWvOAM3sfw2eOzv8ekJayFfCL8MapMhV
	 ZSp3U4JEm5zcRb11An00MpOLSPVVshV9mRai5gJ8OXVQP/fYX8tszxR4QAP6WiE34sEQMDidsJ8VuD
	 CDCiG8iRBEoFNHyfI61UTcdbU5B2jq1QsA+tTs8iW9b6rbMZzoJruvWQpQH47gyfKDUU09JpxyYAly
	 Bd16xrjjyg4QT/wDxw8/Aw0pBMDLkOw==
X-KPN-MID: 33|JmkRIiAAGqR6F2XtPlWn/zSOFVYM7MGsQksIJ5YQe6cAG7L1N3LWavjb/fpejlm
 HxmFeNkUMqlWX+AWrCaAgsa1U1rn+ePCEx8RpqGNXG20=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gaQXNg/LrnOMbU20zTM5bmMbgGDxksWxzzuVQ+TNZ2EwTSgwzio0tYNpvIATUxo
 zNJLFvK2R6jPhaIuQxKFcrg==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0dfa9cec-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:23 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 04/31] afs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:33 +0200
Message-ID: <20260630105400.68459-5-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in afs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/afs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 498b99ccdf0e..3bff8731e67a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1323,7 +1323,7 @@ static struct dentry *afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	op->file[0].modification = true;
 	op->file[0].update_ctime = true;
 	op->dentry	= dentry;
-	op->create.mode	= S_IFDIR | mode;
+	op->create.mode	= mode;
 	op->create.reason = afs_edit_dir_for_mkdir;
 	op->mtime	= current_time(dir);
 	op->ops		= &afs_mkdir_operation;
-- 
2.54.0

