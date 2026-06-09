Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8363FADFC
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 10:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000954; cv=none; b=cv6FZS0IDGIfjlGkgd2DmxZbSM1ke+xIhoML0m1lL/ihABCrShVwpq1uLnkT2qXLaCwaAEOsI+VNLwjfih8mzmMqsZW6hkwGkkIWNFAMVhBfCE8wUG7caUgltgWPB4++AlmcztGIjveIjiD+6V/qLcViSNE91hP62wk8xdQsDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000954; c=relaxed/simple;
	bh=2fy2m5kMcl6xaj1o21gr3pjkbMR6qFnSnmZ+BJ2EFbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIFkArQwJuOOCKyuL45DkTV6ierrOYeA7qusP/dYw90zZqGmOFyyIwzg0mvvsFVrCISAAtW7ed0hgcyeMCwaLW8DqYpLEKVtpdnJGwK8I1VSaj2R1QC0bF9riZpteXEIyHt3zUHfJHzODwuhoitIIW0yNfGSKIqwaqOcc4DhEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RzftQm/Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eanRoSX4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Al/Lwr3S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=USDfc8ri; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RzftQm/Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eanRoSX4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Al/Lwr3S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="USDfc8ri"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F28326A931;
	Tue,  9 Jun 2026 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781000946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ou1IFBIkzjaSAlJTy0Y1/qIBVkrywiJopPppfGP2Yc=;
	b=RzftQm/YU8EBqlKUoRhsQ2egK+72Dwt7XVJV6AOWKFLwRe9GWagv+ZOEAYAEwC0Ofo8jXo
	hbiMylhc9Y9DDxxjbazbnVIOMDKUOizzh5ZPrPe4oYg5CUa0MJ9kXBHKfISbz8rwBVsZie
	A5FdJSPu7fA7e0HBU27+X6PxHs6llfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781000946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ou1IFBIkzjaSAlJTy0Y1/qIBVkrywiJopPppfGP2Yc=;
	b=eanRoSX4nzhPZgpBcbuzftBQiB3c9gFfIuI5w3qIcU/JFOCRAZPLcxvrhElhW58VaAqo5a
	do3GjyEmAIkD3IBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781000945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ou1IFBIkzjaSAlJTy0Y1/qIBVkrywiJopPppfGP2Yc=;
	b=Al/Lwr3SNpi3ZmbK8KpIDD9B+h3rc8UtsA8y06BV9DwydCy0wob/Hg2andkp6sdoVwySMM
	qWUjuzI4Pffq0++X4PaW3TyQrk+wZPLGi0Dw03rmZDLeDKpzcAVOg1LlU9tKnV5aaptsNC
	XhBGNTrU9Fxf1WaqJfLyVEhbjz7/VaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781000945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ou1IFBIkzjaSAlJTy0Y1/qIBVkrywiJopPppfGP2Yc=;
	b=USDfc8ri4+7nUDD/6t4Loo/NapLUhkOOJ5gwt19Wsy+w0TuzY/LToHyprs636uTH3XDD3t
	36JPaQx6Gz+GfvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9110779A7;
	Tue,  9 Jun 2026 10:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8+jjOPHqJ2pnXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Jun 2026 10:29:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8CECFA0A90; Tue, 09 Jun 2026 12:29:05 +0200 (CEST)
Date: Tue, 9 Jun 2026 12:29:05 +0200
From: Jan Kara <jack@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: jack@suse.cz, amir73il@gmail.com, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] fanotify: lift pidfd reporting restrictions
Message-ID: <hsqpfvobwt3pf5he6hho653wl2tkwjaszfldqk6itch5uoqccy@jkijxqcm2in5>
References: <20260607003343.425939-1-anonymemeow@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607003343.425939-1-anonymemeow@gmail.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.80

On Sun 07-06-26 08:33:41, AnonymeMeow wrote:
> The pidfd API now supports pidfds for tasks that are not thread group leaders,
> but fanotify has not caught up yet. This patch set lifts that restriction and
> allows fanotify to report pidfds referring to the event-generating thread.
> 
> Additionally, this patch set allows fanotify to hand out pidfds for reaped
> tasks by registering the event pid with pidfs when pidfd reporting is
> requested and dropping the pid_has_task() check before the pidfd_prepare()
> call, as suggested by Christian.
> 
> Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/
> Link: https://lore.kernel.org/lkml/20260602-patzt-sturz-segen-f1f305d61b75@brauner/
> 
> Changes since v4:
>  - Add a pidfs_register_pid_gfp() helper function to pass in custom flags.
> 
> v4: https://lore.kernel.org/lkml/20260603001516.26234-1-anonymemeow@gmail.com/

The patches look good to me. Thanks! I'd prefer the change adding gfp
argument to pidfs_register_pid() was a separate commit but unless Christian
objects I can live with that. I'll wait for Christian's ack for pidfs
changes before merging this through my tree.
								Honza

> AnonymeMeow (2):
>   fanotify: report thread pidfds for FAN_REPORT_TID
>   fanotify: allow reporting pidfds for reaped tasks
> 
>  fs/notify/fanotify/fanotify.c      | 17 +++++++++------
>  fs/notify/fanotify/fanotify_user.c | 33 +++++++-----------------------
>  fs/pidfs.c                         | 10 +++++----
>  include/linux/pidfs.h              | 18 +++++++++++++++-
>  4 files changed, 41 insertions(+), 37 deletions(-)
> 
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
