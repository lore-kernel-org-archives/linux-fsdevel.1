Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5D40926C
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341266; cv=none; b=Y8rOFsaCEP5/dP5pVpB1EkWHVFl+h8u5sCLSgiS+Hv4xx0VBYAwFW7TOkxHPNLlBgwaXTyRZOXo4gZaeEWDGaSu4QlH00pLhbr3a6b2njweJCqSv33K+Jys+sugPWvHTJJTbacySYTkIQgwKjRGMSKYsLYw2JyFMJ3wWSAUXHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341266; c=relaxed/simple;
	bh=jGCF9xeY0vRfVoQHyo46BCngCpvZ3rfwl1YTTqJhOOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgRzCdZt2GtuTUm5ZODIh4XDuVWFJfvbNtIUi/WGOYy3rCHzsM/0bOxSSxIIcEFQacmhgRz7E9a5slWbMgHkp/Tg8PtEdChVZoi/Scn8V9NRjOvzCImBlvOKr3OjMi4BuMpbjNuOLCNs/Qmly4+bigsxHh2RkoQVKg74Pi0MVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6jq5mdc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6jq5mdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE041F00ACF
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341265;
	bh=GjORBWzC9ssea7fPJaPwA5sQ9HLxrAb0fTNBxcm4LAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B6jq5mdcIt8Ug4wUJcPyB1pWAg7RU4A7HfUvXcNGtaXMK2lopS9wxalB0JhKURI7P
	 7xWOmfd0H3uncLzbaf4nqOhiK6trEMHKQvKTrHoczsbDpL0zS56WGlCOR70Lepief0
	 dWu/dViVaseHiFI0Xe4k7Eoj8gsfyQ2aU7Ci4FtadrA8pxYqI4WQdFUNfN7YM8wpDI
	 FXN7+tk5ZR07jbl1FjhGQ1/6pJfTNEmaS02EQ11gGho8dgMdU337YaHEF2rmKiKENC
	 nm1r4yOdIgUHjr1/W83aYEKnvgXtXfFW1KGEYs1qxaPo0jldvWa3hFG6erqJjK/iAd
	 plzDAFsFcn82w==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69fc9f25118so1649438a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 12:41:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqzFtSc5ksTim5s+VaogBzse/bJO0TZRtuor27JiiuT6l2sWp9B/sOSzu2kOEsGn3RRAwVtD5myf3R0rlQA@vger.kernel.org
X-Gm-Message-State: AFuF++kpfmKZ4fJNJc2/6HD47vlerlJfiOyD7Yo5ngJ99WBmPZyUBn6r
	gtQ2KizosWxQZAeuqL8oPg8bnuYF1BPA6RbT4VIMM/4OAZUGMjmGKVo4aNVr4t/foi5KbbQ2KN5
	A1kgPIMgJNq1QlU2PAchaWegFZPENGK4=
X-Received: by 2002:a17:907:a646:b0:c21:9b4b:2690 with SMTP id
 a640c23a62f3a-c246a61e354mr898338266b.17.1787341264223; Fri, 21 Aug 2026
 12:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1bk66ZhRAS7mojSnD5RBfFS+0ChAPymE3ObRWr0C_udWg@mail.gmail.com>
 <CAO9r8zPpe6fWOSXtRUjFB8WNMroeBqvLT+2QtAU4E27AtLUXMQ@mail.gmail.com>
 <CAJnrk1YifN22mA5PFRVrh3m_ygxax6x4_8nraG2hPqCzyzBj7A@mail.gmail.com>
 <anpsLy_pCanocgS1@google.com> <CAJnrk1Yoj7fqbzurmHkbA-vegpQu3cf-_dfvKor_VxuNhPR-AA@mail.gmail.com>
 <CAO9r8zPLipVW6bvyDK1ypSawbo=LHKvmLqWH0xA6WMR9GYNJpg@mail.gmail.com> <CAJnrk1ai-TqcudPoK-qFRYAJnUjBmg1kVa6Vxg3eDm5w5ivqSA@mail.gmail.com>
In-Reply-To: <CAJnrk1ai-TqcudPoK-qFRYAJnUjBmg1kVa6Vxg3eDm5w5ivqSA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 21 Aug 2026 12:40:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNJ=Fpc0pZExrttVTDCM3yzSmLPCAU=+RS0k5Pm+hY96w@mail.gmail.com>
X-Gm-Features: AcwNN1VOJPzj9vCoFWMkzt8LUQYtVPo1dkJ_NmbLb1w7IqyknFh6FDk9dgL6_34
Message-ID: <CAO9r8zNJ=Fpc0pZExrttVTDCM3yzSmLPCAU=+RS0k5Pm+hY96w@mail.gmail.com>
Subject: Re: memcg stats flushing (WAS "Re: [PATCH] fuse: disable default bdi strictlimiting")
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yunzhao Li <yunzhao@cloudflare.com>, Song Hu <husong@kylinos.cn>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 4:39=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Tue, Aug 18, 2026 at 11:40=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > On Wed, Aug 12, 2026 at 1:59=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > d) vmscan (prepare_scan_control()): for determining whether reclaim
> > > can deactivate, there's this logic
> > >
> > >                 /*
> > >                  * When refaults are being observed, it means a new
> > >                  * workingset is being established. Deactivate to get
> > >                  * rid of any stale active pages quickly.
> > >                  */
> > >                 refaults =3D lruvec_page_state(target_lruvec,
> > >                                 WORKINGSET_ACTIVATE_ANON);
> > >                 if (refaults !=3D target_lruvec->refaults[WORKINGSET_=
ANON] ||
> > >                         inactive_is_low(target_lruvec, LRU_INACTIVE_A=
NON))
> > >                         sc->may_deactivate |=3D DEACTIVATE_ANON;
> > >                 else
> > >                         sc->may_deactivate &=3D ~DEACTIVATE_ANON;
> > >
> > > (and same for DEACTIVATE_FILE for file-backed folios)
> > >
> > > target_lruvec->refaults[] gets set at the end of the reclaim pass. It
> > > stores the same lruvec_page_state() value that prepare_scan_control()
> > > will read at the start of the next reclaim pass, which means if
> > > reclaim passes happen more frequently than the 2s flushes (eg under
> > > sustained/heavy memory pressure), this logic will incorrectly assume
> > > no refaults occurred and deactivation is disabled, which afaict means
> > > folios won't be moved from the active -> inactive list, and reclaim
> > > will start evicting pages from the inactive list that are hot (eg mor=
e
> > > refaults).
> > >
> > > This is from reading the code rather than a reproducer though, so I
> > > don't know how much this matters in practice. Unlike for the writebac=
k
> > > case, I don't think flushign more frequently solves the problem. It
> > > would shrink the staleness window but not eliminate it. Maybe one
> > > solution is to keep the deactivation state for a period of time if
> > > refaults were observed.
> >
> > We do have an internal test that runs a VM under memory pressure and
> > we started observing OOM kills after the ratelimited flush was added
> > in vmscan, so I think it's more problematic than just reclaiming hot
> > memory, but I didn't look too closely.
> >
>
> Would you be able to share the test you're using? I've been trying to
> repro it locally without much luck.

The exact test uses some internal testing libraries, we're looking
into whether we can translate it to a standalone C repro.

From a high-level, the test:
- Creates a VM with 260 MB (256 MB for testing + 4 MB margin) in a
cgroup, backed by shmem THPs. The VM is not a fully fledged VM, just a
KVM VM running bare metal code (so 4 MB is enough margin).
- Enables zswap in the cgroup.
- Tells the VM to write to 256 MB of its memory.
- Checks the cgroup shmem usage and that no swap occurred (no limit).
- Sets the cgroup limit to half the VM memory.
- Checks the cgroup shmem usage and swap again, usage should be ~half
and so is swap.
- Tells the VM to read the 256 MB of memory again. This should cause a
lot of thrashing and reclaim, but no OOM kills as all guest memory is
reclaimable.

With the ratelimited flushing, the test started flaking 5-10% of the
time due to OOM kills.
