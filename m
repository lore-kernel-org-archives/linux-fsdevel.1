Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF23EC835;
	Wed, 23 Sep 2026 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188116; cv=none; b=k26wM92FgFjx7oq+joyVYmotMN0bp1/4EGqjmwSguutm3ZOpyjJDL3ZoNTrutn51hSYxmMx5CFhm6VltKZAgu6rFolD4pYx6xZOMFwvvZE2bCqEk4CncNMeeakK4y3uJofwprp8GHgN1TqCxkD9tr2zZA8/Jlv4NW23jxyFdMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188116; c=relaxed/simple;
	bh=sMRNG3n8Pbi+0o5YR74tznfXXOFw8nk/nbgJbCDE59Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bADPchDFj8TEKLQfP3u8KG2cxbyem9HbXj1BPntV3HlowTkVFMAPvLiRM7AACNcSltUaGhDHBZEMk1L6wgDw/clGnlGX3Wj5UAKq21WE7mDmBzVE2fntm6ZfUdRXhL+rVJE5fScLEGIfn60SYhotD61utiMwgiOUa5rV+b5IqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKUjiLK/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bnaF3AgS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b8SgkgM/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HRFz5SJg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKUjiLK/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bnaF3AgS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b8SgkgM/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HRFz5SJg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53ED81FFB6;
	Wed, 23 Sep 2026 18:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790188108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=viiqtuBsrBHW1P2j5X+UFCaddgfqkYmS7WDoicQQFiA=;
	b=OKUjiLK/Bh8v4l7ardB2b1estTuIj9genTQWS5AImzdCP948cd5xUmDt0F3uLFUH4TFVDU
	WbmDxe7J7vRjs8lgUA57ihJMMaLXn4+5kbl2G+csaHoxy9FnIqO5dKcEqGcfVl3vwoaQrM
	RXcRRxezuaL+Wxo1jqQpnfRz7UVtb/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790188108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=viiqtuBsrBHW1P2j5X+UFCaddgfqkYmS7WDoicQQFiA=;
	b=bnaF3AgSp0JA4GBF3iDsgKMHhl9qMfRsXx21Q4zjwCZvSuilfIHZpIZxhMFMy3jMPSsada
	H3O+znvCQnSIi8Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="b8SgkgM/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HRFz5SJg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790188104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=viiqtuBsrBHW1P2j5X+UFCaddgfqkYmS7WDoicQQFiA=;
	b=b8SgkgM/TtyuJpDcGEpuCwbx2bBqkcJgvuDF1Po6OwhMesB8kkCWEn5CQdzdT3OU93eSX4
	v47/oeAfoTTZ6hyboQmRZNr9btk7XsHtPXYpueaAzxqSEGlB1jTzm0fUNdzJcqpDJ8r+bq
	nQfiaVaanNKvj7mo0/BLAQBk9YWGysA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790188104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=viiqtuBsrBHW1P2j5X+UFCaddgfqkYmS7WDoicQQFiA=;
	b=HRFz5SJgXe94US0XLeZ4FDfP5OFKsm3G0rr/J3u1vNF71Y9NYzXpvLjB5G0Bo4OjlDy5MY
	CUI2XaCKPbcXmRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BC8213354;
	Wed, 23 Sep 2026 18:28:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kDd3AEgatGp8agAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 18:28:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A15F9A13D4; Wed, 23 Sep 2026 20:28:15 +0200 (CEST)
Date: Wed, 23 Sep 2026 20:28:15 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	chenyichong@uniontech.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isofs: validate directory records in
 isofs_read_level3_size()
Message-ID: <deu4onvnjxfbrtwixyhl6u64ci7ogefse35e3fvmqk5fc45rvs@4b2l3gthschm>
References: <20260923153220.777907-1-matthias.goergens@gmail.com>
 <volfx2r3ystjmi6d2qaeyu37pjodjrp3sef6y3vmte3ia6aqoy@acwbpwhk5heq>
 <20260923175211.1577344-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923175211.1577344-1-matthias.goergens@gmail.com>
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 53ED81FFB6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO

On Thu 24-09-26 01:52:11, Matthias Goergens wrote:
> On Wed 23-09-26 19:13:03, Jan Kara wrote:
> > Thanks! I've added the patch to my tree.
> 
> Thanks!  One correction to my commit message, if you're still able to
> edit it: the out-of-bounds reads from all three fuzzer reproducers are
> on de->flags, not in isonum_733(de->size).  The last paragraph would
> then read:
> 
>   Found by fuzzing fs/isofs in a userspace harness with ASan
>   (heap-buffer-overflow reads of de->flags).

No problem. Updated.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
