Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0A30F7FA
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455492; cv=none; b=cT9998tpGykpJ9X26J9xdBITRrLqTWZBUPd6ttccPk3+1/69SyHSr0lDihoR8ISvZY8L0BuFXvrMVV8+9GMWgneD9vCEG3vr9xvJhcqOyjr36xAco8Svz3KTe8dH+kGAVLnmYn2h3/ky39fN+SEL/rCzyIb6xJXNPaagz2pcSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455492; c=relaxed/simple;
	bh=onyf9aEihXpXSsiEtpNg+LiziC9SWA2l0l5dplawHpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSdXlAHL8MmmrdpNuIWHwty/vfQ/o6hGI8+o9leBnumUV9hII5Uu9+V72/pwgmQa7olRYbrIZqMvCDryUXWpIqTn7PMDrMeZph98gIgiJf3F2yk/pYnEKpL50ZRdcRUIwMWSd6lBuHNzyFTW8Uzf0orFC/ZZHHKRN9Hjfdjngo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=epNwih4o; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="epNwih4o"
X-KPN-MessageId: 34092014-6810-11f1-92b5-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 34092014-6810-11f1-92b5-005056aba152;
	Sun, 14 Jun 2026 18:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=DG1IiBWFjIJ75UBMLvL/cnZQMSKo0Zre66RfjqhVblU=;
	b=epNwih4oqCDHpiXuON2fQ8AMf4Pyp+6uu3w7pbOGmyASXgzvcve70RdLOHkb0hvyO/a67oOI235rr
	 0v/bvqeZGpLEp4z2AidLFrdCxHwbpR1ih9O1ffBqcn9O/E99uTgnQvvrFKfqtqiqXw4S98AeLYyaUr
	 FtjkmusNvZ34Fy1Y++2WLjHSDZwjCECwVtmaExht4Vc3v5zodaBg+aSwRwFE7xrhzWYrQ91zeuHhNX
	 Km4f2vSME5bC4lrlWB8qzo+16P+NnDrRaZKBl+6JzlxilO0SRUqkmr2KNkvXJOc378CVMERsP70Tzd
	 ZJwjUk/WmwOm9ZMUpMs8JAGhL3a1arw==
X-KPN-MID: 33|vgtFzhxoUreWlpojy6wBptf/lZkUfnzwkZ0jMfIzmrXHSuJ5l1c9DdG5NBXJDR+
 Rz8Fo4kD10WwZoTD7BLm/Q3RUYx/+Q6Deztp2a9yivLk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|53uXjA1J+fYVWu2NLvwVxd/VPmfie8tisUh+eFzLgM4x/d4s3z7uGavedbVO0ed
 7Mtsc/vbJfe9VNfATeOzCuA==
Received: from daedalus.home (unknown [178.230.193.94])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 33d5e724-6810-11f1-8011-005056ab7447;
	Sun, 14 Jun 2026 18:43:42 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 01/12] fs/namei.c: use trailing_slashes()
Date: Sun, 14 Jun 2026 18:44:27 +0200
Message-ID: <20260614164438.2980769-2-jkoolstra@xs4all.nl>
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

There are several places in fs/namei.c that can use the
trailing_slashes() function to improve intent.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4787244ca4a7..64b91ed9efb7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2777,9 +2777,14 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
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
@@ -4524,17 +4529,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
@@ -4542,7 +4542,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 			return NULL;
 	}
 
-	if (trailing_slashes(nd))
+	if (trailing_slashes(nd->last))
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	dentry = lookup_fast(nd);
@@ -4945,7 +4945,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
 	 */
-	if (last.name[last.len] && !want_dir)
+	if (trailing_slashes(last) && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
 	dentry = start_dirop(path->dentry, &last, reval_flag | create_flags);
 	if (IS_ERR(dentry))
@@ -5562,7 +5562,7 @@ int filename_unlinkat(int dfd, struct filename *name)
 		goto exit_drop_write;
 
 	/* Why not before? Because we want correct error value */
-	if (unlikely(last.name[last.len])) {
+	if (unlikely(trailing_slashes(last))) {
 		if (d_is_dir(dentry))
 			error = -EISDIR;
 		else
@@ -6161,16 +6161,16 @@ int filename_renameat2(int olddfd, struct filename *from,
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

