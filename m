Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835301;
	b=wFJGXX6BR3whPEXAKE9h2WLr5wD7SJ/1oqVJc2Sv+hBCkzI+9ZtHI9TcYzcRJCHZDHRM
	 MiCwfaC2zGdibuaPVOM6oZ5BW2mW9BgLG4K24+gu1t2vrtNxJhAMG1FZjVpfZCrjGx0Vm
	 d/cEJKpTpwD2nUdTrR4Xd9h/M9TrRFgJHGxUZnkemRJPnYDncF6XGygmVz+PNeeFavTyY
	 3fYXmF+7oOxQBCKbo9UrPdIVyavN+Ls7HoD78PGMhF8Zfuq+SlUDpXuOBKgwm3iP54+DY
	 UlKdBan9oz/6+bjYaREGsiUdaWRbJ9OJReb4EvWBckZCD5iS7LZUrep3KQTOrfIzX9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835301;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gxbEQyHwBCT8yQowljHdVcIIxYCDORsLRttGwxGAm8w=;
	b=b+JJqdkls1irY5Elvm2f+ibKXFyAA/0VZ0DQqkpmVzGuDAcWFY9cB3+stKzPFFJFolGx
	 U0s+/oWCsaqM9cupv9d6DwsrE/PWzAA0zgN+dSzsjmHmB6jY7zpMsvj6MqRPR+gLNvNPC
	 fQHFcM2yN6+3t7IFawdCuexNfoe833mBwI1KhKgPqoOn6YyNe16uMO2RXl3i4Ph/5QdnT
	 fGFRReVEPEKQyysrjyeGY3w280UQ552C2RlDy3ALMxLsNQ1+Yrh/jHk85mqKIM/hPo9Vy
	 DWz/jsN1cg/ybDoD4gF7e7cRxEd93iJZKVbiiPAAv0qKc9dd8NN8DetRTTy2jw8UxdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dj64i974;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F87606A32C;
	Wed,  4 Nov 2026 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dj64i974
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB32B1F0093A;
	Wed,  4 Nov 2026 23:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793835301;
	bh=gxbEQyHwBCT8yQowljHdVcIIxYCDORsLRttGwxGAm8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dj64i974G3UuhpOtkNJW5mUFKOqcPtaCKZ0qQ6sCncQpY7Ox6q8ml4mvm6ImiD60v
	 AjRfuTOoeW6YgYH8ZFIjNV2KtZ92BvVddx8qE/yGl5h3WpEi3LiN9y1FUNctZ5/bXe
	 t/a9iCtz8THHlLdq/A6/48IJvrS8TKdS+2B7FTa1h6RyUgAdSjyjzw382shY/s2mcA
	 m+/ZK7BmTF6bp93KQzqFAmVecqupVfHBn2eViayrYsWnId0Gi1KsUNse0Dds3GFjVC
	 GiYCR2p9l/QysLGBOD/NCf99SQ8tyqskf4k+/uRrnxvxNTFqYr0t/xEPBgcaGZW2w/
	 R0tCpol2Qtqvw==
Date: Thu, 5 Nov 2026 00:34:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
	Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
Message-ID: <20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
 <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner>
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
In-Reply-To: <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner>

> I resent once after I cleaned things up post RFC and I don't plan on
> resending (one failed attempt due to my network dropping).

A git tree with all of the patches can be found at:

    https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.procfs.cleanup

The overview is in the umbrella:

    https://patch.msgid.link/20261104-work-procfs-v2-0-b45cd5789ac5@brauner

Thanks!
