Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849404;
	b=M+pYbFO2Gya75FbwT+p8bsZpGuOfgiE2W3q5RVZD1/Wu7+RzLzQABUw+yBVo6WZnXfxb
	 iPDFmd9ziPzvoVdGBcnyH/9jFoLiqaX6EQestLL8Ey1CmiB0S0xRrrimGurNfuqdSWqhX
	 w7ulmbG/KPXl07X33fMC88nrgt4bzUTl0aVB1M0f9ENIEdW8y00ynDaG9odgYac3XtZ5b
	 4h9/GZK1qIjv3LPouO/BTloafbl00bQiPo2L/eRANY9ht6cULYfR8LXeV3M6aJnyMX/p2
	 36FP6KwlqYZTeb8HUiowrjat2a5cBW/PdpbwpQ3qEy89sDOqQkEpKTEFEa/J+gVycTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849404;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=2jNZLjz45UiZbFRBgtvkN5VBQQyio25/owAOWwzhQ9Q=;
	b=PvI/2QfiDdgpzBK4Kv6lvXMbpID+FbUDVwm4VdB3hdMifPUDbDrr17oNwljywrTC/goj
	 5KRkVAMFS+UJYzC14O8yuv7NV1tRvMGnxE/UWfgxuwz2YTed8b9mdE3T/It5ju7YxXjHn
	 VszvLDuJ4hnYX13uQRFERfNXO7wLQrIcN+yuNPH8anWQi/L6RpCH1zGeyyig9jLzivJY5
	 yJPdzh/HZPFZU4Y0pfELsnt5Lpbl8WVlQp04bx3FGqHwy32vC89KFxgeZwJ1XWyw5mxHb
	 0dN64BnLkrpDhgCAocmtVWuzlVnugRvEn/2MrxVY9tCQk1ew1NkWWgSKnkNV54G3EoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iVO1Jzjz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fuo+nyMQ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iVO1Jzjz;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fuo+nyMQ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D643606A338;
	Mon, 16 Nov 2026 17:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D643606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iVO1Jzjz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fuo+nyMQ;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iVO1Jzjz;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fuo+nyMQ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2317F1F7C4;
	Mon, 16 Nov 2026 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794849402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2jNZLjz45UiZbFRBgtvkN5VBQQyio25/owAOWwzhQ9Q=;
	b=iVO1JzjzibxZjBZngNFXSq6nsEm2L+NUjdtxqfB5/pA7XOKvI4Bt64FRnYqG8safLgFYaL
	PcYRJEPxAem1s+Y9tM7Kk9EL6KsDedpBKTN122fmauqmcwB7LzQeyj2eXmfthdc3Ho+T8+
	L1lWmWxdzChl44dJQGsFiARQSU2W9vM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794849402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2jNZLjz45UiZbFRBgtvkN5VBQQyio25/owAOWwzhQ9Q=;
	b=Fuo+nyMQhGcL5D1zj0ZN6TXnEvL1VhJ0seX7AwBbVWpbEksS/ILsnUD/sj24DsaY/Lp5d7
	0LCxOgwrYmSSy6Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iVO1Jzjz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Fuo+nyMQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794849402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2jNZLjz45UiZbFRBgtvkN5VBQQyio25/owAOWwzhQ9Q=;
	b=iVO1JzjzibxZjBZngNFXSq6nsEm2L+NUjdtxqfB5/pA7XOKvI4Bt64FRnYqG8safLgFYaL
	PcYRJEPxAem1s+Y9tM7Kk9EL6KsDedpBKTN122fmauqmcwB7LzQeyj2eXmfthdc3Ho+T8+
	L1lWmWxdzChl44dJQGsFiARQSU2W9vM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794849402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2jNZLjz45UiZbFRBgtvkN5VBQQyio25/owAOWwzhQ9Q=;
	b=Fuo+nyMQhGcL5D1zj0ZN6TXnEvL1VhJ0seX7AwBbVWpbEksS/ILsnUD/sj24DsaY/Lp5d7
	0LCxOgwrYmSSy6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF75713408;
	Mon, 16 Nov 2026 17:16:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nw5EMnk6+2poIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Nov 2026 17:16:41 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 7C19224E95; Mon, 16 Nov 2026 18:16:41 +0100 (CET)
Date: Mon, 16 Nov 2026 18:16:41 +0100
From: Jan Kara <jack@suse.cz>
To: Partha Satapathy <partha.satapathy@oracle.com>
Cc: Jan Kara <jack@suse.cz>, amir73il@gmail.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] : Re: [PATCH 0/1] fsnotify: Check parent watches
 without child dentry flags
Message-ID: <z3mdow3nbrj7tvch2akviandhv5n44lqh5phb5udumhbczsnx7@7vex7u7bdg3w>
References: <cover.1791373689.git.partha.satapathy@oracle.com>
 <qlw6x3hyky5yoievlkd6ylz3ov432hdjlzkcyboswqktnk43il@fvccpqnil5sp>
 <9499fb1a-85f2-41da-88b7-5e7de6fdff0a@oracle.com>
 <gnntcprg4f7ag7ictugnfza24nwfdmyubkuqac7plxbwtedfrz@xgxyvks3h2uv>
 <2528e790-8913-45dc-a8d5-cc22908a441e@oracle.com>
 <f9164f65-1a99-425d-b216-326de0eaee69@oracle.com>
 <4ed59752-f01b-457b-81de-be1c446f18f6@oracle.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed59752-f01b-457b-81de-be1c446f18f6@oracle.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,zeniv.linux.org.uk,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 2317F1F7C4

On Fri 06-11-26 12:10:50, Partha Satapathy wrote:
> On 22-10-2026 13:17, Partha Satapathy wrote:
> > On 13-10-2026 12:08, Partha Satapathy wrote:
> >> Please compile : fsnotify_parent_ref_bench.c -o
> >> fsnotify_parent_ref_bench. After that
> >> run the script ./run_parent_ref_scale.sh
> >>
> >> Thanks
> >> Partha
> > 
> > Hi Honza,
> > 
> > A gentle ping on the benchmark program, Have you had a chance to try it
> > on your setup? Please let me know if any further tests or information
> > would be helpful.
> > 
> > Thanks,
> > Partha
> 
> 
> 
> Hi Honza,
> 
> Have you had a chance to try the benchmark on your setup? Please let me
> know if you need any further tests from my side to move this patch forward.

I'm sorry for the delay. I didn't get to this yet because with the firehose
of LLM generated reports & fixes things get postponed. But I'm looking into
this now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
