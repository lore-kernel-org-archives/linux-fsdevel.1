Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894312;
	b=Bp2RVb8QZGP6zYlOcRP3RWrQM+LkgBKBVSBuQ1V+kGvmxsCXSQX+GPIHLY4FHPGwrfNZ
	 2vs16AIAVkdBG8G2fCaqRJN6Md0gvIvne0RYCj6Jc5GUUetIA1sMe/9UXoOZApMx/lyn6
	 YZTvrjBjEcBP7cjkQ1n5bYNOp05ZcIysGlYyISNVokcP2Aagz6u9djtm9rjoF2VSctHpm
	 5QN3ji/MChE0pEB20g8kS1sfX25KkA3h6X2MdexGmIIiS0z/ykAoTT17/hLMYAKJkXWzo
	 viDe9aMIUGLS8kPWXRAFHOtJwhvv+r3JXYbf9Zt2nY44+PeBs28ov8GEM/iqooMWk1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894312;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+Ty8xjiQpuaS04VenMaZqPaJq/PL1xODbqnu0eXSWcc=;
	b=C0H/Q5OsnI5mlple6DwDHAxNkp4j6Y3YjTwBGIERecxHpfYgJnAxRlciOVW6V7zCWgOZ
	 pogoo4deWvLKMFpJ3G/eaCRczUyMEUychC6aWrROWC0JS6v7SMCSW7gzoddAg8MbCXCFy
	 rp8ZDRgfzVM+VhczHE1jXfpSBOV82qdKHMa/dN/jthJyPGLw0s3IoHKw8VnWuaT0evcQ1
	 D6Ei+orDEzCAPz3nyxoxRqs0et7OnHLz6OHuDRI7DeQLzLXU9LxuHeUz4HPJKhnXghy/k
	 7QZ79oG4eyB9VUzqZueyqyA/nkKH70ED82+wKauA/knJfI3PkKvjVV5WaUAvMWrzqyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFXFQ+QY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F38606A32C;
	Thu,  5 Nov 2026 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFXFQ+QY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BA71F000C1;
	Thu,  5 Nov 2026 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894312;
	bh=+Ty8xjiQpuaS04VenMaZqPaJq/PL1xODbqnu0eXSWcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZFXFQ+QY+ttqZaC0sUX9hpytD98EPqm8Ib8/+NxZtjOxUi8XfcqzVNWGIBwLVn0rM
	 i6G4Lon74oCq38ivVH3evfUya577MOi7tvTSXfwNxVEOdMb+wksYyz3Hq0rfCJltrM
	 qF7cPFNq+1dqGxsojXajf1v5th8swz2OwqKZIhWlhZN3ltzrWuH8UPzeXHXMrGXOEl
	 Jhb7zQ8MZZ+f0JDZyY233ltXcjQ6ZIPqZ5cS2fyfm6ARKXSXf4r1xp8Tq+xgaX2Jho
	 jnQ4XzHNtSWn/MquRcCFMYN3J5/bvEfz16UqnJC1QdnhYT+U107UwyrFGqUVPddZHJ
	 ElT+lQbDkA8qg==
Date: Thu, 5 Nov 2026 16:58:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: How to detect inode leaks?
Message-ID: <20261105-lesbar-puzzeln-duett-fc7bee207796@brauner>
References: <20261030161220.6f773b1c@gandalf.local.home>
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
In-Reply-To: <20261030161220.6f773b1c@gandalf.local.home>

On Fri, Oct 30, 2026 at 04:12:20PM -0400, Steven Rostedt wrote:
> This got me thinking. If for some reason any use case of alloc_inode() did
> not free it, kmemleak will not catch it. I'm guessing because the inode is
> referenced by something somewhere (where it requires the drop_caches or
> memory pressure to free it).
> 
> My question is, is there any mechanism that can catch leaked inodes?

Yeah, but it won't fire for your case. generic_shutdown_super() calls
evict_inodes() and then complains about inodes that are still on
sb->s_inodes:

	if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes), NULL,
				  "VFS: Busy inodes after unmount of %s (%s)",
				  sb->s_id, sb->s_type->name)) {

That's all. That whole block sits under if (sb->s_root).

Your fill_super() fails before that's set. So the superblock gets zapped
without ever looking at sb->s_inodes.
