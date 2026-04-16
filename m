Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327C2DEA9B;
	Thu, 16 Apr 2026 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381550; cv=none; b=lKLPqj69YQc0BASzwwpSjGnzDJp60uHFSR2P/Eg/3vudcGLPN7R7MpupOfhVh4datO7ypS0N8qrOmGtlqfib0kcaL4z7oVQSPCfFOV9QaMZssdz9qltWeMHFUVgpfgfCWeaQ0BOQKDi9PudmLYkcV4TTGhCNWDip8HTzXhAjR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381550; c=relaxed/simple;
	bh=jkLyoiDDDFhSwbegtspSPb994Dl3oJUVdV1pM6K2teM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h04N7jAQXepKiIzgfhETnyc401CNAepehVZJzZK7nIW5+RpgL7Nivp+w0o0peAex0xgjmAbveD12UKyqMfeGXmqohr4rO0i9JTx0fmrIdace49hBn7zH+KmbKAsgKC4B47AW3l2yGHQMtrbOD3IfUQRf3GmU+g0mGrsRaiuAjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vzzNXBK/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vzzNXBK/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LbDwlLe42AmGusr0cf84jHOYtQ4ie+L/QWXt3+eZ4dA=; b=vzzNXBK/cwBZcUU94k42xjXl3g
	7FP19PdJepuq/KbbrLIer3W1aoNnS27ieGHHSIDysm91QTi6pJZZMwKH6Pmt4xJZj5+LCTK1zTXKR
	o037/feipA4Zv6w/XTYwvmazrNqnmysOS9ut9v5O6OXxGIt3oXBSKChcmReTmeeE5wtJZ1Nh1RFPV
	JelWOysoVml2Q+lRio5rYYEOomUxH1MRir5s6f85VprG68lp+y1MvZo1/0Rshr/My1WTlSLKInsES
	2lDSmAcSqYFKUa8mNSn17KE6NvlQgH+KFhS297dIbBBsGoukp6pWI1Od9jGt+qSLZR7qlD2HCdgri
	OCMY8mzw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDVzH-00000002NYT-0KRk;
	Thu, 16 Apr 2026 23:19:07 +0000
Date: Fri, 17 Apr 2026 00:19:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Nikolay Amiantov <ab@fmap.me>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.sourceforge.net,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev,
	linux-mm <linux-mm@kvack.org>
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
Message-ID: <aeFuarTL7xBbut0F@casper.infradead.org>
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>

On Thu, Apr 16, 2026 at 07:41:37PM +0700, Nikolay Amiantov wrote:
> +++ b/fs/fuse/inode.c
> @@ -334,10 +334,42 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
>  	 * extend local i_size without keeping userspace server in sync. So,
>  	 * attr->size coming from server can be stale. We cannot trust it.
>  	 */
> -	if (!(cache_mask & STATX_SIZE))
> -		i_size_write(inode, attr->size);
> +	if (!(cache_mask & STATX_SIZE)) {
> +		if (S_ISREG(inode->i_mode) && attr->size > oldsize) {
> +			struct folio *folio;
> +			pgoff_t index = oldsize >> PAGE_SHIFT;
> +
> +			spin_unlock(&fi->lock);
> +			folio = __filemap_get_folio(inode->i_mapping, index,
> +						    FGP_LOCK | FGP_CREAT,
> +						    mapping_gfp_mask(inode->i_mapping));
> +			if (!IS_ERR(folio)) {
> +				spin_lock(&fi->lock);
> +				if (!test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
> +					folio_clear_uptodate(folio);
> +					i_size_write(inode, attr->size);
> +				}
> +				spin_unlock(&fi->lock);
> +
> +				folio_unlock(folio);
> +				folio_put(folio);
> +				goto size_updated;

Yes, at this point, you've left the folio in an error state.  I'm sure you
didn't mean to do that, but the VFS interprets unlocked && !uptodate as
"an error happened" (there is a minor exception to this involving failed
readahead, but let's set that aside).

What you could do, rather than unlock the folio here is to initiate a
read of the folio and allow the read to unlock the folio.  But I don't
think this is a good idea, I like the idea of invalidating the folio
much better.

