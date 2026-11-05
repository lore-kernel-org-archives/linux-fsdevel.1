Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874544;
	b=JcHrOfilSn+jy2AJXtvy1PvmiaOnSss29kKKr4PC/a4ZVS4p1iLv4fku93YB3Ez9HsTu
	 4DJz6x8IdHZ5Lkz0IdP52+WKED49AAAkdFtrwoZ1Zj6mhQClCarja72wdrNefd4jVHmKP
	 VSw/n3k+9jO9r2HGz9/AwEFuyWzPggjbCdePGYWIf1frnzGCITvzZ2ezpwHkP8tK4y3+v
	 FaaryV/WdwbPOFUUIcmu+CWSjZf5FejLczlHbGjH5HwunoMyKa7sZXgAKOcijFahRpmNd
	 CI0nsYJnB7cFWsLvOy8uu/G7sFkQVPPLElnZuJhq09AznYQfLDXJr6JpcErgTXjotXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874544;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=57E1PfjaDh0LCy68sg+mNNI5f3Z5aUw0wqyBt7zz4T8=;
	b=v95yTTrRk0DNsIt0X+2B5on0e5iUnmnLdG+cG40Cn6SyxWGaVETH/C7SJImJM1ki7RTn
	 b2vt7Xt7Qu9NodK8dACgmaYVhOOeyf2sKs7i4KNIKFhlDiA4rRerSuSsa0d/iGo63JnS/
	 PgWgNsDdm6dE7IzqSlAJd/xjnMatGtVpf+ypQ7HNY9uFcSen6Hq4/jxfDJv5FYJ7dT/6t
	 0k2mGw3v/26xx0ei4Ev2fE3GcrKT8pe3qrBs2qyxiqwUQHbDo6vNmtjs8XKLV4xlj01Ap
	 72H6v8BWC8+Hj2d1b/4vmYO2eAgyvk6fQYLpbB+0wNwf7WnjjD/CVsn4zEsn6brqlhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmbELvjG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD953606D801;
	Thu,  5 Nov 2026 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmbELvjG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808A91F00919;
	Thu,  5 Nov 2026 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874543;
	bh=57E1PfjaDh0LCy68sg+mNNI5f3Z5aUw0wqyBt7zz4T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hmbELvjGRYsr506EAwoJgBAXH0ELDX1EPlqMNbyvDHt92LsnGRKJzHsFbggux76Nr
	 4VuJW2OLsQiJnl39IQDOul1sCQwt9d8MZevNX4eSh6gNm3ZTG/LGbR7xUU9NM2H7ZB
	 Zmf/KjAazsfp6p+rrHhAm27ed37eIP7oTh4Gn6f4ESRdGcc5084mcjIlsi7PeEnK/h
	 ZHrwK8mAJ5fFhNsjwwjPEpQcENFcCs7lLj/i7dd0U+MO//fdk5W/zzCW3ShQTr3BSz
	 /h7RXevBU6GyHIwpRH9BJat6WAMucpuTZsxKrSRux510prhvj/rjFCVc+HBvyfwWTb
	 6GBRdXGUL1uJQ==
Date: Thu, 5 Nov 2026 11:28:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados <joel.granados@kernel.org>, 
	Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, linux-sound@vger.kernel.org, 
	linux-mm@kvack.org, Chuck Lever <chuck.lever@oracle.com>, 
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH RFC 0/7] proc: move procfs to what kernfs does
Message-ID: <20261105-erbrechen-unecht-bauformen-0794d3cfb679@brauner>
References: <20261102-defizit-jobaussicht-kurios-7016c6e67442@brauner>
 <464ef986eab97abf226791c7e19ad111.josef@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <464ef986eab97abf226791c7e19ad111.josef@toxicpanda.com>

On Wed, 04 Nov 2026 22:23:51 +0000, Josef Bacik wrote:
> This is a summary of my Claude review of everything.  It didn't find
> anything wrong with the conversions in parts 3 to 6, the findings are in
> part 1 and on the procfs side.  1-3 are reproduced in a VM, 4-6 are from
> reading the code.

Thanks. This is useful. There's some stuff that I already took care in
v2 fwiw.

> 1) bugfixes 19/38 ("proc: resume readdir after the last name it
>    returned")
>
> proc_readdir_de() now returns 1 instead of 0 when there's nothing left
> to emit:
> [...]
> So at the end of the directory readdir(2) returns 1 without having
> written a dirent, and keeps doing that.  This is syscall 89 through

Indeed. Fixing that.

> 2) cleanup 5/5 ("proc: drop the _buf suffix from the new methods")
>
> 4/5 renames the old ->proc_read() so that "A module that sets one of
> them doesn't build anymore".  5/5 hands the name to the new method, and
> the old and the new prototype only differ in __user:
> [...]
> builds without a warning with W=1.  pde_set_flags() only refuses the
> release helpers for seq_file entries, which this isn't one of, so it
> registers too.  With a module that has exactly that loaded on top of the
> series there's no warning, open() works and every read() fails with
> [...]
> there without anybody noticing.  Either the read method keeps a name of
> its own or pde_set_flags() refuses seq_read, and either way this

Meh, let me think. I think not renaming them back to proc_{read,write}
at the end is ok. Not my favorite but it will cause the compiler to
yell.

> 3) bugfixes 38/38 ("selftests/proc: check that a faulting readlink()
>    doesn't hold up removal")
> [...]
> own.  The two lines want to move to core 08/16.

Fixed in v2.

> 4) core 04/16 ("proc: let procfs own the seq_file of seq_file entries")
> [...]
> return v after pde_seq_stop_pinned() takes care of both.

Gone in v2 as there's a simpler way to do it like kernfs.

> 5) bugfixes 35/38 ("proc: sysctl: don't hold the tables while readdir
>    copies to userspace")
> [...]
> lines that get rewritten.  Handling -ENOENT like d.skip would carry on
> after that name.  -ENOMEM probably wants to be returned instead of
> turning into EOF.

v2 does both.

> 6) stable tags, bugfixes 34/38 and 37/38
> [...]
> table registered.  35/38 applies cleanly without 34/38, so nothing will
> complain if only the tagged one gets picked up.

Right.

> ->free_inode()"), which went into 6.8.  Before that the inode drops the
> entry in ->evict_inode() without a grace period, and the pin is what
> keeps ->data around for a walker that got it from ->get_link().  Which

Right.

> - The cursors in bugfixes 19/38 and 31/38 hang off an open file and
>   anybody can have as many as they have fds, so GFP_KERNEL_ACCOUNT.

That's a generic problem for nearly all of procfs and is another series
I have but I don't want to get chased with pitchforks.

> - copy_to_user_fromio() has no callers left after drivers 22/23.

I'll kill it.

> - fs 07/27 says ntfs_set_label() refused a label that's too long with
>   -ENAMETOOLONG or -EFBIG.  It doesn't always, cpu_str.len is a u8 and
>   ntfs_nls_to_utf16() is allowed (PATH_MAX - 2) / 2 here, so 300
>   characters come out as 44 and pass the check.  That's an old ntfs3
>   bug, it's only the sentence in the changelog.

Right.

> Two more old ones that you might want in part 1, the series doesn't
> change either of them:
>
> - allocinfo can deadlock against a module load.

Yeah, that's in v2 and I think someone else also sent a fix for this.

> - snd_info_text_entry_write() allocates the larger buffer and frees the
>   old one without copying what's in it, so a text entry written in
>   pieces loses the start once it crosses a page.  It's been like that
>   since ffb73b08e794.

Yay, more bugfixes... You share the blame for more mail traffic now.

> This part is me. I have a selftest that my claude wrote to validate #1.
> If you want I can send it along, but we should probably have a test for
> that.

Right, I can probably also cook something up.
