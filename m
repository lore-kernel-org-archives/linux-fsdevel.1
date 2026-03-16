Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CB2B9B7
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661192; cv=none; b=PL71GafygvGUiOFDhPGXsYAwv2lM13N9Wt5x/A+p5RX3xdkGyTsbIatiQMJ408OvkaEYyRIhnjBjSPJKt7ZChK0UmRY5E5/GwILTUSFCPBiwbsyeMcZ/XqvAQuMJAeJfg0F+GsdqhdP3skee0iSHQatQ6TpXl10PjqDdRrkt3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661192; c=relaxed/simple;
	bh=xk8MW+cdL1vGKao181r7gXlVebMDz9A5B1JOCwdl690=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ns6hnzqX2ci7Fa8YkTo4QaZ8oxK2ENBsYtPxxm7Jl2GvD6Vb4exNx5FVSkgydjP1TPoMLRNqTlXzMLH2VQp/3dMXcQSOGZHUYD16RZWKw7u5XR20ZlyiksHVSipNZrVlj29MtlO7Byg6d0513NKBwwlnMAIaSWfa3bnPU3meGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1VOTJ/CI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WrcwIU8w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0FCXMhAH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZwBt7GoV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1VOTJ/CI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WrcwIU8w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0FCXMhAH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZwBt7GoV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EE4C5BD17;
	Mon, 16 Mar 2026 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773661189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpogbJAKqrlr2Jx82XPikBWtnw8kteDhEFarzwucIvA=;
	b=1VOTJ/CIYARFeB4c0GGQe2fUkO3pN5fitVartjTKeOOv6lP4ssiBYqGPXhfjVouCG5x0yS
	UakA4jQQLeGmEnyvOcHkn1CIfi61jXbIyma9ljq1/Agvf1MYoi/+Vl5azAfgpH0Z/ibVNj
	VYBIBvsj2nbpzVwTYIK1XyC7uAolx3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773661189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpogbJAKqrlr2Jx82XPikBWtnw8kteDhEFarzwucIvA=;
	b=WrcwIU8wRm965FXpM+VDVlVGpKbJDkt9Uug6sqYwvZYVi+ZWzx/BHQXO1pV9qRBUhuwxCf
	AUHlxupvyegNqkAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773661188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpogbJAKqrlr2Jx82XPikBWtnw8kteDhEFarzwucIvA=;
	b=0FCXMhAH9XELfYxwGSJLOnqecKF/tC6PDzWwnuVLK1ylgJoaI+Td7JHOofVDa74rV/KmXp
	grxCYxehClvo47PaMja/Zl9/gfp/YrvO1jWbUQUNV7CDIn3ECtIyuvsmZTJVSCHz/L4ble
	8uo7UKa6YFWmdLJ3hvoxWgAsOGE9UsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773661188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpogbJAKqrlr2Jx82XPikBWtnw8kteDhEFarzwucIvA=;
	b=ZwBt7GoVI2St8qTK4fRIa4GWHWz/x8kyNZgD96KCVTBO9gzPgLfJRWCH5Nz8MjOys02hgt
	tgHGMd9kRcy926AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D41C4273B;
	Mon, 16 Mar 2026 11:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aZIgB/7rt2lOKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Mar 2026 11:39:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F2167A08C9; Mon, 16 Mar 2026 12:39:35 +0100 (CET)
Date: Mon, 16 Mar 2026 12:39:35 +0100
From: Jan Kara <jack@suse.cz>
To: "yebin (H)" <yebin10@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>, Ye Bin <yebin@huaweicloud.com>, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	akpm@linux-foundation.org, david@fromorbit.com, zhengqi.arch@bytedance.com, 
	roman.gushchin@linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] add support for drop_caches for individual
 filesystem
Message-ID: <27l3ppyys6j7vto5w2qqxemekk2vvnnn4qxw3iddupdeby3dur@6ijr5wwa5gcb>
References: <20260227025548.2252380-1-yebin@huaweicloud.com>
 <4FDE845E-BDD6-45FE-98FA-40ABAF62608B@linux.dev>
 <69A13C1A.9020002@huawei.com>
 <959B7A5C-8C1A-417C-A1D3-6500E506DEE6@linux.dev>
 <69A14882.4030609@huawei.com>
 <C63DBC11-B4CD-4D8D-9C09-E6A9F690FB21@linux.dev>
 <69A15314.3080602@huawei.com>
 <57055A1C-0684-4B77-80ED-4A641F262792@linux.dev>
 <69A6482C.6060807@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69A6482C.6060807@huawei.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 03-03-26 10:32:12, yebin (H) wrote:
> On 2026/2/27 16:27, Muchun Song wrote:
> > > On Feb 27, 2026, at 16:17, yebin (H) <yebin10@huawei.com> wrote:
> > > On 2026/2/27 15:45, Muchun Song wrote:
> > > > > On Feb 27, 2026, at 15:32, yebin (H) <yebin10@huawei.com> wrote:
> > > > > On 2026/2/27 14:55, Muchun Song wrote:
> > > > > > > On Feb 27, 2026, at 14:39, yebin (H) <yebin10@huawei.com> wrote:
> > > > > > > On 2026/2/27 11:31, Muchun Song wrote:
> > > > > > > > > On Feb 27, 2026, at 10:55, Ye Bin <yebin@huaweicloud.com> wrote:
> > > > > > > > > 
> > > > > > > > > From: Ye Bin <yebin10@huawei.com>
> > > > > > > > > 
> > > > > > > > > In order to better analyze the issue of file system uninstallation caused
> > > > > > > > > by kernel module opening files, it is necessary to perform dentry recycling
> > > > > > > > > on a single file system. But now, apart from global dentry recycling, it is
> > > > > > > > > not supported to do dentry recycling on a single file system separately.
> > > > > > > > 
> > > > > > > > Would shrinker-debugfs satisfy your needs (See Documentation/admin-guide/mm/shrinker_debugfs.rst)?
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > Muchun
> > > > > > > > 
> > > > > > > Thank you for the reminder. The reclamation of dentries and nodes can meet my needs. However, the reclamation of the page cache alone does not satisfy my requirements. I have reviewed the code of shrinker_debugfs_scan_write() and found that it does not support batch deletion of all dentries/inode for all nodes/memcgs,instead, users need to traverse through them one by one, which is not very convenient. Based on my previous experience, I have always performed dentry/inode reclamation at the file system level.
> > > > > > 
> > > > > > I don't really like that you're implementing another mechanism with duplicate
> > > > > > functionality. If you'd like, you could write a script to iterate through them
> > > > > > and execute it that way—I don't think that would be particularly inconvenient,
> > > > > > would it? If the iteration operation of memcg is indeed quite cumbersome, I
> > > > > > think extending the shrinker debugfs functionality would be more appropriate.
> > > > > > 
> > > > > The shrinker_debugfs can be extended to support node/memcg/fs granularity reclamation, similar to the extended function of echo " 0 - X" > count /echo " - 0 X" > count /echo " - - X" > count. This only solves the problem of reclaiming dentries/inode based on a single file system. However, the page cache reclamation based on a single file system cannot be implemented by using shrinker_debugfs. If the extended function is implemented by shrinker_debugfs, drop_fs_caches can reuse the same interface and maintain the same semantics as drop_caches.
> > > > 
> > > > If the inode is evicted, the page cache is evicted as well. It cannot evict page
> > > > cache alone. Why you want to evict cache alone?
> > > > 
> > > The condition for dentry/inode to be reclaimed is that there are no
> > > references to them. Therefore, relying on inode reclamation for page
> > > cache reclamation has limitations. Additionally, there is currently no
> > 
> > What limit?
> > 
> Perhaps I didn't explain it clearly earlier. What I want to achieve is
> the ability to perform memory reclamation (pagecache/dentry/inode)
> based on a single file system. In the current network environment, when
> troubleshooting issues, I want to control the impact of operations and
> only perform memory reclamation on specific file systems. Therefore,
> some files might be in an occupied state, and relying on dentry/inode
> to reclaim pagecache will not achieve the desired effect. Additionally,
> I have encountered some users who periodically run `drop_caches`,
> mainly to clear the pagecache. If we rely on dentry/inode to release
> resources, there will be issues where the pagecache cannot be fully
> cleared. This level of granularity is actually unnecessary because in
> some scenarios, users know which partitions they use more frequently,
> so they only need to clear the pagecache for specific partitions.

Let me revive this thread :) I agree with Ye Bin - the more interesting
part of this functionality is actually giving userspace a way to
effectively trigger drop_pagecache_sb() only for one superblock and inode
/ dentry shrinkers have no chance to do that. In particular because for
example drop_pagecache_sb() will also discard page cache of currently open
files but the inodes / dentries are used (struct file pins them in memory)
so shrinker doesn't even consider them.

I don't have a strong preference whether the API for triggering page cache
reclaim for one sb will be through /proc/sys/vm/<some_new_file> or through
debugfs (possibly <debugfs>/shrinkers/page_cache or something like that)
but this functionality definitely cannot be achieved by just triggering
some shrinkers.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
