Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5CF41323C
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816891; cv=none; b=H+i+Sb7FmZltyYESkfOkzhu7yb2f2gI/4PK2HAVmct2Tqy5GvbbyztpU5vbn7F8KNG/TEaOYgMETLK9DerTRxPcdcQ6eoj865UyFva19XDCw8QXfDv5CdsfUyrDphudzmXbkKJgoVM3lH7J8vnHTwDTuUbXFumARaBRnjNyyOig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816891; c=relaxed/simple;
	bh=Uk+/WyHJjtE2MuRU1zNQ866KZy4HYKQl4BqLY5mPhS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qpi6rqRhrejToGVZ01szk9lqaE+NQrdr/J/s2u0WVdSTkYKOM8MCyiz/nFgStn9QOHBGcwy7IMWwzEdfQmWwuv8xgxiuUMwdrYeJUtP1jo6j/03LlqMvenZwP45Qr6kNGFr+WJzqql56mZdr1AltB0cXmat2WPCUxv1kXXPeMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Fq00iWCs; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Fq00iWCs"
X-KPN-MessageId: 1cd670b6-7472-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1cd670b6-7472-11f1-b2a8-005056abbe64;
	Tue, 30 Jun 2026 12:54:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Y5AAPOXPjfW23Ek4gvsWUMEi+CKmtD3C/DJEXHOyq+U=;
	b=Fq00iWCsoCZrVxUvPzFfktmQfMzguCv+vilflYLG9yz03zUL6Cs+7d1Z4PlItu/h7U6pFMXgNBwOG
	 U8QymV35bx3wFHxQRQi3RvF3iqPqj/VDjidDXSScQBynyEk16tq5sdy4HpM0DhIFFFMK/LGa5pEg86
	 YGhHeYjNvKRqNV8ekY323RX+z81x8sMqein/vMZtdOlfZzqFy7kGWEQ/irhirgahFSqoK0D/2Mm7XQ
	 mY15zC/EQeDzw4rejB7XR3MW53B0yxZ/+R7t7DaoAoxtg5iz2l9ZMbs/usW0r91YIKgrqv5Z80flzz
	 2IzfNrnWabYMElphQjemrY+j6zTcV3Q==
X-KPN-MID: 33|41D0mvihReCMSSj0jt2PxYCvJ4+ngUJt1olpzwSVpFCVHV+K261Irk1djVd+VLk
 hHYZ5rcb9L3EoSdkdAbqApcIRh65KFeqh7yDPrJ5nil4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|9tgQq1ohVxlBJLrcr8gYkhLHl+EVm6K4CIn9U0Sqg1Afvz9nuurlFf4CAEK9+2D
 i1dnKWXGIo3OFYFjUVJDImg==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1c8d72c2-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:48 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 29/31] ubifs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:58 +0200
Message-ID: <20260630105400.68459-30-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in ubifs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/ubifs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 86d41e077e4d..b200f3d682b6 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1031,7 +1031,7 @@ static struct dentry *ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, S_IFDIR | mode, false);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_fname;
-- 
2.54.0

