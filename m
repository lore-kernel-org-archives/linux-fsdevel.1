Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37851421A18
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459442; cv=none; b=R1Q6CYJrXF0IJmTK2f+hgD+xNIdmTJWIVehI7G1vuEKtIWRK479im870TzpcrBr+sJLLyCUoGAOE0J3xToSXX6H0yyz/zykDRW1Te9mQ7RhX+U0n0+/t/rW0ykodNSMmePufrWkVLTOwXS35XkPojYlrc7jSnuC+1Ve8mBof158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459442; c=relaxed/simple;
	bh=VR3Z6NiIbl5pnmjCCnBJH6ZnBA3/aDWVWOXMFiW8hlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8aRB0Kk13nFY1071QpBVVkJ4amxzEmcdSIeYN8+kfBVCbIWCvbJjLfPdOqw5DdVDVaF5Qklv2kwCEYiClF+nAHGt6sLmINBPmCp2M0GRsCcyIg47maCXctECS6dxNziUW1J6OUb+qk8D8MYEnOp1jrppqjHn1eDCbzr+y2p28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pfq2tel9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4Xt3tCAS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pfq2tel9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4Xt3tCAS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pfq2tel9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4Xt3tCAS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pfq2tel9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4Xt3tCAS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DE776739F;
	Fri, 22 May 2026 14:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779459430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UODpLeBpNT8RTXpwjpkfntCTTqUj13DI7O0VKmavHKI=;
	b=pfq2tel9A2SVWcIP+zGTHnReMa21gXZEc87mlobNlJilGpb9Kpm16jJfKPVxP65dYBaU19
	fKHKedh+asaQcA5Tv2Wq0Xmwgd/lU9+6GKHeWO51G2eMAOpgCxRv0J6k9esAwBnt0ANOUv
	pqgHNzXATpU5sFDMG3dS/ccVpv3SQkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779459430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UODpLeBpNT8RTXpwjpkfntCTTqUj13DI7O0VKmavHKI=;
	b=4Xt3tCASkGk3ZKyufr4dKnwBFNupjd34nYbcaulvTEXy0iCMKvGyWFDoKJOdeEZsLwZBOa
	Bgum9tNA+mBDIyAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pfq2tel9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4Xt3tCAS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779459430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UODpLeBpNT8RTXpwjpkfntCTTqUj13DI7O0VKmavHKI=;
	b=pfq2tel9A2SVWcIP+zGTHnReMa21gXZEc87mlobNlJilGpb9Kpm16jJfKPVxP65dYBaU19
	fKHKedh+asaQcA5Tv2Wq0Xmwgd/lU9+6GKHeWO51G2eMAOpgCxRv0J6k9esAwBnt0ANOUv
	pqgHNzXATpU5sFDMG3dS/ccVpv3SQkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779459430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UODpLeBpNT8RTXpwjpkfntCTTqUj13DI7O0VKmavHKI=;
	b=4Xt3tCASkGk3ZKyufr4dKnwBFNupjd34nYbcaulvTEXy0iCMKvGyWFDoKJOdeEZsLwZBOa
	Bgum9tNA+mBDIyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95E2D593A8;
	Fri, 22 May 2026 14:17:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CkKSJGZlEGrJYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 May 2026 14:17:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 26F4EA08F3; Thu, 21 May 2026 19:42:17 +0200 (CEST)
Date: Thu, 21 May 2026 19:42:17 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] fanotify: gate fs event classification by group
 type
Message-ID: <73bt7rkn3djl3yzih7z75ekv3k7lnpfmbmarfooclm2lvpxetw@rop2aob4qyod>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-7-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424170503.2096847-7-amir73il@gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 9DE776739F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO

On Fri 24-04-26 19:04:59, Amir Goldstein wrote:
> fanotify decides on how to allocate events based on the event mask.
> The event mask bits that correspond to filesystem watchers are only
> meaningful in the context of filesystem group type.
> 
> Hence, before checking if event is a specific fs event (e.g. FS_RENAME)
> need to first check the group type is filesystem.
> 
> Separate fanotify_alloc_event() into an allocator per group type, so
> that all the fs events check inside fanotify_alloc_fs_watcher_event()
> are already properly gated.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

...

> +static struct fanotify_event *fanotify_alloc_event(
> +				struct fsnotify_group *group, u64 mask,
> +				const void *data, int data_type,
> +				struct inode *dir, const struct qstr *name,
> +				__kernel_fsid_t *fsid, u32 match_mask)
> +{
> +	struct fanotify_event *event;
> +	unsigned int hash = 0;
> +	bool ondir = mask & FAN_ONDIR;
> +	struct pid *pid;
> +
> +	if (fsnotify_is_ns_watcher(group)) {
> +		event = fanotify_alloc_ns_watcher_event(group, mask, data,
> +							data_type);
> +	} else {
> +		event = fanotify_alloc_fs_watcher_event(group, mask, data,
> +						data_type, dir, name, fsid,
> +						match_mask, &hash);
> +	}
>  	if (!event)
> -		goto out;
> +		return NULL;
>  
>  	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
>  		pid = get_pid(task_pid(current));
> @@ -875,8 +920,6 @@ static struct fanotify_event *fanotify_alloc_event(
>  	fanotify_init_event(event, hash, mask);
>  	event->pid = pid;
>  
> -out:
> -	set_active_memcg(old_memcg);
>  	return event;
>  }

Looks good. Just I'd keep the memcg & gfp dance in the shared code in
fanotify_alloc_event() and just pass the gfp mask into the
group-type-specific allocation functions.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
