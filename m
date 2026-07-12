Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C97367F4A
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878907; cv=none; b=Tr7bGFJRzub/5s1ZLI/ie0Tuw0kt3tRUWLoDW2SUrfK9el6cFtgsidKzAfMN83dH/rcNxKbfSs3sRcx5ZdjbdeBG6W7F3ScDhTUkQtE39SiasrEnZCZE4pEbfIO2mBvbrLab45DLQLIpb5/1bk07s0b3H1zjnmDdjnGbT44572U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878907; c=relaxed/simple;
	bh=qpVwvxXPy6jPCVFeD++9EdIwgB3C6GozoZRoeWP0CxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAgfdou7KJo+2S5O0foqMoscWqzTA5tpc9K5dIFH/Gx7G2EyVc1vLhPAoEH3BO8dnonim64z9HFdO88VUBq7uFEUwGEjlIkLp1AcB9oC6LddztwB4n8Z/TLAxokARK7OfUznNhs9M6KSq3CR2TRx96wRtVKClAq//NNs7EWB2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=doNCId+J; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="doNCId+J"
X-KPN-MessageId: cb2c9998-7e1a-11f1-a59f-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cb2c9998-7e1a-11f1-a59f-005056994fde;
	Sun, 12 Jul 2026 19:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=5j6W/FDwkpFm4i9Np0yyQ66L9ewGj65MEO11VqU5R5g=;
	b=doNCId+Jf/zzBzRRIyluLYlmFqVupHeCwBhmTTDhKsJd6x8VbuvIohQB3yfMmHRh7M6drsh5bI9KN
	 WbwykIbhQon08jh92LSqhX3a40GH+apFRRO0OW5aLXH56Eszp9et0drLeZkyClikErjAFOsFGukBsX
	 m/FOLoULLoBVMgvJOv7NQnYn/XcxXJa5CNHT3EVeDJb2rpcNiacPVzIBUO5Q2/sZkfA+gcxo8NJ6wI
	 Jb24QcX9hXWD1TzUxF8DeeLRVEUNV45ZvyL3d51Ry+1fZpvJwOHAvJLur7dTazmpBHRnSvPHNuf76Y
	 opB5qfX1oHRp4n7I/85TDzdFcDgmtuQ==
X-KPN-MID: 33|IJ1Z28X5cYnUlcwPQzY8Ik14QFxmk4xuDghCFUYP7CUBcSMcJwoFX2qahHy8144
 yDpYx3lqSerWAvqDQcnvpgg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0CQ93ndg2dr/ur5RV+3vAJVQGG5k/wvuUn9dqNMgpRN+xyqpMeoSBd5/ea1q2NK
 XWkaWza5OnOPn7EBC3/dV6g==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cafab80e-7e1a-11f1-87f7-00505699b758;
	Sun, 12 Jul 2026 19:54:56 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 04/10] vfs: move ->create check in lookup_open() to before try_break_deleg()
Date: Sun, 12 Jul 2026 19:55:33 +0200
Message-ID: <20260712175539.1565444-5-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712175539.1565444-1-jkoolstra@xs4all.nl>
References: <20260712175539.1565444-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i_op->create check in lookup_open() takes place after the
try_break_deleg() call. This does not match the order when doing a
regular file create via mknod(2). There the call order is:

	filename_mknodat()
	vfs_create()
	i_op->create check
	try_break_deleg()

Move the i_op->create check to before try_break_deleg() in
lookup_open().

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a43e64717d11..aaba03954cd5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4520,16 +4520,17 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
+		if (!dir_inode->i_op->create) {
+			error = -EACCES;
+			goto out_dput;
+		}
+
 		/* but break the directory lease first! */
 		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
 		if (error)
 			goto out_dput;
 
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
-		if (!dir_inode->i_op->create) {
-			error = -EACCES;
-			goto out_dput;
-		}
 
 		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
 						mode, open_flag & O_EXCL);
-- 
2.55.0

