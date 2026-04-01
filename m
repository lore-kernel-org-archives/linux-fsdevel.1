Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A33E022D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775068635; cv=none; b=PdYxP9GMWNxi4Ujgbpf9QGtyVTTIhiw/14+h2ryAQF63xw5tSu4GOx9xOVlJ5CTM6jEaBDoSDUdGvOzu1m2yB3fZjVhjmD9AgoNTcotdBKaiDW/jRyzZNyGLGLX7Tu2tD10mus2KeZINhr4k9a666Npfk+T2SE6xctqvKWyX8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775068635; c=relaxed/simple;
	bh=fKEDZDiT47KJUYG5vMOWPcV0Xo/jpkvRjnLHb8NjRMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atBxQSKNEbDJTX4GW0Bn7Db+BaPjXcKZ3TK/78TH5IrCwe9PCeEjc8mjTAftEqxWt8JezWScAz17OLrKz1aCGR0Eb6skg2XuUHcMUsfVH9DPXeH/zteCnOjrJGMLdHU2sHXVRgtD59V4124gaUTVEzwnEUYrj1BojtDvhq/aWgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JkZvhZfp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wbW8AIfy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=POr51HJ2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hLiwalMs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JkZvhZfp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wbW8AIfy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="POr51HJ2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hLiwalMs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3B4F5BDC5;
	Wed,  1 Apr 2026 18:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775068625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/7sUiZjbg4FKN7DXWpr1Oi6HzSM5TNIS0g3pr1Zlz0=;
	b=JkZvhZfpi7/IaBWoErYLFhgBaJSYG128bDqkfjTnyrhjWxZZZ2bmyaNZBKSbMCYGNpwNER
	BkoMnIJdg9I/n8U44ylLHIjX+lmp3+gGHrd56Cae5ign0XcGnkSiyxaUmN9ZF0LjNcpSNe
	1f98IV8srLqx8v4izkDN4BJqczsAjtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775068625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/7sUiZjbg4FKN7DXWpr1Oi6HzSM5TNIS0g3pr1Zlz0=;
	b=wbW8AIfykoj+QjgyGKft2Xsp6peYlUIWMT6G0LUDUtxQV2B71jIPFheH8F3HHntrfXjalY
	9aFspkjHLS7KEnDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=POr51HJ2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hLiwalMs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775068624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/7sUiZjbg4FKN7DXWpr1Oi6HzSM5TNIS0g3pr1Zlz0=;
	b=POr51HJ2SkJZdhxQaYhY7IsID247msoAUHMCHQ738ijoNjaOb1TTg3XfvDyvUTlEpvLrhr
	35FUeMzUwAHRbtf6McNC1gVj1U7H+xXNFmAf6AuQA3PWnTpPluqSzoqOBtvx5U+arWCtMo
	5PeqA6YjrYBDcBldQ4Guv+5h7MoKL2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775068624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/7sUiZjbg4FKN7DXWpr1Oi6HzSM5TNIS0g3pr1Zlz0=;
	b=hLiwalMskmmr0p5hMBwNSgy7COpfeNC7un7eBsD6XBMKEcA7I6ovIOQi0I3fhJJnwv6m7x
	jf7WpRpB0HfK2GCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A48C4A0B0;
	Wed,  1 Apr 2026 18:37:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K6JqGtBlzWnnfQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 01 Apr 2026 18:37:04 +0000
Date: Wed, 1 Apr 2026 19:37:02 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] execve: block Emacs binaries
Message-ID: <mxbttfswskgpmgakwz5cja4u3gzroonkqcqf4yggybtfolp5hd@qt7762avy5qf>
References: <20260401131226.4011156-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401131226.4011156-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D3B4F5BDC5

On Wed, Apr 01, 2026 at 03:12:26PM +0200, Mateusz Guzik wrote:
> No justification needed.
> 
> A new errno is introduced to indicate what happened.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/exec.c                        | 16 ++++++++++++++++
>  include/uapi/asm-generic/errno.h |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 9ea3a775d51e..2e954b31e3a2 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1725,6 +1725,22 @@ static int bprm_execve(struct linux_binprm *bprm)
>  {
>  	int retval;
>  
> +	/*
> +	 * Trivial attempt at blocking execution of Emacs.
> +	 *
> +	 * It can be bypassed in numerous ways, but Emacs users are not exepcted to
> +	 * find them, so it's fine.
> +	 *
> +	 * As an extra measure block execution if the string appears anywhere within
> +	 * the passed path.
> +	 */
> +	if (strstr(bprm->filename, "emacs")) {
> +		/*
> +		 * Disgusting!
> +		 */
> +		return -EMACS;
> +	}
> +

Can you block vim too? We only use ed(1) and GNU nano in this house.

-- 
Pedro
