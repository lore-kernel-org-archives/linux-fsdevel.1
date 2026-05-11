Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BC942E009
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515707; cv=none; b=ey040dsDvXfIv2CQMW3ZB0HN+nVyf/tZbWIYGAR8PwIrc9x4lOjAQNMV0BIDikm1fz4pZfHLPENlaj4eveULFc70iKDJzJyOfRTAaWIpf8kd68DDe6Bm63mqs3dQz/Ms294iNq4AK0kcrmwRt0YtBYQhlq/o6THjQC9SA8xPpUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515707; c=relaxed/simple;
	bh=Nex8lPxLdHFCgIQClV3pK+gx/d15OefpM5JcdFYZI70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW/ccNSOxYaKzW8fBWAZ5z60F0YzQ5PGLQPeu9nsnfm/85qUl7LLqzSkIvG9FYlvzKu9BdEKMRsyYdjO5F0xn5tqjE362hublVhKGooRvM8rzLoArNIYk44Ar+TkEFU2VapoHkxxPH3XOSgTx/6MRfu6pn0+0PbYaF1pyL6blPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QZol5d0S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Il8p69kn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QZol5d0S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Il8p69kn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QZol5d0S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Il8p69kn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QZol5d0S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Il8p69kn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD08A5F5B9;
	Mon, 11 May 2026 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778515702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tcIEVBaVodUiSosdygBt1PqHBt7fsQlRKsYMMX7LIJc=;
	b=QZol5d0S5JpQZpfbn2WEvu8oMis72c+s3F8LmKfmYZ+KjD7IzpfUGztsbcWyBAQ9oEXZz4
	3DqZiU73Q3N9FlxCrWIQuB0qPx6MZq2VJi7ZR3qLvjaK0mt77K0OLqEUZ2EasLAnQrxiqJ
	OSIaEFKxuaja683u/6bOLBgl9rvmC5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778515702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tcIEVBaVodUiSosdygBt1PqHBt7fsQlRKsYMMX7LIJc=;
	b=Il8p69knNuAbtu10vesW6cQn17T4FTlBdMzNK/7tOlnHjKK+yH08L+1pU54VNA8vZAzPDj
	N+c7oU1+EWvAQQAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778515702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tcIEVBaVodUiSosdygBt1PqHBt7fsQlRKsYMMX7LIJc=;
	b=QZol5d0S5JpQZpfbn2WEvu8oMis72c+s3F8LmKfmYZ+KjD7IzpfUGztsbcWyBAQ9oEXZz4
	3DqZiU73Q3N9FlxCrWIQuB0qPx6MZq2VJi7ZR3qLvjaK0mt77K0OLqEUZ2EasLAnQrxiqJ
	OSIaEFKxuaja683u/6bOLBgl9rvmC5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778515702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tcIEVBaVodUiSosdygBt1PqHBt7fsQlRKsYMMX7LIJc=;
	b=Il8p69knNuAbtu10vesW6cQn17T4FTlBdMzNK/7tOlnHjKK+yH08L+1pU54VNA8vZAzPDj
	N+c7oU1+EWvAQQAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAEE3593A3;
	Mon, 11 May 2026 16:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X6+PLfb+AWrrSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 May 2026 16:08:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 56D4EA079E; Mon, 11 May 2026 18:08:18 +0200 (CEST)
Date: Mon, 11 May 2026 18:08:18 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	Dave Kleikamp <shaggy@kernel.org>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Bob Copeland <me@bobcopeland.com>, Anders Larsen <al@alarsen.net>, linux-fsdevel@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH 08/10] minix: handle set_blocksize failures
Message-ID: <mxb2r7knst7hz2k454w6i7xy62kd6pyj6m2zqsaddkxqpzykxu@zqpqtbnigdp6>
References: <20260511071701.2456211-1-hch@lst.de>
 <20260511071701.2456211-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511071701.2456211-9-hch@lst.de>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,suse.com,gmail.com,artax.karlin.mff.cuni.cz,paragon-software.com,bobcopeland.com,alarsen.net,vger.kernel.org,lists.sourceforge.net,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

On Mon 11-05-26 09:16:53, Christoph Hellwig wrote:
> minix uses buffer_heads, which don't handle block size > PAGE_SIZE well.
> Without this, mounting we will hit the
> 
>         BUG_ON(offset >= folio_size(folio));
> 
> in folio_set_bh on the first __bread_gfp call.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/minix/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index 9c6bac248907..03a69b13950d 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -292,7 +292,8 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
>  		sbi->s_namelen = 60;
>  		sbi->s_version = MINIX_V3;
>  		sbi->s_mount_state = MINIX_VALID_FS;
> -		sb_set_blocksize(s, m3s->s_blocksize);
> +		if (!sb_set_blocksize(s, m3s->s_blocksize))
> +			goto out;

This should go to out_release AFAICT. Otherwise we leak the bh.

								Honza

>  		s->s_max_links = MINIX2_LINK_MAX;
>  	} else
>  		goto out_no_fs;
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
