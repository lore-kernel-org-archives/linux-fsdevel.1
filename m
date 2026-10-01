Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4441E51AFE8;
	Thu,  1 Oct 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869260; cv=none; b=gv+Zo9CuaKBA8agD1hkPuYQRbEr+Q55IFZ9bemtqob32/2Kn9lTZWEmc2RAf8jacgYuTLqu+7oCdj59pXHqUKrd15DT0MiXob1pZqExfZ+Kp7sXF2P+7C0o44zqKHyoOtyoTVuTkJSpxGQEmGA+BZCwpmssXopjZHsl2mNt3cGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869260; c=relaxed/simple;
	bh=Uzu7G2Y6SDQ8/H5FugtB+YXz+u2acsxQFw1bVNcucGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b15n6uSUVtg+g3KcGvmZnK7fmhlan+2wbRHClI8dggIyztuMUoIfMVJ6FLsBSFOrsLzxfDMPrTYE0JylEiGsU1TvGAehE3TCjw8fgIohwkgoV8JXSSlbKOImh7iBCJIBNg7LKB+0qgG+SNh82Skq99nmN4WI2pO517rAX1UkQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mMvPP6ko; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yMXjK4F0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GsYNvxNw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H8/xUoxx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mMvPP6ko";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yMXjK4F0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GsYNvxNw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H8/xUoxx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 898971FB10;
	Thu,  1 Oct 2026 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790869251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uzu7G2Y6SDQ8/H5FugtB+YXz+u2acsxQFw1bVNcucGw=;
	b=mMvPP6koTtVQDIJZTFf4mnAZoCPoylMOJPnXbfG9O0hwdirKD9jRablxJ8g/SObakGc1/8
	ia3J3/Pkruu0AtEjg7r4RQI683FlKyg4ttEacfdVvfOGTFo54fuNwdSY8FVxEqjUUSbqBw
	Ui6Nn8BPf5CFX9RyHu27zqDfcDVLzag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790869251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uzu7G2Y6SDQ8/H5FugtB+YXz+u2acsxQFw1bVNcucGw=;
	b=yMXjK4F0GttHmfk7MTpMVmFvyn7cT39bE/byKoz0a2qCL+Oy1SHQmZiDwQP0X495p+EDab
	oHQoZ+zxm0+9P6Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GsYNvxNw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="H8/xUoxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790869247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uzu7G2Y6SDQ8/H5FugtB+YXz+u2acsxQFw1bVNcucGw=;
	b=GsYNvxNwc8mMqmYjnTEAz//kHHcVIY9OlS076NgudN/8qDOqSgrJMImAj8ePs5ArtnTMPx
	AGFl7bpu8REBaRYB5fs0AHC4I+xUKlO+FXITI1//rGMD5Yw9gVNUzuPGz5TJHyCQO4qnbu
	bbF3N8/YTDoOiIUgYHHUzp313n3Yui0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790869247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uzu7G2Y6SDQ8/H5FugtB+YXz+u2acsxQFw1bVNcucGw=;
	b=H8/xUoxxs20thTxyQ3HQMmV5h+PzRyUpg8F6ar5Sp5VhvWh6a1RXtfT9JTONP6JBzq2hY9
	8Y5pspR5/wM1frBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26E8213B80;
	Thu,  1 Oct 2026 15:40:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rQXaJ/5+vmqXQAAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 01 Oct 2026 15:40:46 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>, Caleb Sander
 Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] tools: sync io_uring.h UAPI header
In-Reply-To: <CAK5ssPOAZ=PGDMjsihKCx87Gw+UBpc0J=NB+pOo8PbSBdzSpgw@mail.gmail.com>
Organization: SUSE
References: <20260918090010.1688-1-aditya.ansh182@gmail.com>
 <20260918090010.1688-2-aditya.ansh182@gmail.com>
 <CADUfDZorK-i+eOEpGkVFf_vJhqLUKfBX9n_rkiWtbcyoMHT8uw@mail.gmail.com>
 <CAK5ssPOAZ=PGDMjsihKCx87Gw+UBpc0J=NB+pOo8PbSBdzSpgw@mail.gmail.com>
Date: Thu, 01 Oct 2026 11:40:29 -0400
Message-ID: <87pkxtwhsi.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 898971FB10
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,purestorage.com];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Aditya Prakash Srivastava <aditya.ansh182@gmail.com> writes:

> On Fri, Sep 18, 2026 at 10:20=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
>>
>> Can you drop the tab character and just use a space between the words?
>>
>> Best,
>> Caleb
>>
> Thanks Caleb, will fix that to use a single space in the next revision.
>
> Hi Jens, Gabriel,
>
> If there are no other comments or concerns with the patch series, I
> can send v5 with Caleb's formatting fix addressed. If there are further
> changes needed, I can pick them up in v5 along with Caleb's space
> suggestion.

I don't have further comments. As I mentioned in a previous review, Jens
pointed out pushing to the io-wq is not the best design, but we don't
have the infrastructure to do it in a different way yet.

--=20
Gabriel Krisman Bertazi
