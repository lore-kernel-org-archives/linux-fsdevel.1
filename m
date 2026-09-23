Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D5541461;
	Wed, 23 Sep 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183605; cv=none; b=DHC0SeKRho5dsHLqjzoQ/MLpbaQQ4+berbR/dyw7R4GGZAVQ8RoAWKNfzzN5OpcasxcyO7LM8VtzornbsHWCNNeLzAJlhEZ1oRfZbyTMqtNpfn6EQmTygfwPszDBBWCD35Li8gRQWEHIv6YGfs30sXIJqpEO5ClV0HEugGHZPo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183605; c=relaxed/simple;
	bh=mvhUJ75LTiByzPbNX6IULbuU1BxqXI/ab6Nvrk2Q80U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLqA+v3hquc3A5gfI9FC9V61zWLZVVBLEUeZTEZfLvx83PLVIBKUeH1MlJEwH0h1GcNGSteexsstSmV44yke0LqgLP67ZBD4OtS8X0vcd+cypyzsjqhGyllZjfWog7l7kdEOqnIrGaORCeb9gH73npjhszXqwJ2iK90O7X7Jdi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pHosKTx2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RKGLZk9G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kOBlp2a8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9pkDmbIv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pHosKTx2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RKGLZk9G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kOBlp2a8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9pkDmbIv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29D891FF9F;
	Wed, 23 Sep 2026 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790183596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPsu1ud6F2/bWzN0SnFG7bCnihV3IFAHtI7VCr/YN3o=;
	b=pHosKTx2WyQ1qbwNH+tBPxomtNs0pUKLdrvDeP+HCRs6blxEHBML5L8PsJZJrM0gNT9/w1
	KmHucdxnfBuJvulIsm6SgW9t9iX7TqtssYml5DkSblFUopN1djtrbT0hZ8QP0Pvcc4QsGm
	MKDiYSjP77nqE1u0sFoR/XLe0TOs5V0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790183596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPsu1ud6F2/bWzN0SnFG7bCnihV3IFAHtI7VCr/YN3o=;
	b=RKGLZk9Gc84gDU49tb+Xe7RN5K6yrgSbozMN6bWFQijTFrBcKz1mW1heZoIvgxFRoIMqdW
	9bxSttdncH3b9zBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790183592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPsu1ud6F2/bWzN0SnFG7bCnihV3IFAHtI7VCr/YN3o=;
	b=kOBlp2a8CgrzuXghH6zsePFuwsxOkmMydGB5TzbwX7FxkBSmtA0C6hjEai8yanCCl2+zeK
	s+BCiEcZp2QYiSNwyvdkMbt6W3wMEwzAmrsj4JKtSA/Fs0w25OwQILhG5+pi4qtqpLoh2P
	MKIv8a1r5+V05p3QZe7DYnS0/8GsTyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790183592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPsu1ud6F2/bWzN0SnFG7bCnihV3IFAHtI7VCr/YN3o=;
	b=9pkDmbIvZFq/Oi3cas+NuUdWr62L7BI3wEBS0DBe/nZ3uRiN82wGAczENT6lcsFeoEmIDW
	FFqBTKe3ru6WeDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F14DA134E8;
	Wed, 23 Sep 2026 17:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5b/1MacItGrwHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 17:13:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 706FEA13D4; Wed, 23 Sep 2026 19:13:03 +0200 (CEST)
Date: Wed, 23 Sep 2026 19:13:03 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	chenyichong@uniontech.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isofs: validate directory records in
 isofs_read_level3_size()
Message-ID: <volfx2r3ystjmi6d2qaeyu37pjodjrp3sef6y3vmte3ia6aqoy@acwbpwhk5heq>
References: <20260923153220.777907-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923153220.777907-1-matthias.goergens@gmail.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Wed 23-09-26 23:32:20, Matthias Goergens wrote:
> isofs_read_level3_size() walks the multi-extent directory records of a
> file and dereferences de->size and de->flags for each one without ever
> checking the record's length byte.  A record with a short length placed
> near the end of a block makes those fixed-field reads run past the
> record, and for a record at the end of the last block of a page, past
> the buffer.
> 
> readdir, lookup and the NFS get_parent path have validated every record
> with isofs_dir_record_valid() since commit e2ee4078ec58 ("isofs:
> validate directory records consistently").  Do the same here, after
> moving on to the next block when the previous record ended exactly at
> the end of the block or the rest of the block is zero padding, as
> commit 3c01d9263683 ("isofs: Fix handling of directories with tight
> blocks") does for the other two walkers.
> 
> The check rejects a record that would run past its block, so the code
> that reassembled such a record from two blocks can no longer run.
> ECMA-119 does not allow directory records to straddle sector
> boundaries, which is what commit b2eb2e288604 ("isofs: Drop support of
> directory entries straddling blocks") relied on when it removed the
> same code from readdir and lookup.  Remove it here too, along with its
> temporary record buffer.
> 
> Found by fuzzing fs/isofs in a userspace harness with ASan
> (heap-buffer-overflow reads in isonum_733(de->size)).
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
> v2: squash the two patches into one, so the record is checked only
> after the move to the next block, as Jan suggested.  In v1, 1/2 relied
> on the straddle code that 2/2 then removed to handle a record ending
> exactly at the end of a block.  The resulting code is the same as after
> v1's 2/2.  Based on jack/linux-fs for_next, and cites the tight-block
> fix as 3c01d9263683.
> 
> isofs_read_inode() still reassembles a first record that straddles a
> block.  Only an NFS file handle can point it at one now, and the level
> 3 walk then returns -EIO.  I can send a follow-up that makes it reject
> such records too.
> 
> v1: https://lore.kernel.org/all/20260922140137.1768064-1-matthias.goergens@gmail.com/
> 
>  fs/isofs/inode.c | 44 +++++++++++++-------------------------------
>  1 file changed, 13 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index b766b5c9c593b..184350d2e6ad5 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -1176,7 +1176,6 @@ static int isofs_read_level3_size(struct inode *inode)
>  	unsigned long block, offset, block_saved, offset_saved;
>  	int i = 0;
>  	int more_entries = 0;
> -	struct iso_directory_record *tmpde = NULL;
>  	struct iso_inode_info *ei = ISOFS_I(inode);
>  
>  	inode->i_size = 0;
> @@ -1200,9 +1199,12 @@ static int isofs_read_level3_size(struct inode *inode)
>  				goto out_noread;
>  		}
>  		de = (struct iso_directory_record *) (bh->b_data + offset);
> -		de_len = *(unsigned char *) de;
>  
> -		if (de_len == 0) {
> +		/*
> +		 * If we are at the end of a block (or at its zero-padded
> +		 * tail), move on to the next block.
> +		 */
> +		if (offset >= bufsize || de->length[0] == 0) {
>  			brelse(bh);
>  			bh = NULL;
>  			++block;
> @@ -1210,32 +1212,18 @@ static int isofs_read_level3_size(struct inode *inode)
>  			continue;
>  		}
>  
> +		if (!isofs_dir_record_valid(de, offset, bufsize)) {
> +			printk(KERN_NOTICE "iso9660: Corrupted directory entry in block %lu of inode %llu\n",
> +			       block, inode->i_ino);
> +			brelse(bh);
> +			return -EIO;
> +		}
> +
> +		de_len = de->length[0];
>  		block_saved = block;
>  		offset_saved = offset;
>  		offset += de_len;
>  
> -		/* Make sure we have a full directory entry */
> -		if (offset >= bufsize) {
> -			int slop = bufsize - offset + de_len;
> -			if (!tmpde) {
> -				tmpde = kmalloc(256, GFP_KERNEL);
> -				if (!tmpde)
> -					goto out_nomem;
> -			}
> -			memcpy(tmpde, de, slop);
> -			offset &= bufsize - 1;
> -			block++;
> -			brelse(bh);
> -			bh = NULL;
> -			if (offset) {
> -				bh = sb_bread(inode->i_sb, block);
> -				if (!bh)
> -					goto out_noread;
> -				memcpy((void *)tmpde+slop, bh->b_data, offset);
> -			}
> -			de = tmpde;
> -		}
> -
>  		inode->i_size += isonum_733(de->size);
>  		if (i == 1) {
>  			ei->i_next_section_block = block_saved;
> @@ -1249,17 +1237,11 @@ static int isofs_read_level3_size(struct inode *inode)
>  			goto out_toomany;
>  	} while (more_entries);
>  out:
> -	kfree(tmpde);
>  	brelse(bh);
>  	return 0;
>  
> -out_nomem:
> -	brelse(bh);
> -	return -ENOMEM;
> -
>  out_noread:
>  	printk(KERN_INFO "ISOFS: unable to read i-node block %lu\n", block);
> -	kfree(tmpde);
>  	return -EIO;
>  
>  out_toomany:
> 
> base-commit: c8437ca3d4386af1ae1f2869643e82fdb9c1f0f5
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
