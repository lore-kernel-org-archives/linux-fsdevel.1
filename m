Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1337F735;
	Wed, 17 Jun 2026 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709980; cv=none; b=eaEjmEiYvqpkZYhugAdApbnWA/qHpymU09xm5ApuDwmpgtC+EjOPf1gDdrl/05VrVE5jvudNvZeWCI0QN6RLlKWYPcqPNrsJz/BwGjM2PCTXDTD03sVjwHLxU9dj5lGnFQuWzVSN3ILtcyJSdyx/p2TvU2CbfFKuju4HdCc6dfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709980; c=relaxed/simple;
	bh=lex1Sa6IrrZnTHVP75Ze96aKHjsggTCawxWnLB3WRZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvuIwVDpRfn6DjpDWt7BBEvD6eKy7zBrVUs2gAIWKyjYSG0FLaVfvF50zCRR4fsGgzQ9AilXckjOkY5dCnoRnW0sc8KMFf9Ds7PV3/4HJHcrSOVBt81QEindivFE85eWmMgK3bXB1qH+6eAMv5J3kmLLoVsqKW3seVSYhs5rgmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JfeQ51d8; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JfeQ51d8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=nEx33SVN+jDwWu4ahWlgYqgU4PnskQsGXsyT0OtwT14=; b=JfeQ51d80Kbkc6ocZnjWFcw7U9
	yTlPnJioYXoq54YCK4TZM/M9soWgzH5ph2SL3J78GMo4a3CtJRWNmsjjHZ9ciSg84MNLAjJVpWJS0
	S0WxoXtP542WVVk/5xLz2yFGmWabfWu1O4psJ4U/RzdvEw3wclc9Q2ts8MEW6QoWrSFB14OH6LV7Y
	I6EWceBs/L+g34b7k16g4i3v9a1P2VUYykGW5wyodrcgI1D5jRbAU6YB2nTvesxjrvOtX3yGBOHdP
	adltTCEjObASRQ9DrSAmo/PG6i2C4B7l+SyWYMbfhlmw5K7VWO0gFC3CFmDw7Xb/+ZXQhEBrylpG4
	Cf4S/BTg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZs9X-00EiF9-0a;
	Wed, 17 Jun 2026 15:26:07 +0000
Date: Wed, 17 Jun 2026 08:26:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Josh Triplett <josh@joshtriplett.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <ajK711r4YyumuTpJ@gmail.com>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost>
 <ajJgWBCFYwz9OIo3@redhat.com>
 <ajJ1Xi1p9UhQvILi@gmail.com>
 <CAGudoHEyDz-Tbj=CZFK5XMLuLyE8B17NumdFVLf6MTTekFgRRA@mail.gmail.com>
 <ajKxJM5k9U5L05AF@redhat.com>
 <ajKy5ghjlgyN4tFv@gmail.com>
 <CAGudoHGKyN6k+eSAUm35_WDSZcxxtm4QL6fO+4rYJTvtObMqzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGKyN6k+eSAUm35_WDSZcxxtm4QL6fO+4rYJTvtObMqzA@mail.gmail.com>
X-Debian-User: leitao

On Wed, Jun 17, 2026 at 04:57:16PM +0200, Mateusz Guzik wrote:
> On Wed, Jun 17, 2026 at 4:47 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > Hello Mateusz,
> >
> > On Wed, Jun 17, 2026 at 04:37:24PM +0200, Oleg Nesterov wrote:
> > > On 06/17, Mateusz Guzik wrote:
> > > >
> > > > There are trivial touch ups which can be done by adding a bunch of
> > > > predicts and inlining kill_fasync if someone can be bothered.
> > >
> > > I was thinking about another change, see below. It assumes that in the
> > > likely case another writer won't steal the pages from ->tmp_page[]
> > > before we take pipe->mutex.
> >
> > Do you think we could eventually eliminate the tmp_page[] array and
> > consolidate everything into the prealloc pages? That would unify the two
> > page pools currently used in the pipe write path.
> >
> > When I examined this previously, it appeared non-trivial but potentially
> > feasible.
> >
> 
> I think I commented on this in my first e-mail.
> 
> In order for this to be acceptable there would have to be a way to
> reclaim these pages in case of memory shortage.

Hmm, I understand scenario doesn't apply to the patch that got accepted.
The series doesn't grow the cache: tmp_page[] is still the existing 2-entry
array

anon_pipe_refill_tmp_pages() only fills empty tmp_page[] slots; every
other prealloc page is put_page()'d before the write() returns.

So an idle pipe holds at most 2 cached pages — the same cap mainline
already maintains via anon_pipe_put_page() on the release side, freed in
free_pipe_info().

	/* Runs after mutex_unlock() to keep put_page() out of the critical section. */
	static void anon_pipe_free_pages(struct anon_pipe_prealloc *prealloc)
	{
		while (prealloc->count) {
			prealloc->count--;
			put_page(prealloc->pages[prealloc->count]);
		}
	}

Net new unreclaimable footprint from this series is zero.
