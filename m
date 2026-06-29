Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC2537DAA6
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747354; cv=none; b=hUqJTPuu/1gKxbjjLHUUcZ3bnd0TQxOKZZqKGiKvQ1A4jrOHn6Atebe5i0++MhvEnKMuHThI2uJ2S+pmux4D9go4fDECkzEVi/nlYALG6NAQS2aokY4NwP190rvkLN6frhZ5ohgGQz/CZFATRxv7gEhAGuNCiC06FLiu8q+YZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747354; c=relaxed/simple;
	bh=5PLD134ZrEmnn3YL/Utuef6Ep+ADPD3bAmW4mlAyM+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hkv39Si8bKfQJmXjvKvk0mfbc9RqF1Xn0h1lnf+fjrLZaux//13dLGJEYDtlioKGmJDCZqarsOl3ka68WOaEg215AR2rPzKBYNPeavuRKxzSJIUJae4VF/ZIYcD7Fl7+DzV1MLkSKDChQbXFZ7Q3APuePCdutspJlGABdjJ6lwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=JUiUXBR5; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="JUiUXBR5"
X-KPN-MessageId: 326fe27f-73d0-11f1-8f53-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 326fe27f-73d0-11f1-8f53-005056992ed3;
	Mon, 29 Jun 2026 17:35:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=+hUKHnAx6/dQNvRrGgWCQ6JjIxKsKbCG+/FoGh33W5s=;
	b=JUiUXBR5g119pYfLJ10qFsoJ9Srsv+W9ruTVFr9W93a1PGkbfxtxOFLfuXY0C01lgh195YRKMWAE7
	 15vSk1M5HlX1edeW6NO558modGvklTZ14Jpum7dPcIDDL80PQSrj6IYv7/xdTOtnf5Jp+riBikAXYT
	 /FYdSQY5uT85RYnVD+V1Jv9RmeZgTzi7iC1/vhGxHR8pYf3333Uadw/nWbQzu40DG4f/c0tq7llDoP
	 KALwGyBdv4VakKkMleACj4/TyMdsUo4IxyD88K96SnGCXAsOZjVYMEwT4LSG2fEsZJtbcDlM5UigeO
	 CU5wXmmnuJO3RwX9d1jRYoZ0Ewz2sAA==
X-KPN-MID: 33|vwl3+VP3ze8QM7kpdeaM/R+HkcdHLcqEiQJDIpSJ3TicgFKnj37c8Moe+hRondS
 4/YXKzrbM2ZhUGhVh/fRjQhgjLEnCIqzI+HAeN2ZLMH0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|CCxfUq/yU5ENcKfKmQ7YMdft07JPqyyNJQNnnHa/YF2s/MN/AtLgHgOpdxYsGHe
 LxEv1KrvYF9aM8aQFLMi1Vw==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 3234fdff-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:46 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neilb@suse.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 05/14] fs/namei.c: don't dput() when atomic_open() errors
Date: Mon, 29 Jun 2026 17:36:21 +0200
Message-ID: <20260629153630.2158649-6-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
References: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both users of atomic_open() now need the dentry alive after return from
atomic_open() on error, so we can remove the dput() from atomic_open()
to prevent useless dget()/dput() calls on the normal path.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4f747546ff3d..85ce44b068c1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4365,7 +4365,7 @@ static int may_o_create(struct mnt_idmap *idmap,
  * be set.  The caller will need to perform the open themselves.  @path will
  * have been updated to point to the new dentry.  This may be negative.
  *
- * Returns an error code otherwise.
+ * Returns an error code otherwise. On error the ref to dentry is kept.
  */
 static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
 				  struct file *file,
@@ -4389,17 +4389,24 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 		} else if (WARN_ON(file->f_path.dentry == DENTRY_NOT_SET)) {
 			error = -EIO;
 		} else {
+			struct dentry *old = dentry;
+			bool replaced = false;
 			if (file->f_path.dentry) {
-				dput(dentry);
 				dentry = file->f_path.dentry;
+				replaced = dentry != old;
 			}
-			if (unlikely(d_is_negative(dentry)))
+			if (unlikely(d_is_negative(dentry))) {
+				/* Do not drop original dentry ref on error */
+				if (replaced)
+					dput(dentry);
 				error = -ENOENT;
+			} else if (replaced) {
+				dput(old);
+			}
 		}
 	}
 
 	if (error) {
-		dput(dentry);
 		dentry = ERR_PTR(error);
 	} else {
 		if (file->f_mode & FMODE_CREATED)
@@ -4497,13 +4504,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		struct dentry *orig_dentry = dentry;
 		if (nd->flags & LOOKUP_DIRECTORY)
 			open_flag |= O_DIRECTORY;
-		dget(orig_dentry);
 		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
 		error = PTR_ERR_OR_ZERO(dentry);
 		if (unlikely(error))
-			dentry = orig_dentry;
-		else
-			dput(orig_dentry);
+			dentry = orig_dentry; /* atomic_open() keeps ref on error */
 		if (unlikely(create_error) && error == -ENOENT) {
 			/* Should have done a create, but we already errored. */
 			audit_inode_child(dir->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
@@ -5081,18 +5085,10 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		if (create_error)
 			flags &= ~O_CREAT;
 
-		/* atomic_open will dput(dentry) on error */
-		dget(orig_dentry);
 		dentry = atomic_open(path, dentry, file, flags, mode);
 		error = PTR_ERR_OR_ZERO(dentry);
-
-		if (IS_ERR(dentry))
-			/* keep the original */
+		if (unlikely(error))
 			dentry = orig_dentry;
-		else
-			/* Drop the extra reference */
-			dput(orig_dentry);
-
 		if (unlikely(create_error) && error == -ENOENT)
 			error = create_error;
 
-- 
2.54.0

