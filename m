Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB383CC338
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455435; cv=none; b=bHrVg8miKf3W+AqTOFebFr3BIe43V8UxZcdBZmQPdPByQ91F0aC+wOKWoFuWEqkn9Io7yXW09RnW6m2jKNke2+Dl+Yuhwn5SrVW2Zvq0o1pMospp2S9JRnC8CNYoL2UGMhmDdjjX3GP+7QyjVqnpaExj5LnhIQ6xrMa+GT8Pp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455435; c=relaxed/simple;
	bh=KhY+NMOzGSN+7fmmbCzoHszB5m5X6uaef+gfzN9a4xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCViLB1hz1zv8rN5dumRQgJfQt9MaQEFbFW4+3rloJQn3cImiiHrd35ck4iOIsyaf6Je5bodOS59aK6I0BnSmCgVY5O6PJwjVpjcEjZFGRureT8K8f/0UXPXxg5hkggYusM8tQH9jwPB4sPsxfi22wEmxjyqMoHzT96051Rh6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=qRSkRhZW; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="qRSkRhZW"
X-KPN-MessageId: 36857c58-6810-11f1-96a9-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 36857c58-6810-11f1-96a9-005056abbe64;
	Sun, 14 Jun 2026 18:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=fw5vnqRbPzFx6+7x7JKtZpb+fq0VXi0CRFQCcswFFCw=;
	b=qRSkRhZWfSLyNIhqhBTHIUXTMiG1iw8YqbQSkKOmEbgqWiqPuKcCTXbMiqc5bgmUHByUtg2taX0N0
	 DNlPm+NhXGvPyntK8uv8dXp7oFfZLnqtjc3vMyGyGGCM5qW+4aS1G+GQzdKrGVAmnfiW+LhFldv2EJ
	 a8JLQ2NwnfaHgY5PW3KIWkuTblOjhyrOKPcl65vDdk9HszbGyIpo6cncxCPSSpjovhFYgQAJ2UUo0b
	 kJmy64cBSy0GQvHmmIcLN3wWte6VHZFQqebESU6VP6LJyFk/NSJ1P5rYdRTDVIsXjPwWpOHnnl9Psp
	 3/PD6LD4hZ5kj5W84gVvEULOh/hsVJQ==
X-KPN-MID: 33|MRVtqisYOJMnnJKfZlXfdiTlA3brrpdHL2un/S60SZZwhIslxN1dt9i6vlZ5L8Z
 fu/zyTtS8ZdGxLapm7lCkxA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|s1lyAvhMv6YolrOgRVoeE4hJ9+FREPf1oCwISUk/46HveQFcIffYZn7LpzcnyJQ
 yiQIdy8xizRcTWRtRUuRR+Q==
Received: from daedalus.home (unknown [178.230.193.94])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 364cfcf6-6810-11f1-8011-005056ab7447;
	Sun, 14 Jun 2026 18:43:46 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 06/12] vfs: lookup_open(): move i_op->create check to before try_break_deleg()
Date: Sun, 14 Jun 2026 18:44:32 +0200
Message-ID: <20260614164438.2980769-7-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
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

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e21f23502e8d..15bf28b85a4e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4341,6 +4341,7 @@ static int may_o_create(struct mnt_idmap *idmap,
 			const struct path *dir, struct dentry *dentry,
 			umode_t mode)
 {
+
 	int error = security_path_mknod(dir, dentry, mode, 0);
 	if (error)
 		return error;
@@ -4528,16 +4529,17 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
-		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, delegated_inode);
-		if (error)
-			goto out_dput;
 
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

