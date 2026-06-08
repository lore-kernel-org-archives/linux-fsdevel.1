Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDBE33D6FD
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916021; cv=none; b=D15A8hiHajIpBPDeRnynQk6+ewu6RK0xCHC+YAB8PGrq5T0Jo7bOLsId/7FbqTWS6tgAmUFQg4NtRmNHQV/J71tVSZm2LvvtU414WdKLOv2VcMmwny8VaFddTRenrQPW09ESAmI9fL+yiBvdS/PuMdtAg48MYGDmAZpNSrXWcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916021; c=relaxed/simple;
	bh=J6zC06F1sjdhp5lfMIJjtQjc1PZeU3kWTayaF9Hr1HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngyVCFiH/0Cop6hIs7DQKwK39tgaXuk/SdkRnq9Co6XtvO3bzsist0LFHfaka5R6byzarkpitr5GokEOCQ1LMhVf+P4n1/cRdApMAS7M/r0ceD87ldRQ1lig+szeHMC0ZsrhtSHegvmRaAYU90KIS54YVlJFFeIDHZeMMJKs4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nL2QtKOi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3JFeIOJt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nL2QtKOi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3JFeIOJt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nL2QtKOi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3JFeIOJt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nL2QtKOi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3JFeIOJt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 118436A878;
	Mon,  8 Jun 2026 10:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780916018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqkteAQDbIIBnvasNXNhY49MsB7ef/MBf/QRMBdbVdo=;
	b=nL2QtKOiCoWYr4IZ/992M6c4q8FwQgm5OLxUhUHfHc9K5YCH7zUZKofX56zSq7ge01Tl5B
	Po0L+hvjSF9I5TXyKNj+xIpH/ZIWIInx6zg0E/Ht4T6TitZdnrEY5glzf5JP1++9waUR1D
	3Pcl66aWb9hPQbQVh0Phnxvn+IFi8DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780916018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqkteAQDbIIBnvasNXNhY49MsB7ef/MBf/QRMBdbVdo=;
	b=3JFeIOJtcpK5qbtUaTpMKdWPCWjvHmXsOLHJIjMo0wqvQg1t/hJjZtMlPLw/kqBmGL1JNv
	6Q8stWoZP7Yc/TCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780916018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqkteAQDbIIBnvasNXNhY49MsB7ef/MBf/QRMBdbVdo=;
	b=nL2QtKOiCoWYr4IZ/992M6c4q8FwQgm5OLxUhUHfHc9K5YCH7zUZKofX56zSq7ge01Tl5B
	Po0L+hvjSF9I5TXyKNj+xIpH/ZIWIInx6zg0E/Ht4T6TitZdnrEY5glzf5JP1++9waUR1D
	3Pcl66aWb9hPQbQVh0Phnxvn+IFi8DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780916018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqkteAQDbIIBnvasNXNhY49MsB7ef/MBf/QRMBdbVdo=;
	b=3JFeIOJtcpK5qbtUaTpMKdWPCWjvHmXsOLHJIjMo0wqvQg1t/hJjZtMlPLw/kqBmGL1JNv
	6Q8stWoZP7Yc/TCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09065779A7;
	Mon,  8 Jun 2026 10:53:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sOgtAjKfJmq1WwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 10:53:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AAA38A10CB; Mon, 08 Jun 2026 12:53:37 +0200 (CEST)
Date: Mon, 8 Jun 2026 12:53:37 +0200
From: Jan Kara <jack@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, jack@suse.cz, 
	repnop@google.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] fanotify: lift pidfd reporting restrictions
Message-ID: <tjfmtxwsnxittu26nwp44zuulupmulydkkgxvoyxtqcpyh2yfe@z5gtnoox23s5>
References: <20260530013732.50811-1-anonymemeow@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530013732.50811-1-anonymemeow@gmail.com>
X-Spam-Flag: NO
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
	FREEMAIL_TO(0.00)[gmail.com];
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.cz,google.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Score: -3.80

On Sat 30-05-26 09:37:30, AnonymeMeow wrote:
> The pidfd API now supports pidfds for tasks that are not thread group leaders,
> but fanotify has not caught up yet. This patch set lifts that restriction and
> allows fanotify to report pidfds referring the event-generating thread.
> 
> Additionally, this patch set drops the pid_has_task() check before the
> pidfd_prepare() call, allowing fanotify to hand out pidfds for reaped tasks,
> as suggested by Christian.
> 
> Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/
> 
> changes since v2:
>  - Split the two independent changes into separate patches.
> 
> v2: https://lore.kernel.org/lkml/20260529020035.17477-1-anonymemeow@gmail.com/

OK, I have taken these patches into my tree now. Can you please send fixes
for LTP tests fanotify20 and fanotify21?

								Honza

> 
> AnonymeMeow (2):
>   fanotify: report thread pidfds for FAN_REPORT_TID
>   fanotify: allow reporting pidfds for reaped tasks
> 
>  fs/notify/fanotify/fanotify_user.c | 33 +++++++-----------------------
>  1 file changed, 7 insertions(+), 26 deletions(-)
> 
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
