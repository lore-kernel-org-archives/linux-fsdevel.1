Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C42FFF8D
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014598; cv=none; b=VVGORzcVmJCsAryOo7l/TmZSUYoNijAbRNgt2u3ZDlABnKQCH4oVJWwFr7oVQK3YEMWojNyAaxyyGCSyNvdZMAlZph/xrtg4w0Oc5RGdXkpGPvzsV88B50QNiUxLlMDKIF8sczm40nyzRF2UySwVmSqUd3HaJ9QdLivnUaIEVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014598; c=relaxed/simple;
	bh=eEHUCBNB/FycCyuqsdYI9Zgu7Oul0+beHly87DVBPGU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Lj3vqS0xrjs0AgD73Y1lWASLSNrJk1gQrkhfGazb+kE+p/6HP1r0oWn3V8ox5FasFB61VhzCLPFpGAVcIIiF4wF/idCOkeB4revfRGVV9htizcbJFleIfS/S/5ssX+ZmQ3sOG30vRGPpbcK9TVJYY4c9z6XVZG3u0wjd1C8AzHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NWecFLkM; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NWecFLkM"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260424070946epoutp01cba6e296dd0806ee0cfaca976a7e94e6~pOVn3DPkh0568505685epoutp01Q
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 07:09:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260424070946epoutp01cba6e296dd0806ee0cfaca976a7e94e6~pOVn3DPkh0568505685epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777014586;
	bh=YnKL+SiDAqnKZfULUW5kTyB2WwUoXJhZZlDSjiyPb14=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=NWecFLkMeTviQGe8Rl4V32iMq7QJJPANYENmPSKP03oprfGeKgyyUJLhHcCVsOOWk
	 mb05FYqCwj+08P6e+UusNoWmwXz9qKSR0aHK4GEw8t7eGgBJW2CEGV0Ltlq4rx/QXR
	 gAqOCpCUGVLZy5PJ3y9gFCCwk8TFqfFtN2RxWK2Y=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20260424070946epcas1p1895e845d96113d40c8b5a455bea67c80~pOVnmEQN70564105641epcas1p1U;
	Fri, 24 Apr 2026 07:09:46 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.195]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4g23xQ0Gptz2SSKj; Fri, 24 Apr
	2026 07:09:46 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20260424070945epcas1p39e7844d6355c6048a27c38083e55f6a0~pOVm5-H8v0160301603epcas1p3O;
	Fri, 24 Apr 2026 07:09:45 +0000 (GMT)
Received: from W11PB11713 (unknown [10.91.160.69]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260424070945epsmtip26b17c65bffc8aed090cf02c9094a8dbf~pOVm206921803118031epsmtip2R;
	Fri, 24 Apr 2026 07:09:45 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Al Viro'" <viro@zeniv.linux.org.uk>
Cc: "'Namjae Jeon'" <linkinjeon@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <sjdev.seo@gmail.com>, <cpgs@samsung.com>,
	<sj1557.seo@samsung.com>, <sjdev.seo@gmail.com>
In-Reply-To: 
Subject: RE: [RFC] weird stuff in exfat_lookup()
Date: Fri, 24 Apr 2026 16:09:45 +0900
Message-ID: <21c1e01dcd3b9$546fb610$fd4f2230$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHvIU014N/xpMzfEtxh/QSbUZFfYAGOig5MAmhErlICcjrXqwInKJ+WAjN46ze1YYRmIIARje8g
Content-Language: ko
X-CMS-MailID: 20260424070945epcas1p39e7844d6355c6048a27c38083e55f6a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-711,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250228160332epcas1p2b177def4195cedc4c122a5f09bb29d2a
References: <20250227224826.GG2023217@ZenIV>
	<CAKYAXd_-v601SX44WZ970LyZjsCH3L3HFjJXxZH960r1PXo+Bw@mail.gmail.com>
	<CGME20250228160332epcas1p2b177def4195cedc4c122a5f09bb29d2a@epcas1p2.samsung.com>
	<394ca686-a45a-e71c-bc45-33794463b5fc@samsung.com>
	<29a2901db9414$fcacee50$f606caf0$@samsung.com>
	<20260403195408.GM3836593@ZenIV> 

Hi!
> > [with apologies for very late reply]
> That's okay, no problem.
> 
> >
> > On Thu, Mar 13, 2025 at 09:39:39PM +0900, Sungjong Seo wrote:
> > > - thread1: while(1) { mkdir(A) and rmdir(A) }
> > > - thread2: while(1) { stat(A) }
> > >
> > > This is due to the characteristics of exfat allowing negative dentry
> > > and considering CI in d_revalidate. As mentioned in the comment,
> > > unhashed-positive dentry can exist in a situation where mkdir and
> > > stat are competing, and it can be dropped, but exfat_lookup has been
> > > implemented to reuse(rehash) this dentry.
> >
> > That's an interesting scenario, but I still don't see why would we
> bother.
> >
> > Note that in your example we don't need to even look for aliases -
> > it's a directory inode, so d_splice_alias() would do the right thing,
> > no matter what.  And for non-directories you
> > 	* already have d_move(alias, dentry) there, which would do the
> right
> > thing as well and
> > 	* won't get an unhashed alias from d_find_alias() to start with.
> >
> > Frankly, I would skip the entire "look for aliases" thing in case of
> > directory inodes - just let d_splice_alias() handle it.  That has
> > another fun benefit - exfat_d_anon_disconn() check becomes completely
> > pointless.  By the time we call it we have already verified that
> > alias->d_parent == dentry->d_parent, so the only way to get
> > exfat_d_anon_disconn(alias) to be true is to have IS_ROOT(alias), i.e.
> > alias->d_parent == alias and thus alias == dentry->d_parent and at the
> > very least the inode is a directory one.  We obvously want to have it
> > fail with -ELOOP in such case and d_splice_alias() does just that, so
> > if we bypass the entire "look for an alias"
> > thing for directories, the check becomes identical to
> > 	if (alias && alias->d_parent == dentry->d_parent) since the last
> term
> > in the current variant (!exfat_d_anon_disconn(...)) can be dropped,
> > along with the helper itself.
> >
> > Does anybody have a problem with patch below?
> 
> Seems right!
> In fact, exFAT does not support symlinks, shortname aliases, or
export_ops.
> So, all it has to do here is handle case insensitivity for the same name.
> Later, it seems we might also need to check the exfat_d_revalidate().
> 
> I greatly appreciate your meticulous review of the exFAT lookup operation
> and the patches you provided. I will check if there are any issues with
> the existing scenario along with the patch review. However, I am currently
> super busy with my main job, so it would take some time.
> 
> Thanks!
> 
> >
> > [PATCH] simplify exfat_lookup()
> >
> > 1) d_splice_alias() handles ERR_PTR() for inode just fine
> > 2) no need to even look for existing aliases in case of directory
> > inodes; just punt to d_splice_alias(), it'll do the right thing
> > 3) no need to bother with 'd_unhashed(alias)' case - d_find_alias()
> > would've returned that only in case of a directory, and
> > d_splice_alias() will handle that just fine on its own.
> > 4) exfat_d_anon_disconn() is entirely pointless now - we only get to
> > evaluating it in case dentry->d_parent == alias->d_parent and alias
> > being a non-directory.  But in that case IS_ROOT(alias) can't possibly
> > be true - that would've reqiured alias == alias->d_parent, i.e alias
> > == dentry->d_parent and dentry->d_parent is guaranteed to be a
> > directory.  So exfat_d_anon_disconn() would always return false when
> > it's called, which makes && !exfat_d_anon_disconn(alias) a no-op.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

The patch looks good to me and seems to be working as intended.
Thank you for your efforts!

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> > ---
> > diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c index
> > 670116ae9ec8..8fac39f2bcb3 100644
> > --- a/fs/exfat/namei.c
> > +++ b/fs/exfat/namei.c
> > @@ -711,71 +711,44 @@ static int exfat_find(struct inode *dir, const
> > struct qstr *qname,
> >  	return 0;
> >  }
> >
> > -static int exfat_d_anon_disconn(struct dentry *dentry) -{
> > -	return IS_ROOT(dentry) && (dentry->d_flags & DCACHE_DISCONNECTED);
> > -}
> > -
> >  static struct dentry *exfat_lookup(struct inode *dir, struct dentry
> > *dentry,
> >  		unsigned int flags)
> >  {
> >  	struct super_block *sb = dir->i_sb;
> > -	struct inode *inode;
> > +	struct inode *inode = NULL;
> >  	struct dentry *alias;
> >  	struct exfat_dir_entry info;
> >  	int err;
> >  	loff_t i_pos;
> > -	mode_t i_mode;
> >
> >  	mutex_lock(&EXFAT_SB(sb)->s_lock);
> >  	err = exfat_find(dir, &dentry->d_name, &info);
> >  	if (err) {
> > -		if (err == -ENOENT) {
> > -			inode = NULL;
> > -			goto out;
> > -		}
> > -		goto unlock;
> > +		if (unlikely(err != -ENOENT))
> > +			inode = ERR_PTR(err);
> > +		goto out;
> >  	}
> >
> >  	i_pos = exfat_make_i_pos(&info);
> >  	inode = exfat_build_inode(sb, &info, i_pos);
> > -	err = PTR_ERR_OR_ZERO(inode);
> > -	if (err)
> > -		goto unlock;
> > +	if (IS_ERR(inode) || S_ISDIR(inode->i_mode))
> > +		goto out;
> >
> > -	i_mode = inode->i_mode;
> >  	alias = d_find_alias(inode);
> >
> >  	/*
> >  	 * Checking "alias->d_parent == dentry->d_parent" to make sure
> >  	 * FS is not corrupted (especially double linked dir).
> >  	 */
> > -	if (alias && alias->d_parent == dentry->d_parent &&
> > -			!exfat_d_anon_disconn(alias)) {
> > -
> > +	if (alias && alias->d_parent == dentry->d_parent) {
> >  		/*
> > -		 * Unhashed alias is able to exist because of revalidate()
> > -		 * called by lookup_fast. You can easily make this status
> > -		 * by calling create and lookup concurrently
> > -		 * In such case, we reuse an alias instead of new dentry
> > +		 * This inode has non anonymous-DCACHE_DISCONNECTED
> > +		 * dentry. This means, the user did ->lookup() by an
> > +		 * another name (longname vs 8.3 alias of it) in past.
> > +		 *
> > +		 * Switch to new one for reason of locality if possible.
> >  		 */
> > -		if (d_unhashed(alias)) {
> > -			WARN_ON(alias->d_name.hash_len !=
> > -				dentry->d_name.hash_len);
> > -			exfat_info(sb, "rehashed a dentry(%p) in read
lookup",
> > -				   alias);
> > -			d_drop(dentry);
> > -			d_rehash(alias);
> > -		} else if (!S_ISDIR(i_mode)) {
> > -			/*
> > -			 * This inode has non anonymous-DCACHE_DISCONNECTED
> > -			 * dentry. This means, the user did ->lookup() by an
> > -			 * another name (longname vs 8.3 alias of it) in
past.
> > -			 *
> > -			 * Switch to new one for reason of locality if
> > possible.
> > -			 */
> > -			d_move(alias, dentry);
> > -		}
> > +		d_move(alias, dentry);
> >  		iput(inode);
> >  		mutex_unlock(&EXFAT_SB(sb)->s_lock);
> >  		return alias;
> > @@ -787,9 +760,6 @@ static struct dentry *exfat_lookup(struct inode
> > *dir, struct dentry *dentry,
> >  		exfat_d_version_set(dentry, inode_query_iversion(dir));
> >
> >  	return d_splice_alias(inode, dentry);
> > -unlock:
> > -	mutex_unlock(&EXFAT_SB(sb)->s_lock);
> > -	return ERR_PTR(err);
> >  }
> >
> >  /* remove an entry, BUT don't truncate */

