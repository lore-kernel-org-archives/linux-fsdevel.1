Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154F313520
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001340; cv=none; b=Pr+me/tUss8OxnB/o0kOB/RX9jZp9P8FuA66DD6Tf/h9OdwuB1Zvd62L+F3bDB0TaDfaMxIoyEDYxMK+y27g1DAMLhOgaqGBMoFLpPsascH3gtxYf6Rof8vMD0TEd/pQ0ODaNu+w63zGhka2Ad5eFH5u5A2LAEtzgFkLiXS0/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001340; c=relaxed/simple;
	bh=XKWSSJNxVegoAf292DekvTTk1zi27UvsCaqCKtnnnTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/91/JWZt1Il2avGgFMzpK12YdaZtBA8bIPt1nHEZp32XMqH6UvfzH5hq+oXqv+knLs3wf1lfNDJ8dJ+InuvDsxT+M2M3nVHmnWki6TYFlG8xq+c6qEJHRX/skCbIlK2ZJgJaXF+6HiCOyYqhrjx2tr3iFq098Ddjs+0Pv9/zE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PKclKTqU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cA0XlFdD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PKclKTqU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cA0XlFdD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKclKTqU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cA0XlFdD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKclKTqU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cA0XlFdD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 225E275AB2;
	Tue,  9 Jun 2026 10:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781001337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtQ3Nmp8r07SOvl859wsx1b38o+beu9/Bw6+JL0LMsA=;
	b=PKclKTqUFqZgHgu257n8enFknJvKhR/NSvaWLfSqKap8Mpo7KFh6Rg84PQ/pe0klj3j67m
	lbeTNYj4RKUMIDcN/xDGvn9HNXiVYoKTbZDKMI+4fPQf3aMwjZduhjaRuwvQLzGlEj9ZF9
	JY/c0UN9Bo67nsouT+P4h3n2Ofrtfbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781001337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtQ3Nmp8r07SOvl859wsx1b38o+beu9/Bw6+JL0LMsA=;
	b=cA0XlFdDGRW3c3pbv3KE/PzJDzfFHIM5z9j4QREcjm/LlqspZDczn1dBloKglvUIUTjfUT
	XT9ukFgTRekQVzDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781001337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtQ3Nmp8r07SOvl859wsx1b38o+beu9/Bw6+JL0LMsA=;
	b=PKclKTqUFqZgHgu257n8enFknJvKhR/NSvaWLfSqKap8Mpo7KFh6Rg84PQ/pe0klj3j67m
	lbeTNYj4RKUMIDcN/xDGvn9HNXiVYoKTbZDKMI+4fPQf3aMwjZduhjaRuwvQLzGlEj9ZF9
	JY/c0UN9Bo67nsouT+P4h3n2Ofrtfbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781001337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtQ3Nmp8r07SOvl859wsx1b38o+beu9/Bw6+JL0LMsA=;
	b=cA0XlFdDGRW3c3pbv3KE/PzJDzfFHIM5z9j4QREcjm/LlqspZDczn1dBloKglvUIUTjfUT
	XT9ukFgTRekQVzDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18F86779A7;
	Tue,  9 Jun 2026 10:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YsoSBnnsJ2rIZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Jun 2026 10:35:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA19EA0A90; Tue, 09 Jun 2026 12:35:32 +0200 (CEST)
Date: Tue, 9 Jun 2026 12:35:32 +0200
From: Jan Kara <jack@suse.cz>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Jan Kara <jack@suse.cz>, 
	Michael Bommarito <michael.bommarito@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isofs: bound Rock Ridge symlink components to the SL
 record
Message-ID: <6ml66e5et5duncujs2vxb4f4g45kuisfg5jhgpfiummhhnemcv@tiprkwg5yeww>
References: <20260607011823.217748-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607011823.217748-1-hexlabsecurity@proton.me>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[proton.me:email,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -2.30

On Sun 07-06-26 01:18:27, Bryam Vargas wrote:
> get_symlink_chunk() and the SL handling in
> parse_rock_ridge_inode_internal() walk the variable-length components of
> a Rock Ridge "SL" (symbolic link) record.  Each component is a two-byte
> header (flags, len) followed by len bytes of text, so it occupies
> slp->len + 2 bytes.  Both loops read slp->len and advance to the next
> component, and get_symlink_chunk() additionally does
> memcpy(rpnt, slp->text, slp->len), but neither checks that the component
> lies within the SL record before dereferencing it.
> 
> A crafted SL record whose component declares a len that runs past the
> record (rr->len) therefore triggers an out-of-bounds read of up to 255
> bytes.  When the record sits at the tail of its backing buffer - for
> example a small kmalloc()ed continuation block reached through a CE
> record - the read crosses the allocation; get_symlink_chunk() then
> copies the out-of-bounds bytes into the symlink body returned to user
> space by readlink(), disclosing adjacent kernel memory.
> 
> ISO 9660 images are routinely mounted from untrusted removable media -
> desktop environments auto-mount them (e.g. via udisks2) without
> CAP_SYS_ADMIN - so the record contents are attacker-controlled.
> 
> Reject any component that does not fit in the remaining record bytes
> before using it.  In get_symlink_chunk() return NULL, like the existing
> output-buffer (plimit) checks, so a malformed record makes readlink()
> fail with -EIO rather than silently returning a truncated target; in
> parse_rock_ridge_inode_internal() stop the inode-size walk.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Suggested-by: Michael Bommarito <michael.bommarito@gmail.com>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Thanks! I've added the patch to my tree. I've just modified the code in
parse_rock_ridge_inode_internal() to 'goto eio' in case the length is
wrong. We generally do this in that function when we find incorrect on-disk
structure and there's no good reason why we shouldn't refuse broken isofs
images early.

								Honza

> ---
> v2: in get_symlink_chunk() return NULL (-> readlink() -EIO) instead of
>     break on an over-long component, per Michael Bommarito's review.
>     break would let rock_ridge_symlink_read_folio() treat the truncated
>     rpnt as success and hand a silently-truncated symlink to userspace;
>     NULL matches the function's existing plimit-overflow handling and
>     fails closed.  The size walk in parse_rock_ridge_inode_internal()
>     keeps break (it only bounds i_size; the read path now errors).
> 
> Reproducer (crafted ISO-9660 image with Rock Ridge):
> 
>   # a symlink whose SL component length byte is enlarged so the
>   # component overruns its SL record
>   ln -s "$(python3 -c 'print("A"*250)')" /tmp/iso/l
>   genisoimage -R -o rr.iso /tmp/iso
>   # repoint the symlink's CE record to a tight continuation block
>   # (cont_size = 7) holding one SL record:
>   #   53 4c 07 01 00 00 ff   "SL", len 7, ver 1, comp flags 0, comp len 0xff
>   # so rock_continue() does kmalloc(7) and the component text begins at
>   # the end of that allocation.
>   mount -o loop,ro rr.iso /mnt
>   readlink /mnt/l
> 
> Without the patch, get_symlink_chunk() memcpy()s slp->len (0xff) bytes
> starting one byte into the 7-byte allocation, so readlink() returns the
> symlink target followed by adjacent in-kernel bytes.  With the patch the
> over-long component is rejected (slp->len + 2 > slen) and readlink()
> fails with -EIO; a well-formed Rock Ridge image is unaffected.
> 
>  fs/isofs/rock.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
> index 1232fab59a4e..0fe781381e66 100644
> --- a/fs/isofs/rock.c
> +++ b/fs/isofs/rock.c
> @@ -466,6 +466,9 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
>  				inode->i_size = symlink_len;
>  				while (slen > 1) {
>  					rootflag = 0;
> +					/* keep the component within the SL record */
> +					if (slp->len + 2 > slen)
> +						break;
>  					switch (slp->flags & ~1) {
>  					case 0:
>  						inode->i_size +=
> @@ -621,6 +624,14 @@ static char *get_symlink_chunk(char *rpnt, struct rock_ridge *rr, char *plimit)
>  	slp = &rr->u.SL.link;
>  	while (slen > 1) {
>  		rootflag = 0;
> +		/*
> +		 * A component is slp->len + 2 bytes (a two-byte header plus
> +		 * len bytes of text).  If it does not fit in the bytes left in
> +		 * the SL record the record is malformed: fail like the plimit
> +		 * checks below so readlink() returns -EIO, not a truncated path.
> +		 */
> +		if (slp->len + 2 > slen)
> +			return NULL;
>  		switch (slp->flags & ~1) {
>  		case 0:
>  			if (slp->len > plimit - rpnt)
> --
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
