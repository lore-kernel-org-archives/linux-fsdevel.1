Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8B38552F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257272; cv=none; b=k4rVd58vNTndNtHsgoGJMhR2pnzjT3rji2WmLFvrgH+nNRNnG+1IBXVmfEWwqIpTh0d2y+XSWQqYrhLjcpE5cifMD4aAS6NTAYKR6wsqfNkAy+IhC2JiUqCwSpJHChwVsZ3wHZovzPpELZD+N51P601tR1Sz9++nKE65xnKS6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257272; c=relaxed/simple;
	bh=MMMCStvRprmmBBD8qum/nv5eVUZMojQsr/QdImTGU1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4PQtdNY+PmGS2ptcbeQhY1Le1gEdiCyuS5uTOdlYv8grkqkKmgU3yKEyErfiHR/XBpswr6l8G4M/CCfPKmZb3tj4HavOzJjhMEKXR/nsB2YmkT1O/K/XVLnrk7MpU4zJMDSGCBlhOdrj/fc0jHfFlCimworp1bo/t7/3IJhV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oRWi/eSA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uDkgSam+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oRWi/eSA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uDkgSam+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oRWi/eSA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uDkgSam+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oRWi/eSA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uDkgSam+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A3A505BD63;
	Mon, 23 Mar 2026 09:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774257268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWjKJk3ow0swx4Ab1nT/kqJ8g1GHRmQ5dbikFu4nsgY=;
	b=oRWi/eSAk8hHaX7itpodVPfr2hhobNFcYG/pfNeZXTbB9bOs7rcHqltp3lvarnHB46cOk1
	TJPdW2wXfDZz1Joc7dBRll5JDd+Fx6DGrfLM7VBsihdujTgrepau3wkhBbvhSz8OYAhZHk
	wJNRvbCYI7WbiajVIy8R7rb1hZlOtF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774257268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWjKJk3ow0swx4Ab1nT/kqJ8g1GHRmQ5dbikFu4nsgY=;
	b=uDkgSam+YXCgwuc3MAlrX2nlDvFKlDUbucu6igiXrW9JoDm1k3t8gEylg2mmjAIvYKMTXC
	BvhiH8crwQLKsLAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="oRWi/eSA";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uDkgSam+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774257268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWjKJk3ow0swx4Ab1nT/kqJ8g1GHRmQ5dbikFu4nsgY=;
	b=oRWi/eSAk8hHaX7itpodVPfr2hhobNFcYG/pfNeZXTbB9bOs7rcHqltp3lvarnHB46cOk1
	TJPdW2wXfDZz1Joc7dBRll5JDd+Fx6DGrfLM7VBsihdujTgrepau3wkhBbvhSz8OYAhZHk
	wJNRvbCYI7WbiajVIy8R7rb1hZlOtF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774257268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uWjKJk3ow0swx4Ab1nT/kqJ8g1GHRmQ5dbikFu4nsgY=;
	b=uDkgSam+YXCgwuc3MAlrX2nlDvFKlDUbucu6igiXrW9JoDm1k3t8gEylg2mmjAIvYKMTXC
	BvhiH8crwQLKsLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A91B437CE;
	Mon, 23 Mar 2026 09:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EJe6JXQEwWkpUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 09:14:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5081FA0B2E; Mon, 23 Mar 2026 10:14:24 +0100 (CET)
Date: Mon, 23 Mar 2026 10:14:24 +0100
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fanotify: replace deprecated strcpy in
 fanotify_info_copy_{name,name2}
Message-ID: <jdyy4txjjlmbwofqbsvpk53yx6cvx5lto47guv3nevpiflylhc@vjyncn6aesh3>
References: <20260321210544.519259-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321210544.519259-4-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A3A505BD63

On Sat 21-03-26 22:05:47, Thorsten Blum wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

I was a bit undecided about this one because I was wondering what
additional protection does the use of strscpy() bring here. But I guess the
protection from corrupted qstr (where the length doesn't match the real string
length) makes some sense. So I've taken the patch into my tree. Thanks!

								Honza

> ---
>  fs/notify/fanotify/fanotify.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 39e60218df7c..a0619e7694d5 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -2,6 +2,7 @@
>  #include <linux/fsnotify_backend.h>
>  #include <linux/path.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/exportfs.h>
>  #include <linux/hashtable.h>
>  
> @@ -218,7 +219,7 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
>  		return;
>  
>  	info->name_len = name->len;
> -	strcpy(fanotify_info_name(info), name->name);
> +	strscpy(fanotify_info_name(info), name->name, name->len + 1);
>  }
>  
>  static inline void fanotify_info_copy_name2(struct fanotify_info *info,
> @@ -228,7 +229,7 @@ static inline void fanotify_info_copy_name2(struct fanotify_info *info,
>  		return;
>  
>  	info->name2_len = name->len;
> -	strcpy(fanotify_info_name2(info), name->name);
> +	strscpy(fanotify_info_name2(info), name->name, name->len + 1);
>  }
>  
>  /*
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
