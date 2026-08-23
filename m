Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568DF310645
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501229; cv=none; b=UnTZK4CYMyLLqUWRBynodEuA7Ez4bWZ336Nz/9t+h1Fkcbqqfc1LRgY/nAsweNKqfOKAuGCeEvWHW+EX/Ac9263d2jpP3XjUZYHTIG5Ow/aaliReQRUDBfWogfbuTzQIBkf/Sm1Cjt3cMfNgnJKAkwVrRMs8owRMUvuorihNhRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501229; c=relaxed/simple;
	bh=lYHNhghDqhHsjjnzaKnpHZ1Yj+9CZfCiOT3Sdjnr29M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNLwSkzgDpqBthDRJsemkOr1NLKtnXZm0GdMYCY0xcRfxs+pZQe6lLj6sBIOJ9JxqfDwSx50ZRfdxVj3E2iT+vlzONx3ay+wXcVxk5jHwASqXVJBjXJh9Q7clCG+SFggxdWPohvYnfHEyBFPvKWVvLPm4uww/GmYyU+ArJITLnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=vStKSY4V; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="vStKSY4V"
X-KPN-MessageId: 872ec057-9f0c-11f1-8f56-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 872ec057-9f0c-11f1-8f56-005056992ed3;
	Sun, 23 Aug 2026 18:05:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=vNEE7ynNmmy0RLTjcVOI7+EkabxMyxI+8yp5sxRccrg=;
	b=vStKSY4VQtiTM9hjCt+jhY3YKIAH8KTTxMi2+6CwNTmEWE5vpMvWjpI9nHEJPGsyo/864t+//vHwH
	 5tr8Id1XiQQfMqNfkvbjHidaIENHFuPN79iEdfk8RmC935PIDMjXky9i56kdhP+xLfABZpXMhK9BEn
	 HSMNEREbE64qguB+TI/tq6NPzhSc1XMpUs1CTcpG9HYy0LDlda71ZdzLi5wlCY72JIisxedXrGrvyk
	 uwZc0TYWS+igAOXJPTJW3u03yhV6qbsObTpAJxfN+I+cK+rsvxC+2nMjGOe8g3k/WALceQcqELjCmh
	 zq4MuYiPgGRumapH9WiSxxBjZk4K8wg==
X-KPN-MID: 33|uDSyLnk/QUtbS32wqcmPI+9zIWKKnB4AHxXEel5sjRb6A+Eq5IhoIDgAo4oZ9RT
 flzGIUpt1R4U617rL7TaryRlYbTB35pZUsyAX15fiQNw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|GqqSZk1x9goRfoBYy8arhJ2qv85Gk90Hw86U0+Jm3cphDMhWbvIs5PLQuFYBOLe
 8eqzC7a4EVonTpznsm0SdRg==
Received: from daedalus.home (unknown [178.231.250.211])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 86f629b4-9f0c-11f1-8ddb-00505699d6e5;
	Sun, 23 Aug 2026 18:05:58 +0200 (CEST)
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
Subject: [PATCH v5 01/10] fs/namei.c: use trailing_slashes()
Date: Sun, 23 Aug 2026 18:06:57 +0200
Message-ID: <20260823160706.358293-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823160706.358293-1-jkoolstra@xs4all.nl>
References: <20260823160706.358293-1-jkoolstra@xs4all.nl>
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

