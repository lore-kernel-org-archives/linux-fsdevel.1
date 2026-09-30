Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B050254F
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786303; cv=none; b=b8JPPhQCisrlsVk3vTWdCaMiw0iuTWUmJblZLmnGT4sMJMEj4MwQcjo0gGVhFY6KXgq6WkjV/+HnIyILmowxmMyMTdxlDOLZGPXkaY9ZSWNmjr9eCXFwTBzYxnfizmKgIj5+9f3lg1Uisdum194sW8nUAEm7mEQ2f7O2DmKgWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786303; c=relaxed/simple;
	bh=4sa7eJGwfgKrQdvlR2aAmjseAUaspt7l2oSnChsj8Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKUOitXlIT5o/cFG35W0aNJgeWmiIRuZq37CxJ4hVGFixpcDELIZRL60jdKMt47c8C0MJsVi5WpxGzdSssSe2qN10lvUb6z7IJRqF/eSH8ZdBoPEJ6BwrT9PCIU4u1dVwidd0VgK5DYK17bACcUBKlQnmYWDCFftmUhTDPj3qdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jf28N+bN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZndIq80/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BdyjHtL7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/9RFpaNw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jf28N+bN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZndIq80/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BdyjHtL7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/9RFpaNw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 789AC1FAA8;
	Wed, 30 Sep 2026 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790786295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rNIHEiHeQ4/1te1tCIJYZ0yxtmK/9zf6WGIQWiwdCw=;
	b=jf28N+bNnwtnIgKrWWIkAIQD9VJAwEWkL7b3u1iFyhHGRu2/LOOetS4a5swsS8rxh9e0y2
	nWEMY02sKZW0XZ8bmpICmVDPnzo40gZT2/E5RE+MdSIiIT1EedqCGGsosxpQK3UKXUtYay
	1WbIJ2nKrTo7lx1IsL8NU9paWQlhE8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790786295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rNIHEiHeQ4/1te1tCIJYZ0yxtmK/9zf6WGIQWiwdCw=;
	b=ZndIq80/xJ2Hf6JU626UZC7EwF3opWtR7widKF5HvGvhYajrDb4TeXZCDj5WOjn6jNcyLA
	HFbhBbRG8RkqpxBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BdyjHtL7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/9RFpaNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790786291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rNIHEiHeQ4/1te1tCIJYZ0yxtmK/9zf6WGIQWiwdCw=;
	b=BdyjHtL7JOalyiE0rdgfKaljMauNFEzLxUKq32TPhUCtlUJOqYuAd2t3lBkFMOiHsGFCIt
	ubglxOKbfdoAzUBxp+9lsru+U1iiy6JdJKchqQJlQMuGISkf6NsNqRpE5KoiBVxpXe0/yy
	nj7AmV+RizfR5PVkkg3XRsrjT3qkHyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790786291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rNIHEiHeQ4/1te1tCIJYZ0yxtmK/9zf6WGIQWiwdCw=;
	b=/9RFpaNwp1z1eMUOf/wlQzCfBEvTJWZgpcmBD66RahjIu+N/Jdw3lhXX8KGTAG7KJOxkJO
	tvzj9n691s1INsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D3B2136AD;
	Wed, 30 Sep 2026 16:38:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QvjICvM6vWq3BAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Sep 2026 16:38:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BC9CEA13AD; Wed, 30 Sep 2026 18:38:06 +0200 (CEST)
Date: Wed, 30 Sep 2026 18:38:06 +0200
From: Jan Kara <jack@suse.cz>
To: =?utf-8?B?5aSp54u8?= <rockeet@gmail.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file
 mappings
Message-ID: <xhrorb6wn2j2j57ydnt226khnu6gv4ut3crrmjwjr4iwj7d6yo@43lugxdthgyi>
References: <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org>
 <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org>
 <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
 <arz0auULA33fqoWu@gremlin>
 <arz8Plu6J4YOTi0a@gremlin>
 <CAAE3jtcanTUrV3xfofwrvYGCFe5o=Vn7gS66bDzuxzeGg6c5=Q@mail.gmail.com>
 <CAAE3jtdHi7aSsJ62TpEjkxvwA-3TBLvr5i1ohCNg2aupND+_XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAE3jtdHi7aSsJ62TpEjkxvwA-3TBLvr5i1ohCNg2aupND+_XQ@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 789AC1FAA8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hello!

On Wed 30-09-26 23:29:09, 天狼 wrote:
> The distinction behind this request is between surviving a process crash
> and surviving a power failure. After a process crash, the kernel and page
> cache remain alive. A shared file mapping therefore retains the writes
> already made by the process, even if they have not been written to disk.
> 
> ToplingDB has file-mmap MemTables whose data structures survive a process
> crash. Its crash-safe recovery reuses those MemTables instead of rebuilding
> them by replaying the entire WAL. A published sequence number aligns the
> MemTable's per-KV crash-safe boundary with the database's WriteBatch
> atomicity, so recovery can reuse the published data and replay only the
> remaining WAL tail.
> 
> These MemTables also support cheap, millisecond-level ConvertToSST
> (wrap-up and sync, i.e. LSM flush). The file-mmap path renames the existing
> file and appends metadata, preserving the data structure already built in
> it. This avoids copying the contents into a separately constructed SST.
> Moving construction into shmem would add a transfer to the regular file
> that this path currently avoids.

So I think I understand your design and the issues you're facing. After all
I've seen very similar issues with Berkley DB which was also using
MAP_SHARED memory for the DB and under some circumstances the workload
performance was suffering from too frequent writeback.

Now what I miss from your problem description is why "a transfer to the
regular file" from shmem would matter to you. What is the problem with
that? Because a lot of databases do it like that and it works for them. If
you use AIO + direct IO (or io_uring) your performance is going to be even
somewhat superior (or at least on par) to current writeback workers in the
kernel. In terms of data integrity guarantees you are again as good as or
better than using in-kernel writeback because you are in full control when
you write and what you write. So the only reason I can come up with is that
you want to avoid the complexity of your writeback process in your DB. But
in the same spirit we as kernel people want to keep the complexity out of
the kernel :) and if we'd add a feature like this we'd have to maintain it
practically forever so we are very cautious with that.

> Avoiding full WAL replay makes much larger MemTables practical. While a
> large MemTable is being populated, random updates can repeatedly dirty
> pages that background writeback has already written out. Those writes of
> intermediate states consume disk bandwidth without being necessary for
> process-crash recovery. Deferring them is a performance optimization;
> correctness does not depend on the kernel honoring the hint.
> 
> This is a general problem, not something specific to ToplingDB. ToplingDB
> explicitly distinguishes process crashes from power failures and has
> invested heavily in optimizing recovery from process crashes. By contrast,
> LMDB faces the same problem but does not explicitly distinguish process
> crashes from power failures. If sync is skipped when using LMDB, the
> remaining writeback problem is the same as in ToplingDB.
> 
> The global setting and kernel module described in my previous email let us
> work around this locally. The remaining problem is making the optimization
> available to users of a database library. We cannot reasonably require
> every deployment to change a system-wide setting or install and maintain
> an out-of-tree kernel module. The module gets us from no solution to a
> local solution, but it does not provide a broadly deployable interface.
> 
> That is why I am asking for kernel support: a supported, best-effort hint
> that applications can use directly, while leaving the kernel free to write
> back when necessary. madvise is not the only option, deferring writeback
> for the entire file would also be acceptable.
> Per-file deferred writeback would require minimal kernel changes and pose
> a very low risk, while offering enormous benefits.

The problem I see with your per-inode hint is that its semantics is very
vague (and practically tied to the implementation). And this practically
always backfires because people start to make assumptions about the
behavior, then something changes, people's expectations break and people
complain. Or they come with 100 and 1 ways how to tweak the vague behavior
to fit their special usecase and it quickly becomes a mess of conflicting
needs. We've been there many times :-|.

What I could imagine both technically and semantically feasible (but
haven't decided whether it would be used enough to be worth the hassle) is
to implement some say fcntl() / ioctl() with which an owner of the inode
could set / clear a file hint that the inode should be extempt from
periodic writeback - i.e., the writeback that runs once per 5s and flushes
inodes that were dirtied longer than 30s ago (by default). I.e., we will
writeback the inode whenever we see fit but we won't do it just because of
the file's age.

But again similarly as David or Lorenzo I think that implementing your own
writeback worker would be a superior solution for your DB.


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
