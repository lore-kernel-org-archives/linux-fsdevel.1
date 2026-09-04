Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8511344238E;
	Fri,  4 Sep 2026 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514311; cv=none; b=Vlb8LmcL40HrMmTOr7lF+N8nQHtS7Pza3O2fuTuntmzAoT42+jMfCWB4+aXjpaVGl2vPae1QLY2sZ73qYqTO00cL4rJ1WW8qdy4fD3uNwymMLo4Wbq8dQ6K0CIfl98t3QkRWvUcLZSvDlCLGabHOU1QCw2T2634+d9gj1rMoimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514311; c=relaxed/simple;
	bh=9hm7BE+ZsFE5TmrxPA2/EyYAsXYR/AQZ960fjIriESg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBq8gNBKdTsRk+amTgXIQv6VgcOA9+2SsF5AREWQqh2mz1qE2ameWoFdeCJsjkC1CjQKP45lRjq5M+u+PVM25i5F4bA1IsWTdRMS7liItEhkjR+Tu60Quafg5N1qJnJtiDtQgc2FlNhuyPHC2YOHghPy0ElsU3dMTJd+zQvTrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XnNG65jT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HorEgO25; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PZ69kzBW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AYyyhke1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XnNG65jT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HorEgO25";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PZ69kzBW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYyyhke1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABF05203A6;
	Fri,  4 Sep 2026 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788514302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dqqu47eLr7+qgcvKMTvP8XYk3U9M1m+TBbkru5VtPWo=;
	b=XnNG65jT1XRDOE02Bc3G3PhbjAySrlW7i3+qHNg3MMVIOa/qrtJF9l/SgMnjvgKQxPgwIJ
	ebqjeTPL6coBE7mUvuwSuOr0k0+Hvp7Y1Jc2qbH2Ydgymf04cjU3np71yeVTyXwDC0NuTh
	SxirWVFzUD1qz3Lfw46/354brWB60Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788514302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dqqu47eLr7+qgcvKMTvP8XYk3U9M1m+TBbkru5VtPWo=;
	b=HorEgO25yo0R7QsG5/Qi9PSNzBiqT/ht9FEsHm0rAqtSBTZdzMCxkzlFwf84JMl9EHOxYL
	uJ3BUk5r45p1kfCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788514298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dqqu47eLr7+qgcvKMTvP8XYk3U9M1m+TBbkru5VtPWo=;
	b=PZ69kzBWMQO5svqYDZY7y17nvSHPTZQraabNDfECByo2/i16hBhzUoBQBIHeAQaAV724wX
	hAdDiH2VBAPovT115BXXMpqOiBWmXuP1uKpPv32/u+s2RNZ+kISF7+Kjiu1HM10WyQsoy2
	YastFeRIAyJ92fgFLbmGwkBqVS6di7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788514298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dqqu47eLr7+qgcvKMTvP8XYk3U9M1m+TBbkru5VtPWo=;
	b=AYyyhke1jHHDRMuESUaJoHyUsY3w3FwVuPpf5iPBVd32qX7INW9SWXJqWbYr2JSgKYDPz5
	hmecPN1svO/DF+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86E1F13678;
	Fri,  4 Sep 2026 09:31:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +g7nIPqPmmrDDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Sep 2026 09:31:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1E703A13CE; Fri, 04 Sep 2026 11:31:38 +0200 (CEST)
Date: Fri, 4 Sep 2026 11:31:38 +0200
From: Jan Kara <jack@suse.cz>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] super: remember whether freeze holds writer rwsems
Message-ID: <hyhuckyohsabx2suvq3z7uy3pbgmihva6wgzxr3op7pzcrlu33@p7zzlgp2ehjf>
References: <20260903060855.4610-1-kmehltretter@gmail.com>
 <yly6lgithikpjfvmozn73zvcivoftko7ou6qozsf6xntaoi6yc@44aw3yj4i7rh>
 <apnNew8Exp44CgQh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apnNew8Exp44CgQh@gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Thu 03-09-26 21:50:45, Karl Mehltretter wrote:
> On Thu, Sep 03, 2026 at 12:40:42PM +0100, Jan Kara wrote:
> > This looks like one of these theoretical issues LLMs come up with. Frankly,
> > I just wouldn't bother. If the fs gets forcibly remounted RO due to
> > metadata errors, a frozen fs is likely the least of your worries.
> > 
> 
> You may be right that this is not worth fixing in generic VFS. I tried the
> real filesystem paths anyway:
> 
>           Without patch                 With patch
> ext2      next write hangs, unmount     write and unmount complete
>           gives three RCU warnings
> NILFS2    unmount gives three           unmount completes cleanly
>           RCU warnings
> 
> These tests use FIFREEZE, FITHAW, and corrupted filesystem images.
> Other filesystems have similar error paths.
> 
> The f2fs report fixed by 930c6ab93492 exercised the same sequence. The ext4
> change d3476f3dad4a removed the analogous SB_RDONLY assignment because it
> confused filesystem freezing.
> 
> The VFS patch only makes thaw release what freeze acquired. It is needed
> because these filesystems change SB_RDONLY outside the remount path.

Yes, generally just flipping SB_RDONLY bit is problematic and can lead
to more surprises than just fs freezing issues. So yes, I think improving
filesystems so that they just don't set SB_RDONLY on error is a better way
of handling these problems. I'd certainly accept a patch for ext2 for this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
