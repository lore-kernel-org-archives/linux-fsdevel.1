Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792534043;
	b=lyRiEa/Zfwl9PgC59jWwf8eorXF1j08JlTw3PzDQ1tB9bbpbO+YiNcjPbCn7dCarFH3j
	 mg4cVvmfaGhteebQAEobLQ0L9F2YP1hDujcKygJoLEu8jTcYAv8nxCsnUdIOA6p/Sae1d
	 y6ovkefXtii2gG89UC/nFspHgYOLp31WiYK4Z+506WlDEQFswwlKy/RHM3SKcaN1J2ZZZ
	 phYamRWlln57I/lE36WGj14nQzq4sYKYWc2kYyfy3JNK7V5e9RMgYIAu7MdketSzSTZv8
	 tG4eSAPrpzaMwX856GM9nqYYZ7aQ2q0VkNZt/tEMe2kpBcEb+eVD67H+n/uXd+kFdlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534043;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=n9Uj6I/vyje6NpHmWRgLFomQk1yoneAGW7/KZ4kNqIY=;
	b=Ospncj6P1pxnIKRwwnDTdJ2lw/FSgHaAJ4tFhS2GKK6SnMVowJxjsKA/VlLxqVbQXc8i
	 aI5hqa/4W59TUbZ+CKYrWX+keUCJTby0VsGXjmjhBFoW6j7HAZvoU3ZL/+ytlSvFMAi4S
	 U487NA6TOaGc38+UxSivcGCzRTCPcHd94aODsfLT/FWN0zhDU8j0sAv8Fo9rJ850yvKrA
	 KD1TQDpLujgebKhAhpRiDbDCldwvVIPg9/F1AE8NGT1ELqiHaXsowdG3LAuF6yfm8QUr1
	 eVbUrMR+IUUvKFtzNgfSajpJgnaSwQgitVmyekkcnzcoVi1tBlldwPO6kAsy1ItuIEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPrrBgbU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1376606A319;
	Tue, 20 Oct 2026 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPrrBgbU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A841F000CA;
	Tue, 20 Oct 2026 22:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792534042;
	bh=n9Uj6I/vyje6NpHmWRgLFomQk1yoneAGW7/KZ4kNqIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aPrrBgbUNdrGEu1Uw4wv7tSFj4Ap2UM1XENFp6x4IdBcCzvtI2l+UzPXrSLsCQnor
	 tCOxpGVbohItdMi5AmMfrSLtzsDTgm0UwOS95oCAtb8ptK1OzlejGcyfJ99PBU5xZZ
	 koCO92tbqFX3EbZOloUqQq1RkuT9A5oNSAplXD3qWIscYjWmMlSYebeXA9NEcWvrWR
	 s2kFepDeRuZhPn+/JO0BKq45nXpUZEuOKMf3bqgiaFMH/91tdGVjqncxM/hVOb5AWj
	 OhKfDYdmoUp2BKjdSsutBdpwswI29+EeT03+4F4IwNRF4LCnPME4lk7Y7Xp7R+n9P9
	 dyDS2Tt8yA49Q==
Date: Tue, 20 Oct 2026 15:07:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Halaney <andrew@amutable.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>, Eric Dumazet <edumazet@kernel.org>,
 broonie@kernel.org
Subject: Re: [PATCH v4 00/10] net: support thread-specific pidfds for send
 and connect
Message-ID: <20261020150721.0f23d7ea@kernel.org>
In-Reply-To: <atfAmtsj0LmZtBZs@meerkat.local>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
	<1ab71b00-fbe1-42a0-a99e-27d5cd5e5a6e@redhat.com>
	<20261016-erdball-skisport-erhaben-93d64cfd2890@brauner>
	<20261016085732.2f1ffb8a@kernel.org>
	<atfAmtsj0LmZtBZs@meerkat.local>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 19:39:20 +0000 Konstantin Ryabitsev wrote:
> On Fri, Oct 16, 2026 at 08:57:32AM -0700, Jakub Kicinski wrote:
> > Konstantin, could you consider adding a b4 option which would
> > make it apply the patches on the most recent Linus release tag
> > and then merge them into current branch as normal?
> > Simpler version is to let the user name the application base.
> > This lets other trees trivially create a branch later if they
> > want to.  
> 
> This was a fairly frequent request, so I made this change now:
> 
>     b4 shazam -M <msgid>
> 
> applies the series on the nearest annotated tag in the history of your current
> branch (e.g. v7.3-rc6), and then merges it into your branch with the cover
> letter as the merge message, just like a pull request. If the series doesn't
> apply cleanly on that tag, or there is no annotated tag, b4 falls back to
> applying on HEAD and tells you why.
> 
> As previously, use -H instead of -M if you just want the result in FETCH_HEAD
> so you can look at it first.
> 
> If you don't want to upgrade to current master, you can already use
> --merge-base to achieve the same effect:
> 
>     b4 shazam -M --merge-base v7.3-rc6 <msgid>
> 
> It takes any commit, branch, or tag. The most recent master also takes a few
> new markers: _tag (the nearest annotated tag, with no fallback to HEAD),
> _specified (the series' own base-commit, which is what -M used before), and
> _guess (guess from the blob hashes in the patches).
> 
> The breaking change here is that b4 no longer uses the series' base-commit by
> default -- it was always envisioned as more of a hint for the CI systems. As
> far as I'm aware, almost every real maintainer wants to apply to HEAD or, at
> least, to the most recent tag as the base.
> 
> One potential pitfall: b4 can't know if "the nearest ancestor annotated tag"
> is actually useful or meaningful, so if your own annotated pull request tags
> (e.g. net-7.3-rc7) are in the history of your branch, one of those could end
> up being the nearest tag. b4 always prints which tag it picked, so if you see
> that, just pass --merge-base with the release tag you wanted.

Hopefully it only looks for tags which haven't been deleted?

> The same logic now is in the "b4 review" TUI when taking a series with the
> merge method: the dialog shows which base it's going to use and lets you
> change it before anything is applied. I know Mark has been asking for this
> (cc'ing him for review).
> 
> Please let me know if this works for your workflow, or if you run into
> problems, or if I completely misunderstood the request. :)

Looks like you got it right. Thanks a lot!
