Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D937BE8A;
	Thu, 26 Mar 2026 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535177; cv=none; b=TonDPaj3kc+onToQermP48TOrEGi57GGeqYJ6Dg6ormiBHwbF5X2YdsyJ5C9vN+O1vceg3dG5MSDpt1Yvrbqr0VNgP/qeUb5H+lPuPTByezchgWsNIBjA9YBuDCGsu/zb/hVyYTQ4vXLiW3r7VgAkN4drtnPpHKmS2Tqo82F5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535177; c=relaxed/simple;
	bh=FDUjIkRcjKBBWY3/e5wpyBytSdBUm6v7MOjojeM7T5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPFyq9UsmgQ0ydNoGs9q/P+earNkfm/IV39ossPMg8teIyiCLuEMf9SiY43UPPxhs476qCVnEqWSUg3DAAD3mXTAF8BtsiXRVWl4sE0IuO7d8y2Y4UpPI5dG2TX27jIWAB61QQkpRUZ429vKtRouFaPQTo5fJP93DCRT4SNc5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGyWENwK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGyWENwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E12C19423;
	Thu, 26 Mar 2026 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774535177;
	bh=FDUjIkRcjKBBWY3/e5wpyBytSdBUm6v7MOjojeM7T5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGyWENwKSZ4GDxcpr0QNbGmkhfX5RFJhiVCPTboRE2P6jN08M2CKmdqSs6azHSevk
	 b+o6VmV8QHsbkv5s/p1zEeCGQk6AaCBk+2Y8gs1SW7mzXDH4FJFJk/ingGUsr7Dm16
	 BieyCy0sIHWZhANvBqrSKTb2Bg0UYDnPlALTde9f+GjYRWvYB31ansx9GpItNK/TjD
	 nE3QcmAzdq6N8z4DiFQg8MJStYpSnhUR2t3pUDaFpqobmaoeeEwLOBdtbc16oUf5XH
	 3tGnmkIcG+oI+lkM7V9hdRztKyRDAU2vOhikd1xS/ONy2s0M9M+Kt0APxhmHp6rjKs
	 TnL+MrcSlHwfA==
Date: Thu, 26 Mar 2026 15:26:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH] fuse: fix inode initialization race
Message-ID: <20260326-reorganisation-bemessen-c6643edcf629@brauner>
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com>

On Wed, Mar 25, 2026 at 08:54:57AM +0100, Bernd Schubert wrote:
> 
> 
> On 3/18/26 14:43, Horst Birthelmer wrote:
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> > 
> > Fix a race between fuse_iget() and fuse_reverse_inval_inode() where
> > invalidation can arrive while an inode is being initialized, causing
> > the invalidation to be lost.
> > 
> > Add a waitqueue to make fuse_reverse_inval_inode() wait when it
> > encounters an inode with attr_version == 0 (still initializing).
> > When fuse_change_attributes_common() completes initialization, it
> > wakes waiting threads.
> > 
> > This ensures invalidations are properly serialized with inode
> > initialization, maintaining cache coherency.
> > 
> > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > ---
> >  fs/fuse/fuse_i.h | 3 +++
> >  fs/fuse/inode.c  | 8 ++++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 7f16049387d15e869db4be23a93605098588eda9..1be611472eee276371b3bde1a55257c1116cfedd 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -945,6 +945,9 @@ struct fuse_conn {
> >  	/** Version counter for attribute changes */
> >  	atomic64_t attr_version;
> >  
> > +	/** Waitqueue for attr_version initialization */
> > +	wait_queue_head_t attr_version_waitq;
> > +
> >  	/** Version counter for evict inode */
> >  	atomic64_t evict_ctr;
> >  
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index e57b8af06be93ecc29c58864a9c9e99c68e3283b..c6e7e50d80c0edaea57d9342869eaf811786e342 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -246,6 +246,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
> >  		set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
> >  
> >  	fi->attr_version = atomic64_inc_return(&fc->attr_version);
> > +	wake_up_all(&fc->attr_version_waitq);
> >  	fi->i_time = attr_valid;
> >  
> >  	inode->i_ino     = fuse_squash_ino(attr->ino);
> > @@ -567,6 +568,12 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
> >  
> >  	fi = get_fuse_inode(inode);
> >  	spin_lock(&fi->lock);
> > +	while (fi->attr_version == 0) {
> > +		spin_unlock(&fi->lock);
> > +		wait_event(fc->attr_version_waitq, READ_ONCE(fi->attr_version) != 0);
> > +		spin_lock(&fi->lock);
> > +	}
> > +
> >  	fi->attr_version = atomic64_inc_return(&fc->attr_version);
> >  	spin_unlock(&fi->lock);
> >  
> > @@ -979,6 +986,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
> >  	atomic_set(&fc->epoch, 1);
> >  	INIT_WORK(&fc->epoch_work, fuse_epoch_work);
> >  	init_waitqueue_head(&fc->blocked_waitq);
> > +	init_waitqueue_head(&fc->attr_version_waitq);
> >  	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
> >  	INIT_LIST_HEAD(&fc->bg_queue);
> >  	INIT_LIST_HEAD(&fc->entry);
> > 
> > ---
> > base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> > change-id: 20260318-fix-inode-init-race-a47a7ba4af1e
> > 
> > Best regards,
> 
> Had reviewed that DDN internally already. LGTM
> 
> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

Should I grab it?
