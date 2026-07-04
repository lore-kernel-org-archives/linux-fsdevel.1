Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4322472A2
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183282; cv=none; b=MDwv5tIMjDB2oyQpQinY/m5zXzXsQu9kwgGyFADLYCJwvQSwEHwesLXd3DAjGG6rfseGdn3M/Kl8lHuMIdggvK6ZR1ZD/VKcIqO8wnJrhpTna+TpMRkbPQgTf2xmxGukXwZ51wsi3ExVwsAHATz6C66ocyXWMenL9O4o+DgOfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183282; c=relaxed/simple;
	bh=QE0ultVNYqFGiMbEPhbEgh0kk6GJe6Pgk+g1wig9ULw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWVCHuTfSm4txQ8eTUGfSgPo1KDkIzS6Hmp0Hh+KRRwXba5YmLCoXgCH2+IyzYVMzV5qB0Wm+tO9TKc5yCh1zcvYSF5n4dHOlhiEJiiLDD5IORVzFjfIrFebqpCs/jAJNNrZNrJgtlhudLdAvIceeCDy1b7N0dHzlbRhPaLTzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=RIzQRxfY; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="RIzQRxfY"
X-KPN-MessageId: 2d67eff4-77c7-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2d67eff4-77c7-11f1-b2a8-005056abbe64;
	Sat, 04 Jul 2026 18:41:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=LwnIn4ELdcLX68aNwF9MMNAKMh8QHQXL8uFsHEy53gQ=;
	b=RIzQRxfY8SUiBKfEWrC2dlAeN7p1Nanm+ZN+Av5qSPBkCHnC2ja/DSzt1BvxKdHz7v4OEiUyxTs6D
	 IPucfzxDw/Nlx+nb9OB1urRIU4jHiKukJaPejibN+iEpiwGBgZpYfHG2AolL4e72YNqtkuIWsBkk/W
	 X9ryMVToQ62dmuuptiRjuL3mB+ro7BGEfPZkptyMFNBl5HBD7s0qQfEHHfdVxF7iJ3+vGtu7CeEUop
	 8VC8DlVj/uHS0ZIC5Rb6EMRCClKSrWnWjFkYM+FUFQ4HucpjwIlj3hahoMPhyexCU1jN15kolRT+o7
	 aM9PJv+OWd1cBt1PuaVxFqsZRLNvzog==
X-KPN-MID: 33|G3IB9CRxfla0Ys6ZcRINT54mT/O6bLOogzGedhWftFXcftQUiPFEG5JlDUred+K
 Mg+ECaAmZtGlLL3O6cTGNhLzhHyp1Qjk36cY9gFjdJug=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fqmhZPoH2rj5vmZOjAXi5yUb45f7vr8zKoFYFGRcxTeH4mRC7phNp/H8gUHxl39
 7jDwM/d6q0rbbfwZvURED+Q==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2d1ec6ac-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:16 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 06/14] vfs: lookup_open(): move setting FMODE_CREATED down
Date: Sat,  4 Jul 2026 18:41:40 +0200
Message-ID: <20260704164149.3480051-7-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using vfs_create_no_perm() in lookup_open() we need
to move setting FMODE_CREATED on the file mode to either before or after
that call, as currently it is in the middle. If try_break_deleg() fails
it is currently not set, but vfs_create_no_perm() includes a
try_break_deleg().

Going up the call chain of lookup_open() we see that it is only used in
open_last_lookups() if no error is returned from lookup_open(), so we
can safely move it to after the filesystem create() call. This also
makes more sense when reading the code as you don't have to wonder what
the implications are of setting FMODE_CREATED before the create() call.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 88d56a470832..daf31845e3bb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4552,7 +4552,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (error)
 		goto out_dput;
 
-	file->f_mode |= FMODE_CREATED;
 	if (!dir_inode->i_op->create) {
 		error = -EACCES;
 		goto out_dput;
@@ -4564,6 +4563,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 
 	fsnotify_create(dir_inode, dentry);
+	file->f_mode |= FMODE_CREATED;
 
 	return dentry;
 
-- 
2.55.0

