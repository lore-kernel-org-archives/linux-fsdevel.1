Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3D83C4559
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245836; cv=none; b=dQ6FejiEnTI5rsVuk6flY6ZPmqc92EH8GpJqp8Vz2XDjfwNZc4kInZ7kV1FK1heyjnlL7uKKiAft/4ztpPdR3nVhgZTOcgc0yuCeCrcParMByEB1xnb3L5Urtmmeg+brHhillDvg/9UNeJ0k14DnkLjMe0dql9WiRKs3cCoB9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245836; c=relaxed/simple;
	bh=AN30mHDzNXJWM5zKx0aado22O86W+ia9ybrhyOme6R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK3M1C34g/hGFYciB4+sz2DVobxkIuF66NfTYxPxsWx70EnQDMAHI2RiQD3mxHNipPXv+Ilf2OVZShVfcNn/dr76D60LIbZJ0yOT1DA4kvgMkkne1+YCaKikmAcGcb4eVTMCTenwKlzBAMka8SoDYaTtQfWD3wIslBPRsRAeRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cOeCg6jU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cOeCg6jU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1TkBgV22nKm0CALEBVUz4w1fgFVQ+izGjR6IZ+xTjuc=; b=cOeCg6jUOzrzDJD/BnCLorJmGO
	xJeXE3EExl6d/FbGUP/njRi010hxFwQUecTpTFrN+5G3WtAx3Yqp+gfk7M8L/ItRHeNZon5wMKOKM
	4zDPwM62ajoFP9enY7f1OW4sZuVZ7GoXyMWih+WinASYqiWslxiCDrTiiINTZWFFy2nTC2CqxS8hd
	r9VjL0MlldCQDOOcDz+haJlzg1uImb9p0q7zWgYv4C9/qezxWttRZQFhaXLUCXkHXDWJ/gKOfAQxd
	PKIBBnRZMjbXpsPxnXwAGJK+LE8qC8cPWXF45Wp45OCY0BRXD3ancM17yeatN17JOl31hyWUDVh1n
	sufxIDuw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8kam-00000009cFv-0VtB;
	Fri, 03 Apr 2026 19:54:08 +0000
Date: Fri, 3 Apr 2026 20:54:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sungjong Seo <sj1557.seo@samsung.com>
Cc: 'Namjae Jeon' <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org,
	sjdev.seo@gmail.com
Subject: Re: [RFC] weird stuff in exfat_lookup()
Message-ID: <20260403195408.GM3836593@ZenIV>
References: <20250227224826.GG2023217@ZenIV>
 <CAKYAXd_-v601SX44WZ970LyZjsCH3L3HFjJXxZH960r1PXo+Bw@mail.gmail.com>
 <CGME20250228160332epcas1p2b177def4195cedc4c122a5f09bb29d2a@epcas1p2.samsung.com>
 <394ca686-a45a-e71c-bc45-33794463b5fc@samsung.com>
 <29a2901db9414$fcacee50$f606caf0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29a2901db9414$fcacee50$f606caf0$@samsung.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

[with apologies for very late reply]

On Thu, Mar 13, 2025 at 09:39:39PM +0900, Sungjong Seo wrote:
> - thread1: while(1) { mkdir(A) and rmdir(A) }
> - thread2: while(1) { stat(A) }
> 
> This is due to the characteristics of exfat allowing negative dentry and
> considering CI in d_revalidate. As mentioned in the comment,
> unhashed-positive dentry can exist in a situation where mkdir
> and stat are competing, and it can be dropped, but exfat_lookup has
> been implemented to reuse(rehash) this dentry.

That's an interesting scenario, but I still don't see why would we bother.

Note that in your example we don't need to even look for aliases - it's
a directory inode, so d_splice_alias() would do the right thing, no matter
what.  And for non-directories you
	* already have d_move(alias, dentry) there, which would do the right
thing as well and
	* won't get an unhashed alias from d_find_alias() to start with.

Frankly, I would skip the entire "look for aliases" thing in case of
directory inodes - just let d_splice_alias() handle it.  That has
another fun benefit - exfat_d_anon_disconn() check becomes completely
pointless.  By the time we call it we have already verified that
alias->d_parent == dentry->d_parent, so the only way to get
exfat_d_anon_disconn(alias) to be true is to have IS_ROOT(alias),
i.e. alias->d_parent == alias and thus alias == dentry->d_parent
and at the very least the inode is a directory one.  We obvously
want to have it fail with -ELOOP in such case and d_splice_alias()
does just that, so if we bypass the entire "look for an alias"
thing for directories, the check becomes identical to
	if (alias && alias->d_parent == dentry->d_parent)
since the last term in the current variant (!exfat_d_anon_disconn(...))
can be dropped, along with the helper itself.

Does anybody have a problem with patch below?

[PATCH] simplify exfat_lookup()

1) d_splice_alias() handles ERR_PTR() for inode just fine
2) no need to even look for existing aliases in case of directory inodes;
just punt to d_splice_alias(), it'll do the right thing
3) no need to bother with 'd_unhashed(alias)' case - d_find_alias()
would've returned that only in case of a directory, and d_splice_alias()
will handle that just fine on its own.
4) exfat_d_anon_disconn() is entirely pointless now - we only get to
evaluating it in case dentry->d_parent == alias->d_parent and
alias being a non-directory.  But in that case IS_ROOT(alias) can't
possibly be true - that would've reqiured alias == alias->d_parent,
i.e alias == dentry->d_parent and dentry->d_parent is guaranteed to
be a directory.  So exfat_d_anon_disconn() would always return false
when it's called, which makes && !exfat_d_anon_disconn(alias)
a no-op.
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 670116ae9ec8..8fac39f2bcb3 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -711,71 +711,44 @@ static int exfat_find(struct inode *dir, const struct qstr *qname,
 	return 0;
 }
 
-static int exfat_d_anon_disconn(struct dentry *dentry)
-{
-	return IS_ROOT(dentry) && (dentry->d_flags & DCACHE_DISCONNECTED);
-}
-
 static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 		unsigned int flags)
 {
 	struct super_block *sb = dir->i_sb;
-	struct inode *inode;
+	struct inode *inode = NULL;
 	struct dentry *alias;
 	struct exfat_dir_entry info;
 	int err;
 	loff_t i_pos;
-	mode_t i_mode;
 
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
 	err = exfat_find(dir, &dentry->d_name, &info);
 	if (err) {
-		if (err == -ENOENT) {
-			inode = NULL;
-			goto out;
-		}
-		goto unlock;
+		if (unlikely(err != -ENOENT))
+			inode = ERR_PTR(err);
+		goto out;
 	}
 
 	i_pos = exfat_make_i_pos(&info);
 	inode = exfat_build_inode(sb, &info, i_pos);
-	err = PTR_ERR_OR_ZERO(inode);
-	if (err)
-		goto unlock;
+	if (IS_ERR(inode) || S_ISDIR(inode->i_mode))
+		goto out;
 
-	i_mode = inode->i_mode;
 	alias = d_find_alias(inode);
 
 	/*
 	 * Checking "alias->d_parent == dentry->d_parent" to make sure
 	 * FS is not corrupted (especially double linked dir).
 	 */
-	if (alias && alias->d_parent == dentry->d_parent &&
-			!exfat_d_anon_disconn(alias)) {
-
+	if (alias && alias->d_parent == dentry->d_parent) {
 		/*
-		 * Unhashed alias is able to exist because of revalidate()
-		 * called by lookup_fast. You can easily make this status
-		 * by calling create and lookup concurrently
-		 * In such case, we reuse an alias instead of new dentry
+		 * This inode has non anonymous-DCACHE_DISCONNECTED
+		 * dentry. This means, the user did ->lookup() by an
+		 * another name (longname vs 8.3 alias of it) in past.
+		 *
+		 * Switch to new one for reason of locality if possible.
 		 */
-		if (d_unhashed(alias)) {
-			WARN_ON(alias->d_name.hash_len !=
-				dentry->d_name.hash_len);
-			exfat_info(sb, "rehashed a dentry(%p) in read lookup",
-				   alias);
-			d_drop(dentry);
-			d_rehash(alias);
-		} else if (!S_ISDIR(i_mode)) {
-			/*
-			 * This inode has non anonymous-DCACHE_DISCONNECTED
-			 * dentry. This means, the user did ->lookup() by an
-			 * another name (longname vs 8.3 alias of it) in past.
-			 *
-			 * Switch to new one for reason of locality if possible.
-			 */
-			d_move(alias, dentry);
-		}
+		d_move(alias, dentry);
 		iput(inode);
 		mutex_unlock(&EXFAT_SB(sb)->s_lock);
 		return alias;
@@ -787,9 +760,6 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 		exfat_d_version_set(dentry, inode_query_iversion(dir));
 
 	return d_splice_alias(inode, dentry);
-unlock:
-	mutex_unlock(&EXFAT_SB(sb)->s_lock);
-	return ERR_PTR(err);
 }
 
 /* remove an entry, BUT don't truncate */
