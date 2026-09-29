Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AD3B05A2;
	Tue, 29 Sep 2026 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681831; cv=none; b=Vs2kkrnrgtU8L9OQGMI02mR/DcljA+zlvFbRxfyhQGXk+VLDrW4KTp477EScMUnhtbZR8LOeLrgH1e5W8Ij98hYO8dVjn/JZWtoV9uzmP832dGrgEaT/T6/GGfH66ofHm4GWdi2OCVbFbs6kJ67moZ6lwh95fFkqaeSDMrLNEyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681831; c=relaxed/simple;
	bh=E2VdD3LVvVOFZSHMDA7l64rewSvb9FFLhGPbZ3Sum8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOVVD+bBPmcqkN5fwKFRHXaP18LmmWENOJboAdhzGXPe3z/hB0ooLYvr1VDjp8cp7J1v7LxL9ho2viXZWUP4xT5cssfu+Wf8Ymm7PN/cBy8FNCZqkwfdGSGbHHLAhLpi26HFOKnThE0+BsRMUCQOr48Un1hGUUEdyiYhqkJ/wTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JPwLFWNj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7dEXyztx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yAE4SSEI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pH+rGGY5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JPwLFWNj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7dEXyztx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yAE4SSEI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pH+rGGY5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65C1821BD4;
	Tue, 29 Sep 2026 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790681823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OM+puQbJwXJ7Jjzc1ZxVb2OjX3bMtx8ZbdLyyKyi3IY=;
	b=JPwLFWNjmVzd4nvBxIrmxgryaAAIeFSjpaaXz6BOg4NJATjLgImZgkag3LtcaUJEmeynei
	We7RZh6XH9eGxfb7jGzY0VsmXDIZVGUlOVxlgh+XSa3ubX0XooGBg0BxnEMI1NTlXymBjv
	Wxw5GfutzoEb9Ek+pVyAJwKyWRfrF/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790681823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OM+puQbJwXJ7Jjzc1ZxVb2OjX3bMtx8ZbdLyyKyi3IY=;
	b=7dEXyztxC9Gr1BpItmAFLsaueFOF7q0qaWdv/aEIu+z1FlobdfOtOQWsdlhkIt943yDaGN
	yrsiD8ObFRyL8gBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790681819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OM+puQbJwXJ7Jjzc1ZxVb2OjX3bMtx8ZbdLyyKyi3IY=;
	b=yAE4SSEIsc7AM4nobFsy3oCAy1O8qgLuBELql/y+n/7mY7PVRKyslt80ZhLQIL6j9A/b/J
	lVdqym8KAC89I6UPcqAi155dEtaJuNRb/vqF7FQ34RL/0Z/X5t4RqguUbUqzz0Z5mMYX7f
	mhEjP5CkNuOBtacoBSRfqDB/oOQ6hlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790681819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OM+puQbJwXJ7Jjzc1ZxVb2OjX3bMtx8ZbdLyyKyi3IY=;
	b=pH+rGGY5UuW5hm9zWCLScH22nsW92/mzI5SffjIoiwsX5jQ/1iSr5cZFlawE0c/S6Mr+X4
	va4t/ChLRZCbRVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F1E9133F1;
	Tue, 29 Sep 2026 11:36:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WlJdBtuiu2q2IAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Sep 2026 11:36:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B4BE4A132A; Tue, 29 Sep 2026 13:36:54 +0200 (CEST)
Date: Tue, 29 Sep 2026 13:36:54 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: jack@suse.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: don't let a stale metadata buffer overwrite
 expanded file data
Message-ID: <do3w2kv2vbyhbwivuenxawlkqxzzuqpy3awd4b7ameimenuo5k@6zasrnoiii2y>
References: <20260926023512.3035718-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926023512.3035718-1-matthias.goergens@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sat 26-09-26 10:35:12, Matthias Goergens wrote:
> Since commit 62333e480d12 ("udf: Fix data loss when converting inline
> inodes to out of line"), udf_expand_file_adinicb() allocates the data
> block itself with udf_map_block() and then writes the folio with
> filemap_fdatawrite().  Writeback maps the block through
> udf_get_block_wb(), which does not allocate, so the buffer is never new
> and nothing calls clean_bdev_aliases() for the block, as the generic
> code does for every block get_block() reports as new.
> 
> A recently freed block can still have a dirty buffer in the block device
> page cache.  The common case is the file entry of a deleted file:
> udf_evict_inode() updates it with sync_inode_metadata(), which for an
> inode that is not IS_SYNC only marks the buffer dirty, and then frees
> the block.  If that block becomes the data block of an expanded file,
> the next writeback of the block device writes the old file entry over
> the file's data.
> 
> On a fresh mkudffs image, creating 20 small files, deleting them and
> then creating five files with "printf hello >f; truncate -s 3000 f"
> leaves all five with a deleted file's extended file entry as their first
> block after sync and remount.  This happened in 400 of 400 runs, on
> bitmap and table images alike.  When the file is extended by writing
> instead of truncating, the write dirties the data again and the outcome
> depends on writeback order: the data was corrupted in about 7% of runs.
> 
> Clean the aliases of the new block, as block_write_begin() and
> mpage_writepages() would have done.
> 
> Fixes: 62333e480d12 ("udf: Fix data loss when converting inline inodes to out of line")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Thanks for the fix! The problematic commit was actually merged in 7.3-rc1
so there's no need to CC stable, I'll push it to Linus for rc6.

								Honza

> ---
> This is a regression in v7.3-rc1, and 62333e480d12 is also in 7.2.6 and
> 6.18.52.  On 7.2.7 and 6.18.54 the truncate case corrupts the data in
> 400 of 400 runs, as on mainline, and the write case in 10 and 7 of 400
> runs; with this patch, which applies cleanly to both, there was no
> corruption in 400 runs of either case.  Before 62333e480d12, extending
> the file by writing was safe (no corruption in 400 runs with it
> reverted): the write allocated the block through udf_get_block(), which
> marks it new, so block_write_begin() cleaned the alias.  Truncating up
> lost the data before 62333e480d12 as well, which is what that commit
> fixed.
> 
> To reproduce, run this as root in a VM; cmp reports every corrupted
> file:
> 
> #!/bin/sh
> img=/tmp/udf.img mnt=/tmp/udf.mnt
> truncate -s 1M $img
> mkudffs $img >/dev/null
> mkdir -p $mnt
> mount -t udf -o loop $img $mnt
> for i in $(seq 20); do echo small >$mnt/s$i; done
> rm $mnt/s*
> for i in $(seq 5); do
> 	printf hello >$mnt/f$i
> 	truncate -s 3000 $mnt/f$i
> done
> sync
> umount $mnt
> mount -t udf -o loop $img $mnt
> printf hello >/tmp/expect
> truncate -s 3000 /tmp/expect
> for i in $(seq 5); do cmp $mnt/f$i /tmp/expect && echo "f$i ok"; done
> umount $mnt
> 
>  fs/udf/inode.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index e45e546a739a..804554d26595 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -442,6 +442,13 @@ int udf_expand_file_adinicb(struct inode *inode)
>  	err = udf_map_block(inode, &map);
>  	if (err < 0)
>  		goto restore;
> +	/*
> +	 * The block may have held metadata that is still dirty in the block
> +	 * device page cache (e.g. the file entry of a deleted inode). Make
> +	 * sure writeback of that buffer cannot overwrite our data.
> +	 */
> +	if (map.oflags & UDF_BLK_NEW)
> +		clean_bdev_aliases(inode->i_sb->s_bdev, map.pblk, 1);
>  
>  	folio_mark_dirty(folio);
>  	folio_unlock(folio);
> 
> base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
