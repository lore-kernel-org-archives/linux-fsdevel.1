Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3349BD80;
	Wed, 23 Sep 2026 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161485; cv=none; b=V0rWm4/wFrhHb1kDYG25CNDdUDqvNepWHknji6MrguI502xpGlMmu/KcjTBYylSS12FU7WcXbemH2bNN3OyzVuIN/sw5YQY3apfFwYysw0QHmQEdfIiL7l3bHQ08q4dRAn5luy+t+tUBxkmVYX6kHaVMO+KEY0wdSu+frLWGMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161485; c=relaxed/simple;
	bh=kxTqkNtvxN0XjMpp4rSpGhLun3/g+6Eg8rwAP2+IoTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShkMeqcaI3hNUPU93CNprQn1PSm8ax3nEswUVDsmTJdBY7XoHu48O6uAdt5RaKcsQh4bgOkwJPjKSmEIJs7DRpwl9cdzjpBg/zZNe/SPKz+q8DVXfpofY2cb2yPf9ont0WubK2PFWQBywNW331oOZ0+Bx0R9wouDYfUNrokdmNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MQnFioPh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aZzK7TRO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zo7xb20k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FkEhMlh5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MQnFioPh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aZzK7TRO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zo7xb20k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FkEhMlh5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CB4721BB2;
	Wed, 23 Sep 2026 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790161471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw6OkokeLJIdu1oinf7DlsoIhLYgDcqiLRuvFSPgqyk=;
	b=MQnFioPhgeIejxKWrNjckzk367ULWmL5GIGoBCDDXJcS0PfcL3TgJz0cwbmhIh1qHzv8UA
	vIQGQjCB7XoIL/BJK/X5QFC9kekm51gfZmV/LFp3C7z8T1O6enNjIdkIcH5Dcukh5u91z+
	9USXVhagandgHW+F5+jbDwBtF8sC+E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790161471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw6OkokeLJIdu1oinf7DlsoIhLYgDcqiLRuvFSPgqyk=;
	b=aZzK7TROlnjeMzFWXWDMOgcSzKiXbl0VUCMIpz5Muwax6LOBFK/pXbTUPO53NTvVwWdigi
	p8ez/lhAhgodaaCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Zo7xb20k;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FkEhMlh5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790161467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw6OkokeLJIdu1oinf7DlsoIhLYgDcqiLRuvFSPgqyk=;
	b=Zo7xb20kJMQw7vHSdcUPyERhkeJlCIQ94/BozAv/AJKGLOMwTi8aGK39ls7+SQy4VebKPi
	ljC6M+HFwiBmutpAbp39BW+pW7HPq8fcUHhVCC24EYjpfIb/S1zGMdKdu3Iu5GqGXaeb5d
	gx6wp9tYkj6b+Ocl5bhAexu5hqh4hzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790161467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw6OkokeLJIdu1oinf7DlsoIhLYgDcqiLRuvFSPgqyk=;
	b=FkEhMlh5s59LHFAhX79MuKcQm05eRBEBTmJ00Mnm+fOw/I1i/nTFlRYobVFPz3/2AdrhKU
	HdmeuQFyM/O5D6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29C0B13432;
	Wed, 23 Sep 2026 11:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LLdGATuys2pEAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 11:04:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A8058A13D4; Wed, 23 Sep 2026 13:04:26 +0200 (CEST)
Date: Wed, 23 Sep 2026 13:04:26 +0200
From: Jan Kara <jack@suse.cz>
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yefan@hygon.cn, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fs/drop_caches: skip filesystems without fs writeback
Message-ID: <eabsxquvvzvn5nmffrdlpnrgm7bmajy5we4lufiyzk3l3ixope@h63fhuf4y5dd>
References: <20260923070116.3226846-1-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923070116.3226846-1-huangsj@hygon.cn>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 7CB4721BB2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hygon.cn:email,suse.cz:dkim,suse.cz:email,lst.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

On Wed 23-09-26 15:01:16, Huang Shijie wrote:
> Filesystems backed by the noop backing device (procfs, sysfs, kernfs,
> tmpfs, ramfs, etc.) have no fs page-cache writeback.  Skip them in
> drop_pagecache_sb() instead of walking their inode lists.
> 
> This also skips tmpfs/ramfs. tmpfs has clean folios which are
> zero-filled pages from reading holes, which are trivially recreatable.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Huang Shijie <huangsj@hygon.cn>

This looks indeed nice & simple. I'm slightly wondering if there isn't some
exotic read-only fs somewhere which doesn't set sb->s_bdi but so far I'm
not aware of anything (even MTD filesystems do properly setup bdi) so feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> The RFC mails:
>    https://lore.kernel.org/all/arIVBpMZk5-O2AZc@infradead.org/
> ---
>  fs/drop_caches.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index 49f56a598ecb..28c5fb9c7357 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -7,6 +7,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/fs.h>
> +#include <linux/backing-dev.h>
>  #include <linux/writeback.h>
>  #include <linux/sysctl.h>
>  #include <linux/gfp.h>
> @@ -20,6 +21,9 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
>  {
>  	struct inode *inode, *toput_inode = NULL;
>  
> +	if (sb->s_bdi == &noop_backing_dev_info)
> +		return;
> +
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>  		spin_lock(&inode->i_lock);
> -- 
> 2.53.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
