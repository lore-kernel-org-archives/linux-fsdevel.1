Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2971D3F7865
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500384; cv=none; b=hhzUMJk8GOav+V20aGRhsNc6OmpmGHWZF/Db8rGLR4DDVXFJc3iFtzy3Ffxc6wlwOXEfuieIn2eJNB46HktyIb4+P6t/rhqeaFRf877BSp4GnRan0+wmuqKyUbgbPUK57hXiSXIgKwjlfshF9FmkWzlwdeS31BTIq9JAXAWwQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500384; c=relaxed/simple;
	bh=GJmWFzM1yIn6zHol1MvWB7/xIbDpU0K/0zBdhF0oYmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kj+QfCjI1kvqJIwYJn3KUnInJ54c60mDnHyDNX6DlzZwTgjobhzurcVC8XlaH8mI6mGMZQCU3DMKyWqIhnU3dne2vOef+qa+v3vh0fBcZviCRYbR1AegrcoQ4rFlUYle4YRNUoj7RUhbIYDYmiD+p5dICFpsrsrtfyBRed7x3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w7ZE91A1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JdYT3pRq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mjhvBGEJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oy5vJssx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w7ZE91A1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JdYT3pRq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mjhvBGEJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oy5vJssx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 288F57DF4A;
	Fri, 31 Jul 2026 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785500375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjNFs9hiMVj91PcpoE+HXByjoZhHtNXsefArY022XaU=;
	b=w7ZE91A1JBEyvEIhiiSEI40ZMtusiFZTKB7CKjygJYk0OjmqLHqero2+os050/1GjkZQDz
	sa1ugTelFFECV2aohGEjR9Q910k8oMprka97ViVSW4ZNSiCd3u3nnT7crCUaeK2Zy3kRSG
	1MkcgcW1j/6TKEj5SIsOSc75Nz1CNEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785500375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjNFs9hiMVj91PcpoE+HXByjoZhHtNXsefArY022XaU=;
	b=JdYT3pRqooLC1/HHMOl40d54B3JEIAeBnzcWiCPqZhOs6+mry6wCiSWFlkKEITYVtZ/swo
	w/p9qvKMdyMP3LDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mjhvBGEJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oy5vJssx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785500371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjNFs9hiMVj91PcpoE+HXByjoZhHtNXsefArY022XaU=;
	b=mjhvBGEJwBN2dNygFrhnHS/9V9r3/WMTEc6FpNgO9WOwRH6VTqxW9H6lcRCFpVC4qJJ4gu
	L6eW0OsgMmKTVij/9gmxETldvrPB8lSEBdb5EZ3rZGmOTd1VQz3rb+G6KfGmdB40eDLsud
	KUStSS876CaMQJTIQZyYmotxzW+f5+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785500371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjNFs9hiMVj91PcpoE+HXByjoZhHtNXsefArY022XaU=;
	b=oy5vJssx9qoAqc53GpODibDHPubFT7BeLrmiJtQyERMb25z+Pgbzis6FCZmICmB1Xc551H
	5+uS5gVVdhQ0cNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BE4F779C7;
	Fri, 31 Jul 2026 12:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iavNBtOSbGrlfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 31 Jul 2026 12:19:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BD6CAA13A4; Fri, 31 Jul 2026 14:19:22 +0200 (CEST)
Date: Fri, 31 Jul 2026 14:19:22 +0200
From: Jan Kara <jack@suse.cz>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: jack@suse.cz, amir73il@gmail.com, repnop@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fanotify: report full event length for FIONREAD
Message-ID: <gpxknoebwrtfxspbgi7jhtprzimno2hdzb6pee2iwwtsatranb@prvukrmdldfp>
References: <20260731021827.602479-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731021827.602479-1-chenyichong@uniontech.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,uniontech.com:email,suse.com:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 288F57DF4A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Fri 31-07-26 10:18:27, Yichong Chen wrote:
> fanotify_ioctl(FIONREAD) reports the number of bytes available to read
> from the event queue.  It currently accounts only FAN_EVENT_METADATA_LEN
> for each queued event.
> 
> That underestimates events that carry additional information records, such
> as FAN_REPORT_DFID_NAME events.  A userspace program that uses FIONREAD to
> size its read buffer can receive a length that is smaller than the next
> event.  Reading with that buffer then fails with -EINVAL, while a larger
> buffer succeeds and reports a larger metadata.event_len.
> 
> Use fanotify_event_len() when summing queued events so FIONREAD includes
> all info records.
> 
> Fixes: 5e469c830fdb ("fanotify: copy event fid info to user")
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9ee373ff5840..33693886b7d8 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1150,11 +1150,13 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
>  {
>  	struct fsnotify_group *group;
>  	struct fsnotify_event *fsn_event;
> +	unsigned int info_mode;
>  	void __user *p;
>  	int ret = -ENOTTY;
>  	size_t send_len = 0;
>  
>  	group = file->private_data;
> +	info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
>  
>  	p = (void __user *) arg;
>  
> @@ -1162,7 +1164,8 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
>  	case FIONREAD:
>  		spin_lock(&group->notification_lock);
>  		list_for_each_entry(fsn_event, &group->notification_list, list)
> -			send_len += FAN_EVENT_METADATA_LEN;
> +			send_len += fanotify_event_len(info_mode,
> +						       FANOTIFY_E(fsn_event));
>  		spin_unlock(&group->notification_lock);
>  		ret = put_user(send_len, (int __user *) p);
>  		break;
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
