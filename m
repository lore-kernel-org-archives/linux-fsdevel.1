Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE58473C81
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269066; cv=none; b=qDj+DQynZIy3py7KEIOqvJRnWYOEOpLOo98DNdl/iy3KTIk8lP9JmM82gzC6XNdrLtCYiASIvwWbLELJ1q2cONzcZs7umbsVz5y6mQ1IQkaR4+CDuy2sfPCpy5WY5atMZ0ZVAboyCGysyI1UX4eepU3d95oTgtzUoIvlNgoLTgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269066; c=relaxed/simple;
	bh=MyXPQw4RrkIRWrgcTYbYhSVFwdMADbZNaxG95+hTsx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reJkXShqzCPva75hNlTeSJxYGC38zlxoykMp+30G/pWUnIk4By24fBoEReoef5gtsSoEuWBiyT4xkwsbfiHPpYNzO+tUu0n2+ytYGFV8L09UWiOW861UBW9xYnU/GTtR6ZZCv1iAWllcuB+JsUBVVmnd2sMqWg1B5yShpBPtcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQNkvgqP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJrUAGi8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MfZfcmGS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M83w8sp8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQNkvgqP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJrUAGi8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MfZfcmGS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M83w8sp8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB0937C529;
	Tue, 28 Jul 2026 20:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785269059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRmV0vzisE7gU3jBJjeQA7FfT8MJgf6AiW7t4sSwdYo=;
	b=pQNkvgqPQfy7dqzn9XYzDHpEy84Lz3n1CFaRTf1RNu+J8G1z/ZmGdfT5yZaqJlb5MHTbqu
	yDaYxuSs5a7hjXjwu85+bmspGu9fcHlg0qRSNewXXekqSmocTywFDgQEtkqD0FHvJiG7yv
	K7A5V9M+cq+Yr7kNmq5ZyheY57+jVkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785269059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRmV0vzisE7gU3jBJjeQA7FfT8MJgf6AiW7t4sSwdYo=;
	b=XJrUAGi8XcUR7zGyrAPUvHYhHBoAqW1pVNq9pJw9QIhIl3Cw6BB0gKqQoPlLkgSjtNgxi5
	tCY07vexFrN9GdCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MfZfcmGS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=M83w8sp8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785269054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRmV0vzisE7gU3jBJjeQA7FfT8MJgf6AiW7t4sSwdYo=;
	b=MfZfcmGStEeGEW5y5E1RDsKfcev2tGYchSxa45AjTX6+VpUSn+o9u1MnP1rtyHIguyE8mN
	Rg6W5u/nwGJsnAhW4HWx/1a7FvvE+y18h+qxld5ZbO5CYrKkdM3hJs0K8O5EC6UGt2mVLq
	MS8KMtmp0mXm4kwHfr84Sx8qXYkT7AQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785269054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRmV0vzisE7gU3jBJjeQA7FfT8MJgf6AiW7t4sSwdYo=;
	b=M83w8sp8gj/hWBD/Mdg3qxjveJLyplYq0LGuUEyU8lF7JKQd4OV85IaIm5hQNkZDCHNhHk
	UBod+Ap3m3ILTeCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9C72779B1;
	Tue, 28 Jul 2026 20:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fh3VLD4LaWr5VQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 Jul 2026 20:04:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 54615A10B6; Tue, 28 Jul 2026 22:04:06 +0200 (CEST)
Date: Tue, 28 Jul 2026 22:04:06 +0200
From: Jan Kara <jack@suse.cz>
To: Chengfeng Lin <lin2530632123@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] fsnotify: concurrent inotify watch add/remove slows
 after 94bd01253c3d
Message-ID: <rbrddfiyruub77dds3hhsal2lyxen3kqybenrlitmdamnstqbt@ywzf5g5xgpjc>
References: <CANGjgd=RwMy=29OYG14b6kkoF1uBHz67jTGge5Nubb-XemMvBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANGjgd=RwMy=29OYG14b6kkoF1uBHz67jTGge5Nubb-XemMvBg@mail.gmail.com>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CB0937C529
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hello!

On Tue 21-07-26 00:00:32, Chengfeng Lin wrote:
> I found a repeatable slowdown in a concurrent inotify workload. An exact
> bare-metal comparison points to:
> 
>   94bd01253c3d ("fsnotify: Track inode connectors for a superblock")
> 
> #regzbot introduced: 94bd01253c3d
> #regzbot title: fsnotify concurrent inotify watch add/remove slowdown
> 
> This is a focused synthetic microbenchmark, not an application benchmark. It
> uses tmpfs, 96 separate inotify instances, and 96 files with different inodes.
> Eight threads, each pinned to a different P-core, concurrently add one watch
> for each instance/inode pair and then remove it.

Thanks for the detailed and throughout analysis! TL;DR for the ones too
lazy to read the whole report: Heavily parallel addition of inode marks to
distinct inodes contends on the superblock's inode_conn_list (and the
corresponding lock) which can reduce scalability of adding inode marks.

Just as a verification: Do I get it right that you observe no regression for
a case where single process is adding inode marks?

If the single-threaded case indeed isn't measurably affected, then I'm not
seriously concerned. Adding inode watch is comparably rare, I would
consider workloads which intensively add inode marks as kind of
pathological and so a scalability regression is acceptable tradeoff in my
opinion (at least for the time being). That being said I have experimental
patches sitting in my local tree which replace the list with rhashtable and
avoid pinning inodes by inode marks. These patches should improve the
scalability as well as a side effect. But I have to find time to revive
them and push them to completion...

								Honza 

> The matched control uses the same instances and pathnames, but all pathnames
> are hard links to one inode. A keeper watch keeps that inode's connector alive
> during timing. The control therefore measures watch add/remove without
> connector creation and destruction.
> 
> I used a fresh boot for each point:
> 
>   6c790212c588 parent A -> 94bd01253c3d child -> 6c790212c588 parent B
> 
> Each point had 2 warm-up rounds and 25 measured rounds. The kernels used the
> same normalized config, compiler, Kbuild metadata, module-signing key,
> preemption mode, and equal-length release strings.
> 
> The machine was an Intel Core i7-12700KF system with 32 GiB RAM. The workers
> used CPUs 0,2,4,6,8,10,12,14. The CPU governor and EPP were set to performance,
> Turbo was disabled, and the runtime setting was preempt=none.
> 
> The primary medians were (lower is better):
> 
>   metric                         parent A      child   parent B
>   P8 distinct, aggregate worker ns/watch
>                                   4182.614   4920.865   4274.895
>   P8 distinct/shared ratio       0.248777   0.292725   0.240657
> 
> P8 means eight workers. The first metric sums the time spent by all workers
> adding and removing watches, then divides by 96; it is not wall-clock time.
> The ratio compares each distinct-inode round with its matched shared-inode
> control round.
> 
> Relative to parent A and parent B, the child was slower by 17.65% and 15.11%
> for the distinct-inode metric, and by 17.67% and 21.64% for the ratio. Parent
> drift was 2.18% and 3.32%, respectively. All correctness and affinity checks
> passed. Updating an existing watch mask and pathname lookup both changed by
> less than 0.3%; the shared-inode control was slightly faster in the child.
> 
> A second parent-child-parent sequence checked worker-count scaling. At P6,
> the distinct-inode metric increased by 9.03% and 9.56%, and the ratio by
> 10.75% and 10.85%. At P8, the distinct-inode increases were 19.58% and
> 19.11%, and the ratio increases were 17.62% and 16.80%. Exact P1 and P4 tests
> stayed below the pre-registered 5% threshold. A 16-worker SMT run changed in
> the same direction, but missed the variability gate and is not part of the
> main result.
> 
> I also tested two diagnostic variants at the child commit in this order:
> 
>   full -> lock-only -> full -> nolist -> full
> 
> Full is the unmodified child. The reductions below are averages relative to
> the full builds immediately before and after each probe:
> 
>   build       list updates   list_lock   P8 distinct reduction   ratio reduction
>   full        kept           kept        baseline                baseline
>   lock-only   removed        kept        14.27%                  12.70%
>   nolist      removed        removed     21.43%                  20.46%
> 
> The lock-only result shows a cost from the list updates or the extra time they
> hold the lock. Removing the lock recovered about 7 percentage points more.
> This suggests that lock acquisition and handoff also contribute. These builds
> are diagnostic probes, not proposed fixes.
> 
> Before sending this report, I checked v7.1.4, v7.2-rc4, Linus' master at
> 1590cf032971, next-20260717, and the linux-fs fsnotify, for_next, and for_linus
> branches. Connector creation and detach still use the list_lock and
> list_add()/list_del() operations introduced by 94bd. I found no equivalent fix
> or matching report in the official linux-fsdevel and regressions archives
> through July 20. The exact timing claim above remains limited to the direct
> parent/child comparison.
> 
> As a topology check, I traced eight unmodified Ubuntu inotifywait processes,
> each watching a different subtree of a Linux 7.1.3 source tree on one ext4
> filesystem. They created 4,177 directory watches. For each process, the counts
> of fsnotify_add_mark_locked(), inode-connector allocations, and
> fsnotify_detach_connector_from_object() matched its watch count. Watch-add
> events from all eight processes appeared in the same 1 ms interval. I started
> them together on purpose, so this trace shows that normal software can create
> the tested topology; it does not measure application performance or how often
> this concurrency occurs in normal use.
> 
> I understand that a05fc7edd988 ("fsnotify: Use connector list for destroying
> inode marks") uses this list to avoid scanning all inodes during unmount. I am
> therefore not asking to revert 94bd.
> 
> Is the extra watch add/remove cost an expected trade-off? If not, would it be
> useful to develop an optimization that preserves the connector list and the
> current unmount behavior?
> 
> Evidence bundle:
> 
>   https://github.com/lcf0399/linux-regression-evidence/tree/245fec71aa05eb2dbd68f11e4c98729f22bbc541/fsnotify-concurrent-inotify-watch-setup
> 
> Standalone reproducer:
> 
>   https://github.com/lcf0399/linux-regression-evidence/tree/245fec71aa05eb2dbd68f11e4c98729f22bbc541/fsnotify-concurrent-inotify-watch-setup/reproducer
> 
> Thanks,
> Chengfeng
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
