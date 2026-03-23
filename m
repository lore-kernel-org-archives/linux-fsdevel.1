Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B111423815B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277263; cv=none; b=k1CH1N5KJK8D270h/UR1ba1h8yo1SffAAnsB+v6q+MGf9TFZygrf+dAJfql70tfYbmqp/hiel7d44sLq7JEhR4TQY823mexINlMggbE9ds0riOZx90EXWXAhIoD6ijVR3SP7Ey0P7n12LWl4QMrO6c806BN25vd7er6OR6D2xjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277263; c=relaxed/simple;
	bh=v+s2pp2ez3BUcNBAxyqfWU7qppPWpX6HmAzpJrFZMj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G940KF9ft06Cnf5xnmGcqr0U5r4yTdRpNrYRGDnUylpU75N1+pfR/j67OtQjhUywlia9PyUs77KLC8oL6HXW7RiSVzBLBYssMsr/bxLVbhxJR67EdxTDO9gKpS9BlV0lRLcGWT5dZbJ2+Ii+JwC/SJdliOfiKVbhO7SGH54bXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xW5AbK6c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KZ7WEX41; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z3f0WCw2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T7SRUo4e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xW5AbK6c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KZ7WEX41";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z3f0WCw2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T7SRUo4e"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEA995BD46;
	Mon, 23 Mar 2026 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774277260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDIakh5P7EjLFe9W4ao/Gryf3EEwBITyYA0HS/CgLAw=;
	b=xW5AbK6cek9SuwYpIoaBEHEBV8F+iyrcKmcjtX1iGXOxEGTfrw5+hZLGUgLM9YSwvgBxuv
	m11Q1EQGwmZ6stya2zJo/IfKRCuf9XlHxTCLSsWVuwHJ6aDa8WYdF5kXnrJtxTFnWCJS76
	3eKTCTqwFYK2FL64yUXwOChYNkizdEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774277260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDIakh5P7EjLFe9W4ao/Gryf3EEwBITyYA0HS/CgLAw=;
	b=KZ7WEX41DXTcjmho620cI6LzC8L0fciXu7FSrUm9ckmEulUS7ni/u3PLsrjMcp0mAtjdUx
	0KtxcB9e09RLDdBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Z3f0WCw2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T7SRUo4e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774277259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDIakh5P7EjLFe9W4ao/Gryf3EEwBITyYA0HS/CgLAw=;
	b=Z3f0WCw2NlEBTNZD1zB+Ycj7bgRtK5tRnUBPBeH+8DEjciLooXiyxzcLoOQe3busTmLK7c
	Sm/dqVTnBokbQnIs0uXTnVz2KsfMvI5SK2jc0Ka8Pc+mXmxmYhr3cgexzJNTvveP29xVug
	+hgzx0PMiSodEhybksME/eIi/1+H9Ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774277259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDIakh5P7EjLFe9W4ao/Gryf3EEwBITyYA0HS/CgLAw=;
	b=T7SRUo4evhxQ+n6wcU4+bUsZe1HuACVHcdcwvpop6Yat+ngNcsUwFeuYGBpmVPQPVmIQfH
	DvjfTO7/7ScajRBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C10074391B;
	Mon, 23 Mar 2026 14:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SCwZL4tSwWlRMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 14:47:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 779CBA0B32; Mon, 23 Mar 2026 15:47:24 +0100 (CET)
Date: Mon, 23 Mar 2026 15:47:24 +0100
From: Jan Kara <jack@suse.cz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Jan Kara <jack@suse.cz>, Demi Marie Obenour <demiobenour@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <2gyfmxfnnxrglpzb7kz63xbve5vnosl6gi54c3umgrpwbjr4og@lz4e2ptqanfe>
References: <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
 <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
 <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
 <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
 <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
 <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,lwn.net:url];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,szeredi.hu,vger.kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CEA995BD46

On Mon 23-03-26 22:36:46, Gao Xiang wrote:
> On 2026/3/23 22:13, Jan Kara wrote:
> > > > think that is the corner cases if you don't claim the
> > > > limitation of FUSE approaches.
> > > > 
> > > > If none expects that, that is absolute be fine, as I said,
> > > > it provides strong isolation and stability, but I really
> > > > suspect this approach could be abused to mount totally
> > > > untrusted remote filesystems (Actually as I said, some
> > > > business of ours already did: fetching EXT4 filesystems
> > > > with unknown status and mount without fscking, that is
> > > > really disappointing.)
> > 
> > Yes, someone downloading untrusted ext4 image, mounting in read-write and
> > using it for sensitive application, that falls to "insane" category for me
> > :) We agree on that. And I agree that depending on the application using
> > FUSE to access such filesystem needn't be safe enough and immutable fs +
> > overlayfs writeable layer may provide better guarantees about fs behavior.
> 
> That is my overall goal, I just want to make it clear
> the difference out of write isolation, but of course,
> "secure" or not is relative, and according to the
> system design.
> 
> If isolation and system stability are enough for
> a system and can be called "secure", yes, they are
> both the same in such aspects.
> 
> > I would still consider such design highly suspicious but without more
> > detailed knowledge about the application I cannot say it's outright broken
> > :).
> 
> What do you mean "such design"?  "Writable untrusted
> remote EXT4 images mounting on the host"? Really, we have
> such applications for containers for many years but I don't
> want to name it here, but I'm totally exhaused by such
> usage (since I explained many many times, and they even
> never bother with LWN.net) and the internal team.

By "such design" I meant generally the concept that you fetch filesystem
images (regardless whether ext4 or some other type) from untrusted source.
Unless you do cryptographical verification of the data, you never know what
kind of garbage your application is processing which is always invitation
for nasty exploits and bugs...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
