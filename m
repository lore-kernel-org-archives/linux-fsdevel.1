Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225F4F6477;
	Thu,  1 Oct 2026 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847012; cv=none; b=RFOGfz3WyhrG4E2VFDOuvIrqVKnoQ+CWW4OD42kzA3/PvrDCCzpAFNtPslI6/j74IJMirEXPdzr6TZmFYvOsrXy1qlkZ3gp2T/kux9JffZuUS9ONLsGuKBYl8eRfKzQFV1B/FLoduttAdSnrClsQrCBT4rp5Yhu+fi7thVo6dhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847012; c=relaxed/simple;
	bh=ztq+Ygi+M+S8A2YGuXH4UO7cjcVv8uEN6su5v3/3lYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLQhwZ8yTLihbkC0MEOsxU/4qbFjIa5WgjEgj5NdJ6vfErmxNJ2tbZHe77T7Vvvaf1Kpmv5KSbC5UMO6hjb6HgmAKzIbBu33idst2ErIKz2/ltR8IOW6wuiGGvg8Wdkw8g5/k6RWzVhFPKzu8NONK9/2ufqyG/IyMMFqCaCoTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SjXPeXTu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dtfzVzLP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bvBG8aGg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gzq9gMVE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SjXPeXTu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dtfzVzLP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bvBG8aGg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gzq9gMVE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9923621C43;
	Thu,  1 Oct 2026 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790846998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEZP882SfQ3eIL2PdowrKQ9SqnClwFQWZZmK2uGnCws=;
	b=SjXPeXTu0+uaQ+Nj3zbGmiIrxzJUy6UUV93UO6dPxXypIhnWDUKV1HamTpa+RdS3fmrS7X
	+pvv6kkWxrYHy5ArqUuDKFlYInMQXUGny/TaXfE/bnm2R/ur0hqAg9aUdkL/TGt+yCksSy
	lNFwu4gQRhixkF/gFYcYY8ypXT4tGdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790846998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEZP882SfQ3eIL2PdowrKQ9SqnClwFQWZZmK2uGnCws=;
	b=dtfzVzLPcxACyPR6zHkD17B11njMfPraolxT7/dK1oUTgntQQDmi+Ocr664OAJYTJFHMpC
	OdvUxWG6A59qdOBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790846994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEZP882SfQ3eIL2PdowrKQ9SqnClwFQWZZmK2uGnCws=;
	b=bvBG8aGgcsivtYMlNYX/8EGu4wWkxULvMrAwbVQrHQjsmbodyAxV8SAaBFIurRxE8ksAFu
	beiyiyJlKAnKpZpXUgcdV12q8BiWj0p9c7xhKUC4ANy1Epi2JFMW8hacrLH/7l8d1RYZHL
	/Jtf4MmowKhdF+PFGP8H8fmaGE8TGSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790846994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEZP882SfQ3eIL2PdowrKQ9SqnClwFQWZZmK2uGnCws=;
	b=Gzq9gMVERWd1uijWVauDjPjqaM/ZoVr/zyBOEbMe5osFXqKvTJhsmWAuW8lx5/SETwJYsf
	ZIe8BH3699f4sMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65BF9136A8;
	Thu,  1 Oct 2026 09:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DEZSDhIovmosKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Oct 2026 09:29:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E1C52A13F7; Thu, 01 Oct 2026 11:29:45 +0200 (CEST)
Date: Thu, 1 Oct 2026 11:29:45 +0200
From: Jan Kara <jack@suse.cz>
To: Palla Raghunath <raghunathpalla.0209@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Brigham Campbell <me@brighamcampbell.com>, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, 
	syzbot+e8ebfecec06a009dd2d3@syzkaller.appspotmail.com, kudo3228@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: Re: [PATCH RESEND] romfs: reject directory entry chains that do not
 move forward
Message-ID: <s3mwyg5flbjlcsdhyt4gnah6ww3luypkne5do6mdgiquzrsy36@ztjylv36x663>
References: <20260918164645.9230-1-raghunathpalla.0209@gmail.com>
 <34t4huzelgho3zelar7vp332rwerth7nso6e76jrfced4chtrt@7q2cjbeymwov>
 <20260930173328.79017-1-raghunathpalla.0209@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930173328.79017-1-raghunathpalla.0209@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[e8ebfecec06a009dd2d3];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,brighamcampbell.com,lists.linux.dev,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Wed 30-09-26 18:33:28, Palla Raghunath wrote:
> On Tue, Sep 22, 2026 at 11:58:35AM +0200, Jan Kara wrote:
> > I doubt these bugs have any practical relevance so I wouldn't CC stable.
> > But I guess that's for Christian.
> 
> Fair enough. I'll drop the stable tag if there is a v2.
> 
> > The patch looks good, I'm just not sure we are guaranteed ROMFS directories
> > are indeed following monotonically increasing disk offset (although that's
> > the most logical thing to do) - added Dave to CC for that.
> 
> Thanks for the review, Jan.
> 
> Documentation/filesystems/romfs.rst doesn't state it, but genromfs
> always lays directories out that way. processdir() hands each entry the
> current offset, which only ever grows, and it places a subdirectory's
> contents straight after the subdirectory's own header, before the next
> sibling. Entries are added to the directory list in that same order,
> and dumpnode() writes each next pointer from that list, so within one
> directory every next pointer points forward. I don't know of any other
> tool that builds romfs images.
> 
> If you'd rather not rely on that, I can bound the walk by the number of
> 16-byte header slots in the image instead. That stops a cycle without
> assuming any particular order. Happy to send a v2 either way.

After checking Documentation/filesystems/romfs.rst I agree that monotonely
increasing offsets were likely the intention despite it isn't stated there
explicitely. So I think your current version is fine. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
