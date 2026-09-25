Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DC3BB126;
	Fri, 25 Sep 2026 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328776; cv=none; b=reD9plZcmw2PNJiNrS4WXg0Lp8VHbeH7nbn3LrwqoQbm7IjJ6tnvkFLG0X/nTDvzqttlBWr6iZUwPXyZI0jnBpg3VwptDclIxrFWCmmRHM2RyETxf3hn7PB3Km034/l8sp8/TaLyKxm9es/YC7hgjQX11NSAmwlke8P0NKGSOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328776; c=relaxed/simple;
	bh=FZHOSQCbU0yz2LrTj5ZDV+Fs0nWY8u2ZMV0zLiKmZug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf23S5kQqY8qVP4OaNn8oJxo/5f2OgwwEiG03H2ESxuWg/zT3HljxQS3yHJDZasAfD2RccDCaRYJR3WaXq7cnxRwIs+0+wtuCLPxC7jJj6KumM/bvIihnRSdy7BsFQFpXfssD4NuHXn0Q+Lxgy6GtzuKm/ZnzdhVnyLj+TxRg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1rNEvZ2P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6ORble1B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jk8n2FUI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wRnNBuoq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1rNEvZ2P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6ORble1B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jk8n2FUI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wRnNBuoq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 114601FE16;
	Fri, 25 Sep 2026 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790328768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTvl1PDrKPezU5DYOL8yNnZhAwpezqrF/JSpQNHiXWk=;
	b=1rNEvZ2PhBySqCF/wwU+V994+Xz+QTrUabmAHu0iCOdQJGqV1nSfik6xZpMcSVVe9X0WJ9
	SSF85iAdsyMEeHBVE8swXaNtSfc9WoMDNYgfZCoWCY5RJDgz4QJ0sPYFGkp/BeItsk5t7g
	K+S9BwO7k13sPMh0T7+hcVowBYlWQ/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790328768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTvl1PDrKPezU5DYOL8yNnZhAwpezqrF/JSpQNHiXWk=;
	b=6ORble1BuI8FEuas8u9mdz5NNzYJTogVLDLctbONkrCXjbh0PFDlsZcdGi1Dr613BvBN0p
	Wm5TRimT971IC4DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790328764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTvl1PDrKPezU5DYOL8yNnZhAwpezqrF/JSpQNHiXWk=;
	b=jk8n2FUIh1bjnPfQjN9yHRNasI2gpOxqOgu0ZevrBunemkYMRnviEML8dv2Ii/sBEJUj/5
	F2e70TkRETUjjuVvG9ynk7hevafhxeZB3Lpi0TlITL/jqcVqsBel46NT7sSRnWmTO1x/j6
	ugjvZJFYXG/U6EjIPT5x+ydX/J8TsIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790328764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTvl1PDrKPezU5DYOL8yNnZhAwpezqrF/JSpQNHiXWk=;
	b=wRnNBuoqxB+7sJA/tTv/obyu6z5J1N+jzZytXcB66UVpA0dkyhF89Po0wpvlNURkf3CweV
	kkArOg0Ok/d+Q8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBF4913432;
	Fri, 25 Sep 2026 09:32:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qIiZLbs/tmoxLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 25 Sep 2026 09:32:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6DEF7A13DA; Fri, 25 Sep 2026 11:32:43 +0200 (CEST)
Date: Fri, 25 Sep 2026 11:32:43 +0200
From: Jan Kara <jack@suse.cz>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs: porting.rst: use literal string to avoid warning
Message-ID: <hyk4puvpheleitf4kt74aamqex2ytuxpda2iki5bgzoteldf23@pccvy6sdmerx>
References: <20260924183915.400588-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924183915.400588-1-rdunlap@infradead.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,lwn.net:email,intel.com:email,linuxfoundation.org:email,infradead.org:email,suse.cz:email]
X-Spam-Flag: NO

On Thu 24-09-26 11:39:15, Randy Dunlap wrote:
> Avoid the docutils warning:
> 
> Documentation/filesystems/porting.rst:1417: WARNING: Inline emphasis start-string without end-string. [docutils]
> 
> by quoting the const pointer in literal quotation marks.
> (Adding a space between the '*' and the '.' also works but it looks odd.)
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609231806.ILZP6Fy0-lkp@intel.com/
> Fixes: 025756ee7b47 ("fs: port mnt_idmap() and file_mnt_idmap() to const mnt_idmap")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks! Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> 
>  Documentation/filesystems/porting.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20260923.orig/Documentation/filesystems/porting.rst
> +++ linux-next-20260923/Documentation/filesystems/porting.rst
> @@ -1418,7 +1418,7 @@ All struct mnt_idmap pointers handed to
>  ->create(), ->mkdir(), ->mknod(), ->symlink(), ->rename(), ->setattr(),
>  ->getattr(), ->permission(), ->tmpfile(), ->get_acl(), ->set_acl() and
>  ->fileattr_set() as well as the xattr ->set() handler and the vfs_*()
> -helpers take a const struct mnt_idmap *. mnt_idmap() and file_mnt_idmap()
> +helpers take a ``const struct mnt_idmap *``. mnt_idmap() and file_mnt_idmap()
>  return one. The idmapping is immutable so nothing should have modified it
>  anyway. References are taken and dropped via mnt_idmap_get() and
>  mnt_idmap_put() as before, both accept a const pointer.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
