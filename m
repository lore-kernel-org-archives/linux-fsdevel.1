Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886635;
	b=WoRNPkuhnTpYhcOybD7PEgdkMbewkWT7764wlHMfUDzkTswTnVcnhBdlnqXyYkrwp2da
	 pWHe3PqHC+h65m5VNfaprZyiQD66aNZR4OhWPltoy4lj85Nj4zgRexCuulLa7CWg9KC1p
	 1I2rPbWjNZMDlRfYh1i3+U7jASzqfqXOWCxI/+KHc2xiTkRwl82thUcwm0ToUaqqrVj1K
	 hpZX1SnSmT4FEu42DbSeroLSUpaYPhFSSawYGhkmZxvF5b9p7Lx9u6v/zP3OBMl7Yfmbj
	 LeLGUakvfzNrPQlsNkqsuQ/JtaHdY2T6peFMPma47XF9OSQoaUGLV0IlZQ0PGrmolRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886635;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=zSXInAuqH7iL9rLrxziOvJqV4jWEdpG/JECW+pI+5DM=;
	b=PV/O8EfYG0YjnIV97v+Wk/1YRE0Wz2yA/aUF4TeMTFYZV7ZJMHqNT49yMkY9dCAwdsPZ
	 Q35m/tqyHC+uws7tYI3Sh9KsNEQA1tuov2aWhoVc7YjG/nk3hsdy+5g7Ra/R7iLb4iJx3
	 qYpvzzueeAMm3h71bB+hu1vRMRxbTSoEmgMy3Nvox5U3YwA3YrzvHa7zZuR1Han2WhPir
	 pBT8OK/pxBU8R0obDPlhIY1+QV5aPoQgQRQ0M0//9DIdebQBqBOik+dAcNtTqrXwOj+Eo
	 fMu5BgEov3cLurlc+6Pr5/CWZZ1TOpMwv16pcUbST4cAc6u2CpSHgN9thRAuhtKHWWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BxvxbiUz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=myR62+Dc;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=1exBjhja;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=276HOllR;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA093606A32D;
	Thu,  5 Nov 2026 13:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA093606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BxvxbiUz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=myR62+Dc;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=1exBjhja;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=276HOllR
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B65B21E9D;
	Thu,  5 Nov 2026 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793886632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSXInAuqH7iL9rLrxziOvJqV4jWEdpG/JECW+pI+5DM=;
	b=BxvxbiUzwTSLaVFxfR4z6AodSbdlVOc6T5g4Dp279H5e/gxH1ApHrQnLPv73lkJkM3+EVm
	cRj39mOW+FWgkmvX1aZz1AL5NWa45T6Afzrc4z6Aq7E8Q3XNpxxqjVpG/P3TOMwwmrdDhP
	hEgsZctPVidpkLrceCXvt6Gm14i2x8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793886632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSXInAuqH7iL9rLrxziOvJqV4jWEdpG/JECW+pI+5DM=;
	b=myR62+DcAdU0pNl6FPl6kGiAHELiEwA1cWJBQVfBOGM6+1BtRbX0xnE3zg1WVybDZnOEhw
	bTZ8IVW3JrdVB4BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793886631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSXInAuqH7iL9rLrxziOvJqV4jWEdpG/JECW+pI+5DM=;
	b=1exBjhjaM7/kggx+XBV28w+aYLQCUG11jUqRT3auaENfECnJMS4c13C0f3PDEUqgJH/OGz
	t0DpejMJOUJ0AZkhBohCS1wg6UHBV7QfM0ql5+/osNlskg3iBXXRfRjHSFEQqMTHH9/hEs
	xKsSn1gfb+H5WEylUPWJ1UolaeqEuJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793886631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSXInAuqH7iL9rLrxziOvJqV4jWEdpG/JECW+pI+5DM=;
	b=276HOllRALTzvm0j/WctnSKysZI5G0GdQLtOGmdYJYW68OqRj0wqHfT/Wu2Pdbp8FfCF6N
	ez1i9QJ0x1mvF6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56743134F4;
	Thu,  5 Nov 2026 13:50:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 45/DDKeJ7GqrfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Nov 2026 13:50:31 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by quack.suse.cz (Postfix) with ESMTP id D482BB70F;
	Thu, 05 Nov 2026 14:50:30 +0100 (CET)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/4] udf: fix double allocation from the unallocated
 space table
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com, 
 syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com, 
 syzkaller-bugs@googlegroups.com
In-Reply-To: <cover.1793349907.git.matthias.goergens@gmail.com>
References: <cover.1793349907.git.matthias.goergens@gmail.com>
Date: Thu, 05 Nov 2026 14:50:29 +0100
Message-Id: <179388662938.277086.14352291743940863574.b4-review@b4>
X-Mailer: b4 0.16.0
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[43fc5ba6dcb33e3261ca,799a0e744ac47f928024];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.30

> Hi Honza,
> 
> Patch 3 now fixes udf_discard_prealloc() the way you suggested, and
> udf_next_aext() is left alone.  Its Fixes: tag now names the commit that
> added the peek into eloc and elen there.  The two other users that v1
> covered through udf_next_aext(), both walks of the unallocated space
> table, are fixed directly in patch 4.  The code in patch 1 is unchanged,
> and patch 2 only rewords one code comment.  The messages now make the
> mount and stable-backport consequences explicit.
> 
> A filesystem made with "mkudffs --space=unalloctable" hands out blocks
> that are still in use.
> 
> Patch 1: udf_table_new_block() keeps the extent type in the length
> word, so an exhausted type-1 table extent (the type mkudffs writes)
> survives as a zero-length extent pointing at an in-use block, and the
> next allocation from it underflows into about a gigabyte of "free"
> space.  Filling a fresh 1 MiB image with empty files is enough to
> overwrite the reserve VDS and the backup anchor.  This is the double
> allocation behind the two syzbot reports linked in the patch.
> 
> Patch 2 checks the table once at mount and refuses read-write access
> if it is damaged, for example by the bug in patch 1.
> 
> Patches 1 and 2 should be taken together.  Patch 1 prevents the
> allocator from creating new empty extents.  Patch 2 rejects an empty
> entry left by an old kernel before it can be consumed again.  It also
> rejects extents outside the partition.  It cannot detect every possible
> overlap in a table that is already damaged.
> 
> Patch 3: when a file's extent list ends in an empty allocation extent,
> udf_discard_prealloc() frees that allocation extent's block a second
> time instead of the preallocated blocks.  On a table the block is then
> handed out twice, and fsx, as run by generic/091 and generic/263,
> reads back bad data, with or without patches 1 and 2.  On a bitmap the
> preallocated blocks leak.
> 
> Patch 4: udf_table_prealloc_blocks() can hand out the block of an
> empty allocation extent at the end of the table.  With patch 3 alone,
> the reproducer below patch 3 passes, but generic/091 or 263 failed in
> 8 of 34 runs on the 2 October base.  udf_table_free_blocks() can
> write a partition reference it never set; that one I have not
> reproduced.

Thanks, I've taken the patches to my tree.

								Honza

-- 
Jan Kara <jack@suse.cz>
