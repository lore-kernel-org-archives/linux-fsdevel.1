Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39893F6C2C
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325420; cv=none; b=JBamjuXONMBWSSDrynLx2eJ7HrWb6alQUoBhFLkxvv50CMOuC77FYqPTXwGjCTk0k0CZmq70+/2x3lXUu3FBB8vq9qqAbgR1/5MZg0XPqmlmVNFJtXbVWqH3O206zcNUYw9/nMxbpkfjFoLGgyNHkSIqMUHnj4f2kMLwOMOiVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325420; c=relaxed/simple;
	bh=lYHNhghDqhHsjjnzaKnpHZ1Yj+9CZfCiOT3Sdjnr29M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ibqogao0230C278vZ+dizQVetlJhcVggy2kcEN0hcG5Tg6G644ts1mikG5DEB6vEPUjr+B1sJ7Vymem9QpU3LS86j1HU+TOVY43Af0GiZqHy7XeUzke13prDSZcPAGGSXd7x7O0Rjq5IlEN0pCkmTP1N+OoCbiV+7FQgg7686So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=TMeFNUx0; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="TMeFNUx0"
X-KPN-MessageId: cce791ff-afa3-11f1-83b4-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cce791ff-afa3-11f1-83b4-005056ab378f;
	Sun, 13 Sep 2026 20:49:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=vNEE7ynNmmy0RLTjcVOI7+EkabxMyxI+8yp5sxRccrg=;
	b=TMeFNUx0cSPY1PKF1AqiagTF6ZlpxI/QsncdPKv0WWLhfS03ngxOVOx2ypE8RDtrJZBbK5Iv+vpUC
	 HrgQ81tlVbGRFDCC91C3Ca34dOjL/ghHyMps6+ncJ0xO6H5qBQowOVkjP1D6NZX7CLifqEySthCIWz
	 xVl85q+Zd1LETleYL2CtNP7SzkQdL1kcrr8RdRInqvtNGhSwNt3Fa8cdODJ6EjakiC5Xiaxi7cdyCJ
	 yJ4YV9tNqno+tNiHqehZSlxy9rDU+Wjg7OqPzSg06+z+LM8DPke9hiGWPVZ2eanrDruLFWHlUbRwHo
	 UtLzPzcpUpbvBdebcJtL/3Io7FKxjWg==
X-KPN-MID: 33|QMax/3FaIf/4wM/xQHbcP+J+3/ibaJYlJtXvgyzwZ/2KekrViWGMRMWNQVzcV/S
 /aNoIZXt6+BblJIzkzMtXyOheE1Y0WlBMi8OcKHLaSuI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|GTfEyWXGERy4CA1ZkiB5z4mcfaCiV8u8nN5wMtg6E5YumrEy0Fye+91NFGIzCPE
 LpZQeUnGYKv4uNI4vedSXLg==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ccaaf1df-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:07 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v6 01/12] fs/namei.c: use trailing_slashes()
Date: Sun, 13 Sep 2026 20:50:05 +0200
Message-ID: <20260913185016.523376-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913185016.523376-1-jkoolstra@xs4all.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several places in fs/namei.c that can use the
trailing_slashes() function to improve context. To allow this broader
use its signature is changed to take a struct qstr instead of a struct
nameidata.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 20a6534ea3ef..ab1302b38f46 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2781,9 +2781,16 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	return s;
 }
 
+static inline bool trailing_slashes(const struct qstr *last)
+{
+	/* last->len is set by hash_name() to the length of the current
+	 * component ->name, terminating with '/' or a NUL character. */
+	return (bool)last->name[last->len];
+}
+
 static inline const char *lookup_last(struct nameidata *nd)
 {
-	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
+	if (nd->last_type == LAST_NORM && trailing_slashes(&nd->last))
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	return walk_component(nd, WALK_TRAILING);
@@ -4695,17 +4702,12 @@ struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
 }
 EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "nfsd");
 
-static inline bool trailing_slashes(struct nameidata *nd)
-{
-	return (bool)nd->last.name[nd->last.len];
-}
-
 static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 {
 	struct dentry *dentry;
 
 	if (open_flag & O_CREAT) {
-		if (trailing_slashes(nd))
+		if (trailing_slashes(&nd->last))
 			return ERR_PTR(-EISDIR);
 
 		/* Don't bother on an O_EXCL create */
@@ -4713,7 +4715,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 			return NULL;
 	}
 
-	if (trailing_slashes(nd))
+	if (trailing_slashes(&nd->last))
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	dentry = lookup_fast(nd);
@@ -5087,7 +5089,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
 	 */
-	if (last.name[last.len] && !want_dir)
+	if (trailing_slashes(&last) && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
 	dentry = start_dirop(path->dentry, &last, reval_flag | create_flags);
 	if (IS_ERR(dentry))
@@ -5703,7 +5705,7 @@ int filename_unlinkat(int dfd, struct filename *name)
 		goto exit_drop_write;
 
 	/* Why not before? Because we want correct error value */
-	if (unlikely(last.name[last.len])) {
+	if (unlikely(trailing_slashes(&last))) {
 		if (d_is_dir(dentry))
 			error = -EISDIR;
 		else
@@ -6305,16 +6307,16 @@ int filename_renameat2(int olddfd, struct filename *from,
 	if (flags & RENAME_EXCHANGE) {
 		if (!d_is_dir(rd.new_dentry)) {
 			error = -ENOTDIR;
-			if (new_last.name[new_last.len])
+			if (trailing_slashes(&new_last))
 				goto exit_unlock;
 		}
 	}
 	/* unless the source is a directory trailing slashes give -ENOTDIR */
 	if (!d_is_dir(rd.old_dentry)) {
 		error = -ENOTDIR;
-		if (old_last.name[old_last.len])
+		if (trailing_slashes(&old_last))
 			goto exit_unlock;
-		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
+		if (!(flags & RENAME_EXCHANGE) && trailing_slashes(&new_last))
 			goto exit_unlock;
 	}
 
-- 
2.55.0

