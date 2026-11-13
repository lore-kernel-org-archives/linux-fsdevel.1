Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566991;
	b=jsRF4Wfc499Nod5P96tNNc446zSdal5EVWDOOEollIXi6xGMErllCXeHLHgiy+hbQu/C
	 Z1NVfPDop+YF1/3rTEIDjyNcETn7XjSh71JtyvkOQE0demjDe+TzDbbMqMrZIgM/oT6hY
	 ZsqssgkTZl8kY/eSSx1M/GSmly6AiwfkYmKqqhRk6Bh7VYlR4Y5FEzttm/AHnxoxjB2Pq
	 9panCUQJuyXJvnXs1xcdl53uU2Hs7AkFR6hJ8ALener0bn/ZAK1CXOaWFJfmKMaO5nSRG
	 YK6UI57/7vf812dQBaOwd04A1FLppxltCJ5du/6Lg73TCdhkoUcOf0BnhecYYkmegBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566991;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=UgeXoQO63jyyWYBJnOrmN0NXexIHB8eKSstanicZRbU=;
	b=fnvEE+lbfnuvl4r/VHIlTyCfeMyovQMgEzHLqy1HblsZhPmDvmRTNyhwBo49uD7+L5xv
	 a0WomgoQyJcY4T2hSg394tQZAJD8vGRqXGXEJHp2bx1F0l+XP4w3LKUjId+XAzkiNrGnZ
	 R06QjUcyQ1gOVUcI4ZKFEY/PbuXuulzUX/mE8BCvpoaIhrmD84ykpJgU99/yMwfNIRVYs
	 fhbNXR15N1kOJUTm5aVOmVoH4ogvTzEPv5qvxbMMFzwUZvGbJ425rtEUusSEkFEGrDl3m
	 cdjMmlb//RvFr08ihen0y5udCmRQj4i7wVhKx5zs/SxGGU1A4YT603zWqym1FTeXTGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=eiNty2yK;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=r4wanjr1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZOjT9QJL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sOOnTczQ;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90663606A321;
	Fri, 13 Nov 2026 10:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90663606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=eiNty2yK;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=r4wanjr1;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZOjT9QJL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sOOnTczQ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9F4921FD4;
	Fri, 13 Nov 2026 10:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794566988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgeXoQO63jyyWYBJnOrmN0NXexIHB8eKSstanicZRbU=;
	b=eiNty2yKIkAnDy3I/rZLhL3FXKIog6VJHKMyyy2VbxCOd3YNnLSW1A8Do/SKKwXk1U4CwD
	rPKwbHXN6yqTFejbayGcf2Vcit2E/G2uPkpZPXS7Rc9tbvGyGrKV9AL/3uDdgkpXUm2HvF
	BwlR4r/6Ca1arEpBuXPKtLAgpfxOIsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794566988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgeXoQO63jyyWYBJnOrmN0NXexIHB8eKSstanicZRbU=;
	b=r4wanjr1u0pV+KbN4dDhSPCcbGN1dpz7en1wcn5FD7/tD+Rht/1z7dkKykW73vpcit9Ggx
	alM9Mik+nf6xtuBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794566987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgeXoQO63jyyWYBJnOrmN0NXexIHB8eKSstanicZRbU=;
	b=ZOjT9QJLCxd3zwnOlf9HvnMNm4hyiYpZ2s9wyhUX3hWCY7AdgmW9eJAmMjSO10ewuOGJh2
	huigTTTSiclx4cF9RikzSOmix/aZZeHfQx0/b2sgURYA2/MiYfdnJjR0WfVQR3OokwPMFI
	VMSPcmcKUyl5WIVHTwwg+MrFNDEvlJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794566987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgeXoQO63jyyWYBJnOrmN0NXexIHB8eKSstanicZRbU=;
	b=sOOnTczQ8taHIYnIjnPplPlNe6Bei9OR8at2rO1CT3ZcOLPVtmmNZT05qBTkwu5gUhXcl6
	xmhaX8XTJ4eFFlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4EB4134C3;
	Fri, 13 Nov 2026 10:49:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MbgEKkvr9mrkFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 10:49:47 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 496BF22C8C; Fri, 13 Nov 2026 11:49:47 +0100 (CET)
Date: Fri, 13 Nov 2026 11:49:47 +0100
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: pack fields `i_state` and `i_fsnotify_mask`
Message-ID: <bjeoejajvv7ioxbeqtusyojxhmxxj6l776vh2jgi57xlwdf637@npi5psruy3o7>
References: <20261111153631.1309838-1-max.kellermann@ionos.com>
 <mvh4ekf6iyfijuqggxhpl7kwxdyysx2zqdrp65bxitucxikwpm@6bkppgjyhsoj>
 <CAKPOu+91dBHnssGbHRi2BhwLPU_aoR71Bybh2ddGHeg_G=j4rg@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+91dBHnssGbHRi2BhwLPU_aoR71Bybh2ddGHeg_G=j4rg@mail.gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 13-11-26 09:07:44, Max Kellermann wrote:
> On Thu, Nov 12, 2026 at 7:38 PM Jan Kara <jack@suse.cz> wrote:
> > When moving i_fsnotify_mask please move it along with i_fsnotify_marks. It
> > should better be in the same cacheline because these two are accessed on
> > some performance sensitive paths.
> 
> Tried that, but:
> 
>         struct inode_state_flags   i_state;              /*   120     4 */
>         __u32                      i_fsnotify_mask;      /*   124     4 */
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         struct fsnotify_mark_connector * i_fsnotify_marks; /*   128     8 */
> 
> The cacheline happened to end after "i_state" (and now
> "i_fsnotify_mask"). I could move "i_state" down instead, or move other
> fields around - but you're a better expert here, please advise what
> you believe is best.

I have checked and none of the big filesystems (xfs, btrfs, ext4, tmpfs)
place struct inode to the beginning of their inode allocations. So where
exactly the cacheline boundary ends up being is kind of random anyway (plus
the allocations of the inode structures aren't cacheline aligned anyway).
So I'd just keep these two fields together to have a good chance of them
not being in different cachelines and leave the rest on $deity. ;)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
