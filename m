Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A8429827
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566126; cv=none; b=pK0RkA5peo6JquUPqjVD0+AqV6ejV6IKs+eVJrw4BAsbpZD0S36Ehu0OZ6MnlKDioOGloBHueMAdT/8CRwjf3Valp/j0qRm57vOw5cU/gciHcYFUsWNnVglqNPNTYYv3fKRM4gOYbJcschAX8lp1V0v2zTuTaZvDsBSh6SorQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566126; c=relaxed/simple;
	bh=H7hmDRTTZVGUJ1wNAnKf8iKvjTauE7vnWgqTjjTknE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aboQgXbaCFNI2rGWVKlvh3HyzHECcpzMcHjkOATJsJcDozR1pg1o2JCxThAcaESn7F7Fy0hL35VeSeecmtMMtenQ1PQgwKWvcBQ5PRNvL2af8NFLKlViNoKmYn4Ol4jI6bwv2hG2LyWrEcf7Z4j0/6o3wG7brkBJqVrVAT9F+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DE9C6732A; Tue, 12 May 2026 08:08:30 +0200 (CEST)
Date: Tue, 12 May 2026 08:08:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Bob Copeland <me@bobcopeland.com>, Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH 08/10] minix: handle set_blocksize failures
Message-ID: <20260512060830.GB28955@lst.de>
References: <20260511071701.2456211-1-hch@lst.de> <20260511071701.2456211-9-hch@lst.de> <mxb2r7knst7hz2k454w6i7xy62kd6pyj6m2zqsaddkxqpzykxu@zqpqtbnigdp6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mxb2r7knst7hz2k454w6i7xy62kd6pyj6m2zqsaddkxqpzykxu@zqpqtbnigdp6>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 11, 2026 at 06:08:18PM +0200, Jan Kara wrote:
> On Mon 11-05-26 09:16:53, Christoph Hellwig wrote:
> > minix uses buffer_heads, which don't handle block size > PAGE_SIZE well.
> > Without this, mounting we will hit the
> > 
> >         BUG_ON(offset >= folio_size(folio));
> > 
> > in folio_set_bh on the first __bread_gfp call.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/minix/inode.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> > index 9c6bac248907..03a69b13950d 100644
> > --- a/fs/minix/inode.c
> > +++ b/fs/minix/inode.c
> > @@ -292,7 +292,8 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
> >  		sbi->s_namelen = 60;
> >  		sbi->s_version = MINIX_V3;
> >  		sbi->s_mount_state = MINIX_VALID_FS;
> > -		sb_set_blocksize(s, m3s->s_blocksize);
> > +		if (!sb_set_blocksize(s, m3s->s_blocksize))
> > +			goto out;
> 
> This should go to out_release AFAICT. Otherwise we leak the bh.

Yes.  Christian, do you want a resend or incremental patch?

