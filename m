Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088707;
	b=Xsclo05H7xN3jkr7LsS/mgora6kZ0wHeUO2spkQEOiaUuMyZusVNk3W2ZNMqUAPfwRDw
	 xjaIHi8Z13Izxmcg9/a3Gtf6In5YFfwV0VhNdFawFXDBLO6QY2YCpgNaY61O9ko1N1PdO
	 nd2nWScwhy9oIo9vkDuGlduLjgHXoEV10fUv7/9wQdZzBJU1rH0YLGc7kPE0rlpbHDBBI
	 PYcm0EpjyTJOulb3cvYWvpyAMhAO2WAbnFPODa/vGKZ37bN5M9+pERhwwpHELMtTp573M
	 pgtjP0HNkjGSIe5UGoGce+nHJvlKjIrKKQbqAVcCQOWhomht9XHqUUX6sgmgL78jNIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088707;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zWiovQmt52JknvMZ+2tR1jIIifrS0DuJHTJpeDT1LCw=;
	b=Y3+E0Kefw1awyqxyMUTuVgNC7bCo9RKniukmSG+aG5IyB2jXDxmP6jLZwJHD5xvSGt91
	 ufTEsUgTHtiHQskxluEIt7NYZCiW1VOCRMWpmMUNY8bGJ45a1KYQJQu6zrqBT32N7hyqa
	 Xktw4RPvv2+2jPO1jDRaOxztE6WflGrDfHs6SDUidUzlUH/6XHcjwLNfprjVwlpAlfVs8
	 tJW96k4yRKIJdZwVHtdxKg88yV5QbmLjpMWgvVpBSD0/OnN1VYMjW1SHwjDUeedQ4Bi+0
	 FJhduSfVKBsgZ/+xpKMm2DhuVb54cZ+ohxGqWKOfUF3QF1SyXsyzA+IZz4CtxzHvGCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKLtFG+6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00035606A31D;
	Tue, 27 Oct 2026 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKLtFG+6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0F61F01825;
	Tue, 27 Oct 2026 08:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793088706;
	bh=zWiovQmt52JknvMZ+2tR1jIIifrS0DuJHTJpeDT1LCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OKLtFG+6tS8Jk+lXq844MxC/uFP28WCkpAfshRkL+QQMdpWMG9BvhlHI6ruMnxLa9
	 qqr5TcWyKXy/5EHd9VaXfk8CdYTkK1FwpLGeFuPvlIDs+ZosXj96Jce7FA5M7+1J6X
	 WRUk0xeStBmvmRon9nfJ3NN6HvNOYDfLNfrKJb/MQ2W2FKs1l1QwEyp2f1ZC1qJ67J
	 jflWWrlIp+TfhtGQDZpY2Eydg8cIGaR6t5PFNOdrltYjkOhwWfPV4Q20eoQNAoVhaC
	 xKTAryfg88PtYcSMsOGUzH9Kr3pQdwlPJ7I/jSAPsl0qJUM8Y3MTfqGXYsukLMA6D9
	 +o9tOdCVDiOGQ==
Date: Tue, 27 Oct 2026 09:11:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] super: make sync(2)'s wait for s_umount killable
Message-ID: <20261027-spargel-laterne-verirren-9d984ac342d4@brauner>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
 <20261023-work-super-lock_helpers-v1-4-d0fcb3f2f275@kernel.org>
 <tqgqwii6it4zxhtsfgnkri2mppbcijvsdnywrsbsyrsc3ey6w5@ts5aqmpikwyv>
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
In-Reply-To: <tqgqwii6it4zxhtsfgnkri2mppbcijvsdnywrsbsyrsc3ey6w5@ts5aqmpikwyv>

On Mon, Oct 26, 2026 at 01:02:46PM +0100, Jan Kara wrote:
> On Fri 23-10-26 11:41:04, Christian Brauner wrote:
> > iterate_supers_sync() waits killably for a superblock that's being shut
> > down, but it takes s_umount of a live superblock uninterruptibly. So a
> > freeze_super() or remount that's stuck under s_umount, in
> > sync_filesystem() or ->freeze_fs() say, still hangs every sync(2) on
> > the machine without anyone being able to kill it.
> > 
> > That's inconsistent with fs_bdev_sync() which already uses a killable
> > super_lock() for both waits. And the reasoning is the same: if the task
> > is killed the walk stops and ksys_sync() returns, there's nobody left to
> > make a promise to. The emergency sync and the sync before suspend and
> > hibernation run from a workqueue where that can't happen. The PROM sync
> > on sparc32 runs in whatever task it interrupted but that one could
> > already be cut short while it waited for a superblock being shut down.
> > 
> > Let __iterate_supers() pass SUPER_LOCK_KILLABLE together with
> > SUPER_LOCK_WAIT_SHUTDOWN for SUPER_ITER_WAIT_SHUTDOWN. Only
> > iterate_supers_sync() passes that flag.
> 
> This might get surprising in the future, I guess SUPER_ITER_KILLABLE flag
> might be a more explicit way to control this but I can live with what we
> have now.

I think you're right I'll fix that up in-tree.
