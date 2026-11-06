Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977338;
	b=4ayUUFtFgPfPHlWes/bTIyYjDHvNOv7zVoFL1PRHUEYHDBiBp771WYRAPhqocR2GJXFz
	 YmyGNSdOAwiBm8wPd1HD/nv8wgApTP+RTad8n72J2mP0RH8UWo7xl+W6qaCjkWkEnE19z
	 lVQPEbaeL/3yeQ+g7glPH6gTza9P74xX12wqmSNhY2prDYLC4/DNDz7hAFxGCKxBRK0/7
	 inDifjxgF9FjAj1vxKxP/8gDl7CZQclT2zxnk7N1/z5cH5Nje3VpQxQY5a2Oz2Ncfzu+/
	 WOjY+ZuKuimDvO++oNswgQPuP9gs4/hFV97PsbyDs8C1Qfg4pX2MAe3B+xtzkXtNE9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977338;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=TDtXPdEsZccRCyjiEYbL6djLMqFzCkE9S7yHHucO/Y0=;
	b=0MrRXzM3ZjFP7tGwaQ8aoIw2U8Yeut890CWalW4szGYtqkhPuBx3dUfXc5Xhx7cy5UdD
	 AQ0GKeChjex8Fjli9jlBMEEXaae3nEQnkhkLssuE244jwfyt0UJ8ZqK7tC19oFFezeRoE
	 Qx1o8Yanv/0TSWRD9jjQ0MUYkegwlgw9ZyL/mNX3pWJLGULrx56E9XRBCmcO6wzPjw7Yp
	 axtshd33y2JDFtMinMQs7LN4k16lYVuA0V/AM63D/q2QIU1NbcNsYr81SbhyI+NdPiWS0
	 naVhOvfNEI1TzWndDXPKQxEeGaxdL51PZN3Kyu5pbzJfySkMVBn3QuZPE7zbW7g6bAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MVW024mu;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1Lr3dwzb;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MVW024mu;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1Lr3dwzb;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C302606A331;
	Fri,  6 Nov 2026 15:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C302606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MVW024mu;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1Lr3dwzb;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MVW024mu;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1Lr3dwzb
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42E9522189;
	Fri,  6 Nov 2026 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793977336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDtXPdEsZccRCyjiEYbL6djLMqFzCkE9S7yHHucO/Y0=;
	b=MVW024mu3KUwb1eDIw9bJ7PUOylrtjz83alILp27tKzUsdCksGRqb2eNBKhuCftDFHtDtf
	KABuC9It6O4tyCiPhUZjyZ0u1CeiNtO1HN59BmgR16E4h4eTs/ZpBWkV5LTiB8N+XVmgMb
	7B6PnDrfL/H4DtYHAIw1gx2QjGhRbKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793977336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDtXPdEsZccRCyjiEYbL6djLMqFzCkE9S7yHHucO/Y0=;
	b=1Lr3dwzbGO42cHRrGquEh+E16qepkp47m3zjRAPxn7qf0CmFHNw6zxA6wxNnbXYCoqd78j
	473SBMFwRpWhQHDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793977336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDtXPdEsZccRCyjiEYbL6djLMqFzCkE9S7yHHucO/Y0=;
	b=MVW024mu3KUwb1eDIw9bJ7PUOylrtjz83alILp27tKzUsdCksGRqb2eNBKhuCftDFHtDtf
	KABuC9It6O4tyCiPhUZjyZ0u1CeiNtO1HN59BmgR16E4h4eTs/ZpBWkV5LTiB8N+XVmgMb
	7B6PnDrfL/H4DtYHAIw1gx2QjGhRbKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793977336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDtXPdEsZccRCyjiEYbL6djLMqFzCkE9S7yHHucO/Y0=;
	b=1Lr3dwzbGO42cHRrGquEh+E16qepkp47m3zjRAPxn7qf0CmFHNw6zxA6wxNnbXYCoqd78j
	473SBMFwRpWhQHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C6F132C9;
	Fri,  6 Nov 2026 15:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id guvJOffr7WpFFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Nov 2026 15:02:16 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id A02AA21BA3; Fri, 06 Nov 2026 16:02:00 +0100 (CET)
Date: Fri, 6 Nov 2026 16:02:00 +0100
From: Jan Kara <jack@suse.cz>
To: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence.csokas@arm.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/2] Add scope-based cleanup capability to eventfd_ctx
Message-ID: <boyk6gdk2qmgj4fxhbluqbtcbhqkgnyiq36hurhomfib6vrogw@tjgi2oxtbvmd>
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
 <20261106-hinein-lagebericht-abbezahlen-cb826d68d175@brauner>
 <bba04255-5dee-4dd2-a877-5e169edceadc@arm.com>
 <sp6gvawt6petvrlky7g6pqaqsp3jwouu6ixarevis5m5vd7fwe@xjxeakzi3nn3>
 <803191ed-6597-4b8d-af7d-812b1b494fee@arm.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <803191ed-6597-4b8d-af7d-812b1b494fee@arm.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,zeniv.linux.org.uk,linux.intel.com,suse.de,gmail.com,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,arm.com:email,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

Hi!

On Fri 06-11-26 15:30:07, Bence Csókás wrote:
> On 2026. 11. 06. 15:13, Jan Kara wrote:
> > Hi!
> > 
> > On Fri 06-11-26 10:31:58, Bence Csókás wrote:
> > > On 2026. 11. 06. 10:05, Christian Brauner wrote:
> > > > On Tue, Oct 27, 2026 at 05:22:00PM +0100, Bence Csokas wrote:
> > > > > Add __free() support to eventfd and update drm_syncobj to use it as an
> > > > > example consumer.
> > > > > 
> > > > > A minor discrepancy I encountered is whether to put a semicolon after
> > > > > DEFINE_FREE(). It seems some in-tree code does, some doesn't. In the end,
> > > > > I followed the example set in core-api/cleanup.rst, and omitted it.
> > > > > 
> > > > > Signed-off-by: Bence Csokas <bence.csokas@arm.com>
> > > > > ---
> > > > 
> > > > I'm really having trouble seeing how this improves anything
> > > > significantly. Probably others have the same impression which is why
> > > > this doesn't get a lot of review.
> > > 
> > > The goal of the __free() API is to reduce the number of goto-based error
> > > paths. Normally, you'd have to keep the state of every local in your head
> > > for every early return. (Has it been initialized? Has it been consumed? Or
> > > does it need to be freed?) Then you need to arrange your "goto tree" (error
> > > labels) in a way that frees everything, and then for every early exit, jump
> > > to the correct one. This can be quite complex for some functions. Look at
> > > KVM or HyperV eventfd code, for example.
> > > 
> > > By contrast, you just mark the local var with _free() and an appropriate
> > > destructor snippet, and the consumption point (the point after which we
> > > don't need to free it on a return) with no_free_ptr(), and the compiler
> > > instruments every early return accordingly.
> > 
> > Sure, but there's also the other side about which you don't speak: unless
> > the destructor is trivial (like kfree()), there are implications about
> > locking, when resources (such as references held by the object) get
> > released etc. So it can also be more complex to wrap your head around
> > __free usage than around standard cleanup code.
> 
> Sure. Thankfully eventfd_ctx_put() is one of the pretty trivial ones,
> basically just calling kfree() on itself when the kref drops to 0.

Ok, fair.

> > So unless __free is providing a noticeable simplification of some goto
> > hell, cleanup in many functions or similar, I generally don't find it worth
> > it...
> 
> Look into for instance mshv_irqfd_assign() and weep... And then imagine how
> much simpler it'd be if it were using __free() instead.

Well, over the years I've seen much worse things :) But I agree for that
function using __free would be a simplification.

> For the example in 2/2, I deliberately chose one callsite where it's trivial
> to deduce that behaviour is unchanged.

Well, the change is kind of "meh, I don't care much" for me. So I guess if
you include some conversion that actually makes code simpler, I guess
Christian might be open to merging this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
