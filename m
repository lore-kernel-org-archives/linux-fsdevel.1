Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018B3AF643
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268401; cv=none; b=Np3c12oaT57p/2ZovwP/rsrcuVtBobnDX+6mEPv9k5VuOj5yF6vV6k4ja1LZVXtmrELR0FdoZ8GHCb+NYThAxHHlmN0XHqjQLzBwtUViPo4UgCnL/ZSIv3ekpi2SPIP5Gq/uT+wiSiYYAMP3pmXPKNQ1AIuDm+KaNx36JJV4xLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268401; c=relaxed/simple;
	bh=0+xBh+HqF1UwRZtVYH/R3YM/sVBN9f7V+c0oPLIczV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj8n5dzMSImBK0z6WVnGSsPgAiB6rzONP3YwtZNPccIUrhv8cQLZaK/Do+vbeZWaw7mrNkjjzXXcbNrZ1jdDX3yCKVRuhUd9Hx+hY2NDZ0VAd8kgYBvLB6wca8f/lQ40g4SaDIKR1MLay0CLAgOKlOT+GdeeQKsPxZAPmt4wmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rranzaAj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G9WBP+OA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f1FnaWrD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u1/e+Gz/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rranzaAj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G9WBP+OA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f1FnaWrD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u1/e+Gz/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0C736AB8F;
	Wed, 20 May 2026 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779268394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wd2LazAG0w5QcjYPj1fj45bCF6JDwSV09eUtrSORw/U=;
	b=rranzaAj7bPIKLt1ccBrD2ViuusbArjpiSupfH5LbztiECknrKIqUeSQ7JYSO3K891ZpUW
	lG4AH4pIjWVgVKXRvPwrJyOW86Lho0/hPsdTDsiF0txYB9lJGSptSDil6eoTpbeoMO4RMS
	MyuHRJQCWLIvnbCf33IWHvCBpSDsVYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779268394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wd2LazAG0w5QcjYPj1fj45bCF6JDwSV09eUtrSORw/U=;
	b=G9WBP+OAP3ZGMDuKZvkw/NewZbOGxtTZDItXWpAQGevkI8QQFLjXYIkGC3f23eQlrSFRpR
	CpYJ0R1m6aS41hBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f1FnaWrD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="u1/e+Gz/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779268393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wd2LazAG0w5QcjYPj1fj45bCF6JDwSV09eUtrSORw/U=;
	b=f1FnaWrD7oKVZHw/zvHDWXNB+K1ze1ImqxYath+jslm2vEHrTnSleoFtIZwaMq9IXXeNAl
	hI3357l3LkvXDkXsEL1nk35gKAOF11nGJ5QQPPLMLsCLNV/YnXRn/07uKAToeM5FpzAT6Q
	MHcVbkM/znNvaL3jBZ2Zu0VQ9jNUaQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779268393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wd2LazAG0w5QcjYPj1fj45bCF6JDwSV09eUtrSORw/U=;
	b=u1/e+Gz/8uiqtvHu7e9E+7gg8Od5N/33eQrfPBm/AHztFXJW99uWqSu7lBDJZNBR2r8wa3
	Y+RoNUFdz/yteYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA284593AA;
	Wed, 20 May 2026 09:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMgiOSl7DWrvRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 May 2026 09:13:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 933AAA08D7; Wed, 20 May 2026 11:13:08 +0200 (CEST)
Date: Wed, 20 May 2026 11:13:08 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] fsnotify: introduce fsnotify group types
Message-ID: <2gnaoibhljk7a4f2lwri3ovyrfydld6kqyzmjmcwekl2fub24o@dfhdjc2vzsfj>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424170503.2096847-3-amir73il@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F0C736AB8F
X-Spam-Level: 

On Fri 24-04-26 19:04:55, Amir Goldstein wrote:
> Currently an fanotify group can subscribe to events FAN_MNT_ATTACH/DETACH
> only on mark type FAN_MARK_MNTNS and IFF the group was initialized with
> FAN_REPORT_MNT.
> 
> Hence, mount events can not be mixed on the same group with filesystem
> events and mntns marks cannot be mixed with filesystem type marks.
> 
> Define a new property for an fsnotify group called fsnotify_group_type
> which describes the category of events and mark types and use a distinct
> category FSNOTIFY_GROUP_TYPE_NS for the mount event groups.
> 
> Create helpers fsnotify_is_{fs,ns}_watcher() and the macro
> FANOTIFY_NS_INIT_FLAGS and use them to generalize some code that was
> checking the FAN_REPORT_MNT flag.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

...

> -#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | FAN_REPORT_MNT)
> +#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
> +
> +/* fanotify_init() flags to create a namepsace event watcher */
> +#define FANOTIFY_NS_INIT_FLAGS	(FAN_REPORT_MNT)

Seeing this and where FANOTIFY_INFO_MODES is used - FAN_REPORT_MNT does
influence the set of supplemental information that's provided with the
event. So IMHO it should stay in FANOTIFY_INFO_MODES. We should just have
bitmasks (currently two of them) through which we decide the type of the
notification group we are creating.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
