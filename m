Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD07392828
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200529; cv=none; b=JitAttlkpnQyYjIylE2hIFy/AI6HQ+Jqc5WXULw7O2Oi1oFyduzg4AdBkF4tXDUfgA4ROI5CC7NefioMwOlXH9wZhAtN5hU3TSJUiK8Gh2pbWSvqVSzAEnyi9p0FjqNO+NGcTli/DcFzvSMlN5uKZDqxBwMv0+Y5IyrnURed6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200529; c=relaxed/simple;
	bh=+d07ctN9vJc03vVv4Ka18r3+LNjei/BYsccG0Hi5LPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKwJUZJqO5gez6uky/jgQ/+QLYxmTiB+l750keMShsDBH9nGZLfbkG1Z528qd1ECtHWgZl5hXvLky86WueegV55bMQFbatHuIUlBTc6AAK8kNNtF8eAgNqSPnbxNv9nXDVTsecdPzwl1fDSCgVe7rNXrkvsPd8o7wVCdxseDmLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y8pe5nNd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSWWo0Op; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y8pe5nNd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSWWo0Op; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y8pe5nNd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSWWo0Op";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y8pe5nNd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSWWo0Op"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC00378910;
	Thu, 16 Jul 2026 11:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784200525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKasMQpFETwoHWai7FC3B+Bdca2ypN4wjEmQ/W2O48k=;
	b=y8pe5nNds2/EEbhkp7FNU2fqZVsusCgm0VJrVqe8A830LIke5RBmXLFGFpUhdzGuOuE3SX
	d2jnetYhSN4C0sHT2+7r7IB7p4Cb8oC8hT6TGHCBbMNmNybj7EOmWgwdqkeiQFAr5rq3dP
	nzwXKdo0U4x5DsXvwdcS53C9gmPDLrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784200525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKasMQpFETwoHWai7FC3B+Bdca2ypN4wjEmQ/W2O48k=;
	b=kSWWo0OprfQewV8/i2qaJdVuwlls3w2M3kMCf2TDr1Y5wo+51Zi1gq7fJf85Gy1EG7KyfK
	P9m9q6f8UgPbEQBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784200525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKasMQpFETwoHWai7FC3B+Bdca2ypN4wjEmQ/W2O48k=;
	b=y8pe5nNds2/EEbhkp7FNU2fqZVsusCgm0VJrVqe8A830LIke5RBmXLFGFpUhdzGuOuE3SX
	d2jnetYhSN4C0sHT2+7r7IB7p4Cb8oC8hT6TGHCBbMNmNybj7EOmWgwdqkeiQFAr5rq3dP
	nzwXKdo0U4x5DsXvwdcS53C9gmPDLrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784200525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKasMQpFETwoHWai7FC3B+Bdca2ypN4wjEmQ/W2O48k=;
	b=kSWWo0OprfQewV8/i2qaJdVuwlls3w2M3kMCf2TDr1Y5wo+51Zi1gq7fJf85Gy1EG7KyfK
	P9m9q6f8UgPbEQBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3506779AD;
	Thu, 16 Jul 2026 11:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rKjdJ029WGqDAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jul 2026 11:15:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51A49A0855; Thu, 16 Jul 2026 13:15:21 +0200 (CEST)
Date: Thu, 16 Jul 2026 13:15:21 +0200
From: Jan Kara <jack@suse.cz>
To: Li Chen <me@linux.beauty>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfs: handle FS_IOC32_GETVERSION in compat ioctl
Message-ID: <otzlginv2dxlzgyoya454oidpepdmfizwgttl7noru7wenhi3t@6v2yywvt376q>
References: <20260716052822.1034228-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716052822.1034228-1-me@linux.beauty>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

On Thu 16-07-26 13:28:20, Li Chen wrote:
> FS_IOC32_GETVERSION has a distinct compat command encoding. Passing it
> through compat_ptr_ioctl() leaves pidfd_ioctl() unable to recognize the
> otherwise architecture-independent inode generation query.
> 
> Translate the compat command to FS_IOC_GETVERSION before dispatching it
> through the native pidfd ioctl implementation.
> 
> Signed-off-by: Li Chen <me@linux.beauty>

It's a bit sad we have to do this but you seem to be right. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>


> ---
>  fs/pidfs.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c20ffd747ff51..c55f46c32801d 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/anon_inodes.h>
> +#include <linux/compat.h>
>  #include <linux/exportfs.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> @@ -659,6 +660,17 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	return open_namespace(ns_common);
>  }
>  
> +#ifdef CONFIG_COMPAT
> +static long pidfd_compat_ioctl(struct file *file, unsigned int cmd,
> +			       unsigned long arg)
> +{
> +	if (cmd == FS_IOC32_GETVERSION)
> +		cmd = FS_IOC_GETVERSION;
> +
> +	return pidfd_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
> +}
> +#endif
> +
>  static int pidfs_file_release(struct inode *inode, struct file *file)
>  {
>  	struct pid *pid = inode->i_private;
> @@ -686,7 +698,9 @@ static const struct file_operations pidfs_file_operations = {
>  	.show_fdinfo	= pidfd_show_fdinfo,
>  #endif
>  	.unlocked_ioctl	= pidfd_ioctl,
> -	.compat_ioctl   = compat_ptr_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= pidfd_compat_ioctl,
> +#endif
>  };
>  
>  struct pid *pidfd_pid(const struct file *file)
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
