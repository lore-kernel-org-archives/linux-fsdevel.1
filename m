Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434B395AD0
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251660; cv=none; b=otMHRycPGr1SV35Kg8s9bqqt9wl7dna0W24HMfqDEnV7welf+Q0PwtWHRqGkQGa547sH7C8vgWT0Pf35NufRUdwGQDnylJtbGN2tC2mTmnV9HbwyqauGSKV7cyezhRJdc8qtcExfwc/70v05v9YN8axFGi4oiBDS/GV+zccFE5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251660; c=relaxed/simple;
	bh=LofID8F4aeEP2NL0yaU8KzdnQikWu1PqIr89V0ExjAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfH0TTRS+GuffaNYxh1l1JWFVH+7Mqwf3bigfdJDxXqM0hKFMfzkbgnLvTzbOymFcWw0vAfsP/3KSk20DJesMnEWZhgeVZoyKlpYhUJFMjYPl764Ulr94oBUuCLpvThV+MzlL8qcpvNEadqANXwgNyklyZ3q42xhHIg8zoVlEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=FKUJ7owK; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="FKUJ7owK"
X-KPN-MessageId: 4fcef7d3-5d1d-11f1-8aa3-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4fcef7d3-5d1d-11f1-8aa3-005056ab378f;
	Sun, 31 May 2026 20:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=jAqQXpNHogqs9fFU91Con1KstcX0pVy6+8pBtPvuNSI=;
	b=FKUJ7owKCLkG7rXEiBj1BOZyWOdtucG8t+us2U7k9J3bQPGflq1DaQnQET0WFTEPrtKCJ2ElCK5hb
	 VWBtXSQAENkODxrxRyFKMGbBtqp3u20cLSuHvYmZCBas8lzrRJsHN5zveMBhmjeFbESMuXE5uhPdyR
	 q79mQraGanOyTaaRofVNe2oup5oVYfIabaL1qjftenqNtrruZifmwl7qCCL2U6UmO4TLdVu/UYkVPY
	 ueRjWoaPEc1dRTfIsPIREZq4iYU5htz+bHsnktdO4Iu5WsISoOYEjzctwUhoivUfP6rbmnbOt3PjMF
	 bqi026e77hBoJlgIxwJn74j8gLTQKpw==
X-KPN-MID: 33|jtdY/8S3y1tmkQ/r3Cn+C0sYUN/ZhPyGWf7w86oLMQ/TAmtpP4X2iwHwEznTW3L
 K5JgVlf+FV8hF63nVu4zcr9x3WEZEZqC//vpkSkqCGuc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|j5Q6Jaakw7n4qKrREEATSrRBGDN7n1DofkSF5tWf8f79p3YAAR45JsRwvGTSkIM
 rCXp6tlVMsNEO8XBxEcyFxg==
Received: from daedalus.home (unknown [178.227.141.146])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4f826e69-5d1d-11f1-8011-005056ab7447;
	Sun, 31 May 2026 20:19:49 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [RFC PATCH v6 5/9] vfs: lookup_open(): move audit_inode_child() and i_op->create check to before try_break_deleg()
Date: Sun, 31 May 2026 20:20:41 +0200
Message-ID: <20260531182045.171711-6-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531182045.171711-1-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling audit_inode_child() and the i_op->create check in lookup_open()
take place after the try_break_deleg() call. This does not match the
order when doing a regular file create via mknod(2). There the call
order is:

	filename_mknodat()
	vfs_create()
	may_create_dentry()
	audit_inode_child(dir, child, AUDIT_TYPE_CHILD_CREATE)
	i_op->create check
	try_break_deleg()

In particular, audit_inode_child() is called regardless of whether
try_break_deleg() fails.

Move move audit_inode_child() and the i_op->create check to before
try_break_deleg() in lookup_open().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 16dcf537db87..293592a4d011 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4526,17 +4526,18 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
-		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, delegated_inode);
-		if (error)
-			goto out_dput;
-
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
+
 		if (!dir_inode->i_op->create) {
 			error = -EACCES;
 			goto out_dput;
 		}
 
+		/* but break the directory lease first! */
+		error = try_break_deleg(dir_inode, delegated_inode);
+		if (error)
+			goto out_dput;
+
 		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
 						mode, open_flag & O_EXCL);
 		if (error)
-- 
2.54.0

