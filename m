Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE62D33F5B3
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878900; cv=none; b=D3c0JjXgwkq4Y3J1u6xkNNw/rF9T5DsKnwtDKKOBOQSyQpx6QcPDNw4bFwI+X5DpIvGq3QV7Al3tA3CiGbRzfw8RfEUtkANnmL4FvwXcSQvlefiJyDUhdro4IPK8YeNkjanEBfJ8FvNcUn7wMjRc4GZxXmhtGf6LY+F2p0pmTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878900; c=relaxed/simple;
	bh=QNix6x/aQRh9lHJssv2ffhUtsBhRUkfQnO7F7MOscPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbHe8ApyXVoK8xSQbFcIFLwlsEG0bLOORa9GrvHTo+FWcFFTOtGYWbD0JzJ/uWjoeo6gAPA3BDwG1UWRs5UR7TrZQuPvz7nJun1wFbkYE1bql05CAef5tvwsog6uTsnLKE3nzAjejlmE5kFzx7PKUUyKGY1SlFnNedCsKy0unqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=nkPQW3yA; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="nkPQW3yA"
X-KPN-MessageId: c9007a25-7e1a-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c9007a25-7e1a-11f1-bfba-00505699b430;
	Sun, 12 Jul 2026 19:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=xrGpWzjKvcPVKevloUJ26DMlZ0X9lAKe5tg9ZytSdII=;
	b=nkPQW3yAZc6AS97TkvBcB4KZgtLGYrLb/itcl8P6Ub3hVN+dfBdWEATxYwE711KlUDA+o2HvMBfn9
	 QqV9ZzL1p4uGvNB7dkmkOHVqnASs5OneM23rphMiZcgr82kNcXgAHEYmBMcJ+0RV0UiGtf5ckzkeKa
	 qZRK9rrEMa3cT7nYqiCftmRBMYfZSiSfQZM+uN8mfP7VaLUzrgaIxsv33qjT+UMsx/wYT4M5oj02UF
	 fu2KiOy6v5MIRydOX3tA4MpzmcGjUX/lDdPImPSQxGVA7T5FWEM+KDN9Zqww/iyeO+EtlMT8EjoKtC
	 fCwmsU8zG2ayvdtWxHRRM2EilsyVzjw==
X-KPN-MID: 33|iELg2BFSGX7rwGyk0hxQWuzea0zBycv+QKlWqk3UBd5nTdAff/XzsJAkoq5revs
 Bg7d1Ijou3jB1LVeSer1sMW3Ax+iM8BIpTOpe7kZM8Ek=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xF9sWC18cYw1wRXNzooeY1jNerzWcqf+rvaaoZad2v1GgBuo5dcn1t9JiqQsyip
 3RWaFxKU94qbhiJRcDpREWQ==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c8c0fa6d-7e1a-11f1-87f7-00505699b758;
	Sun, 12 Jul 2026 19:54:53 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 01/10] fs/namei.c: use trailing_slashes()
Date: Sun, 12 Jul 2026 19:55:30 +0200
Message-ID: <20260712175539.1565444-2-jkoolstra@xs4all.nl>
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
index 19ce43c9a6e6..93e7d3e9bcb4 100644
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
@@ -4521,17 +4528,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
+		if (trailing_slashes(&nd->last))
 			return ERR_PTR(-EISDIR);
 
 		/* Don't bother on an O_EXCL create */
@@ -4539,7 +4541,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 			return NULL;
 	}
 
-	if (trailing_slashes(nd))
+	if (trailing_slashes(&nd->last))
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	dentry = lookup_fast(nd);
@@ -4950,7 +4952,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
 	 */
-	if (last.name[last.len] && !want_dir)
+	if (trailing_slashes(&last) && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
 	dentry = start_dirop(path->dentry, &last, reval_flag | create_flags);
 	if (IS_ERR(dentry))
@@ -5569,7 +5571,7 @@ int filename_unlinkat(int dfd, struct filename *name)
 		goto exit_drop_write;
 
 	/* Why not before? Because we want correct error value */
-	if (unlikely(last.name[last.len])) {
+	if (unlikely(trailing_slashes(&last))) {
 		if (d_is_dir(dentry))
 			error = -EISDIR;
 		else
@@ -6171,16 +6173,16 @@ int filename_renameat2(int olddfd, struct filename *from,
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

