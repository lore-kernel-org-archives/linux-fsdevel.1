Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33319C556
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327491; cv=none; b=MW8UoKQlrO7A9cVHMZnn/PgZ/M2J8lQcbhNjaG3k7o1hSrtQ8sJnVZVcEGjxQUEv5a6PchiIfnN1Z0/odJFWHCpxmnqJOde4vjj8+eaEj92JsQ7PGGnvsmn2TuPSkXYVR1TiETjfUPqVowik+4G65LKck3rIp/j25LfoEvasCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327491; c=relaxed/simple;
	bh=Youvu+/98a1GQmyNgxxq0VIsqE7FMhqzQ+yGosrBDV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRF0qH4k+yRYaBgmMBqfV4IN0WhhyUxNdd/S9XfBKCwSXMhku0bmcII4fS048JQHddH2C5Qt+AouLIuEX9QUWuzcscvF9ljyQJpBnbuDQdfC51gC1szfOrktfTzlRolHII8+8rZl0/vkEOd56jxom2tZcu0PbvdD+6u9nEbUHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ldLznwij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NsXKB8zZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ldLznwij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NsXKB8zZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ldLznwij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsXKB8zZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ldLznwij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsXKB8zZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B41F466E95;
	Mon,  1 Jun 2026 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780327484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVoyn1A1p/psU+AB0Abkwtx3wFgJUJhGvT7b7VguNYw=;
	b=ldLznwijLsWdwlAL6Syza2RLKIxPHsZtn1TXVQRdxOLyordhPLkwfNripWlw3NHjuzTyQ0
	fzF8IAe8Cnx+p6Scz6u3tAHoMMv70hrmSq//f4KY9UM17go2+P9yXnL5MjUSR4h76jXyjF
	NtwgsKfbok9Y0ku7X77ED0JvhizSF0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780327484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVoyn1A1p/psU+AB0Abkwtx3wFgJUJhGvT7b7VguNYw=;
	b=NsXKB8zZoCQqTrSDWsdIHmwLtOqlzi5YTFJ2PmDo22WGtLohZQxuxPvTpGQPira8NUaP3S
	DatsBr/kdjb1xpDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780327484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVoyn1A1p/psU+AB0Abkwtx3wFgJUJhGvT7b7VguNYw=;
	b=ldLznwijLsWdwlAL6Syza2RLKIxPHsZtn1TXVQRdxOLyordhPLkwfNripWlw3NHjuzTyQ0
	fzF8IAe8Cnx+p6Scz6u3tAHoMMv70hrmSq//f4KY9UM17go2+P9yXnL5MjUSR4h76jXyjF
	NtwgsKfbok9Y0ku7X77ED0JvhizSF0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780327484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVoyn1A1p/psU+AB0Abkwtx3wFgJUJhGvT7b7VguNYw=;
	b=NsXKB8zZoCQqTrSDWsdIHmwLtOqlzi5YTFJ2PmDo22WGtLohZQxuxPvTpGQPira8NUaP3S
	DatsBr/kdjb1xpDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9527779A7;
	Mon,  1 Jun 2026 15:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LZxPKTykHWoHPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jun 2026 15:24:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B797A0EC0; Mon, 01 Jun 2026 17:24:36 +0200 (CEST)
Date: Mon, 1 Jun 2026 17:24:36 +0200
From: Jan Kara <jack@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: brauner@kernel.org, amir73il@gmail.com, jack@suse.cz, 
	repnop@google.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: register event pid for pidfd reporting
Message-ID: <dolfs6j4x4thpgluglxhlepg34l5uvvxv2sjcmuao57bxnbtjb@urx5vgczxbup>
References: <20260530013732.50811-1-anonymemeow@gmail.com>
 <20260530105117.45792-1-anonymemeow@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530105117.45792-1-anonymemeow@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,suse.cz,google.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 

On Sat 30-05-26 18:51:17, AnonymeMeow wrote:
> pidfd_prepare() may still fail if userspace reads the event after the
> task has been reaped and the pid has not been registered with pidfs.
> Register the event pid with pidfs when creating the fanotify event if
> pidfd reporting was requested, so pidfd_prepare() can later create a
> pidfd for the reaped task.
> 
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

So the two patches in this series so far look good to me. This patch looks
OK to me as well and since the overhead of allocation etc. is only once per
registered task, I think it's fine but let's wait a bit whether Christian
agrees this is what needs to be done.

								Honza

> ---
> 
> Hi, Christian,
> 
> I tested this patch set and found that fanotify still usually can not
> report pidfds for reaped tasks, because the event pid may not have
> been registered before it exits, and registering it after the task
> has been reaped is not allowed, so fanotify still fails to report a
> pidfd for the event.
> 
> This patch registers the event pid when the fanotify event is created.
> With this change, the current LTP fanotify21 test fails as expected.
> 
> But I do not know whether it is worth doing so to improve fanotify's
> ability to report pidfds for reaped tasks. And, what should fanotify
> do if pidfs_register_pid() fails? Should the error be reported to
> userspace through the pidfd info record, using the raw error when
> FAN_REPORT_FD_ERROR is set and FAN_EPIDFD otherwise? But the event
> struct in fanotify does not have spare space to store this error code.
> Or should it just ignore the failure here and let pidfd_prepare()
> fail later in copy_event_to_user()? I would appreciate your feedback.
> 
> With Best Regards,
> AnonymeMeow
> 
> Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/
> 
> ---
>  fs/notify/fanotify/fanotify.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 38290b9c07f7..24b2af397126 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -14,6 +14,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/statfs.h>
>  #include <linux/stringhash.h>
> +#include <linux/pidfs.h>
>  
>  #include "fanotify.h"
>  
> @@ -868,6 +869,15 @@ static struct fanotify_event *fanotify_alloc_event(
>  	else
>  		pid = get_pid(task_tgid(current));
>  
> +	if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD)) {
> +		int err = pidfs_register_pid(pid);
> +		if (err) {
> +			/*
> +			 * What to do here? Pass this err to userspace via pidfd?
> +			 */
> +		}
> +	}
> +
>  	/* Mix event info, FAN_ONDIR flag and pid into event merge key */
>  	hash ^= hash_long((unsigned long)pid | ondir, FANOTIFY_EVENT_HASH_BITS);
>  	fanotify_init_event(event, hash, mask);
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
