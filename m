Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A33451CD;
	Tue,  8 Sep 2026 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862071; cv=none; b=pWfwfVQN/W1/oZczf8aDC/1jpuaH1FrhpFNF69GnbJyyTeet+Sx6fN2rwjgyQk5nfVa0caAXjvnDcgP3+CK+MVY7OjVAwV7CAZos2OaCzO1+h+LtlsCyrmd0a0UK/xlUXPUk72MHYGsOSxEV711NP2NvSw2PodBLAGTTfkWWWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862071; c=relaxed/simple;
	bh=lqSddtxLhRkCjapYlOyuz31HniRvvv/nxl83dngAZcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbL4tnbmfkQ1YVP0DTvqhOOiuoJG5Z29By0ygAxiyc78ODdzW+hAk0z4YXqa92fPVuLDomb3p+cv7YpoInANW+omMpPGwMmkA79VbodA3Mm/yQM4MsUms5ovaZji5TgkrJNWzO9H2Oh2UDoyECtKp4CSpSqN8/fJSEqY7VFloRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ggr+9v8e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yA2vIdrf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GxfED4qB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=knG5YV35; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ggr+9v8e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yA2vIdrf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GxfED4qB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="knG5YV35"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F85E21A0D;
	Tue,  8 Sep 2026 10:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788862063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3PepwHHkM+D7WdCatRqyZDV1QmpqXVTHByew5psvytQ=;
	b=Ggr+9v8euyzHjjNKJGzF1UNdCWbHTux6TJA5GlglVkBUL3uDCkXvgb1qxKhMsfwM+RecLG
	Qn0hZ7Lh0Da18MUNqtnidd1m+qTimqoSITA4l5oWl/6KJgJuXY5UiQUlZ9PTDNYRtF0KX3
	HDvK6cuEcCOxKRyZIOfEYHt9HPV1jQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788862063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3PepwHHkM+D7WdCatRqyZDV1QmpqXVTHByew5psvytQ=;
	b=yA2vIdrfilRvvogWoOkm8r+k/7BNIUcp0RQPu2kc0ks+ArcLbmBgjtj1FMqjldWpe1ACoP
	FBkAKWhcC1weUmAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788862059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3PepwHHkM+D7WdCatRqyZDV1QmpqXVTHByew5psvytQ=;
	b=GxfED4qBnLaQYIaTITEvTX9yDpBJ01MSyP99m4sJxNyhEgHSiqC6/rDIfkKLlTpYwyWwO0
	lIJqTC2sgsHrnCqjmoVq5g3xKpqe4U6e/IMePNAK7tCCA4JKNzLkqIipufhI7eP9Yw/8lo
	ioYg7khyMoYE6eKbr/zwg2msKU237JI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788862059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3PepwHHkM+D7WdCatRqyZDV1QmpqXVTHByew5psvytQ=;
	b=knG5YV35NfGTPRiULj/VgM0PWBhx5FM8ZbmpQHc95d+WfMd2WThGjkHpRepdv/KO0iT0D/
	GC0FvHywzi59S1BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CBBE13332;
	Tue,  8 Sep 2026 10:07:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I3ufFmven2q3AQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Sep 2026 10:07:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E173DA12E2; Tue, 08 Sep 2026 12:07:34 +0200 (CEST)
Date: Tue, 8 Sep 2026 12:07:34 +0200
From: Jan Kara <jack@suse.cz>
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chao Shi <coshi036@gmail.com>, 
	Weidong Zhu <weizhu@fiu.edu>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Ridong Chen <chenridong@xiaomi.com>
Subject: Re: [PATCH next] buffer: guard folio_test_dropbehind() against a
 NULL b_folio in __bh_submit()
Message-ID: <mpqseqzxcgyug5cwk5sivtyngvtcz7az7pugzv65nkm3ylmwjq@rfhz34dg655s>
References: <20260908023600.788219-1-ridong.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908023600.788219-1-ridong.chen@linux.dev>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,xiaomi.com:email,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,fiu.edu,vger.kernel.org,xiaomi.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,xiaomi.com:email]
X-Spam-Flag: NO

On Tue 08-09-26 10:36:00, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> Commit 8deae2284976 ("buffer: allow a buffer_head to point at memory
> outside the page cache") made bh->b_folio optional: jbd2 submits a shadow
> buffer_head whose data lives in slab (the frozen/escaped copy of a metadata
> block), and such a buffer carries no folio at all - b_folio stays NULL from
> alloc_buffer_head() onwards (see the comment in
> jbd2_journal_write_metadata_buffer()).  That commit audited __bh_submit()
> and taught bio_add_folio_nofail() and wbc_account_cgroup_owner() to check
> for a NULL folio, but it missed an earlier dereference:
> 
> 	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
> 		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
> 
> That test was added by commit a2c924c240e7 ("buffer: set
> BIO_COMPLETE_IN_TASK for dropbehind writeback"), which predates the
> NULL-b_folio semantics and so dereferenced b_folio unconditionally.  Once
> b_folio may be NULL, folio_test_dropbehind() reads NULL->flags and the
> kernel takes a NULL pointer dereference.
> 
> This is reached from the jbd2 commit path (bh_submit() -> __bh_submit())
> whenever a shadow buffer is submitted, i.e. when a metadata block has to be
> escaped or was copied out, so it is data/timing dependent rather than seen
> on every commit.  When it does hit, it is deterministic and independent of
> the dropbehind bit, since the flag test dereferences the folio before
> examining it.
> 
> Reproduced on x86_64 with KASAN under filesystem write pressure:
> 
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:__bh_submit+0x21b/0x9d0
>   Call Trace:
>    bh_submit+0x15/0x30
>    jbd2_journal_commit_transaction+0x1c19/0x5ac0
>    kjournald2+0x1cf/0x760
> 
> Guard the flag test with a b_folio check, matching the other folio
> accesses in the same function.
> 
> Fixes: 8deae2284976 ("buffer: allow a buffer_head to point at memory outside the page cache")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>

A similar fix was already posted here [1] and is on its way to upstream.

								Honza

[1] https://lore.kernel.org/all/20260902013357.2815214-1-joseph.qi@linux.alibaba.com/

> ---
>  fs/buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 427d8a817cd5..f46fa6413032 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1106,7 +1106,8 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
>  
>  	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
>  
> -	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
> +	if (bh->b_folio && folio_test_dropbehind(bh->b_folio) &&
> +	    op_is_write(opf))
>  		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>  
>  	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
