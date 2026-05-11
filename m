Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC14279E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515863; cv=none; b=n14BVc+ZQO8LcOe6cQ+7jaOUSjEvQ6nNJKlM+1R34Z7q0kpsxbThFUyuRvdce2gmpEJOP8ZAmopBRFVDHTw3xQcToe8cTaKMjsIiawXrsdYhfdgHh1/Vr/svxv98P/VXDxsmh8p0NFWQ/tfro+oD5iX1KeVBUrPYa5Fkf2YcQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515863; c=relaxed/simple;
	bh=a7NmzoyWqFhHkhmmoBDHE5Fupy2NSpDMzOj0EAcKe48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8KSHqgJ0lOhOmu6kRqaWdZhYEBFyBRoXCnfImuhUfz03q5efi+Odtlclt6adKkKdJI0IeclWpcLlcYBK0pWckl1y80zSa/st8RXhPIo2eblrECqmhJUmMl1fR20x/p02Qt2QbFTH7DiqyOTHCp6VHyOrSJPJLyk+kbTF0z86cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TR+qanZ3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uvna0LcX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K1fxEjGa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XM5wuyMk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TR+qanZ3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uvna0LcX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K1fxEjGa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XM5wuyMk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BD1C65F68F;
	Mon, 11 May 2026 16:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778515860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dHCereSCwPGtptXFhJTG+je6AuNNbQ1TCMrEuoURpQA=;
	b=TR+qanZ3H8T0Xm6bUC+iCc7tjZVhTFgq9mtogNd2kbyuyewzr02s2JrgZRWtp+Sq9WuuIR
	OYzkjLxE7HP0eQejWc4bRexvXq+aRAcxWjgaslRD8HjvZ9LtTG1fVoEkaSRvMJj02G8wYi
	dXe59UaCySeQ+ofgNjgD7YjDGcZG+o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778515860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dHCereSCwPGtptXFhJTG+je6AuNNbQ1TCMrEuoURpQA=;
	b=Uvna0LcXPhiLO/wdSCpFCHPAxKjhTd+D/ROXQ4uGsNTJ/bNsresyYhr1bCv6oFIQ91rS4l
	T9qkVOZdD+vjFEBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778515859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dHCereSCwPGtptXFhJTG+je6AuNNbQ1TCMrEuoURpQA=;
	b=K1fxEjGaewNJbqrvrkQodS1dBdFh+aSsKcxt24Ho3VMyPWcbfMXtEHwnr6np3G/gnb0HIH
	Bns2Otbd9/NkM6IVXW16fbbdfY6+TPEAtsOxE139KE+reOCGqb2CHV7kSx1IA7qNSM3wdg
	rUFMTPa2+pZAnOaxJiPHG7XG7KsXyF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778515859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dHCereSCwPGtptXFhJTG+je6AuNNbQ1TCMrEuoURpQA=;
	b=XM5wuyMkE+1w7amC4q0f3Jt7Nyi/OEyzUUi1hO3LvJh1a0FCugpccAZqroTUzBpRFdEwhT
	8ZGaukEahlk1OLCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D1D8593A3;
	Mon, 11 May 2026 16:10:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lue4FpP/AWrISwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 May 2026 16:10:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03AC1A079E; Mon, 11 May 2026 18:10:59 +0200 (CEST)
Date: Mon, 11 May 2026 18:10:58 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	Dave Kleikamp <shaggy@kernel.org>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Bob Copeland <me@bobcopeland.com>, Anders Larsen <al@alarsen.net>, linux-fsdevel@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/10] bfs: handle set_blocksize failures
Message-ID: <xhrhv2me7xqmem6x3u4aoh2crkdveencprsoovpy2yuj6npos3@tu325ohquuyj>
References: <20260511071701.2456211-1-hch@lst.de>
 <20260511071701.2456211-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511071701.2456211-2-hch@lst.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon 11-05-26 09:16:46, Christoph Hellwig wrote:
> bfs uses buffer_heads, which don't handle block size > PAGE_SIZE well.
> Without this, mounting will hit the
> 
> 	BUG_ON(offset >= folio_size(folio));
> 
> in folio_set_bh on the first __bread_gfp call.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/bfs/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> index 19e49c8cf750..9c3e90390824 100644
> --- a/fs/bfs/inode.c
> +++ b/fs/bfs/inode.c
> @@ -346,7 +346,8 @@ static int bfs_fill_super(struct super_block *s, struct fs_context *fc)
>  	s->s_time_min = 0;
>  	s->s_time_max = U32_MAX;
>  
> -	sb_set_blocksize(s, BFS_BSIZE);
> +	if (!sb_set_blocksize(s, BFS_BSIZE))
> +		goto out;
>  
>  	sbh = sb_bread(s, 0);
>  	if (!sbh)
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
