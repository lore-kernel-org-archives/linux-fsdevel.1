Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BA372EE3
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183281; cv=none; b=kC1FgqwZdDUR9x6sxxoyDUpQJm3QDpUagIss9DSnqrt47FKs2vLN7wsbulsW6IHgYz+XBYoh66f5TD9WOdLmttj+QPnqrV9Aig2jJWCe3UyoOCIlzemI++dcdKsXUU88QPvAzi1TniwfXSGVOOeeHIvXyYKQCKJdEysEljYwe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183281; c=relaxed/simple;
	bh=NU71MByyrmLCm9wNzZEVqBW5nxKkAQQAxQYlce8eSxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qt/OPmHhI+zWKYAlygW2sC/fEJUJvkKwwBwJ+2BPrKNFAEnZFH+Z5G33FIA2wA9b2X7Bl4emcs9INJN3XSkPAvOaNjQ+LV6HjS9aPqLnP6NRV7cPAcqfTzZKBZ4NEtfTb7CeATzRh1/F4i25Dj7jzfurRby66b8m0vwT+HhYw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ThqT/Wa2; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ThqT/Wa2"
X-KPN-MessageId: 27ed4e0f-77c7-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 27ed4e0f-77c7-11f1-b2a8-005056abbe64;
	Sat, 04 Jul 2026 18:41:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=J1MPw7M4TP0cx2KZqlK96OWfzBhLyzBYB+ov8glzooU=;
	b=ThqT/Wa2CCHaHaXyeQiqp5/d4Z/7MVCkzVQyHTbnMR0CpQtaxmpPwONL+19hltyXNhztcerxORNZu
	 teyUbJQ1jufuTuuiUQolVhfTRr18gRfwn6S4Gl48MsOpPf1YTv0dQQo5SX3ILw7f3OHm+IB9MI7m+x
	 dZkUMvN9AGZW1wGQYWsnIL6LLA6lO8k38bco5lVcBHZr5wlbpo5b93M47qP8kuJlPdu8c2ifuzKNzq
	 XY2SwgNCoPemAM7VEPk6bPOivMpY67OuDdwzHqTqxB9mAaNZX0jmRdA1QlSg/5DxD3kzs51AyVWCHZ
	 bu6Y9zLphl4AVvNsJwdZgH1BUt3RBUg==
X-KPN-MID: 33|EBT+rJpq5AxSEInYbC+DW0bYJlanJia9tVMyotH848I+QhL5xc3og8ilzF5B6d7
 OcJpwbaRfb5mlqtAKo7ZJ0/pNVF3sAKo9xtjtzRgNCNA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|sQB56BN8R1fCVMaSguLylh16WQ0xxnerhBtm/cXsNaKmuck2f/HNqAx3Q/yVyzZ
 ldIW/kk6sQJHl4UCi2EG1sw==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 27acbfdd-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:07 +0200 (CEST)
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
Subject: [PATCH v3 01/14] fs/namei.c: use trailing_slashes()
Date: Sat,  4 Jul 2026 18:41:35 +0200
Message-ID: <20260704164149.3480051-2-jkoolstra@xs4all.nl>
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

There are several places in fs/namei.c that can use the
trailing_slashes() function to improve intent.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 19ce43c9a6e6..a8890bc0ae21 100644
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
@@ -4950,7 +4950,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
 	 */
-	if (last.name[last.len] && !want_dir)
+	if (trailing_slashes(last) && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
 	dentry = start_dirop(path->dentry, &last, reval_flag | create_flags);
 	if (IS_ERR(dentry))
@@ -5569,7 +5569,7 @@ int filename_unlinkat(int dfd, struct filename *name)
 		goto exit_drop_write;
 
 	/* Why not before? Because we want correct error value */
-	if (unlikely(last.name[last.len])) {
+	if (unlikely(trailing_slashes(last))) {
 		if (d_is_dir(dentry))
 			error = -EISDIR;
 		else
@@ -6171,16 +6171,16 @@ int filename_renameat2(int olddfd, struct filename *from,
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
2.55.0

