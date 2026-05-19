Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4C480339;
	Tue, 19 May 2026 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188377; cv=none; b=ZS31UiVovUIR1TuyE/cV4OkiQHgo0q1KX59BOd8x06oG/5utbDFS5VSvXxkrOwlZQ0aewjUZiCHt/W+2Un/nb2jcEZa2pSO3iG7Bmil6fpDzEx9mFz3YdxnVp7rGeouDktyPYDktZLqbK+l1L3ZtOD5Dbe9HojnqBT8BrVUVbCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188377; c=relaxed/simple;
	bh=A/sK4uYKDHlfqofPeTZV72AW44cUa0BDZi7ueukxUkw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=SQ1PuRstr/BwD2m2tMU+9H4KqiIlrwi7/gHdXwiZI056EBDJbFA81bUOHIOn6DijPaBtHSYQuGcro+t2ao8MHu9v6FbKF5kY06Q0SBHJvSlQN/vtbVMkw+v7A1tkcXFfFpGEkdnHHimltOViFPceTv0J1QzHBgAf/SZpbgPanzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG5qVDw4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG5qVDw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B010DC2BCB3;
	Tue, 19 May 2026 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779188376;
	bh=A/sK4uYKDHlfqofPeTZV72AW44cUa0BDZi7ueukxUkw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=aG5qVDw49j2L2f66I6reDbbTDvfsExNp2ERHe47cjeXBviNqvvDR8z1frpZlrBkse
	 tIlzlu2hXDy8PjKpn0j/EAltvgWotNHLkJ4ekyCZemhrcPrT/gByURBUTWQa1K2wlX
	 4qz2Dz96oe1ggLnbsHF2LqOPMY4LhwRWzQMZyewA5986IhP7HBSKoO6FWnrcNsOHty
	 ZX6EYI1V6k+mJONl0TkLkWHyUMV7XvNjaDR5EIUpfaaiptF2RAeWVNHTDRy7H/po3/
	 QiU1dYvQR4i5schE8YVonPenLPwyprZcoJJ+REeEaNGiNHpKm8MEHPz194awVo6y96
	 0aIN+NccsREnw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Jens Axboe <axboe@kernel.dk>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
 Kees Cook <kees@kernel.org>
In-Reply-To: <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <20260518-starten-messdaten-3b8aa670ec85@brauner>
 <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
 <177918418452.771415.4371785688744608623.b4-reply@b4>
 <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
Date: Tue, 19 May 2026 12:59:31 +0200
Message-Id: <177918837114.804096.3977912252785122973.b4-reply@b4>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3427; i=brauner@kernel.org;
 h=from:subject:message-id; bh=A/sK4uYKDHlfqofPeTZV72AW44cUa0BDZi7ueukxUkw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTxOE0tNgvv0N2gc3XLoTeeh03teF81p9f8dZ3ub7eBf
 eNjKSOJjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncj2ZkmHauY9nrwpt7P1y8
 8+CtbdTPmQee6blN3WazXbCr/MbUDi+G/44M8ww4N7uWHvvyRTt83TcF5kufzkUfO/KL95jUocz
 NwnwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-05-19 12:51 +0200, Mateusz Guzik wrote:
> On Tue, May 19, 2026 at 11:49 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On 2026-05-18 20:59 +0200, Jann Horn wrote:
> > > I feel like a sysctl for "disable all the splice-like interfaces and
> > > zerocopy TX" would be reasonable to have? Either by blocking such
> > > operations, or better, silently downgrading all such operations to
> > > normal copies.
> >
> [..]
> > I think blocking isn't going to be useful as it will make it harder for
> > distros to turn this on. So we should degrade.
> >
> [..]
> > Let's discuss the other aggressive alternative: Can we try and
> > unconditionally degrade to copy. This would affect sendfile(), splice(),
> > and vmsplice(). Worst-case we would have to introduce the sysctl
> > retroactively.
> >
> 
> I know at least nginx uses sendfile, but I never benchmarked how much it buys.
> 
> The original patch as proposed filters by rw perms on the file, which
> I expect to exclude nginx.
> 
> While kernel-internal copy is still going to beat a userspace-based
> read/write loop, this is still going to be a hit and I expect people
> are going to complain. Afterwards you may end up with tutorials how to
> re-enable pre-patch behavior, partially defeating the point.
> 
> How about denial of splice usage or degradation to copy are still on
> the table, but based on a different criterion: whether code involved
> is "known good" for lack of a better description. iow the kernel would
> maintain a whitelist of "safe" cases. Random-ass AF_NOBODYEVERHEARDOF
> does not make the cut.

I had thought about that to but I felt a bit iffy about it. You could
envision an FOP_* flag for this:

  /* Module may use splice-like apis */
  #define FOP_MAY_SPLICE          ((__force fop_flags_t)(1 << 8))

But that doesn't address how fundamentally broken vmsplice() for example
really is and that probably no one should get to use it in its current
form.

> Common-case usage would have to be audited of course, but this sounds
> rather actionable and would provide hardening without much friction.

And that's the usual problem where rando module will just raise the
flag. Maybe that's fine and we will keep up.

> I can't stress enough that mucking around splice (even if worthwhile)
> is merely addressing the currently popular attack vector and not the
> general problem.
> 
> The general problem is that the kernel is expected to be able to run
> with untrusted unprivileged users, while it avoidably exposes a huge
> attack surface. Of course there is no way around providing a bunch of
> syscalls to users, so *some* danger will always be there and one has
> to expect that even core code has bugs which will be discovered by
> LLMs in the coming months. Even then, there is tons of code which is
> currently being audited by third parties and which has no use in most
> setups. Instead it gets autoloaded in response to an exploit wishing
> to take advantage of its bugs.
> 
> The huge attack surface was always a problematic position to be in,
> but with the advent lf LLMs any unskilled person can drop a 0day and
> the position is straight up untenable. In the long run there is no way
> around blocking access to code by default, way beyond the current
> splice proposal.

I see this is the "let's become goat-farmers" portion of the message.

