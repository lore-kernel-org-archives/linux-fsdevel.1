Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732438F230
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781461683; cv=none; b=sjG5TNQMqhxFFQNBNzfdmm0phzb223sDfOgNZlpLB3hTp2PuqaITM5qIt8i5RxVwz3PdaTek+ml+RymYj6TC5mNijhiBrvfRpHsVql32TkNasQjQ2Z2o2ZD23KjwIIDWUcJ0W4XLeAuds6IiQXExeZo3NI5Bnsi/9CuhBKIyruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781461683; c=relaxed/simple;
	bh=wiRLgDQ1NNM3tdk+XtvN64zQ85KksleKj+OTqXAf5Wc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=raQ3oAu8dnTTpf4li2xb2VGCCTvR4h2Fliu1lSIujdaHB41p1Z5hSMvgK35+yg7daKT/pfB1UASCqxE76APKMZxii8q+X0BUfoPzEedQckra6DwDs4mU54HhARdNMRG3vDZgSQg8UTvQeCIPMHlAgw5pzyFuIdKIVAH2R9xH46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=N5rP64fO; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="N5rP64fO"
X-KPN-MessageId: c15fefde-681e-11f1-afe8-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c15fefde-681e-11f1-afe8-005056994fde;
	Sun, 14 Jun 2026 20:27:52 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id c15ec912-681e-11f1-8109-00505699693e;
	Sun, 14 Jun 2026 20:27:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=H8cWbcatkteNjLy3HBwTUk9w2yhFvzTFryA8wfPpsGA=;
	b=N5rP64fOkFZqi+0x0DPWPVamMrroLbXjf2ceCBQsdlqbGJE6LWTUYM5o1MuLWJmlLuN2nGiAz1q+3
	 Kv1BCtuc80T4I700TNRoxsXc9WiCLMxnmzokr/c7SJZJX466wFmQR6cNaxwXB6NCEbIUnNekfVYIg+
	 ZyzBspMgzXu5BseErv/XZ2T/NAMkxGXUTgxgRkSUivVH3adfhEDuBokgq/gStW+Mp/fsrmG6zLasNt
	 UU67gNH2BgwcMBFnemk6D+FYe+MJh+28wxrT+K/XRP1R9GbSnDW59VBcbxAV3YN4L5HFDWvFahXZAA
	 t+MyfEYTb0takMo17oCvZE9y24Z8CZw==
X-KPN-MID: 33|pB+L7oskNzMNIChXiX9zsXGfqqASig7LQtkAUoxjM5fL347LJU8ckAFgxKf/SJR
 x8ZbBR0B85Jxb0uj4qTZvvfX3cfqABX9ee5hrKMb5ghk=
X-CMASSUN: 33|OC4oVPcrSPAVq8U0k1Sthwpig/R76djuZ2KLmTkuvnCG5FqRtsXGw7O2x/IW3gf
 3VuEGaEeE0omzLiDUND7aNA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id c14ca14f-681e-11f1-b8d7-005056995d6c;
	Sun, 14 Jun 2026 20:27:52 +0200 (CEST)
Date: Sun, 14 Jun 2026 20:27:52 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Message-ID: <1838729341.1691008.1781461672647@kpc.webmail.kpnmail.nl>
In-Reply-To: <178028376148.2923901.10614738518137561136@noble.neil.brown.name>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
 <20260531182045.171711-8-jkoolstra@xs4all.nl>
 <178028376148.2923901.10614738518137561136@noble.neil.brown.name>
Subject: Re: [RFC PATCH v6 7/9] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 01-06-2026 05:16 CEST schreef NeilBrown <neilb@ownmail.net>:
> > +
> > +static inline umode_t o_create_mode(struct mnt_idmap *idmap,
> > +		const struct inode *dir, umode_t mode, bool create_dir)
> > +{
> > +	if (create_dir)
> > +		return vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
> > +	else
> > +		return vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> 
> I still don't see a justification for different permission masks.
> There should be a comment explaining why there is a difference, though
> I'm not convinced a difference is needed.
> 

I just copied current semantics from vfs_mkdir() and vfs_create().

Let me add what you wrote before here for context:

> It isn't clear the purpose of this.
> In the create_dir case, shouldn't we pass S_IFDIR as the last arg: type?
> 

Yes, you are correct. This is being handled separately.[1] (I know you know
that, but let me add this to provide context for other readers).

> The difference between "S_IRWXUGO | S_ISVTX" and "S_IALLUGO" is not
> immediately obvious, but the former excludes S_ISUID and S_ISGID.
> The setuid bit is meaningless on directories so there is little point in
> stripping it, but I don't object as long as the intent is documented
> here.
> The setgid bit is meaningful but vfs_prepare_mode() seems to already
> handle it correctly for directories if you pass the type as S_IFDIR.

mode_strip_sgid() is just for regular files and is a noop when passed
a S_IFDIR. So I am not quite sure what you mean.

Apparenly, mkdir(2) cannot enable the setgid bit itself. This has been the
case since the initial git commit, which contains:

+       mode &= (S_IRWXUGO|S_ISVTX);
+       error = security_inode_mkdir(dir, dentry, mode);
+       if (error)
+               return error;
+
+       DQUOT_INIT(dir);
+       error = dir->i_op->mkdir(dir, dentry, mode);

I am not sure why.

@Al, you have been around for a long time? Do you know why mkdir(2) cannot
enable the setgid bit?

> If you have a good reason to impose different handling here, that might
> be sensible, but it should be documented.


> >  }
> >  
> >  /*
> > @@ -4379,8 +4409,12 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
> >  
> >  	file->__f_path.dentry = DENTRY_NOT_SET;
> >  	file->__f_path.mnt = path->mnt;
> > -	error = dir->i_op->atomic_open(dir, dentry, file,
> > -				       open_to_namei_flags(open_flag), mode);
> > +
> > +	if (O_IS_MKDIR(open_flag))
> > +		error = EINVAL;
> > +	else
> > +		error = dir->i_op->atomic_open(dir, dentry, file,
> > +					       open_to_namei_flags(open_flag), mode);
> >  	d_lookup_done(dentry);
> >  	if (!error) {
> >  		if (file->f_mode & FMODE_OPENED) {
> > @@ -4413,6 +4447,10 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
> >  	return dentry;
> >  }
> >  
> > +static inline
> > +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *,
> > +				 struct dentry *, umode_t,
> > +				 struct delegated_inode *);
> 
> forward declaration aren't ideal...  This is a new function that you
> introduced.  Could you place it earlier when you introduce it?
> 

I wanted to keep vfs_mkdir_no_perm() close to vfs_mkdir(). But I can
live with moving it.

Thanks,
Jori.
