Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA3A3C1998;
	Tue, 12 May 2026 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617416; cv=none; b=ZdWMka+4f+9RkpoTu9B4u0ulXAN9FZP3QvQrYOPUYGJCejEhBV0Wm25DkHq0/o4FkFg33MnvmAEwHErihPzPaM8V7Zdofz1rYNYfzVcH65d+OSkZZ4SjGgqhxZ7UYsYozTTCasJFLF8c+XWs4B/Lq/cr8zdERC4svrKYV+W207Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617416; c=relaxed/simple;
	bh=99bL7XlRbXgicpyoQ368EedVEUI6/Us2ig7Gwjaafdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0D+k/rpxFb/Z3b/OpZrbFDx7dOzjWl74litGKUDocR2cC1vzTdWdwBjZZEJ+CZHUKtEURccK/Kmr2fL4FvOyro9N04F/ss6q9K9plCAeXP9pJ9TBd9g3EFwBLKxkwm9Tjql+V+3U4oY882LWvcglPVvaNNJ64xuObXGoGNg5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4FcQCJi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4FcQCJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9357C2BCF5;
	Tue, 12 May 2026 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778617416;
	bh=99bL7XlRbXgicpyoQ368EedVEUI6/Us2ig7Gwjaafdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4FcQCJiiTc09ZN0kW4hvxtklXS1v29k1aq/dm/ZozDRx1ABf/uAllGUL23zYeacV
	 ev5SeXGVo2YfgTCD0EHDwBigQVDHVSERhRP8Z/I1VLQ1BpopXx1XfY+f0zF1FFvLa6
	 XULbr2D2lktQMTVQdsqenWLtabGL18gYO7jnu9iuAqN/YIWgxVqU5VmTl77Y/GAljw
	 Pat5uVN0t3akmf3sTBncgwLcS8o93vuV5J1Dh8KVlS6GEwTMblbbN3ihJck3ChD4xd
	 oNIIGO4ngUnoRuC7sHLyp+SaHTOWa2qt/v29LoNoXVkIRsGAl/EvSacNNMEJzs5lz/
	 RxHQvjRhU/3pw==
Date: Tue, 12 May 2026 13:23:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel <fuse-devel@lists.linux.dev>, linux-fsdevel@vger.kernel.org,
	John Groves <John@groves.net>,
	Joanne Koong <joannelkoong@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Horst Birthelmer <horst@birthelmer.de>,
	Luis Henriques <luis@igalia.com>
Subject: Re: [post LSFMM summary] where is fuse going?
Message-ID: <20260512202336.GC9544@frogsfrogsfrogs>
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>

On Mon, May 11, 2026 at 05:12:42PM +0200, Miklos Szeredi wrote:
> Please let know what I missed.
> 
> CO-MAINTAINER:  Position still open, though we formalized some
> subsystem maintainership roles, sent MAINTAINERS patch.
> 
> FAMFS: Let's try to find some common ground between the fuse-iomap api
> and the famfs api.  I.e. add striping as a generic mapping method,
> even though normal filesystems don't (currently) use it.  Using BPF is
> a bad idea.

Hrmm well that /will/ delay famfs even more.  I *do* have a patchset
that adds striping abilities, but it's tacked on the end of the existing
fuse-iomap patches.

> FUSE-IOMAP: Need to reduce the scope of the patchset further, as no
> one can sanely review it.  Idea: first just implement static maps
> (i.e. read-or-re-write-only).  This should be much simpler, yet could
> demonstrate a read-only mount of ext4, right?

I don't think doing static maps would help much with reviewability.

Most of the complexity with non-static maps (e.g. delayed allocation,
unwritten extent conversion, out of places writes) are already handled
in fs/iomap/ or by the fuse server itself.  The only part that needs
help from fuse is the FUSE_IOMAP_IOEND command so that iomap can tell
the fuse server whether or not the operation succeeded so the server can
decide what to do with the state that it speculatively created.

[If I misread the sentence and you're interested in starting with
readonly files first, then let me say that the bulk of the new code in
the direct/pagecache IO patches that isn't the IO path itself are the
file attribute updates that happen before or after a write.  So I
could yank the _read_iter code out of the direct/pagecache IO patches.
It's not an exciting patch since you end up with a pile of thin wrappers
around iomap_dio_rw, generic_file_read_iter, iomap_bio_readahead, and
iomap_bio_read_folio.

In other words, we'd go from two large patches to two large patches and
two small patches.]

What I could do is break up the branches into even smaller pieces, and
then we could try to merge the smaller pieces.  Keep in mind that all
the iomap functionality is gated off until the last patch of the iomap
cache patchset even if CONFIG_FUSE_IOMAP=y.  That enables us to merge
the iomap code without enlarging the userspace ABI until we're ready to
merge that final patch.

Then we can try to review 4-5 patches at a time, and merge as many
pieces that pass muster.  The other question is -- who is willing to
review with me (besides Codex)?

Until that time, to create a program that would be broken by an ABI
change, you'd have to build your own kernel with a patch applied and
enable an option in Kconfig, and convince people to run that kernel.  In
other words, you'd have to be a fuse developer. ;)

> COMPOUND REQS: let's add this to fusex.  uAPI is simple, kAPI needs refining.
> 
> FILE HANDLES: same: let's add to fusex.
> 
> URING BUFFER MANAGEMENT: there's a disagreement between Joanne and
> Bernd about this.  I think we first need a very high level description
> of each solution and why it's preferred over the other.

(I'm so unfamiliar with this topic I didn't even realize there were
competing solutions.  But I'd need some Dumm Manager Cave Drawings to
understand it.)

> LARGE FOLIOS: depends on !strictlimit.  I don't have a good enough
> understanding of writeback throttling to decide whether removing the
> strictlimit requirement for unprivileged fuse is okay or not.  Need
> more analysis.
> 
> FUSEX: there was approval for the idea of using this as a uAPI major
> version update.  In other words fusex will gain feature parity with
> legacy fuse, but with a more consistent interface.

Hrm.  At first I formed the impression that fusex was supposed to be a
(subset?) of regular fuse to explore making something a little more
targeted towards to local filesystems.  But the discussions since then
indeed make it sound like this is more about declaring that more
features will always be on, and some old APIs are now gone.

As for fuse-iomap I'm not sure how to proceed -- in the long run I think
it would be cleaner if each file IO path (virtiofs dax, passthrough,
writeback_cache, iomap, and whatever we call the original one) had its
own file_operations.  But that would require us to refactor the common
code chunks from each file operation function into a bunch of smaller
functions, which I think would sharply increase the review backlog.

--D

> MAILING LIST: we have a shiny new one, there was agreement that it's
> sufficient for normal fuse discussion and patch posting, and usually
> there's no need to cross post linux-fsdevel.
> 
> Amir asked about how long it took for overlayfs to go upstream.  Well,
> I looked up both fuse and overlayfs:
> 
> fuse first release: Nov 2001
> fuse merge: Sep 2005
> 
> ovl first patchset: Aug 2010
> ovl merge: Oct 2014
> 
> Both 4 years ±2 months.
> 
> So don't despair! There's light at the end of the tunnel (and
> hopefully not the oncoming train ;)
> 
> Thanks,
> Miklos
> 
