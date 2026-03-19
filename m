Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7811F3D56;
	Thu, 19 Mar 2026 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773894448; cv=none; b=RDmj/romtPplqXLaYDkkxEaG7QOvR0/GpWTGKqF4rULGFNBNNr2w9ofk8h0MunFGJGcCW4Wqm4Z/k676f2sAKWfs8i1h/2AxVotY8FhrkxojCn17h4N2KBBwwhS9V1XDKaoMIgGYX6ZQ0bUkpUb35BVNzdVDBprHUCJPF2kCdAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773894448; c=relaxed/simple;
	bh=V1zSyOJ0rk6azl8RJmNHPKcu723NrfPtHK+wsdNmHiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O63GbWfjq0WXEQs7/YgOcLhrdDYxPO1GBJaGBBphrHi+hMgPnLF9LvLq5+puhWQmjlcfVwNADhvUjpEc0H4JrcQA1Onw1OwNg0JOd0W1A7+LCWSaPfXMYjv20aix21AOVTHJYTc12UbbiVY9oDEGtNwHKTh1EA2y/sBEJ4H7+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2W6clGm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2W6clGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14789C19425;
	Thu, 19 Mar 2026 04:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773894448;
	bh=V1zSyOJ0rk6azl8RJmNHPKcu723NrfPtHK+wsdNmHiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2W6clGmaZvSG8p9yl4g1CVSl5MhbExu1ZYzIWU+/2BFSUWTV3iKcRlDdnMACjn+y
	 eyHlDDMZ0JsiORxSvXP+lQLAkKyqdDoAwuNSSv3e1Z+tnr3Z8RNMpal4eK9u5vuV7+
	 cMyx3SqkVleJVzgHWsoKKj7wK0jtx0XJMD8GJUf71Z0X83/oF4JjFjcj7SyZFez/c4
	 18E3hISymodxSdFLrMgA75VVWkHuaAP8f0odPJstEoTxg7n0xmGpuqYXHbvg6lyz7E
	 BD2xJ5O8zNhPxOM5E/MkBuIHReuWASK4DVrW5g1GFPAavHBie308pnWbbpIKXYnc5E
	 UnQhkp/QC+dig==
Date: Wed, 18 Mar 2026 21:27:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	Horst Birthelmer <horst@birthelmer.com>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH] fuse: when copying a folio delay the mark dirty until
 the end
Message-ID: <20260319042727.GA3496922@frogsfrogsfrogs>
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com>
 <abhg4tbxDhYO_iHV@fedora.fritz.box>
 <CAJnrk1bBu5VJYnoZcV3uaS7+uyxK6TK9SLDtF2WpcRNfhUvO6w@mail.gmail.com>
 <abqvmS4adTXVxFIW@fedora.fritz.box>
 <CAJnrk1bF0JFAWOF=4hjMhiciSLrvob268fcQgv3P28Po8J=qwQ@mail.gmail.com>
 <60103445-0d45-427c-aa00-2fa79207b129@bsbernd.com>
 <CAJnrk1aWgWxzh0ETFkZXvJcfHFAC8KESEBLXa2S=ZqDfSSssvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aWgWxzh0ETFkZXvJcfHFAC8KESEBLXa2S=ZqDfSSssvA@mail.gmail.com>

On Wed, Mar 18, 2026 at 06:32:25PM -0700, Joanne Koong wrote:
> On Wed, Mar 18, 2026 at 2:52 PM Bernd Schubert <bernd@bsbernd.com> wrote:
> >
> > Hi Joanne,
> >
> > On 3/18/26 22:19, Joanne Koong wrote:
> > > On Wed, Mar 18, 2026 at 7:03 AM Horst Birthelmer <horst@birthelmer.de> wrote:
> > >>
> > >> Hi Joanne,
> > >>
> > >> I wonder, would something like this help for large folios?
> > >
> > > Hi Horst,
> > >
> > > I don't think it's likely that the pages backing the userspace buffer
> > > are large folios, so I think this may actually add extra overhead with
> > > the extra folio_test_dirty() check.
> > >
> > > From what I've seen, the main cost that dwarfs everything else for
> > > writes/reads is the actual IO, the context switches, and the memcpys.
> > > I think compared to these things, the set_page_dirty_lock() cost is
> > > negligible and pretty much undetectable.
> >
> >
> > a little bit background here. We see in cpu flame graphs that the spin
> > lock taken in unlock_request() and unlock_request() takes about the same
> > amount of CPU time as the memcpy. Interestingly, only on Intel, but not
> > AMD CPUs. Note that we are running with out custom page pinning, which
> > just takes the pages from an array, so iov_iter_get_pages2() is not used.
> >
> > The reason for that unlock/lock is documented at the end of
> > Documentation/filesystems/fuse/fuse.rst as Kamikaze file system. Well we
> > don't have that, so for now these checks are modified in our branches to
> > avoid the lock. Although that is not upstreamable. Right solution is
> > here to extract an array of pages and do that unlock/lock per pagevec.
> >
> > Next in the flame graph is setting that set_page_dirty_lock which also
> > takes as much CPU time as the memcpy. Again, Intel CPUs only.
> > In the combination with the above pagevec method, I think right solution
> > is to iterate over the pages, stores the last folio and then set to
> > dirty once per folio.
> 
> Thanks for the background context. The intel vs amd difference is
> interesting. The approaches you mention sound reasonable. Are you able
> to share the flame graph or is this easily repro-able using fio on the
> passthrough_hp server?
> 
> 
> > Also, I disagree about that the userspace buffers are not likely large
> > folios, see commit
> > 59ba47b6be9cd0146ef9a55c6e32e337e11e7625 "fuse: Check for large folio)
> > with SPLICE_F_MOVE". Especially Horst persistently runs into it when
> > doing xfstests with recent kernels. I think the issue came up first time
> 
> I think that's because xfstests uses /tmp for scratch space, so the
> 
>     "This is easily reproducible (on 6.19) with
>     CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ALWAYS=y
>     CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ALWAYS=y"
> 
> triggers it but on production workloads I don't think it's likely that
> those source pages are backed by shmem/tmpfs or exist in the page
> cache already as a large folio as the server has no control over that.

/me stumbles in-thread to note that xfs gets large folios for its files'
pagecache fairly frequently now, especially as readahead ramps up.

Ok back to the hell that is deploying ClownStrike through a Java program
while Firefox repeatedly drives my laptop to OOM.

--D

> I also don't think most applications use splice, though maybe I'm
> wrong here.
> 
> For non-splice, even if the user sets
> "/sys/kernel/mm/transparent_hugepage/enabled" to 'always' or in
> libfuse we do madvise on the buffer allocation for huge pages, that
> has a 2 MB granularity requirement which depends on the user system
> also having explicitly upped the max pages limit through the sysctl
> since the kernel fuse max pages limit is 256 (1 MB) by default. I
> don't think that is common on most servers.
> 
> Thanks,
> Joanne
> 
> > with 3.18ish.
> >
> > One can further enforce that by setting
> > "/sys/kernel/mm/transparent_hugepage/enabled" to 'always', what I did
> > when I tested the above commit. And actually that points out that
> > libfuse allocations should do the madvise. I'm going to do that during
> > the next days, maybe tomorrow.
> >
> >
> > Thanks,
> > Bernd
> 
