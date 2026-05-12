Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1B238D3F4;
	Tue, 12 May 2026 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588035; cv=none; b=CPwuYdT7gVXeQkcrstGWe8K2rE7LQQpYg/uwCVVGD8K5YTnS3lSEQ+kaZ9hLH1lN6L/kk3TmBNHI1r78pwaxig10LWXTNfSYLxw8JYPF8qCDQTGwp43iOmiSaknjwj5i8pKWrioSzlzhCV/jvBxWupREzYm+DaiVow84YHshin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588035; c=relaxed/simple;
	bh=QasGsII44cL0MZruvOvo/638UVsaSR2ejfSFBhjzzRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2DuR3SVjM1e4S4Sy7aRHh+Eas7zSDDNivfmRiahdcMdamOmn6aimPWZxy7Ojok3RoA5U0z9uwH/lq5+vO4IZuaYbVgd1FgNjqFFRgBPhS6HLFErWHOeyObFkvu/llM0/WR3rqOZLJsTMvowTFJPxQTBD5IQPHRSTPuMXPRoNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qecbIrNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qecbIrNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79FBC2BCF5;
	Tue, 12 May 2026 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778588035;
	bh=QasGsII44cL0MZruvOvo/638UVsaSR2ejfSFBhjzzRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qecbIrNmRKsXyeLYrLf/K6yoeibtVttieM5mikjquoXJLQIbgK0ZWyqJGjPwi0jO1
	 eonyCTNPVPIqmSecdF3r7h+Y6o1RhvjSCPY3OQGZ+cd63484Q7UBGS9zCt1Yvei3y0
	 9PqySFZ4nNQ0mXmXUucnzZ/gQo6ByNUQm3beCFR9PJpjWNFq/UiF1nfcZrJaypZSet
	 aEpuzgkbRWk2t25p1iB56ZS4BKXLLLFNvNzkGS2kmGfGF1x0QN5ya2pXzxqfxAkyiA
	 M+PLyAWx/H7eZEW+mzk0C+vI5j0W6NdPpEECVLgEA6o4qdFO/hbLGvxUblCjasofxf
	 094M9L79jR2Xg==
Date: Tue, 12 May 2026 14:13:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Bob Copeland <me@bobcopeland.com>, 
	Anders Larsen <al@alarsen.net>, linux-fsdevel@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH 08/10] minix: handle set_blocksize failures
Message-ID: <20260512-umgehen-hafer-6022c6046c60@brauner>
References: <20260511071701.2456211-1-hch@lst.de>
 <20260511071701.2456211-9-hch@lst.de>
 <mxb2r7knst7hz2k454w6i7xy62kd6pyj6m2zqsaddkxqpzykxu@zqpqtbnigdp6>
 <20260512060830.GB28955@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512060830.GB28955@lst.de>

On Tue, May 12, 2026 at 08:08:30AM +0200, Christoph Hellwig wrote:
> On Mon, May 11, 2026 at 06:08:18PM +0200, Jan Kara wrote:
> > On Mon 11-05-26 09:16:53, Christoph Hellwig wrote:
> > > minix uses buffer_heads, which don't handle block size > PAGE_SIZE well.
> > > Without this, mounting we will hit the
> > > 
> > >         BUG_ON(offset >= folio_size(folio));
> > > 
> > > in folio_set_bh on the first __bread_gfp call.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/minix/inode.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> > > index 9c6bac248907..03a69b13950d 100644
> > > --- a/fs/minix/inode.c
> > > +++ b/fs/minix/inode.c
> > > @@ -292,7 +292,8 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
> > >  		sbi->s_namelen = 60;
> > >  		sbi->s_version = MINIX_V3;
> > >  		sbi->s_mount_state = MINIX_VALID_FS;
> > > -		sb_set_blocksize(s, m3s->s_blocksize);
> > > +		if (!sb_set_blocksize(s, m3s->s_blocksize))
> > > +			goto out;
> > 
> > This should go to out_release AFAICT. Otherwise we leak the bh.
> 
> Yes.  Christian, do you want a resend or incremental patch?

Incremental patch. When we reasonably can fold something clean we should
do it instead of refiring a bunch of mails.
