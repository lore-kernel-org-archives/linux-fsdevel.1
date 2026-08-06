Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E601367B8B
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050263; cv=pass; b=GaJ6e1c99H2NbYIAyqCuXqdIAM5vfM8EjIiMuvE6LaGNg3+Y5WODLelN0AlNa4xM2hdGFTZTRk4aOKgM2MIgWgIg/SnKCEo5PZqtHubPvKGJ7zLCndITRF1fEBxPIM9v2JWEHOhbav3Dq+pwqYyzjjubuFM8X0dbqYxCoNRmm0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050263; c=relaxed/simple;
	bh=8ilisN6b9rsvSV7tujnE8pXGbGA5qhlw1JHj7X5z5Dg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PILETp9cPP5trnSNWg8/cuIXRXevfOGP6Iz5PD/uZNpm86LQVFiG4riDhcOBMpzxakPWfKmjdBtUTiSL4kZIpRBQ1aAtk6eEJNgjnpZy8Gq/NYBu5IIocYzzIM8Ow08M7GppiAmVPrGn2Eyg6kWRJe+/Z4aLIIy351YWrCKQBNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTzUo8P9; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTzUo8P9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4955de8797cso17475035e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 14:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050260; cv=none;
        d=google.com; s=arc-20260327;
        b=jDTdVvpIcALbX4H9kDlfMymp0XW054euIZc//vbaBPHDJfm06TVKH9XkQWzKtlULFO
         njMcTzON+mFTCRaL5mKqP2SeMbG4dC3MNf9gTHs8hsWl4LvJF5SabHCvHsoQEozRJYvv
         cJXjH6g6vDtjFSxf+fcuFBROo9bTgSBk6vVo9IWe0VG8ZJ3AcMRX9pEJ5jK6CIvjHlPF
         9XfHbb87zxHfRRGHHDuONDAo0aqQiK27kIRNu+o1DC37wr6eRZ2z9Z/mI2EutTXG5K1C
         GUWjao7dMEDhvuk2Vi0CMcSdNzalsOpdRvzDk8uBhlB1z+TJi0Ics1LhwjroSF/zWBgm
         Zg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=8ilisN6b9rsvSV7tujnE8pXGbGA5qhlw1JHj7X5z5Dg=;
        fh=roWbUqFaiAh2OHQVSjF9aJkP2jJNvbAqLLabYf9V/vc=;
        b=GeqGXXut5787G7QWV9cuOojdSEW35Vp6FGfIEptOB0rVRC2yjbKzgekvXdmQ4PnD/m
         v00QN+onItgz03l4y+P6E7gWXq/rGC1LZtdWGyY7ZSw3fcjNtV4yERlsDVXr6hHCMd7J
         b/uO/cr2ngMc4Epb+V1NiCe9p+QXCB9lDoRqTjZ6wi+suQIvYOHbC2oMio8uIScdStuz
         5qRMU68AIY0wSN7xn1famb3GaiEovLsYKLJCvwB8GcF6al/DAFGdYjk2uyApbi0I/9zg
         ZgceZBeXQGQYFDXZGxzsTB1jGlt4YskoOe66a8YykzJYs0lfKaIsfIjvrGYPndb0T2IT
         w1eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786050260; x=1786655060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ilisN6b9rsvSV7tujnE8pXGbGA5qhlw1JHj7X5z5Dg=;
        b=YTzUo8P97m6EYpn+7T2YYPfL6Hc0rTtj52wTNGF10uPS0JqBuVg+XYnYbN/rB37lUX
         ixswBmlZIKWPXMcbA7lypkeqEZf/SP5t1mC/fVAzcXayOEOIhjpBxXH3uBiJG3x18fEC
         i20vWfXV1vy9BTAjWengd8WDxL3zVN/jUTwHoWj2oZm2e7lc1PQcoE9VDIX/YOEoEhYI
         glYK3+cZA26NCuGwxINh797hnWCuOsCtgl8ybc1lvM0KnMK1T1L2PIIOTwMgsVREg40K
         GCUz/gMLkuv0J7QIM4WJcE8sGv5chOBhJPNdDUpNY9nm1dYzDFbU6jFmwAF63jeyGUZE
         6lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050260; x=1786655060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8ilisN6b9rsvSV7tujnE8pXGbGA5qhlw1JHj7X5z5Dg=;
        b=JcLkVxmqhFyN9NY9Ma6QFrWHlYoJ8yD8VVpf4+ITwjITYhVAX35cl/+hnwD8wlTVGH
         O9LIIm7mZNaqFukDbdfjQTcNFKVH5u2L3588UakAtfYxp4tnjl+kA1oCHcYZOOIKTrbk
         LceGLL6vagJkW/63o2bfX0lVjgltFPJDeYlU8w7sigCxfLwTqjOXrTfxDllcqGOJeiSD
         gVZK5g1VJJDTvaishmxEZm65qRwJpyASqvyPizewzcRXiM00dTKsBb3yaPfNKz1If7zm
         FOz5hI2xf3PvL+2WRPOP4bPGtuxrt5jeRZAXWefT3B5f6cX5mqPRe3yeX/ql6/tZZ1ur
         d0Qg==
X-Forwarded-Encrypted: i=1; AHgh+RpJKS+SSBif7eNoIWOoDZDjJqNWbvtZwd9vVfwvf3m6A1lQGBgE8u4X6AHhVSBQS6lEotWmQXkUe4OsBvrG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dDEIr3Jb1XZqEFAgICHxK8BnAos2MPsdWLBUX450vH1RwXvK
	5GJuXLsCoiT68xVLu5tbeLvuKGmGWWZ23tFBsUuwF6FasVegA6g6MC55X/asa57EHAlAXicTLNA
	21G9P+YCSCxzagewLR7B1VuD4/TtWZBs=
X-Gm-Gg: AR+sD11Y30nQIWHMyZv2zE6SxPzGZ3NWI08kYQTIxGAqyteYjagxppt0yBbf9HzlPpn
	6uKh8+CGudzfq7ExlT309lXzgZWjKwg2qIX91DyqHN2aBwILpFCvxkiz1w0O6QI/HLWBszNLdfI
	Vo//a/Ji/mfKLQyldemQnHHnzUPRO50SvY6btDDXvC0AJJAj/vyc8A5p9+kQ1qGf099++J6qlki
	LeLf1Qp6GKdvEL0pJXSZYbd3Hak3pN3KAPohdh0UMkbGUKx/iM3GwuyEDMCHwAW12UaEpj+fJ4q
	afUIuLdB5Z/Fry4H/vO33hOZtQHSuxp0XE2zKBls/iItb2xIkqqclWnYoePBLv6MKDOEqqqJbZI
	qRNm8hNoljK/+3g2KFOH9i3v31Nksk/WxW0vJWbUCNxxF4/4=
X-Received: by 2002:a05:600c:8b55:b0:495:3de8:33a6 with SMTP id
 5b1f17b1804b1-4994e7cdd39mr269199205e9.16.1786050259636; Thu, 06 Aug 2026
 14:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 6 Aug 2026 14:04:06 -0700
X-Gm-Features: AUfX_mxaCgp8oYES6RNp3g9or9e5V5Tk3wVFme00shwxNtlto6HFGbmfyuWHQps
Message-ID: <CAJnrk1bk66ZhRAS7mojSnD5RBfFS+0ChAPymE3ObRWr0C_udWg@mail.gmail.com>
Subject: memcg stats flushing (WAS "Re: [PATCH] fuse: disable default bdi strictlimiting")
To: Yosry Ahmed <yosry@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yunzhao Li <yunzhao@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Wed, Jul 22, 2026 at 1:38=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> > > > First let's see if the general solution is doable and simple otherw=
ise we can
> > > > explore use-case specific solutions. In extreme case revert is an o=
ptions as
> > > > well but I would prefer a more sophisticated ratelimiting (that Jan=
 suggested)
> > > > than a revert.
> > > >
> > >
> > > Sounds good. I'll keep an eye out for the work Yosry's doing on this
> > > and look into hooking it up to writeback if/when his general solution
> > > becomes available.
> >
> > I am not sure if I had in mind would generalize well. For zswap, I was
> > just going to replace rstat with per-memcg atomic counters, and simply
> > walk the cgroup parents in the update path, as the zswap load/store pat=
h
> > shouldn't be too hot.
> >
> > However, looking at other in-kernel flushers (including
> > mem_cgroup_wb_stats()), I see they consume other stats like
> > NR_INACTIVE_FILE/NR_ACTIVE_FILE, which are updated in the page
> > allocation path. I am not sure if a cgroup parent walk with atomic
> > updates would fly there.
> >
> > A more problematic one is count_shadow_nodes(), which consumes slab
> > object stats. I think we definitely cannot do atomic updates in the sla=
b
> > allocation path. Although it seems like count_shadow_nodes() is a rough
> > estimate and perhaps we can forgoe using the stats there.
> >
> > If we want a generic solution for in-kernel flushers to improve stats
> > accuracy without killing performance, I think we need a heavier lift to
> > rework rstat or move away from it completely.
>
> (Adding a few more people and mailing lists)
>
> So I experimented with a per-memcg atomics in zswap (see [1] for
> context), and it appears to be too expensive even for updating the
> zswap stats during reclaim / swap faults. So I think zswap will need a
> similar approach to writeback and other in-kernel users.

Thanks for running the experiment.

In a previous thread [1], you mentioned your team was investigating
some premature OOM kills that might be attributed to this same stale
stats issue in the vmscan path. Did that turn out to be the case?
Asking because if so, that might be something we'd hit at Meta too.

>
> One idea is to keep per-CPU per-cgroup counters, but on the update
> side we update all the parents' counters, instead of just updating the
> current cgroup's counters. Flushing the stats then only needs to
> iterate the per-CPU counters and doesn't need to walk the cgroup tree
> at all. There is added work on the update side, but hopefully it's
> cheap enough to update per-CPU counters, and cgroup hierarchies aren't
> usually too deep.

I'm not sure about the zswap case, but for the writeback case there
are significantly more updates than reads. There are four stat updates
for every folio that gets dirtied / written back, so four per page
with 4k folios, while the read happens around every few hundred pages
dirtied. In the scenario I was testing with memory.max set to 8 GB and
using the default 20% dirty ratio, during freerun the stat gets read
once every 256 to 512 pages (with flushes happening less frequently
than reads).

I'm not too familiar with memcg or vmstat so apologies if this is a
naive question, but does it make sense for memcg to just do a similar
approach to what vmstat does? As I understand it, mod_lruvec_state()
updates the node counter and the memcg counter (if memcg applies),
where for updating the node counter, mod_node_state() does some
batching where it updates the global counter for that stat only once
it crosses some threshold (pcp->stat_threshold). Could memcg keep its
per-CPU counter as the accumulator but once it reaches some threshold,
it then propagates it up the parent/ancestors into a per-memcg atomic
global counter? The atomic would then only have to be touched once per
batch than on every update, which might eliminate the overhead of the
per-memcg atomic you saw previously? It seems like this would get rid
of needing to do any flushing altogether, as we could just read that
global counter directly.

>
> A more radical approach is to completely drop the per-CPU rstat trees.
> So instead of walking the parents to add them to the per-CPU tree, we
> just walk the parents and directly update the stat. The flush side
> will then always iterate the per-CPU counters to accumulate them. With
> this approach, the update cost roughly remains the same, but the flush
> cost changes. Instead of walking the trees and flushing all cgroups,
> but only doing it on CPUs/cgroups that actually have updates, we
> always iterate and sum the per-CPU counters. The average flush cost
> may become more expensive, but it should be more consistent and won't
> scale with the cgroup tree size. I am not sure if this would be a net
> win or not.

I wonder if this scales for machines that have a significant number of
cores? Onsomething like the 96-core / 192-thread machine Yunzhao
mentioned in the zswap case, it seems like the flush now would have to
touch multiple additional cachelines per CPU when it seems like for
the majority of the stats, only a small fraction of those hardware
threads would have any updates on them?

>
> We can also choose to do the above for all the stats or only the ones
> used by in-kernel flushers, the latter would probably perform better
> but at the cost of more complexity.

I agree. For the writeback case, afaict I think we really only need to
do this for NR_FILE_DIRTY and NR_WRITEBACK, neither of which are
updated from the page allocation path.

>
> I honestly don't have any time to pursue any of these approaches, so
> this is mostly just a brain dump. But I do think we should try to more
> systematically solve the stats flushing problem as it has given us a
> lot of pain over the years.
>

Thanks for writing up your thoughts on this - I found it helpful!

Thanks,
Joanne

[1] https://lore.kernel.org/linux-mm/CAO9r8zOiwgG80EjqdZFgWQvODUe1RzecLemxc=
B7xXNm_f3XfbA@mail.gmail.com/
