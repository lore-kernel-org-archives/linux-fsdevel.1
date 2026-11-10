Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348430;
	b=DIqJ5BFqsJ/YNJOz0M9/LzUMHPUuzfpaKZWpyCP2fPzSHUMpU/9L/ZYQcuWv/Flp9vgK
	 02GhDeQ1ZD5uxcAegn7WT6f0/DmY66yTYWRd8p/v7/0hQcdU1UvvmyZH4+FxwEcbJt/HI
	 dABwEm+KltWQucAEtDDX3ZvK6vqVhKEsdY7yoQPsrmiEg16OteUfGJGXgn8AHVzi2T04b
	 +2PiJZxjTk7+UvB8X2leJDGcp0J5GFEJ73wvxA/EYjqD0wMkoUBXl8JLlDfNpqRQ3I9Qm
	 ZAz+WqlZqg6mJB7XpRgedvqHgLz67RO0H8GWUPKWXKKn5V6JpMabyxaljTfM1US3uyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348430;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vZ0g/FzovkvxTWd4Wk5Itwu89T8MT44mf5XsIEyYYrc=;
	b=Xv+/dd4/5zK0ZWmJ1ONMT3XawwgnEyig5wO4hMQNtGxG4diOlgaTcnHOR0JtAmPZr2TD
	 d1w4Hx1U6nDzOjALeNPDudMUyCfpkUsHcnNXvk5mjui6KR5zGgne5qhL1uHt8OdxQ7y7X
	 ufTVumhiQjqQOHHUZER4qYdVt3/yDBS735jeH1tih9eTiWz4wOaM6Ih2Vglqx/A701idZ
	 /CpHoWmDEFU61RL14Qpwopj+dQ9VgGs2yhSbG0ak71L/5qQWp+s1AC4x7dplG8e8IFnW7
	 pI2fPmDVfTdWezApPJ5t1GaVhLz9eu+PXGoMirHTrD70a9781SMQG5FIs1xeT4ipjSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhf0SZ8L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41879606A325;
	Tue, 10 Nov 2026 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhf0SZ8L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2D31F0089F;
	Tue, 10 Nov 2026 22:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348429;
	bh=vZ0g/FzovkvxTWd4Wk5Itwu89T8MT44mf5XsIEyYYrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hhf0SZ8LsQ4XzQPLkOaIhbR2UsNod9O99izG6C/a2lqzInVF6otY8auYQm0WV1gJN
	 XwgVuretnH8UMEQVaGSGpcAK2QzE8EfJdXBWaMIaSmmTtYuhy4WkaFx3EBNRwBKRIA
	 bt/DR5+6QNKSMkSyeIfz5T7c52XF5Lr2iWPwI9NNCB82GrKu+xkx3rfK0fIKQ/YK8O
	 6dSt5VY+hOdxiSnB09n/5ofG+4pp9qbyXVIT7dDYNQxCaxmeE3WMNLKvEwwhz6LXfx
	 rgmds+HgvA9TZIvnURXWK83BxrQzLWS2ahzHEnKdnNrShP6nOfH4TlU/DkPRWR1Y1x
	 csyCa8SFz7Mug==
Date: Tue, 10 Nov 2026 23:07:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
	Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
Message-ID: <20261110-goldkette-zugzwang-woher-1d6f21b4ddca@brauner>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
 <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner>
 <20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
 <CAHk-=wgLpWDjmcNWphCMkKXKwuZsa8KWRPvJ4j=C_ktCL4gBzg@mail.gmail.com>
 <CAHk-=wi-B--TBQuYjz6J6vKtEMpNSm4_wVRzTP_vE=uTLb7P5g@mail.gmail.com>
 <20261109-hackfleisch-lohnt-konkret-02b5f3dde4f6@brauner>
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
In-Reply-To: <20261109-hackfleisch-lohnt-konkret-02b5f3dde4f6@brauner>

On Mon, Nov 09, 2026 at 12:26:23PM +0100, Christian Brauner wrote:
> On Fri, Nov 06, 2026 at 12:19:45PM -0800, Linus Torvalds wrote:
> > Ahh, this all goes away in "scsi: core: let procfs copy in writes", so
> > never mind.

I updated the tree incorporating all the review items I acked on-list:

    https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.procfs.cleanup

The overview is in the umbrella:

    https://patch.msgid.link/20261104-work-procfs-v2-0-b45cd5789ac5@brauner
