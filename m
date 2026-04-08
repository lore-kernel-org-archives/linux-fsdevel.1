Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34BC339B3D;
	Wed,  8 Apr 2026 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775682345; cv=none; b=cyHCyNWN/ROSPPjvE8F0aC2+BDVoJTr4Fz8QTcLGVDWuc+3rF7y34xxeW6Ebjr9sCU2ksclVey9Hm4rnZnN0yhd4xPsFgNTuJEvQj1lizpCa+uNS4F0fXBk5XvO/EsOizoe8HUF5oih2yD5UCPIlVHw4u2bqCvchpDcm2UpvXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775682345; c=relaxed/simple;
	bh=5pF7YtRERMCa2hZ6asD7YIvR0VEUx5fH/DbdVR1U3sM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OA4C7n/FWhaWzzi6jptBHQHpb0WQbFQsZhcVRl2b88Pl0mQpe8gwNR3FoMgPV8W7NUvKVAWppX7ZBWpft2vBCwrYrPIApjbkTiYVTDTbYlVSrSWSExOOFOb1RGfA4O5Kg17A+b98UpxDh5DvAj+K0YWT/xRnwph89C33TggMKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgbVqIt8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgbVqIt8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E94C19421;
	Wed,  8 Apr 2026 21:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775682344;
	bh=5pF7YtRERMCa2hZ6asD7YIvR0VEUx5fH/DbdVR1U3sM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pgbVqIt8PsgqIb3tULWeSN7IEY8hsVgaRKoEj1MPGy/LRfj3P4rsAmtHW0dlLcfVO
	 /T17xYwcQArALHinozD1q1g+sgs06uZQKs1I/JIQrlUzJXu1QkUPB0c28HtpGJxNv3
	 W4Z2WL6ek785Y+RALuAwIx4JaUgAHU15EwVjl7+hFRHII6NFLlqSPysYEFqfZqu78R
	 vEMy7X7Y+8U7K/rB4Ht4yxtGD9LNLA2d6pQqA2bWv8arjeuGxEvATcfGkDPe3mywNz
	 wcSSv4zMuITqCBNf8Fgi5w7onhNhXgE/w12Gs8uwpuf6zNZwIB7oFB3xjbDtUXiEuV
	 lSj0HN/jRgEsg==
Message-ID: <10d8499d60824f319e32f52fd6a196b3645f6652.camel@kernel.org>
Subject: Re: [PATCH] dcache: warn when a dentry is freed with a non-empty
 ->d_lru
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, clm@meta.com, 
	gustavold@meta.com
Date: Wed, 08 Apr 2026 17:05:41 -0400
In-Reply-To: <20260408192620.GI3836593@ZenIV>
References: <20260406-dcache-warn-v1-1-c665efbc005f@kernel.org>
	 <20260408064251.GE3836593@ZenIV>
	 <f44d1047296ede580c69bdad8e527ac8294746ec.camel@kernel.org>
	 <20260408192620.GI3836593@ZenIV>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-08 at 20:26 +0100, Al Viro wrote:
> On Wed, Apr 08, 2026 at 02:28:20PM -0400, Jeff Layton wrote:
>=20
> > ...it turns out that Gustavo had been chasing this independently to me,
> > and had Claude do a bit more analysis. I included it below, but here's
> > a link that may be more readable. Any thoughts?
>=20
> Other than rather uncharitable ones about the usefulness of the Turing Te=
st,
> you mean?
>=20
> > **In production** (narrow race window): The livelock occasionally
> > resolves through specific timing that allows a parent dentry to be
> > freed and its slab page reused.
>=20
> Livelock is real and known, all right, but do explain what does "resolves
> through specific timing that allows a parent dentry to be freed" mean.
> Especially since the reference to parent is *not* dropped until after
> having child detached from the tree and DCACHE_DENTRY_KILLED on it,
> with ->d_lock on child held over that.  So select_collect2() seeing
> the victim still locked and attached to the tree has to happen before
> the grace period for parent has a chance to begin.  And rcu_read_lock()
> grabbed there prevents that grace period from completing until we
> do the matching rcu_read_unlock() in shrink_dcache_parent().
>=20
> > In `select_collect()` (the `d_walk` callback used by
> > `shrink_dcache_parent`), two types of dentries are incorrectly counted
> 						     really?
> > as "found":
>=20
> > 1. **Dead dentries** (`d_lockref.count < 0`): Another CPU called
> > `lockref_mark_dead()` in `__dentry_kill()` but hasn't yet called
> > `dentry_unlist()` to remove the dentry from the parent's children list.
> > With the debug delay, the dentry stays dead-but-visible for 5ms.
>=20
> Yes.  And?  That's the livelock, all right, and it needs fixing,
> but how does busy-wait here lead to UAF on anything?
>=20
> > 2. **`DCACHE_SHRINK_LIST` dentries**: Already isolated by another
> > shrinker path (e.g., the global LRU shrinker from `drop_caches`) to its
> > own dispose list. These are being processed by that other path but
> > slowly (5ms per proc dentry with the debug delay).
> >=20
> > When `select_collect` counts these as `found++`,
> > `shrink_dcache_parent()` sees `data.found > 0` and loops again. But
> > these dentries can never be collected onto `data.dispose` (dead ones
> > have count < 0, shrink-list ones already have `DCACHE_SHRINK_LIST`
> > set), so the loop never makes progress =E2=86=92 **infinite loop**.
>=20
> They have no business going into data.dispose; for fuck sake, dentries
> on somebody else's shrink list are explicitly fed to shrink_kill().
>=20
> > **Why this is correct:**
>=20
> It is not.
>=20
> > - **Dead dentries (`count < 0`)**: These are being killed by another
> > CPU's `__dentry_kill()`. That CPU will call `dentry_unlist()` to remove
> > them from the parent's children list. `shrink_dcache_parent()` doesn't
> > need to wait for them =E2=80=94 they'll disappear from the tree on thei=
r own.
>=20
> ... and since they keep their parents busy, we should not leave until
> they are gone.  For real fun, consider calls from shrink_dcache_for_umoun=
t() -
> and yes, it *is* possible for another thread's shrink list to contain
> dentries from filesystem being shut down.  Legitimately so.
>=20
> > - **`DCACHE_SHRINK_LIST` dentries**: These are already on another
> > shrinker's dispose list and will be processed by that path. Counting
> > them as "found" forces `shrink_dcache_parent()` to wait for the other
> > shrinker to finish, which can take arbitrarily long (especially with
> > filesystem callbacks or the debug delay).
>=20
> Ditto.
>=20
> > - **The `select_collect2` path** (used when `data.found > 0` but
> > `data.dispose` is empty) handles `DCACHE_SHRINK_LIST` dentries
> > separately by setting `data->victim` and processing them directly. With
> > this fix, `select_collect2` is only reached when there are genuinely
> > unprocessable dentries (count > 0, not dead, not on shrink list), not
> > when there are merely in-flight kills or concurrent shrinkers.
>=20
> Bollocks, due to above.
>=20
> > ### Relationship to the production UAF crash
> >=20
> > The livelock is the **precursor** to the use-after-free crash seen in
> > production (P2260313060):
>=20
> ... and it still offers zero explanation of the path from livelock to
> UAF.  It may or may not be real, but there's nothing in all that verbiage
> even suggesting what it might be.  And proposed analysis is flat-out
> wrong.
>=20
> As for the livelock, see viro/vfs.git #work.dcache-busy-wait (in -next
> as of today).

Thanks for taking a look, Al. We'll keep looking at this thing and see
if we can collect more info, and come up with a better theory of the
crash. I'll dig deeper into the vmcore tomorrow.

FWIW, I've been running a bpftrace script across a swath of machines
that emulates the WARN_ON_ONCE() in the original patch I proposed.
We've had a few crashes while it's running and haven't yet collected
any stack traces.

The script only runs about 80% of the time though, so it's possible
we're just getting unlucky, but I sort of doubt it. It seems more
likely that these dentries are racing onto the list after we've passed
the check.
--=20
Jeff Layton <jlayton@kernel.org>
