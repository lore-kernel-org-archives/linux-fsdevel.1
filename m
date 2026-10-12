Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14F3C09F8;
	Mon, 12 Oct 2026 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794444; cv=none; b=pR9vqLgVpiwWq8UVNK4pIxToIVSVq/heeo4q0Koy1FuY4LbIcWKg7KpJOT0kJIlSpAHLqZkVwGS8pDSXM4irNwnzVDMOiEJKpFbI303qTGuZJtF316H8YI4iZhf2ovC7PPTgUCpKycvFaw0LdZlZZFxgh84RYg3+w+wXXObNLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794444; c=relaxed/simple;
	bh=H97ELR+tvImsQ4TESHAGuldi9zxY8l1VaVPrCUxUHUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcHh39+Z2DmIg8m0i6ObEi6ujr9cM3qiZK1u2zZbTHFYb9cIjzLmxCy5XqDyvJoden9De/qaiBJ5+NExGfU03fMubohPoRXihup3CmcwlTeq6MXKcmL0h8hLObW6e2LhxEqoDgTEnL0qYufaYA3izTz6iIpx9zEsAtfDSnNzebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K7bD2YBT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ezql2drQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KBDOSqos; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Voy1d4Kr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K7bD2YBT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ezql2drQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KBDOSqos";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Voy1d4Kr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D004921CF4;
	Mon, 12 Oct 2026 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791794440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1d9Dp9HUCpFEb5fVeS22xq/3HlibzKltDxJkQGJtHU=;
	b=K7bD2YBTXmSCOBj1UGVFglEueuyXW1M7XjCOaWPuSChp+AbWVVK2j86rbeLBEAmhJbjGrL
	XFL/Bh6WrA1EbIWKVXaInX92kOGIMTHekPGBJVwnyFawPeXwdD4J3WBKFnGU8/K9BcMZkh
	Bl+pBYEe4wXnTyAkFFm5D6iBkupRWwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791794440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1d9Dp9HUCpFEb5fVeS22xq/3HlibzKltDxJkQGJtHU=;
	b=Ezql2drQWRVjELFifXNSfRgJnHvXQJSC0K4OU/vT3M4brdQHFqcw6bmnrMayPV/bybT1VI
	e7XpLUFP8lz736Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KBDOSqos;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Voy1d4Kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791794438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1d9Dp9HUCpFEb5fVeS22xq/3HlibzKltDxJkQGJtHU=;
	b=KBDOSqosmu9WXisSdaZQgyXcKeM+q96TzF7dmFdcyiCuBGIk1Lftmi05OPs4Nn+Tj+vj4u
	B+6Jzqm4+J0yZqX95r7Fv9F/5Z8kQjFNG0OSYbQ9PHFhb7Ij4eeKVQ9GUl3LXrlCZhUbxI
	ul3swCcOtRIXDIT7s+2zvqfVrZ4L7WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791794438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1d9Dp9HUCpFEb5fVeS22xq/3HlibzKltDxJkQGJtHU=;
	b=Voy1d4KrZlSpTEUdW39g6+PZkp3/ncviquE1ltePETq+sr+VbruhNIua6/i94t47FVFQ9j
	djbd4V7+614kQRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A90FE13408;
	Mon, 12 Oct 2026 08:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RV0mIQadzGqzMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 08:40:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37DC3A1403; Mon, 12 Oct 2026 10:40:23 +0200 (CEST)
Date: Mon, 12 Oct 2026 10:40:23 +0200
From: Jan Kara <jack@suse.cz>
To: Partha Satapathy <partha.satapathy@oracle.com>
Cc: Jan Kara <jack@suse.cz>, amir73il@gmail.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] : Re: [PATCH 0/1] fsnotify: Check parent watches
 without child dentry flags
Message-ID: <gnntcprg4f7ag7ictugnfza24nwfdmyubkuqac7plxbwtedfrz@xgxyvks3h2uv>
References: <cover.1791373689.git.partha.satapathy@oracle.com>
 <qlw6x3hyky5yoievlkd6ylz3ov432hdjlzkcyboswqktnk43il@fvccpqnil5sp>
 <9499fb1a-85f2-41da-88b7-5e7de6fdff0a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9499fb1a-85f2-41da-88b7-5e7de6fdff0a@oracle.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D004921CF4
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,zeniv.linux.org.uk,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri 09-10-26 17:18:17, Partha Satapathy wrote:
> Hi Honza,
> 
> Thanks for suggesting this workload.
> The setup and before/after timing comparisons are below.
> 
> Architecture:                x86_64
> CPU(s):                      512
>   On-line CPU(s) list:       0-511
> 
> NUMA:
>   NUMA node(s):              2
>   NUMA node0 CPU(s):         0-127,256-383
>   NUMA node1 CPU(s):         128-255,384-511
> 
> Testcase :
> Using /dev/shm  tmpfs to create  private test directory.
> Create 1,024 files each fully populated with 4kb.
> Add IN_MODIFY inotify watch to the directory.
> Start a listener thread to read notifications and count queue overflows.
> Start X(1,2,4..1024) client threads; each opens a different file once.
> Wait until every client is ready, then release them together.
> Each client starts its timer and performs 1000000
> one-byte pwrite() at offset0 on its own file.
> Each client stops its timer and closes its file.
> Wait for all clients to finish, drain remaining notifications,
> and stop the listener.
> Print write times, throughput, notification count, and queue-overflow count.
> Close inotify and delete the test files and directory.
> 
> Note : File creation, open, close, and cleanup are outside the timed
> write loops.
> 
> Run 1:
> -------
> 
> | Clients | Before average time | After average time | Time change |
> |---:|---:|---:|---:|
> | 1 | 1.392 s | 1.484 s | +6.6% |
> | 2 | 2.205 s | 2.402 s | +8.9% |
> | 4 | 3.969 s | 3.644 s | −8.2% |
> | 8 | 5.851 s | 5.804 s | −0.8% |
> | 16 | 10.607 s | 11.538 s | +8.8% |
> | 32 | 21.093 s | 22.492 s | +6.6% |
> | 64 | 48.698 s | 49.576 s | +1.8% |
> | 128 | 100.208 s | 100.467 s | +0.3% |
> | 256 | 198.773 s | 197.669 s | −0.6% |
> | 512 | 400.056 s | 399.550 s | −0.1% |
> 
> 
> Run2 :
> --------
> 
> | Clients | Before average time | After average time | Time change |
> |---:|---:|---:|---:|
> | 1 | 1.491 s | 1.484 s | −0.4% |
> | 2 | 2.391 s | 2.402 s | +0.5% |
> | 4 | 4.050 s | 3.644 s | −10.0% |
> | 8 | 6.630 s | 5.804 s | −12.5% |
> | 16 | 11.931 s | 11.538 s | −3.3% |
> | 32 | 22.513 s | 22.492 s | −0.1% |
> | 64 | 50.231 s | 49.576 s | −1.3% |
> | 128 | 100.699 s | 100.467 s | −0.2% |
> | 256 | 198.771 s | 197.669 s | −0.6% |
> | 512 | 401.860 s | 399.550 s | −0.6% |
> | 1,024 | 803.812 s | 806.593 s | +0.3% |
> 
> 
> Positive means After Fix took longer; negative means faster.
> 
> 
> The measured write performance is broadly comparable before and after
> the fix, with no consistent substantial regression or progressively
> worsening slowdown as concurrency increases.
> 
> The differences vary between baseline batches: the increases at 16
> and 32 clients in the first comparison disappear or reverse in the
> second. At 128–1024 clients, average write times differ by approximately
> 0.6% or less. These shifts are consistent with run-to-run variation;
> the results do not show a persistent substantial slowdown from the fix.

Thanks for running these tests. Results are very interesting. Can you
please share your benchmarking program with me?  I'll check it and try to
play with it on my end. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
