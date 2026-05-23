Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D5523EA84
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549983; cv=none; b=Z+i+a4IprTMlJRunJHRy7LSAzQuhMqP/gG34i9FTNAd9vo33UsrMUj88v1jfItZjivHni2vpY/f2fG+wDjCrSFC4AzMn8DSJLP/goIYhzKy74LYs+r6tdesO3YHu3kIkyVdwXOTyg8RClc1wmLLe+qt0kq32TKPeC2BQeNo2Ac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549983; c=relaxed/simple;
	bh=NgotHrQQbm8sNGxojUDNvnnGViittoPeFV5xGybD9EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb+vG+CF6uUI/J4FrpqAk0Lw3qA7eTqZtctG1KSiCrwM42uJtR4tLrOyZVC6ustvSD8BpCtOzCwiXfjMi/4GTDJCfR68KFEYIklmi0mvU6Nc2oFQaX9GdyU/hLlHQZtESgnVPGbUcsJ1RUlppX1R/hr4GVavp70Z8PcsLQRdsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i+HqVWVF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8r5qKrkF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cb5keoz3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YqPfOxiK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i+HqVWVF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8r5qKrkF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cb5keoz3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YqPfOxiK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E025A63C80;
	Sat, 23 May 2026 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779549978;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H2AquFydWxc/VlH/uT2dGIPVr1AoG9TSE18J5/LjYM=;
	b=i+HqVWVFyJwcbY3VgfU2SoU9uR22D9pOoWmf8CEbf6Y1M3puhVFxm2FEr6q8UiQql55eBh
	O6oeTzJwxLJ3oNwF6plF1jgGLn95SG0jIpLhkwA7RNKhgRs7ym8ICnyNapmIevkR0ns1QJ
	XM+TC4HZPRBRhz4SB2zzS77/dsV0M8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779549978;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H2AquFydWxc/VlH/uT2dGIPVr1AoG9TSE18J5/LjYM=;
	b=8r5qKrkFtoep7oNnYiMp7zq73MA+gypelvn8CfIxE0pp8x3H0sFaKbzn10RSkQWArfXRRs
	NqfIOGalM+Ts5jAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779549976;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H2AquFydWxc/VlH/uT2dGIPVr1AoG9TSE18J5/LjYM=;
	b=Cb5keoz31AAOgIbGdCsQjt+Wz+rq2iv/FpSw4PxfNFviR1nZ2cQCf0tvaBl0GiLkZ+kmRg
	Q3hww9NREf4BBcUOTRFNXDhBkgLahTAi8UQRor9EyzcC++Jw7LChzeO8dc7bPHJjyOBuMd
	S+vxxM25Rl0kKt2gG89UUewucXg0JVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779549976;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H2AquFydWxc/VlH/uT2dGIPVr1AoG9TSE18J5/LjYM=;
	b=YqPfOxiKsDcY8MLGLWoobeSVd9ky4Im9Q/Snnc8qUZKyAA0GbTpMMorWKdL65O9qzd10Vk
	3hDGN5T5+0RAqbAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD3F4593A8;
	Sat, 23 May 2026 15:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hdxwLRjHEWqhZgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 23 May 2026 15:26:16 +0000
Date: Sat, 23 May 2026 17:26:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] affs: Move long delayed work on
 system_dfl_long_wq
Message-ID: <20260523152615.GD183694@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260508134541.282073-1-marco.crivellari@suse.com>
 <20260508134541.282073-7-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508134541.282073-7-marco.crivellari@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:mid];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, May 08, 2026 at 03:45:34PM +0200, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
> 
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.
> 
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a single
> CPU.
> 
> Recently, a new unbound workqueue specific for long running work has
> been added:
> 
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
> 
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit from
> scheduler task placement.
> 
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Acked-by: David Sterba <dsterba@suse.com>
