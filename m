Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA036DA10
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259686; cv=none; b=VxTcCnVxU4KMXuGKMuseAaqLkYf/ri1nLYqhuUyrCkUw6LiVz321Ena/oUk192lzBsmkVDhgrfp1QfSP5v8gc+QVY7EhXEHV9f6sT8uj4SA2zeVyRjElns8TzEUTyMK3HhSjPdKZFcB1zYFlLDIepA1wUldbJudVtJGqGl5uk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259686; c=relaxed/simple;
	bh=dhXrE5GCgxZEzh5r9Hy0EOj1y2g+aE9O1TYAmqbTCj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi0H56T5j1mzeLgBp4KbI7hXO54TqbmJsACZCqgFsmrCpW1cgSfMJyOev5szGZWV9EQcTK4ZAXXIiOOk1U3Hj/2X7r5Ha+AXmYU/ArqL8vM33HOmKFFTXzMqxeMXkxGynx1gLW+zOeo4NJVY7xA7nbWIcsYudBm4uBQeMupKvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oj1vGC2O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kHY/P1qa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oj1vGC2O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kHY/P1qa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oj1vGC2O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kHY/P1qa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oj1vGC2O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kHY/P1qa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 520144D2A4;
	Mon, 23 Mar 2026 09:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774259683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjfmQKky+GSEILtV07IckQjRnDeYuXTC7RuDPIvRYEM=;
	b=Oj1vGC2ONYuLDc5lsjZbnCeluIby0OQiQFEvlStgP4u2lLwj8hEwv1kyj58irJOvkAMfi7
	4iq0uGvLFrVnjQUyfUlzqhwUt4+GlZDdQgVcKe/a5p/KVINARfORG1Au+jy15BKqVonIUa
	erKj3h2Rss7H7Rr1f0KSHHgFvnAEiZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774259683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjfmQKky+GSEILtV07IckQjRnDeYuXTC7RuDPIvRYEM=;
	b=kHY/P1qatqNpoQIA3tKy4t6NoPaIhMdexybx52pKvTMq4JrxFvWvVX4+rzfFIzd/oia88k
	Rj3yAU82U0HjJ5DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Oj1vGC2O;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="kHY/P1qa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774259683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjfmQKky+GSEILtV07IckQjRnDeYuXTC7RuDPIvRYEM=;
	b=Oj1vGC2ONYuLDc5lsjZbnCeluIby0OQiQFEvlStgP4u2lLwj8hEwv1kyj58irJOvkAMfi7
	4iq0uGvLFrVnjQUyfUlzqhwUt4+GlZDdQgVcKe/a5p/KVINARfORG1Au+jy15BKqVonIUa
	erKj3h2Rss7H7Rr1f0KSHHgFvnAEiZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774259683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjfmQKky+GSEILtV07IckQjRnDeYuXTC7RuDPIvRYEM=;
	b=kHY/P1qatqNpoQIA3tKy4t6NoPaIhMdexybx52pKvTMq4JrxFvWvVX4+rzfFIzd/oia88k
	Rj3yAU82U0HjJ5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46EA1437F7;
	Mon, 23 Mar 2026 09:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JShLEeMNwWnYewAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 09:54:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0B63EA0B2E; Mon, 23 Mar 2026 10:54:39 +0100 (CET)
Date: Mon, 23 Mar 2026 10:54:38 +0100
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
Message-ID: <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
 <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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
X-Rspamd-Queue-Id: 520144D2A4
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Sun 22-03-26 12:51:57, Gao Xiang wrote:
> On 2026/3/22 11:25, Demi Marie Obenour wrote:
> > > Technically speaking fuse4fs could just invoke e2fsck -fn before it
> > > starts up the rest of the libfuse initialization but who knows if that's
> > > an acceptable risk.  Also unclear if you actually want -fy for that.
> > 
> 
> Let me try to reply the remaining part:
> 
> > To me, the attacks mentioned above are all either user error,
> > or vulnerabilities in software accessing the filesystem.  If one
> 
> There are many consequences if users try to use potential inconsistent
> writable filesystems directly (without full fsck), what I can think
> out including but not limited to:
> 
>  - data loss (considering data block double free issue);
>  - data theft (for example, users keep sensitive information in the
>       workload in a high permission inode but it can be read with
>       low permission malicious inode later);
>  - data tamper (the same principle).
> 
> All vulnerabilities above happen after users try to write the
> inconsistent filesystem, which is hard to prevent by on-disk
> design.
> 
> But if users write with copy-on-write to another local consistent
> filesystem, all the vulnerabilities above won't exist.

OK, so if I understand correctly you are advocating that untrusted initial data
should be provided on immutable filesystem and any needed modification
would be handled by overlayfs (or some similar layer) and stored on
(initially empty) writeable filesystem.

That's a sensible design for usecase like containers but what started this
thread about FUSE drivers for filesystems were usecases like access to
filesystems on drives attached at USB port of your laptop. There it isn't
really practical to use your design. You need a standard writeable
filesystem for that but at the same time you cannot quite trust the content
of everything that gets attached to your USB port...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
