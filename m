Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D625B305;
	Fri, 27 Mar 2026 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774632294; cv=none; b=pL/KVSAjcwYmSuW0aN+/7iLTktqj36AeAILaLc8esNCxQFzRCxeymdpPO+tIFSkIijWggIIiKWaNyOfXuUMN/aizer2/h+TsVGN8vHBWZRoE/aXBUIheJIR7b3vXH+UeuYis+gcPpYQAJsj6tH4ClWlVbN1dFPtuPczmtlmlHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774632294; c=relaxed/simple;
	bh=GPN1Rt/iLy0M4URWrbRBrZMYnOrFXI2hEPFSfy/tnqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtQXC2MLjBIjXxYhTYshuxj0Q8G6RjEw2h1kjJ9Kp8SDEHJe1wpxzxCn1OrZ3DuC/DUJTaahMoiv3DzFzJ9VYKl/ZMIgH0H1UnMC9i5sbu5VD4VzBWZKr1HiLOyWKQqeghNo5pCc04upGqNlvvn1G0/wB7kmujoGHe8avK2KGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (108-141-067-156.ip-addr.inexio.net [156.67.141.108])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id E69CBE038F;
	Fri, 27 Mar 2026 18:24:43 +0100 (CET)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 27 Mar 2026 18:24:43 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v2] fuse: fix inode initialization race
Message-ID: <aca9JlM59zH6ZldQ@fedora.fritz.box>
References: <20260327-fix-inode-init-race-v2-1-22b1757109f8@ddn.com>
 <CAJnrk1YuxmmkqC+J5f=YyXoFeUgYZPsURyLdkzUJPBKK+CjcFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YuxmmkqC+J5f=YyXoFeUgYZPsURyLdkzUJPBKK+CjcFw@mail.gmail.com>

On Fri, Mar 27, 2026 at 08:40:49AM -0700, Joanne Koong wrote:
> On Fri, Mar 27, 2026 at 12:36 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> >
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> >
> > Fix a race between fuse_iget() and fuse_reverse_inval_inode() where
> > invalidation can arrive while an inode is being initialized, causing
> > the invalidation to be lost.
> > By keeping the inode state I_NEW as long as the attributes are not valid
> > the invalidation can wait until the inode is fully initialized.
> >
> > Suggested-by: Joanne Koong <joannelkoong@gmail.com>
> > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > ---
> > Changes in v2:
> > - switch from waitq guided by attr_version to wait_on_new_inode() and unlock_new_inode() when
> > the inode is fully initialized
> > - Link to v1: https://lore.kernel.org/r/20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com
> > ---
> >  fs/fuse/inode.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index e57b8af06be93ecc29c58864a9c9e99c68e3283b..fa0adc2bbe58cee6f63153c60c401b78ec3695bf 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -470,6 +470,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
> >         struct inode *inode;
> >         struct fuse_inode *fi;
> >         struct fuse_conn *fc = get_fuse_conn_super(sb);
> > +       bool is_new_inode = false;
> >
> >         /*
> >          * Auto mount points get their node id from the submount root, which is
> > @@ -505,13 +506,13 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
> >         if (!inode)
> >                 return NULL;
> >
> > -       if ((inode_state_read_once(inode) & I_NEW)) {
> > +       is_new_inode = inode_state_read_once(inode) & I_NEW;
> > +       if (is_new_inode) {
> >                 inode->i_flags |= S_NOATIME;
> >                 if (!fc->writeback_cache || !S_ISREG(attr->mode))
> >                         inode->i_flags |= S_NOCMTIME;
> >                 inode->i_generation = generation;
> >                 fuse_init_inode(inode, attr, fc);
> > -               unlock_new_inode(inode);
> >         } else if (fuse_stale_inode(inode, generation, attr)) {
> >                 /* nodeid was reused, any I/O on the old inode should fail */
> >                 fuse_make_bad(inode);
> > @@ -528,6 +529,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
> >  done:
> >         fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_version,
> >                                  evict_ctr);
> > +       if (is_new_inode)
> > +               unlock_new_inode(inode);
> >         return inode;
> >  }
> >
> > @@ -565,6 +568,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
> >         if (!inode)
> >                 return -ENOENT;
> >
> > +       /* Wait for inode initialization to complete */
> > +       wait_on_new_inode(inode);
> 
> This isn't needed.
> 
> The fuse_ilookup() -> ilookup5() already waits on I_NEW.

I actually suspected that and looked for it, but did not see it in ilookup5()
Sorry about that.

> 
> Thanks,
> Joanne
> 
> > +
> >         fi = get_fuse_inode(inode);
> >         spin_lock(&fi->lock);
> >         fi->attr_version = atomic64_inc_return(&fc->attr_version);
> >
> > ---
> > base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> > change-id: 20260318-fix-inode-init-race-a47a7ba4af1e
> >
> > Best regards,
> > --
> > Horst Birthelmer <hbirthelmer@ddn.com>
> >
