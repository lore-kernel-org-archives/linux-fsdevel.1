Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1562C027C;
	Thu, 24 Sep 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244158; cv=none; b=dpxrmuIVkN3fyddX4gobtMpXpB7Ir50OJW9f+pPbOnqGhtsN9TVhC0hWp5qYiNMrA4/57JZegGkkLGo6wuNAGHYQeb6Sv9lAcHvhL4Urfi9H/CX4nRcAbf3z6suEWNLkJnLRMZ/I078r+0iOzHzV4I/Vh7wvKieWbIkBfUGtZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244158; c=relaxed/simple;
	bh=j9bzPr8c/APpw1BFsgzCv6jQ1N1HBVG3AWZYXhTX1wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY1DPY4pGj+cv9anp9HBGtZKLIb1duBo4qxmvMh5NU3ptA0i4/Mdf7rle3NB9tpIElhdxURfGtK3GHBKXPWbkEvRY3VckE//VU3MteFtvmTRqO68aapMmQ+qqb3ckMa8aNTu/CLoKt5VFxwJ1nIerfpTucZDbQlIwpUMJqXXNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k1UDX0Sc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R//TPFuf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZrXg5bKf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cbf8/GAg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k1UDX0Sc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R//TPFuf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZrXg5bKf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cbf8/GAg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23D1820078;
	Thu, 24 Sep 2026 10:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790244144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUgbq2oEPVNbQ4QENlBT3vH4AJoiP0XYBkZ7hOGg7tQ=;
	b=k1UDX0ScgR177+S8gtL0B5TSSbz7rNXB6MmgYOpPi7yzJ/Y8LGibYhJg5LKbfQ1GtsSvoj
	4X928R8jaRA8yqAZNN7PsvzB7cUNuVDfw2236IHaJDjF/MQnYZ3COWNKXGsAu65HDiWhN7
	FjZl+UH6fv5NrFymm5kbF9zxK3wxMl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790244144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUgbq2oEPVNbQ4QENlBT3vH4AJoiP0XYBkZ7hOGg7tQ=;
	b=R//TPFuf/11ED5Xq6lKCgQ3A9LTO+78tPISpshJsvoAVDveh9LJljAKxTLCvVssswYAEiU
	mlS4phsYpMKyNiAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790244140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUgbq2oEPVNbQ4QENlBT3vH4AJoiP0XYBkZ7hOGg7tQ=;
	b=ZrXg5bKfqAiXRfqCx17EHFgvrfQy69ONHxIU2SKZ8XNlukoLoXDmsCq0nY1OCXXXVPqW9M
	9P5JQytZIPFB9JcVDP7AR5V7VUlYNjO1ul5Q45/+7Clq3nveUNUWVV/X71oWgsBykiV6Lp
	eyugY02y4FWgzB1cx/YL5tqw+SjiTkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790244140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUgbq2oEPVNbQ4QENlBT3vH4AJoiP0XYBkZ7hOGg7tQ=;
	b=cbf8/GAgMko46tktgPctenXiNGV9q/ko10jXLleVD/Q179KrKPlQpgGIOi2S34m6CtYotF
	18i2oi5EC+ZwAiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F037313354;
	Thu, 24 Sep 2026 10:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1cr6MSv1tGrxRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Sep 2026 10:02:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7B32CA132E; Thu, 24 Sep 2026 12:02:19 +0200 (CEST)
Date: Thu, 24 Sep 2026 12:02:19 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] isofs: tie the name conversion buffer to its bound
Message-ID: <q2yv3qj5fhkg6gm2zgada2agi2vywt4g264ijw7ocpk4mxclkp@7iehjt5slo6u>
References: <20260922155524.1993425-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922155524.1993425-1-matthias.goergens@gmail.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Tue 22-09-26 23:55:22, Matthias Goergens wrote:
> Two cleanups around the scratch buffer isofs_readdir() and
> isofs_lookup() hand to the name converters.  No functional change; the
> first patch's assertions hold on the current code.
> 
> Found while looking at something else: get_joliet_filename() has been
> passing PAGE_SIZE as its output bound since b2eb2e288604 shrank the
> buffer to 1024, which is safe only because de->name_len is a single
> byte.  That seemed worth writing down in a form the compiler checks.

Well, the buffer indeed was allocated PAGE_SIZE large but the space beyond
offset 1024 was used for the storage of iso_directory_record loaded from
the disk (tmpde). So the storage available for the name was only 1024 bytes
large from the start. Only the failures would be more subtle if the
overflow ever happened before b2eb2e288604. That being said I agree that
get_joliet_filename() usage is outright wrong (despite being harmless) and
making buffer size handling logic more robust is useful.

								Honza

> 
> Matthias Goergens (2):
>   isofs: size the name conversion buffer from a named constant
>   isofs: bound the Joliet iocharset conversion by the output buffer
> 
>  fs/isofs/dir.c    |  9 ++++++++-
>  fs/isofs/isofs.h  |  9 +++++++++
>  fs/isofs/joliet.c | 25 ++++++++++++++++++++-----
>  fs/isofs/namei.c  |  2 +-
>  fs/isofs/rock.c   |  3 +++
>  5 files changed, 41 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
