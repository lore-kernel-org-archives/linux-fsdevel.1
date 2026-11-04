Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790390;
	b=Jv7bSS/vFAn+3uOrqUE2a+TnW20WLTPU9i/2LB5WCXSDMSn0Fq5sh8zgCe4D3IeRr6eK
	 4hAV8yWn+1OeAanxwzIg4cLvmLqWqdeYPL6J3tU4zyXpVqw8F3CGUNJID2JLZi8RIByPg
	 RulcWnKlv9DIbW/W+DBCPYsmNYtLs4RLgPo93USjB4xDnCkotR0C3rCeeJRhHdXDC0UUa
	 KXlTDQtMdCs7EuvbDipAlfFH18kHqlMo2rG7PHn6rXsrgdhokonXBqRXCvVTh7ssRvauk
	 3MeGQz9aA3g9ON26RKgd3WpMwPZgyn6RjneuoStIgfqjtG4mc85oqZ9OisdtEGsozgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790390;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=rHaH8Zw4iYvRFhdUT/FXYRK3RlcY/zDX7iGU3dpcCoo=;
	b=TEWve4ffsPiNqK5sxyZXIFl17Sy8VzX7Xa3LrKJnbmYNISJ5u0cF1hhl0b9XXWPHLU+U
	 pe5996j3OHSnjE4A5K0w13Bo6KQxQ1Ns30OBmh391Yl/yj5LCuRt259CEoi9u8R+p2tlE
	 OB5cybwfuPO4LGX+EKZs9XRFZQruBJmvVQEO4rq7WZxD0GWlxSGvXyH+9Fgk/qYDRWZEL
	 PNJRFcZVO9Xv/ZA+8WyuyDXcHzUjHiFNp1FGMtOiEoN/mp7xKm5iBoT9GMd5/b1W17OIm
	 6yVSNWlo33xA/BvvmbS0F1pRyQGZ4qPy/v4guvJTt1xw7V6lASy4xB7RRAtRZg5Eixg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yrQJ5d7j;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=he53flkv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yrQJ5d7j;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=he53flkv;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310B606A329;
	Wed,  4 Nov 2026 11:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F310B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yrQJ5d7j;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=he53flkv;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yrQJ5d7j;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=he53flkv
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0878B1F7D2;
	Wed,  4 Nov 2026 11:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793790388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHaH8Zw4iYvRFhdUT/FXYRK3RlcY/zDX7iGU3dpcCoo=;
	b=yrQJ5d7jYSoRibWSWtiLtXg/3cOt65m+fsjaJDI1cFelqwhcawvaP0ZSjWD1hRiD0O1Fq6
	M3CHW1HSOHONITJH7BXsPaoBW/zTjc5Ow9nHG/EzCaNIqSuMAiwqDW/CcVYevnuopysIX1
	S31SNEGa20RSV3MKeMcOGUR2i+laasQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793790388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHaH8Zw4iYvRFhdUT/FXYRK3RlcY/zDX7iGU3dpcCoo=;
	b=he53flkvk0kpXLqvPBub0pU+UUx7yqrlO3KEYUGj9kijoGCgfotrLP+gn1vyOuWWRhfxGG
	o8Xcchx16X7EpJDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yrQJ5d7j;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=he53flkv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793790388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHaH8Zw4iYvRFhdUT/FXYRK3RlcY/zDX7iGU3dpcCoo=;
	b=yrQJ5d7jYSoRibWSWtiLtXg/3cOt65m+fsjaJDI1cFelqwhcawvaP0ZSjWD1hRiD0O1Fq6
	M3CHW1HSOHONITJH7BXsPaoBW/zTjc5Ow9nHG/EzCaNIqSuMAiwqDW/CcVYevnuopysIX1
	S31SNEGa20RSV3MKeMcOGUR2i+laasQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793790388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHaH8Zw4iYvRFhdUT/FXYRK3RlcY/zDX7iGU3dpcCoo=;
	b=he53flkvk0kpXLqvPBub0pU+UUx7yqrlO3KEYUGj9kijoGCgfotrLP+gn1vyOuWWRhfxGG
	o8Xcchx16X7EpJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C128E134A5;
	Wed,  4 Nov 2026 11:06:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +kmRAbAR62qxGgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 04 Nov 2026 11:06:24 +0000
Date: Wed, 4 Nov 2026 22:06:12 +1100
From: David Disseldorp <ddiss@suse.de>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs_test: exercise the oversized CPIO namesize
 guard
Message-ID: <20261104220315.0cbf0ed2.ddiss@suse.de>
In-Reply-To: <20261027085138.4107590-2-thnkslprpt@gmail.com>
References: <20261027085138.4107590-2-thnkslprpt@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 0878B1F7D2

Hi,

On Tue, 27 Oct 2026 10:51:39 +0200, Avi Weiss wrote:

> initramfs_test_fname_path_max() uses a directory with a nonzero body.

Hmm, indeed, that doesn't make much sense.

> Such entries are skipped even without the namesize > PATH_MAX check,
> so the test does not detect removal of that check.

This is phrased a bit cryptically: the existing test *does* exercise
the name_len > PATH_MAX check, but you're right that removal of that
check would still see the the entry skipped due to the subsequent
if (S_ISREG(mode) || !body_len) filter.

> Use a regular file and terminate the archived pathname early after
> fill_cpio() has encoded the oversized namesize. This allows the test
> to detect a missing parser check without relying on VFS pathname
> length limits.

I don't think adding the early fname termination makes sense in the
context of the test.
