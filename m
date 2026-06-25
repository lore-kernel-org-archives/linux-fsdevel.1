Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6C1A9F87;
	Thu, 25 Jun 2026 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413732; cv=none; b=ZorF//nkx1j5YJWgVxciN/ru8/jqcW2oJksVJPu5pfagogApq5CPH26G7tOZAyQ05O4DJ+zW4pQgEv7J1RST6MVQK75Bt1umRJv2Uxm6q/8iyhyeC8FSxmsd/fosftNGgCKYaTaNfv/srXw3xSQfgkdv4Jcu+2LmbLasXTlKswo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413732; c=relaxed/simple;
	bh=E+9MAV45LCV50hgStqZmJDAaMiAM8aXnD1UrITZrVNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUj27J3SguGdqHaHyLBVNY5RM3PxQsOXmXVgK0UCbWVnH2n1eGFVRE078qUJHj+kidVyV71Uf/RdgC2TR6X4oO47/8YYwGeTD53TUvjH/OzTZ33RmH9azzIUJ6plqoakowRVVNGzbVcU0j3MUckKm7yNJYoGfiteLyNX4UBfp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFDehaIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFDehaIU"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 35CF01F000E9;
	Thu, 25 Jun 2026 18:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782413731;
	bh=QcX/ENuUP5c8fAk9azfkTZBCV9/T2lwuah6cM2dTAsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jFDehaIU7lAJW35UUNLbm30gzyp83/VQzNKS7QAw+s0czue6bme8cKikhMpt11gp8
	 ktlk1QCBRfLxmsu9YX73Jt5ppCUpR0FcSDF/GEvs+ovv7StWSW4YrBbCkkrabqR1/l
	 tlcdf0l+eqHKT88ra3K8rOGbdDWpanT/rdoi7eM1JG+DAEsdXUlsMUiIX0gTX9nwyP
	 z68ZUwYBKNItqj4xaGmiprbmoh9U8POXQXTIYDGBPau1eWdWQlbnia5o9ZrMeeUTy1
	 Pq1e+pU9c2TpTSBDsGaplGqTOjUVWrICNd304vMpvoOTmC3qlAcU6rJXCkLFLFGeTH
	 w0f1xquDNDFFw==
Date: Thu, 25 Jun 2026 11:55:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, willy@infradead.org,
	hch@lst.de, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] fuse: don't clear folio uptodate on writethrough
 errors
Message-ID: <20260625185530.GS6070@frogsfrogsfrogs>
References: <20260624205201.842714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624205201.842714-1-joannelkoong@gmail.com>

On Wed, Jun 24, 2026 at 01:52:01PM -0700, Joanne Koong wrote:
> In the writethrough path (fuse_send_write_pages()), if the write to the
> server failed or was a short write, the uptodate flag on the folios are
> cleared.
> 
> As explained by Matthew in [1], this is dangerous because the folio may
> be mapped into userspace. The mm code has the invariant that a
> non-uptodate folio must never be visible to userspace (to avoid
> potentially leaking confidental information to userspace) and has checks
> in place for this that if violated can bring down the whole machine.
> 
> Practically speaking, the effect of this change for the fuse
> writethrough error path is that if an application does a write and then
> the server fails to persist the data or only services a short write, the
> page cache folio keeps the data the application wrote instead of being
> reverted to the server's contents on the next read. The failure is still
> reported to the application synchronously through the short count /
> error return of the write() syscall. Folios that were only partially
> written are unaffected since they were never marked uptodate in the
> first place (fuse_fill_write_page() only marks a folio as uptodate if
> the whole folio was written to).
> 
> [1] https://lore.kernel.org/linux-fsdevel/ajtPMgO65FA1TXhi@casper.infradead.org/
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Heh.  I suppose it's good that we no longer throw away dirty folios
because it's a bit rude if read() suddenly reverts.  Let's hope there's
not some weird third-level side effect that blows this up.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fuse/file.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index cb8da4c06d17..c4ae4009a423 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1227,8 +1227,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
>  	struct file *file = iocb->ki_filp;
>  	struct fuse_file *ff = file->private_data;
>  	struct fuse_mount *fm = ff->fm;
> -	unsigned int offset, i;
> -	bool short_write;
> +	unsigned int i;
>  	int err;
>  
>  	for (i = 0; i < ap->num_folios; i++)
> @@ -1243,24 +1242,9 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
>  	if (!err && ia->write.out.size > count)
>  		err = -EIO;
>  
> -	short_write = ia->write.out.size < count;
> -	offset = ap->descs[0].offset;
> -	count = ia->write.out.size;
>  	for (i = 0; i < ap->num_folios; i++) {
>  		struct folio *folio = ap->folios[i];
>  
> -		if (err) {
> -			folio_clear_uptodate(folio);
> -		} else {
> -			if (count >= folio_size(folio) - offset)
> -				count -= folio_size(folio) - offset;
> -			else {
> -				if (short_write)
> -					folio_clear_uptodate(folio);
> -				count = 0;
> -			}
> -			offset = 0;
> -		}
>  		if (ia->write.folio_locked && (i == ap->num_folios - 1))
>  			folio_unlock(folio);
>  		folio_put(folio);
> -- 
> 2.52.0
> 
> 
