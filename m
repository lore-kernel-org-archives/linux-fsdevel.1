Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B882749C1
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561154; cv=none; b=MzamoPdeVAGfKOiUs2h4ehcX6SLP0kNXA8TY10GopfNudMHopWB4yzg5BTjU16vZu1dzhoeENbSdH/d85dlU//hJBK7GKrprMpH/egz/oN5mhoiGlbhIvDkOJhK54uJEkBKLkyr/V/+e1ZZV9A+w3PVaZXjejXc8dN+oIla50H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561154; c=relaxed/simple;
	bh=0cS3VyR4Z8ZEaGQjWxhK6zIOcvyGFbJqVuevUXNKV7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bm2c9urzm7066G8J3BQU3eEYuD/PhUb62LJPMkjdm10OcfunOcMoKAcfgu8e2v03xOC6OX2ok8dk+tbv3gGCdMIiQ9wl5dtQlNI/1YWQ3fDdSn8GM1gxjz5ONb+26XoDc2E7NY3oFG4cqS9Qj7+7JuQaYaHEf5t1WOYwul8rSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QE4fe8WW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/ymXAw0O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QE4fe8WW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/ymXAw0O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QE4fe8WW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/ymXAw0O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QE4fe8WW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/ymXAw0O"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B13897A024;
	Mon, 20 Jul 2026 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784561150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vN9biC/t0CAhvU2zJIhYxFG/nqLPZ9deMWJFMTyfvq4=;
	b=QE4fe8WWZ8TfW7POvCFkGLD85WhH1C6JJobcD26i0CroIHmVB2t5mVsOLzgS4MLis5Q+IN
	YLKmzDLkl4AImLjSMWTqJ4+ix1wUkATM69pNSaV+7AZSylwkVZxL7H/UeyJW03VrMBys7C
	v2yjK/R7AQpxWTF7amvLqwDKGNtxUng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784561150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vN9biC/t0CAhvU2zJIhYxFG/nqLPZ9deMWJFMTyfvq4=;
	b=/ymXAw0Od7u5OKZ09dS5dzbg23c8LqmzJzteEwKcB5eBalZyjVU/nFG2C+OQfkuL4Mcmjz
	bwTmkcvlADC6J+AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784561150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vN9biC/t0CAhvU2zJIhYxFG/nqLPZ9deMWJFMTyfvq4=;
	b=QE4fe8WWZ8TfW7POvCFkGLD85WhH1C6JJobcD26i0CroIHmVB2t5mVsOLzgS4MLis5Q+IN
	YLKmzDLkl4AImLjSMWTqJ4+ix1wUkATM69pNSaV+7AZSylwkVZxL7H/UeyJW03VrMBys7C
	v2yjK/R7AQpxWTF7amvLqwDKGNtxUng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784561150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vN9biC/t0CAhvU2zJIhYxFG/nqLPZ9deMWJFMTyfvq4=;
	b=/ymXAw0Od7u5OKZ09dS5dzbg23c8LqmzJzteEwKcB5eBalZyjVU/nFG2C+OQfkuL4Mcmjz
	bwTmkcvlADC6J+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DF91779AA;
	Mon, 20 Jul 2026 15:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qZLDE/49XmqBCQAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 20 Jul 2026 15:25:50 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>, Jens Axboe
 <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, io-uring@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aditya
 Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: Re: [PATCH 0/2] io_uring: add removexattr and listxattr support
In-Reply-To: <20260720072213.2719-1-aditya.ansh182@gmail.com>
Organization: SUSE
References: <20260720072213.2719-1-aditya.ansh182@gmail.com>
Date: Mon, 20 Jul 2026 11:25:48 -0400
Message-ID: <87fr1d1y4j.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk,kernel.org,zeniv.linux.org.uk];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,mailhost.krisman.be:mid]
X-Spam-Level: 

Aditya Prakash Srivastava <aditya.ansh182@gmail.com> writes:

> This series completes io_uring's xattr feature parity by adding support
> for the remaining four xattr operations:
> - IORING_OP_REMOVEXATTR
> - IORING_OP_FREMOVEXATTR
> - IORING_OP_LISTXATTR
> - IORING_OP_FLISTXATTR

It is much cheaper to open a fixed file and use the FD variant of these
operations in io_uring that it is with a syscall.  Could we just live
with IORING_OP_FLISTXATTR/IORING_OP_FREMOVEXATTR?

> Historically, applications looking to achieve zero-blocking metadata
> management had to fall back to synchronous threads to list or prune
> extended attributes. This is particularly problematic for highly secure
> layered filesystems, active monitoring engines, or container runtimes
> utilizing namespace isolation xattrs.

Please drop the LLM explanation.  Why is this a problem for
"highly-secure layered filesystems" in particular?  This enables xattr
operations in an asynchronous fashion. period.

> To support this cleanly and reuse existing optimal VFS-layer code paths:
> - Patch 1 makes the necessary listxattr/removexattr VFS-layer helpers
>   non-static and exposes them in fs/internal.h.
> - Patch 2 implements the io_uring operational support (opcodes, opdefs,
>   preparation, and issue handlers) and invokes these exposed helpers.
>
> This approach ensures zero code duplication, robust filename handling,
> and maintains design consistency across both subsystems.
>
> Testing
> =======
> A self-contained test program is provided below

Please turn it into a proper liburing testcase.
-- 
Gabriel Krisman Bertazi
