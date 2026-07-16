Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1CE3F7A83
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209648; cv=none; b=q0PFFvp6f9TX0V0i8VxmukffzfKv4mW45hhoA9VnCRbQwTRy/7oku9lPw5CGljmETZ0r5plEhkLxTJ/FSgUIzAaAwT12bnsdT2k6mQ7KL2309H8nt+B/3st95wKdNDpR3VWfKBqs+jDzv8K94Y9gK2VQs6ELfcLX4vArSUf2AH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209648; c=relaxed/simple;
	bh=iNgALBorITFTncS+ZX8fvjq2CrgEinLKgaJoSxICT24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiA6cxskmBFzbrPc/Xwn8Q+6Re0H2xhBwX1w6shm/ZoqNT3p4ZQWFd8A86h1iZwGi8QQ4udShq1MYUXtJLMpn4twd8/kesLeyyS4WBe2z3gQVYTNjtAe9uXmn/GnpOzMLQiWIr34xakrfMFDseydfMA/h3sJzrEzUYW0cQcGLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KyYLc4o7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SNuLru5e; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KyYLc4o7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SNuLru5e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KyYLc4o7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SNuLru5e";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KyYLc4o7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SNuLru5e"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 525D578997;
	Thu, 16 Jul 2026 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784209641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDStzPX9UlI5VoVP07ifYDhokG7ohtM2r0GWQRfdxFI=;
	b=KyYLc4o7omQEAIQQVvpJVuI5KSd1kclspaNWbAInWqUOUGtM6plhyC+jQHq5zsxQ1yVkMe
	5wxQm7hobrz9RD9+BmWaHOhru99i4nyOSkm3jpSYxJUU6wnksiaZVqvqCJp0SCGOrR5q4m
	tUPtN6eX8Cb/O6vYibPeL3n1i2KcgB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784209641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDStzPX9UlI5VoVP07ifYDhokG7ohtM2r0GWQRfdxFI=;
	b=SNuLru5eiey3TThUMGcQ6MtjBHzduOctWbE/+NyjYuxbHEW5SsF74nxlSvFQYHwrM65NlJ
	s5FTeDKKPKf1L4Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KyYLc4o7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SNuLru5e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784209641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDStzPX9UlI5VoVP07ifYDhokG7ohtM2r0GWQRfdxFI=;
	b=KyYLc4o7omQEAIQQVvpJVuI5KSd1kclspaNWbAInWqUOUGtM6plhyC+jQHq5zsxQ1yVkMe
	5wxQm7hobrz9RD9+BmWaHOhru99i4nyOSkm3jpSYxJUU6wnksiaZVqvqCJp0SCGOrR5q4m
	tUPtN6eX8Cb/O6vYibPeL3n1i2KcgB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784209641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDStzPX9UlI5VoVP07ifYDhokG7ohtM2r0GWQRfdxFI=;
	b=SNuLru5eiey3TThUMGcQ6MtjBHzduOctWbE/+NyjYuxbHEW5SsF74nxlSvFQYHwrM65NlJ
	s5FTeDKKPKf1L4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20D67779AD;
	Thu, 16 Jul 2026 13:47:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dBekBungWGprGQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 16 Jul 2026 13:47:21 +0000
Date: Thu, 16 Jul 2026 23:47:18 +1000
From: David Disseldorp <ddiss@suse.de>
To: longlong yan <yanlonglong@kylinos.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs_test: add NULL check for kmalloc in
 initramfs_test_fname_overrun
Message-ID: <20260716234718.31479e5d.ddiss@suse.de>
In-Reply-To: <20260715020820.425-1-yanlonglong@kylinos.cn>
References: <20260715020820.425-1-yanlonglong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 525D578997
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,kylinos.cn:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi,

On Wed, 15 Jul 2026 10:08:19 +0800, longlong yan wrote:

> Add missing NULL check for kmalloc return value in
> initramfs_test_fname_overrun(). Without this check, if kmalloc fails,
> the subsequent memset() will dereference a NULL pointer, causing a
> kernel crash.
> 
> Fixes: 83c0b27266ec ("initramfs_test: kunit tests for initramfs unpacking")
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> ---
>  init/initramfs_test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/init/initramfs_test.c b/init/initramfs_test.c
> index 1fc990a66563..c7aab7e5383e 100644
> --- a/init/initramfs_test.c
> +++ b/init/initramfs_test.c
> @@ -189,6 +189,9 @@ static void __init initramfs_test_fname_overrun(struct kunit *test)
>  	 * are already available (e.g. no compression).
>  	 */
>  	cpio_srcbuf = kmalloc(CPIO_HDRLEN + PATH_MAX + 3, GFP_KERNEL);
> +	if (!cpio_srcbuf)
> +		return;
> +
>  	memset(cpio_srcbuf, 'B', CPIO_HDRLEN + PATH_MAX + 3);

Panicking on kunit test alloc failure is reasonable behaviour IMO;
the Fixes tag isn't appropriate here. Also, your patch is only
handling one of the many allocations. KUNIT_ASSERT_NOT_NULL() would be
a better option if we wanted to explictly catch these failures.
