Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640F3FAE19
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747413; cv=none; b=TbY3E3tGaFQ+B+ib8rDnteEZjqRAtCos7NsSyPghz+uG3S+zNRVjk45ghj0PVAn26nzNSW7Z4NOkGqddQINdiZJEhWeqvAgv59x07FAtrX9ColD+WwG6MkwZV0YLribFbgB7s5DjM3/ukFhufYtnpQZps46/YlC6Adclery4K4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747413; c=relaxed/simple;
	bh=9QiU3eK0jAxf8PLk8vUi8H4ukzLDmvkgcgQ3d9BV2uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgYfxFTo6OxDl7wSM8nb6t4ZBWMD8snUX/O+4Jaoz2aevap6R3I942/PQHXYb7EZdI+oLbTUOCNp7dqFcGFqpR//sWrIguCiD7jdej560dBOBM7gT+603psApKXShD1wSoIUH+1MF9OYSCZtCFg3G6MzQq8dp5KoOJngAwuDj6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ptdDFX6O; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ptdDFX6O"
X-KPN-MessageId: 30a7dfa0-73d0-11f1-a59f-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 30a7dfa0-73d0-11f1-a59f-005056994fde;
	Mon, 29 Jun 2026 17:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=oagfIm4xPQIxQdDp0zlFn353IxoDjLawSLkCpeCgjXc=;
	b=ptdDFX6O5v3/2JpMcU2dv+0EUQWrB8FufG6KFX1rzAOl1/hXQm1Pq3EplVnMGZu7/N3QEIokx1uXW
	 wiueBldNJq3HQYR7iaJNM7sUSL4BbPGtE57G9zUjBFOjYFJeSTnCtNEGXuXjpovMvxPscsNSiZIA+v
	 urh4YSEzeDz7/FEbu8DZFtXTt5lUsEpxC1sfvJFBsQuFimQ3aaquf+Plcbipye7wHP5KS2Sv4b8UD+
	 FwhqbyZ+qZbqbH6cqZ90TT8sCkrgEAqHgdBkeJOO8LOz8hdu9BrnKYiX5vJdyhhsBtPzXSPzMP61ES
	 ib+KiSsG/FgPersyuJmPsLUDAlP1z6Q==
X-KPN-MID: 33|lStetxaxPvxJfh9u+ONYiIpC4NI/TFHj35vAgRvQne6lCaRi4grNu+hwMSLCnCX
 Us+5QZQ3aBf3YYtKZ/gkul1gaz7BlV6WZbbMOnXtWU3E=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|YDOjyGWtnie33rzG2jj4iOEv61s2wUJ38J6A6UX6aldxfNOyCDFvSAcBaCzjXkS
 aDizJZE9sez3b9KyjmUad7g==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 306bd8b3-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:43 +0200 (CEST)
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
Subject: [PATCH v2 01/14] fs/namei.c: use trailing_slashes()
Date: Mon, 29 Jun 2026 17:36:17 +0200
Message-ID: <20260629153630.2158649-2-jkoolstra@xs4all.nl>
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

There are several places in fs/namei.c that can use the
trailing_slashes() function to improve intent.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5cc9f0f466b8..98f9d788cbe5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2781,9 +2781,14 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	return s;
 }
 
+static inline bool trailing_slashes(const struct qstr last)
+{
+	return (bool)last.name[last.len];
+}
+
 static inline const char *lookup_last(struct nameidata *nd)
 {
-	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
+	if (nd->last_type == LAST_NORM && trailing_slashes(nd->last))
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	return walk_component(nd, WALK_TRAILING);
@@ -4521,17 +4526,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	return ERR_PTR(error);
 }
 
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
+		if (trailing_slashes(nd->last))
 			return ERR_PTR(-EISDIR);
 
 		/* Don't bother on an O_EXCL create */
@@ -4539,7 +4539,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 			return NULL;
 	}
 
-	if (trailing_slashes(nd))
+	if (trailing_slashes(nd->last))
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	dentry = lookup_fast(nd);
@@ -4946,7 +4946,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
 	 */
-	if (last.name[last.len] && !want_dir)
+	if (trailing_slashes(last) && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
 	dentry = start_dirop(path->dentry, &last, reval_flag | create_flags);
 	if (IS_ERR(dentry))
@@ -5565,7 +5565,7 @@ int filename_unlinkat(int dfd, struct filename *name)
 		goto exit_drop_write;
 
 	/* Why not before? Because we want correct error value */
-	if (unlikely(last.name[last.len])) {
+	if (unlikely(trailing_slashes(last))) {
 		if (d_is_dir(dentry))
 			error = -EISDIR;
 		else
@@ -6167,16 +6167,16 @@ int filename_renameat2(int olddfd, struct filename *from,
 	if (flags & RENAME_EXCHANGE) {
 		if (!d_is_dir(rd.new_dentry)) {
 			error = -ENOTDIR;
-			if (new_last.name[new_last.len])
+			if (trailing_slashes(new_last))
 				goto exit_unlock;
 		}
 	}
 	/* unless the source is a directory trailing slashes give -ENOTDIR */
 	if (!d_is_dir(rd.old_dentry)) {
 		error = -ENOTDIR;
-		if (old_last.name[old_last.len])
+		if (trailing_slashes(old_last))
 			goto exit_unlock;
-		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
+		if (!(flags & RENAME_EXCHANGE) && trailing_slashes(new_last))
 			goto exit_unlock;
 	}
 
-- 
2.54.0

