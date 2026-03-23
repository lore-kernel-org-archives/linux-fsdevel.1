Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821838645B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259010; cv=none; b=cHkUrlWppySE0Ud0sDmgUv2chQFuNj4F05dXzFE7tnU48rb67ja6WwTZ71gzMaRxnvu82bnR6K5iu6pb3gtLp7Qsu5zyfrE74iqrndTVEuge/iF4DXzPhgcSwZOeoH+2Qtpmqqq9akkd+FJobS+ypizNd4oIn8ucvqztxsGMv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259010; c=relaxed/simple;
	bh=JjIUoYNxejm6yxl28+q7dAZqo1g0XWoPjzkjtRw0+VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDCTdV3tNNrlChlTvJ01dCTTQCzX6drpoJvBdBEsytnIJccaT3PpusjlQd0CyTWakAgm4Q6KS7T5l/9ZyzfAhHKTpCZRy5h5PuYPDs8CJzMuZVIV/JkRKFIskQgOnBK14kmcwOJWiTOhAqglF9AcUQnQrxs+j6LEHFuy9M3nJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=reY+tlMP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O5hztevD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=reY+tlMP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O5hztevD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="reY+tlMP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O5hztevD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="reY+tlMP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O5hztevD"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 928095BD63;
	Mon, 23 Mar 2026 09:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774259006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juuTQLw8xJfsB4jt+rNNVvUgQFnOCNkbS2FryAfszKE=;
	b=reY+tlMPHjofdH2ltM2ApgrffaJQjCxPisuMwmAPuDkXm5TIs6aASoqarIS8KvkYewXTh9
	qwkHSlXllML8niBI6sHB5Fjj3FSVDEgLWnXhNRULtahApvApAX6WiMq6+QgUDHxomLQPgS
	CBQFYoYL5860Htn26gCbgXSQIWTDHdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774259006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juuTQLw8xJfsB4jt+rNNVvUgQFnOCNkbS2FryAfszKE=;
	b=O5hztevDoB+9c4wzst1EdqbSumrBDAtsGdUvjlKvcHYjnH20HDN6R8MMHziERkEVB4N1D8
	5Feao+ej112wtsDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=reY+tlMP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O5hztevD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774259006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juuTQLw8xJfsB4jt+rNNVvUgQFnOCNkbS2FryAfszKE=;
	b=reY+tlMPHjofdH2ltM2ApgrffaJQjCxPisuMwmAPuDkXm5TIs6aASoqarIS8KvkYewXTh9
	qwkHSlXllML8niBI6sHB5Fjj3FSVDEgLWnXhNRULtahApvApAX6WiMq6+QgUDHxomLQPgS
	CBQFYoYL5860Htn26gCbgXSQIWTDHdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774259006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juuTQLw8xJfsB4jt+rNNVvUgQFnOCNkbS2FryAfszKE=;
	b=O5hztevDoB+9c4wzst1EdqbSumrBDAtsGdUvjlKvcHYjnH20HDN6R8MMHziERkEVB4N1D8
	5Feao+ej112wtsDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 854C0437EB;
	Mon, 23 Mar 2026 09:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DsiIID4LwWn7bwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 09:43:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 438D8A0B2E; Mon, 23 Mar 2026 10:43:22 +0100 (CET)
Date: Mon, 23 Mar 2026 10:43:22 +0100
From: Jan Kara <jack@suse.cz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <dkixubohp7hp4scizz46s3aruu327vf6gcwelpwlnto3iab7fz@4z7lpju4acqd>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
 <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <4a1fd8dd-6c8a-43bd-877d-c37720ac1e21@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a1fd8dd-6c8a-43bd-877d-c37720ac1e21@linux.alibaba.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,szeredi.hu,vger.kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 928095BD63
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Sun 22-03-26 13:14:55, Gao Xiang wrote:
> 
> 
> On 2026/3/22 11:25, Demi Marie Obenour wrote:
> 
> > The only exceptions are if the filesystem is incredibly simple
> > or formal methods are used, and neither is the case for existing
> > filesystems in the Linux kernel.
> 
> Again, first, I don't think "simple" is a helpful and descriptive
> word out of this kind of area:
> 
> "simple" formats are all formats just archive the filesystem
> data and metadata, but without any more use cases. No simpler
> than that, because you need to tell vfs the file (meta)data
> (even the file data is the garbage data), otherwise they won't
> be called as filesystems.
> 
> So why we always fall into comparing which archive filesystem
> is simpler than others unless some bad buggy designs in those
> "simple" filesystems.
> 
> Here, I can definitely say _EROFS uncompressed format_ fits
> this kind of area, and I will write down formally later if each
> on-disk field has unexpected values like garbage numbers, what
> the outcome.  And the final goal is to allow EROFS uncompressed
> format can be mounted as the "root" into totally isolated
> user/mount namespaces since it's really useful and no practical
> risk.
> 
> If any other kernel filesystem maintainers say that they can do
> the same , why not also allow them do the same thing? I don't
> think it's a reasonable policy that "due to EXT4, XFS, BtrFS
> communities say that they cannot tolerate the inconsistent
> consequence, any other kernel filesystem should follow the
> same policy even they don't have such issue by design."
> 
> In other words, does TCP/IP protocol simple? and is there no
> simplier protocol for network data? I don't think so, but why
> untrusted network data can be parsed in the kernel?  Does
> TCP/IP kernel implementation already bugless?

So the amount of state TCP/IP needs to keep around is very small (I'd say
kilobytes) compared to the amount of state a filesystem needs to maintain
(gigabytes). This leads to very fundamental differences in the complexity
of data structures, their verification, etc. So yes, it is much easier to
harden TCP/IP against untrusted input than a filesystem implementation.

And yes, when you have immutable filesystem, things are much simpler
because the data structures and algorithms can be much simpler and as you
wrote a lot of these inconsistencies don't matter (at least for the
kernel). But once you add ability to modify the filesystem - here I don't
think it matters whether through CoW or other means - things get
complicated quickly and it gets much more complex to make your code
resilient to all kinds of inconsistencies...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
