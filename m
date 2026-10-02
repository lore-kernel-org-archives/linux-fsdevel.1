Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8945D906;
	Fri,  2 Oct 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948419; cv=none; b=CdG3QF9MHVD3mdm1FU2n4CvXUSoFpZrdjrDHFa6tLrBuHxugFDW1+1jiow1O5quicx4A+0uPCwRbnk3BDbLNuJHNEEA+WR7d3By5SpAEqzzW1g1Z1SXad8ZZszTgIOLpi58tDTRnAe+V5jKI0v4V9fZBzaF9gvMzMQDfQQgLRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948419; c=relaxed/simple;
	bh=XLTdNpPpENYIRMA822cGaG1JPSNAT3rqJDchR0Mf+U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEuR6CwgqeYHJdoGiqFNuwQaM9W3H+FnBefeXG0oKPyY3Lg8/Ga1GotVCVqYN6kyL0zxK1yK+O7ONyaVb67cy8MtJXPwYi6wTXjVbNbDgOisAEHeMUyL9JUkQe4j4+s3LpPAmlcGFfBT7Hh99I9OZasQe9Gr8idjlBpcd/YEv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IoeHXWw9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DLuHXI2f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XVRuy/PO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=36OJaPNM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IoeHXWw9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DLuHXI2f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XVRuy/PO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="36OJaPNM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D1D31FE33;
	Fri,  2 Oct 2026 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790948402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWVrbaEUCTjYQGLk9y2gvaSWRP3b40xi28stjx15mIg=;
	b=IoeHXWw9SvNi5tw3aWpGBy5fXegEHSd9hMnsnid/sXF3hJ2wmEHEllgk/VhSZI5s6Uyfbr
	FUJjUFNdPryuWNjiaSZM4e8l6Pexk2njIz7K9JjiebfVntXSovpSdBp0UWG4X+tSUNNJcp
	MTrFnsVX40yS4hTleknv1waBFPQrjDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790948402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWVrbaEUCTjYQGLk9y2gvaSWRP3b40xi28stjx15mIg=;
	b=DLuHXI2fN8CcB9OSOdJ6RYQ3XSuaFrhI7EhuK0E4u4bsVJ9mF+iX+MD2g/JVCvUGRkhoqT
	J1bBod5jT3yuEgCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790948398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWVrbaEUCTjYQGLk9y2gvaSWRP3b40xi28stjx15mIg=;
	b=XVRuy/PO1XBwZMNp8+GP5xajOGqDsAJwFBTZV++ED35KT2Lm4EYNFnqMI1UINtmRvtJ/CQ
	na9iAQv+u9XZ0qdzMxrQgBKyNolLG8pK502uVFqeZFBdHBAKrXttRRrL40LiCkEXX5ss3l
	I261tGYixxC4AlITW3K1mGn8C4oLdv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790948398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWVrbaEUCTjYQGLk9y2gvaSWRP3b40xi28stjx15mIg=;
	b=36OJaPNMOyN8JvVlAqlpHl4m2bhOpEvaXrNAOWEhdLUmArZz0rB2PBsxbbTwxbXZWMn3aC
	7KfgRf/bAgrFUKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7373136AE;
	Fri,  2 Oct 2026 13:39:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3vqYIC20v2q+DAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 02 Oct 2026 13:39:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A47EA13C2; Fri, 02 Oct 2026 15:39:53 +0200 (CEST)
Date: Fri, 2 Oct 2026 15:39:53 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com, 
	syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH RESEND 3/3] udf: leave udf_next_aext() outputs alone at
 the end of the extent list
Message-ID: <2z7rpiwsnbclohlffljpuj2rbccdvg7kgmv4on6txskkgapxbi@rbizm4qcitmb>
References: <20261002042627.1677228-1-matthias.goergens@gmail.com>
 <20261002042627.1677228-4-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002042627.1677228-4-matthias.goergens@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[43fc5ba6dcb33e3261ca,799a0e744ac47f928024];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Fri 02-10-26 12:26:27, Matthias Goergens wrote:
> udf_next_aext() decodes each allocation descriptor straight into the
> caller's eloc, elen and etype, and follows a continuation descriptor
> into the next allocation extent.  If that allocation extent holds no
> descriptors, it returns 0 for the end of the list, but by then eloc,
> elen and etype describe the continuation descriptor itself: the block
> of the empty allocation extent, one block long, type 3.
> 
> The kernel creates such lists itself: udf_delete_aext() leaves the last
> allocation extent of a list empty when it removes its only descriptor,
> and udf_do_extend_file() and udf_extend_file() already handle a list
> that ends in an empty one.
> 
> Two callers use the outputs after a return of 0.  udf_discard_prealloc()
> walks to the last extent and, if it is a preallocation, deletes it with
> udf_delete_aext() and frees eloc/elen.  When an empty allocation extent
> follows, udf_delete_aext() removes the continuation and frees the empty
> block, and udf_discard_prealloc() then frees that block a second time
> instead of the preallocated blocks.  On a space bitmap the preallocated
> blocks are leaked and the free block count drifts.  On an unallocated
> space table the second free adds a second free extent for the same
> block, which is later handed out twice: fsx as run by generic/091 and
> generic/263 ends up with two parts of its test file in one block and
> reads back bad data.
> 
> udf_table_prealloc_blocks() can likewise take an empty allocation extent
> at the end of the table's own list for a free extent starting at the
> goal block.
> 
> Only update the outputs once a descriptor other than a continuation has
> been found.  The other callers use the outputs only on a positive
> return, or not at all, with one exception: when udf_table_free_blocks()
> appends a new extent, it keeps the partition reference of whatever eloc
> last held, which for a table whose list is a single continuation to an
> empty allocation extent would now be uninitialised.  Take it from the
> freed blocks instead.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Good catch! But I'd consider this mostly a bug in udf_discard_prealloc().
If udf_next_aext() returns value <= 0, you cannot assume anything about the
content of eloc & elen, including whether their value was or wasn't
clobbered. So IMO a nicer fix is to fix udf_discard_prealloc() to use
tmpeloc & tmpelen which should fix the problem as well.

								Honza

> ---
> Reproducer, with fsx from fstests and mkudffs from udftools:
> 
>   truncate --size=2G udf.img
>   mkudffs --blocksize=512 --space=unalloctable udf.img
>   mount -t udf -o loop udf.img /mnt
>   fsx -N 10000 -l 500000 -r 4096 -t 512 -w 512 -Z -R -W /mnt/junk
> 
> Without this patch fsx stops with READ BAD DATA after about 9850
> operations, in every run; with it, all 10000 operations complete.
> With --space=unallocbitmap fsx completes either way.
> 
>  fs/udf/balloc.c |  1 +
>  fs/udf/inode.c  | 21 +++++++++++++++++----
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index 2ec577b4321c..d863ee201cbf 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -457,6 +457,7 @@ static void udf_table_free_blocks(struct super_block *sb,
>  
>  		int adsize;
>  
> +		eloc.partitionReferenceNum = bloc->partitionReferenceNum;
>  		eloc.logicalBlockNum = start;
>  		elen = EXT_RECORDED_ALLOCATED |
>  			(count << sb->s_blocksize_bits);
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 71386e7ac796..0e55f749bc48 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -2266,22 +2266,35 @@ void udf_write_aext(struct inode *inode, struct extent_position *epos,
>  
>  /*
>   * Returns 1 on success, -errno on error, 0 on hit EOF.
> + *
> + * eloc, elen and etype are only updated when the next allocation descriptor
> + * was found.  In particular, when a chain of indirect extents ends in an
> + * empty one, following the trailing CONTINUE descriptor and hitting EOF must
> + * not clobber them with the location and length of that CONTINUE: callers
> + * keep using the last real extent's values after a 0 return, e.g. to discard
> + * its preallocation.
>   */
>  int udf_next_aext(struct inode *inode, struct extent_position *epos,
>  		  struct kernel_lb_addr *eloc, uint32_t *elen, int8_t *etype,
>  		  int inc)
>  {
> +	struct kernel_lb_addr tloc;
> +	uint32_t tlen;
> +	int8_t ttype;
>  	unsigned int indirections = 0;
>  	int ret = 0;
>  	udf_pblk_t block;
>  
>  	while (1) {
> -		ret = udf_current_aext(inode, epos, eloc, elen,
> -				       etype, inc);
> +		ret = udf_current_aext(inode, epos, &tloc, &tlen, &ttype, inc);
>  		if (ret <= 0)
>  			return ret;
> -		if (*etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
> +		if (ttype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
> +			*eloc = tloc;
> +			*elen = tlen;
> +			*etype = ttype;
>  			return ret;
> +		}
>  
>  		if (++indirections > UDF_MAX_INDIR_EXTS) {
>  			udf_err(inode->i_sb,
> @@ -2290,7 +2303,7 @@ int udf_next_aext(struct inode *inode, struct extent_position *epos,
>  			return -EFSCORRUPTED;
>  		}
>  
> -		epos->block = *eloc;
> +		epos->block = tloc;
>  		epos->offset = sizeof(struct allocExtDesc);
>  		brelse(epos->bh);
>  		block = udf_get_lb_pblock(inode->i_sb, &epos->block, 0);
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
