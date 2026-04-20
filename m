Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A73DC4A5
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695857; cv=none; b=jJbpfDEmLOBi0X2tFCQzN99AnZiyR1ylu576B9RHz+dCM/VlTrH8oZ5P/WWlJ3rgqBB2/kAMxWoFP2LhNEB7Uhizc6umqmfEKxudj9yXrp3kc4POk7iko9fW2B/WTBfzr7HKVhLX17AXBTZmGWIjp1se602AzMny76Lq0geI8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695857; c=relaxed/simple;
	bh=8f8r9D05z66yFZB8PlwZx7bRvvR5EVuh5ioPmSvk434=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URp6Vooi2clJSoK0oA2gkojVBmVv9FYKRzwxzbsaeh0XXxndW5UWj+QJr3GfXv0covZ3sSd1WOZEyTOXymUEEIuh9uJQET0rj07yII6XjtZPqc7IR8p0T9z2ISqbXcdOReN3w3rZSNPUNJuancyfhjtGfV8NnGByY6skJ+zt2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vNNH7lv6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s62krNrz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vNNH7lv6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s62krNrz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vNNH7lv6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s62krNrz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vNNH7lv6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s62krNrz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3CC4A6A7E9;
	Mon, 20 Apr 2026 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9Sht0RCpDykUHgnBn+MnpiaegOoYQYhSjnmhhz/xxs=;
	b=vNNH7lv6wPVdqjELgxKd2J3shedILPRp4cGeGy4TCaMUXE1kw17UGUMKeEIAC4cqZMSnrR
	kxNYaluacrI9938dLYW81SfzRSZWE3mPgCznnnDKxpi/2E+q0SnbXlwTkIWElSfyOmS3xT
	yvXxXc63AKzDdo5M9shhMPXU1HQ21Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9Sht0RCpDykUHgnBn+MnpiaegOoYQYhSjnmhhz/xxs=;
	b=s62krNrzHGWeeFpPGkwrNBM4GrPHz7SNMkrOU52/cOQdlwWIDJIndgH9bjFMnZdkh1YSPC
	Y4P+sL9nWfgRJrBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9Sht0RCpDykUHgnBn+MnpiaegOoYQYhSjnmhhz/xxs=;
	b=vNNH7lv6wPVdqjELgxKd2J3shedILPRp4cGeGy4TCaMUXE1kw17UGUMKeEIAC4cqZMSnrR
	kxNYaluacrI9938dLYW81SfzRSZWE3mPgCznnnDKxpi/2E+q0SnbXlwTkIWElSfyOmS3xT
	yvXxXc63AKzDdo5M9shhMPXU1HQ21Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9Sht0RCpDykUHgnBn+MnpiaegOoYQYhSjnmhhz/xxs=;
	b=s62krNrzHGWeeFpPGkwrNBM4GrPHz7SNMkrOU52/cOQdlwWIDJIndgH9bjFMnZdkh1YSPC
	Y4P+sL9nWfgRJrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F581593B0;
	Mon, 20 Apr 2026 14:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DcqECyI65mm2cgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 14:37:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D560A0C02; Mon, 20 Apr 2026 12:49:49 +0200 (CEST)
Date: Mon, 20 Apr 2026 12:49:49 +0200
From: Jan Kara <jack@suse.cz>
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, amir73il@gmail.com, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH v3 2/2] fanotify: introduce restartable permission events
Message-ID: <bcodsu6plppnwotjuisi7kvwkftpennowemslxur33qhtmd4qp@wc536gzxu53m>
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
 <20260416194844.3874004-3-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416194844.3874004-3-ibrahimjirdeh@meta.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[meta.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,toxicpanda.com,meta.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO

On Thu 16-04-26 12:48:44, Ibrahim Jirdeh wrote:
> This adds support for restarting permission events. The main goal of
> the change is to provide better handling for pending events for lazy
> file loading use cases which may back fanotify events by a long-lived
> daemon. For prior discussion of approaches see [1][2].
> 
> In terms of implementation, we add a new control-fd/queue-fd api.
> Control fd returned by fanotify_init keeps fanotify group alive and
> supports operations like fanotify_mark as well as a new ioctl
> FAN_IOC_OPEN_QUEUE_FD to open a queue fd. Queue fd is used
> for reading events and writing back responses. Upon release of
> queue fd, pending permission events are reinserted back into
> notification queue for reprocessing.
> 
> Control-fd/queue-fd api is guarded by FAN_RESTARTABLE_EVENTS flag.
> In addition FAN_RESTARTABLE_EVENTS can only be used in conjunction
> with FAN_CLASS_CONTENT or FAN_CLASS_PRE_CONTENT, and only permission
> events can be added to the mark mask if a group is initialized with
> FAN_RESTARTABLE_EVENTS.
> 
> [1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr
> [2] https://lore.kernel.org/linux-fsdevel/20250623192503.2673076-1-ibrahimjirdeh@meta.com
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>

Thanks for the patch. Some comments below...

> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 39e60218df7c..dd64af8313a9 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -552,3 +552,7 @@ static inline u32 fanotify_get_response_errno(int res)
>  {
>  	return (res >> FAN_ERRNO_SHIFT) & FAN_ERRNO_MASK;
>  }
> +
> +extern const struct file_operations fanotify_fops;
> +extern const struct file_operations fanotify_control_fops;
> +extern const struct file_operations fanotify_queue_fops;

Why cannot the ops remain static? I didn't find anything in this patch that
would require them to be extern...

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 787e57a00466..b4610c49daab 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1018,6 +1018,15 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>  			if (file->f_flags & O_NONBLOCK)
>  				break;
>  
> +			/*
> +			 * With FAN_RESTARTABLE_EVENTS, queue fd may
> +			 * outlive control fd. Return EOF if group
> +			 * is shut down.
> +			 */
> +			ret = 0;
> +			if (group->shutdown)
> +				break;
> +
>  			ret = -ERESTARTSYS;
>  			if (signal_pending(current))
>  				break;
> @@ -1101,6 +1110,7 @@ static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t
>   */
>  static void fanotify_restart_pending_events(struct fsnotify_group *group)
>  {
> +	mutex_lock(&group->fanotify_data.queue_mutex);
>  	spin_lock(&group->notification_lock);
>  	while (!list_empty(&group->fanotify_data.access_list)) {
>  		struct fanotify_perm_event *event;
> @@ -1121,10 +1131,21 @@ static void fanotify_restart_pending_events(struct fsnotify_group *group)
>  		}
>  	}
>  	spin_unlock(&group->notification_lock);
> +	group->fanotify_data.queue_opened = false;
> +	mutex_unlock(&group->fanotify_data.queue_mutex);
>  
>  	wake_up(&group->notification_waitq);
>  }
>  
> +static int fanotify_queue_release(struct inode *ignored, struct file *file)
> +{
> +	struct fsnotify_group *group = file->private_data;
> +
> +	fanotify_restart_pending_events(group);

I think fanotify_restart_pending_events() can run without the mutex, cannot
it? The queue fd is closing, new cannot be created until we clear
queue_opened. Then we can just lock the mutex here, clear queue_opened, and
drop it. It looks a bit cleaner if handling of queue_opened isn't hidden in
fanotify_restart_pending_events(). Also given how trivial
fanotify_restart_pending_events() ended up being, I'd just squash that
commit with this one.

> +	fsnotify_put_group(group);
> +	return 0;
> +}
> +
>  static int fanotify_release(struct inode *ignored, struct file *file)
>  {
>  	struct fsnotify_group *group = file->private_data;
> @@ -1182,6 +1203,44 @@ static int fanotify_release(struct inode *ignored, struct file *file)
>  	return 0;
>  }
>  
> +static int fanotify_open_queue_fd(struct file *file)
> +{
> +	struct fsnotify_group *group = file->private_data;
> +	int f_flags, fd;
> +	struct file *queue_file;
> +
> +	if (!FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS))
> +		return -EINVAL;
> +
> +	guard(mutex)(&group->fanotify_data.queue_mutex);

Do we really need a new mutex for this? AFAICS it is used only to serialize
fanotify_open_queue_fd() calls and fanotify_queue_release() calls. I think
we can happily use fsnotify_group_lock() / fsnotify_group_unlock() for
this?

> +
> +	if (group->fanotify_data.queue_opened)
> +		return -EBUSY;
> +
> +	f_flags = O_RDWR;
> +	if (group->fanotify_data.flags & FAN_CLOEXEC)
> +		f_flags |= O_CLOEXEC;
> +	if (group->fanotify_data.flags & FAN_NONBLOCK)
> +		f_flags |= O_NONBLOCK;
> +
> +	fd = get_unused_fd_flags(f_flags);
> +	if (fd < 0)
> +		return fd;
> +
> +	queue_file = anon_inode_getfile_fmode("[fanotify-queue]",
> +					      &fanotify_queue_fops, group,
> +					      f_flags, FMODE_NONOTIFY);

Please use new FD_ADD() infrastructure for this. fanotify_init() already
uses it.

> +	if (IS_ERR(queue_file)) {
> +		put_unused_fd(fd);
> +		return PTR_ERR(queue_file);
> +	}
> +	fsnotify_get_group(group);
> +	fd_install(fd, queue_file);
> +	group->fanotify_data.queue_opened = true;
> +
> +	return fd;
> +}
> +
>  static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>  	struct fsnotify_group *group;
> @@ -1207,7 +1266,21 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
>  	return ret;
>  }
>  
> -static const struct file_operations fanotify_fops = {
> +static long fanotify_control_ioctl(struct file *file, unsigned int cmd,
> +				   unsigned long arg)
> +{
> +	int ret = -ENOTTY;
> +
> +	switch (cmd) {
> +	case FAN_IOC_OPEN_QUEUE_FD:
> +		ret = fanotify_open_queue_fd(file);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +const struct file_operations fanotify_fops = {
>  	.show_fdinfo	= fanotify_show_fdinfo,
>  	.poll		= fanotify_poll,
>  	.read		= fanotify_read,
> @@ -1219,6 +1292,23 @@ static const struct file_operations fanotify_fops = {
>  	.llseek		= noop_llseek,
>  };
>  
> +const struct file_operations fanotify_control_fops = {
> +	.show_fdinfo	= fanotify_show_fdinfo,
> +	.release	= fanotify_release,
> +	.unlocked_ioctl	= fanotify_control_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +const struct file_operations fanotify_queue_fops = {
> +	.poll		= fanotify_poll,
> +	.read		= fanotify_read,
> +	.write		= fanotify_write,
> +	.release	= fanotify_queue_release,
> +	.unlocked_ioctl	= fanotify_ioctl,
> +	.compat_ioctl	= compat_ptr_ioctl,
> +	.llseek		= noop_llseek,
> +};

The new scheme with queue fd & control fd opens up an interesting new set
of races which needs a deeper thought I think. As it is currently
implemented for example if there's a task waiting for event on queue fd, it
will never wake up if control fd is closed. Similar problem is there for
fanotify_poll(). So we need to carefully define how operations on queue fd
synchronize with operations on control fd and closing of it in particular.
Besides dealing with the hung waits (which can be dealt with by just waking
the notification_waitq from fanotify_release()) we also need to deal with
fanotify_read() moving events from notification list to access list. I'm a
bit unhappy with how ad hoc and fragile this looks but so far don't have an
idea for a cleaner solution.

> +
>  static int fanotify_find_path(int dfd, const char __user *filename,
>  			      struct path *path, unsigned int flags, __u64 mask,
>  			      unsigned int obj_type)
> @@ -1640,6 +1730,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	int f_flags, fd;
>  	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
>  	unsigned int class = flags & FANOTIFY_CLASS_BITS;
> +	unsigned int restartable_events = flags & FAN_RESTARTABLE_EVENTS;
						  ^^^ Can we perhaps call
this FAN_EVENT_FD or something like that? Because I can forsee we will find
other interesting ways how to use the scheme with two fds and not all of
them tied to restarting of permission events. So FAN_RESTARTABLE_EVENTS
will become confusing at that point.

>  	unsigned int internal_flags = 0;
>  
>  	pr_debug("%s: flags=%x event_f_flags=%x\n",
> @@ -1718,10 +1809,17 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
>  		return -EINVAL;
>  
> -	f_flags = O_RDWR;
> +	/*
> +	 * FAN_RESTARTABLE_EVENTS requires FAN_CLASS_CONTENT or
> +	 * FAN_CLASS_PRE_CONTENT
> +	 */
> +	if (restartable_events && class == FAN_CLASS_NOTIF)
> +		return -EINVAL;
> +
> +	f_flags = restartable_events ? O_RDONLY : O_RDWR;

I don't think we really need to differentiate control vs queue fd with
O_RDONLY / O_RDWR. I'd just leave it with O_RDWR. Without implemented ops
any attempt to read / write will fail with EINVAL anyway.

>  	if (flags & FAN_CLOEXEC)
>  		f_flags |= O_CLOEXEC;
> -	if (flags & FAN_NONBLOCK)
> +	if (!restartable_events && (flags & FAN_NONBLOCK))
>  		f_flags |= O_NONBLOCK;
>  
>  	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
> @@ -1781,7 +1880,9 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	}
>  
>  	fd = FD_ADD(f_flags,
> -		    anon_inode_getfile_fmode("[fanotify]", &fanotify_fops,
> +		    anon_inode_getfile_fmode("[fanotify]",
> +					     (restartable_events ? &fanotify_control_fops :
> +					     &fanotify_fops),
>  					     group, f_flags, FMODE_NONOTIFY));
>  	if (fd >= 0)
>  		retain_and_null_ptr(group);
> @@ -1999,7 +2100,8 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		return -EBADF;
>  
>  	/* verify that this is indeed an fanotify instance */
> -	if (unlikely(fd_file(f)->f_op != &fanotify_fops))
> +	if (unlikely(fd_file(f)->f_op != &fanotify_fops &&
> +		fd_file(f)->f_op != &fanotify_control_fops))

Please indent like:

	if (unlikely(fd_file(f)->f_op != &fanotify_fops &&
		     fd_file(f)->f_op != &fanotify_control_fops))

>  		return -EINVAL;
>  	group = fd_file(f)->private_data;
>  
> @@ -2035,6 +2137,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		 group->priority == FSNOTIFY_PRIO_CONTENT)
>  		return -EINVAL;
>  
> +	/*
> +	 * With FAN_RESTARTABLE_EVENTS, a user is only allowed to setup
> +	 * permission events and modify event flags.
> +	 */
> +	if (FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS) &&
> +	    (mask & ~(FANOTIFY_FD_EVENTS | FANOTIFY_MOUNT_EVENTS |
> +		      FANOTIFY_EVENT_FLAGS)))
> +		return -EINVAL;
> +

Amir already commented this is wrong...

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
