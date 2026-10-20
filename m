Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525165;
	b=uKfZGBZ9YFchaZTXguKB0TwaI9Z4vjHdudhsk3MsjlbuPvcyFpNrOwTh0pq0rICv3YYf
	 mv4I0013yth4Bx0hS4OUSniiSm+eQbZiF3vGoLyqNmnYTgnVykZUEtpB+fysK634dORwm
	 mbEFu+NjPaDfMEcEW+YVDKLaN7+SdvuGvXmkwGAsS4BZGEXyzBTZUKi7dYCYSOf/iPvkQ
	 J3M/wzAGH+mgt7YXZAuNryz+fGbR3ikuIMovZPPA2xNdJFDTnjiEfPj0sN12W96G14Kfk
	 WyMhv3Q352ygW6ttGrdEyOcrs8qnDVv5oGOg6hyNtGCZZIBb0sYilP/6H4hsFSruoRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525165;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8tphokwrbS+HdbFZVHYS2Ey3PTd8HsI2I3XPiryFaz8=;
	b=D3/gq+BHwPhvxDrodKTf7lpgSn91Mp0FncVYqbtRrhFZAhhWztMoeeDKcr0UmA01B+nh
	 o82G7uSwT/HXXkkUZqIpqZKH09lrC+cVI47Bw+7YqTUHbE9I0yyxZEbszp6n1+Kapha0F
	 Mz0pJonMAwAZAU76uaiIAm9bjQjppSTY44cPeT4uzqdEBBHw0QYC+NI2h3GEqLVIKaLUp
	 bHJ6r6xJwGLueOMSIgNVFNh3H8/XMQlGFOTlyzZqnYBtE8NKvWI+v7q+MJOjLaHvQYm3L
	 y1y2Mo5K7ro0qXP0OdnID2/BJYlKPw1i+K5dSucFD+1iU8NS0BRTvsX6b4x6/ypUL9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="UAhxKh/m";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72885606A321;
	Tue, 20 Oct 2026 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UAhxKh/m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947C71F000C9;
	Tue, 20 Oct 2026 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792525164;
	bh=8tphokwrbS+HdbFZVHYS2Ey3PTd8HsI2I3XPiryFaz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UAhxKh/mN7h5ci7uCwGPUZI2lvi2kyDTYDZ7j2ckCo/qpRwN9o65AyUnzUkpww67c
	 Lx9MO/nT2bRnbxFc4KYvrLAOmED/6nUYALhFivIHGG96IGNGYSgMINsMo8G5W0QfeE
	 gOJaTT92wsZhCHnYP5ZDFECUXHeK9p1eIWewIXck=
Date: Tue, 20 Oct 2026 19:39:20 +0000
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Halaney <andrew@amutable.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Eric Dumazet <edumazet@kernel.org>, broonie@kernel.org
Subject: Re: [PATCH v4 00/10] net: support thread-specific pidfds for send
 and connect
Message-ID: <atfAmtsj0LmZtBZs@meerkat.local>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
 <1ab71b00-fbe1-42a0-a99e-27d5cd5e5a6e@redhat.com>
 <20261016-erdball-skisport-erhaben-93d64cfd2890@brauner>
 <20261016085732.2f1ffb8a@kernel.org>
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
In-Reply-To: <20261016085732.2f1ffb8a@kernel.org>

On Fri, Oct 16, 2026 at 08:57:32AM -0700, Jakub Kicinski wrote:
> Konstantin, could you consider adding a b4 option which would
> make it apply the patches on the most recent Linus release tag
> and then merge them into current branch as normal?
> Simpler version is to let the user name the application base.
> This lets other trees trivially create a branch later if they
> want to.

This was a fairly frequent request, so I made this change now:

    b4 shazam -M <msgid>

applies the series on the nearest annotated tag in the history of your current
branch (e.g. v7.3-rc6), and then merges it into your branch with the cover
letter as the merge message, just like a pull request. If the series doesn't
apply cleanly on that tag, or there is no annotated tag, b4 falls back to
applying on HEAD and tells you why.

As previously, use -H instead of -M if you just want the result in FETCH_HEAD
so you can look at it first.

If you don't want to upgrade to current master, you can already use
--merge-base to achieve the same effect:

    b4 shazam -M --merge-base v7.3-rc6 <msgid>

It takes any commit, branch, or tag. The most recent master also takes a few
new markers: _tag (the nearest annotated tag, with no fallback to HEAD),
_specified (the series' own base-commit, which is what -M used before), and
_guess (guess from the blob hashes in the patches).

The breaking change here is that b4 no longer uses the series' base-commit by
default -- it was always envisioned as more of a hint for the CI systems. As
far as I'm aware, almost every real maintainer wants to apply to HEAD or, at
least, to the most recent tag as the base.

One potential pitfall: b4 can't know if "the nearest ancestor annotated tag"
is actually useful or meaningful, so if your own annotated pull request tags
(e.g. net-7.3-rc7) are in the history of your branch, one of those could end
up being the nearest tag. b4 always prints which tag it picked, so if you see
that, just pass --merge-base with the release tag you wanted.

The same logic now is in the "b4 review" TUI when taking a series with the
merge method: the dialog shows which base it's going to use and lets you
change it before anything is applied. I know Mark has been asking for this
(cc'ing him for review).

Please let me know if this works for your workflow, or if you run into
problems, or if I completely misunderstood the request. :)

-K
