Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F942C510
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380590; cv=pass; b=SKSHoF/fijjnnDwV4rlHgNKX26uPONCcc4Rm3C1LajpftROeJHK+Chg2yPK8SXh94ku5lWAHnO+3edhyIVgXIEsB9zY2J/6jR2NUGi5yzm3RjYDZ5FHO5WAf3+u8YklvofZLDVgFaLf9kMuWm9n23fixRgBnMEMJoOhx7UnMw4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380590; c=relaxed/simple;
	bh=opQteIDfNDFGbe327v0N4D1kt+GGRQG5/oQ05zdVIEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9s+uen8D1JFfVlyHACKRYGynu/nf49LaPBxqdDS9SSrJAaS0KNIMfsC+WrclVUHh9mdpg5A05qajqGwT3wFA7DqhlqoWvGEi4yoipijdpmHs7sPNh92/i/kwbrbNpyAzRdGs0FAemQ6pVNtmgPUKKOziL3jHbq+O/o6Fl0veHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qX+F7K/u; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qX+F7K/u"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso15633045e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 09:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786380585; cv=none;
        d=google.com; s=arc-20260327;
        b=s59l1jM+NnXMABWN8ugCk+EVGgUUb+R3dusVX2hRYyDMuRHsua1klRXPAnZa34FPnW
         +qDLIDlp9m+Arx8cAPSWkbScfeHViILL+XxNokzf2nXR7siSkN9DDiyo+MQDXavBT6k2
         3lJl+I3VJuboqj2Z9PY3UAm4BpkZhMVccDwdRQAvB/LwTHutX4kDCB3ls7ztyC/2siHh
         j2wMclAxkhg03awvIbrNhBzOeQKQIfJ5wvbEDMbFt7V9uSOTkQvV+PJAbVVUpvFerYKG
         wg7nF7M9KDfXHTHGaOaOXciqA8okN0zGs/ZlliJNomKGmf2bxj7rg0mgdcoWSBO2cFJ+
         ITJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=opQteIDfNDFGbe327v0N4D1kt+GGRQG5/oQ05zdVIEY=;
        fh=WRqqNMKxG/RkWCZ0D9K1OystdVewZAWs93GmdGM54bU=;
        b=iZW8/GDRChhoxXkwUdxlrJhXEhJQ3La8Lhuusu+eUKSdS6HJSGiD8qXuABPAfPsNdi
         E3yiCpcmBQyEArSSgQd0zl5OegQApYx6PC+CTV5wk13GzYh6NZH2KDTVZWuz5eTZT4AN
         Dq57FC7MHyYSGOkOfi0BemXPFcK02dlp24Ht7cfpV1kqcFdI6Uj5VZfwwa+uiplMRMY2
         jmqu2TZMXAZX1xbzrIWsbJe04P77Niwcv3KaDlzjJH+v/nfA0cDVYg9cdi2wUZw+veQV
         EmcBQisbwxTxNW0ruMy639Y0V/JKf/QtEWD9x0XqjEqpKfNVvdtJ3MQ6ibkufj4yluTI
         3GgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380585; x=1786985385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=opQteIDfNDFGbe327v0N4D1kt+GGRQG5/oQ05zdVIEY=;
        b=qX+F7K/uuADeCnqptZBKtnV2YEnjldheIRRQE7brhZcUfFXoaaV223hruDjpgeB0A4
         BjfZ0ZUNTdM/WLLE/7q4MM+Pa5m1aP9YLwaJzFBcf95uHqex0Hu75yGWHcq153fsuv2M
         uQXQ+5C8IaVPP9tiOFndo4+rgYmwDS9IdBcOZN3Eib39Df7QjiWiqLoyndGhU4rLMeI8
         HubE9uwvSw6BEnb2e/gHjCYBGmXAtDTYlkiuFqtqI3AFr4s4LCzb8lsPtNaC447BerGD
         fPU9SU+qap+JgSQaLaw+LyP1tK/LgYhGqX+gMKnCUA398DMksT79rCNueR71YBpKnqVN
         IzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380585; x=1786985385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opQteIDfNDFGbe327v0N4D1kt+GGRQG5/oQ05zdVIEY=;
        b=nUHmC2DDXdy23yWhiZnMid4YmFkS4emnG1Woy834dB0N6rfCunqNzHApiB5LOA1s2v
         pwdJMUtZIfZxsSC4xB27mzB1TwwI3hXHOwQR4aZj+5NPDoBUEdKKjOUnD1amXZ/x6w2X
         1L8kuyT/eNO2JLHH1fVS1P4qvRM5MI7H6vnEwpP5mAu5X3msh1A1AEMCcA7mqAcmjUD8
         usu2H8/PnAQYcBwUc0Zivzl9vX3fPJ+WlrsOTMw7LVlz/TGimn4Jo1g2AH+WUEJBWoFm
         IDCyg3elZ3d+6MpR/v0eurR8mrF08UGLM4RYfJwnsM/STWVaRAjhLDEkyfZhilej5C+n
         Ievg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3mcpF2BLKevIztmkeRrLl10wIsBV7Fa2lhVIVih/1uVxRj5gjE+bBQHY0YGdVr/zCTjpiKZqXAQjwgeM9@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqVQ32Ig3YTQqYEfJMspkTWIVqNSp8kUg/AXqH0SBFMilvFs6
	GCY1TK3M5uqeryJpyR/y0ME5DRIhzYtSQrzD5syfZoJVwBR1VkPsiz3MCtKQHIo3Qlg07b0WTC4
	DvgJCAATEVS35iy3vchDNqZA5Q0I3lkA=
X-Gm-Gg: AR+sD12hWGk5aIUpqgtjmIc4QPmmwj2xfv+68deR470kU8vt5S1cZCPkUJr0wfkH/1T
	GPr4Fp5l9w+IubFUiKYOIrxF07ppqTBD5C+KsPI997PxFfoUB6+dnndrLlBhDPN1WbduS+MDPep
	DFB6ndTWUJZT4f++HUh4H6k6AmrDkT1BTf3YO0qtPR7FJ4ziXANfD72pyIRjP/RaKJsru3qSulz
	z/lKP5tLS+Q0MFhEMcL8FLlXwiWpTy3/oQa8X/HCjpnyeR+qhETJkyuOGjXbrShbrb9tTJb12eq
	GP9QTZMSyYCqPIw2SyaA8d+VCIraK1/D4GI/iqyB08ildVv9aDBC3/NviCGNebJo8SPgwl1rWrx
	tIVthX6+HCWgx07/S+44DTBPD
X-Received: by 2002:a05:600c:8b4b:b0:495:5fdf:2075 with SMTP id
 5b1f17b1804b1-4995e0254cemr315174035e9.0.1786380585382; Mon, 10 Aug 2026
 09:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1bk66ZhRAS7mojSnD5RBfFS+0ChAPymE3ObRWr0C_udWg@mail.gmail.com>
 <CAO9r8zPpe6fWOSXtRUjFB8WNMroeBqvLT+2QtAU4E27AtLUXMQ@mail.gmail.com>
In-Reply-To: <CAO9r8zPpe6fWOSXtRUjFB8WNMroeBqvLT+2QtAU4E27AtLUXMQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 10 Aug 2026 09:49:31 -0700
X-Gm-Features: AUfX_mxLee7dpyylWKON8KDAzBJgmBm61mwBeQMBp_ggGZ_j5xRcyxsvPI5PLAk
Message-ID: <CAJnrk1YifN22mA5PFRVrh3m_ygxax6x4_8nraG2hPqCzyzBj7A@mail.gmail.com>
Subject: Re: memcg stats flushing (WAS "Re: [PATCH] fuse: disable default bdi strictlimiting")
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

On Thu, Aug 6, 2026 at 2:31=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrote=
:
>
> On Thu, Aug 6, 2026 at 2:04=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > I'm not too familiar with memcg or vmstat so apologies if this is a
> > naive question, but does it make sense for memcg to just do a similar
> > approach to what vmstat does? As I understand it, mod_lruvec_state()
> > updates the node counter and the memcg counter (if memcg applies),
> > where for updating the node counter, mod_node_state() does some
> > batching where it updates the global counter for that stat only once
> > it crosses some threshold (pcp->stat_threshold). Could memcg keep its
> > per-CPU counter as the accumulator but once it reaches some threshold,
> > it then propagates it up the parent/ancestors into a per-memcg atomic
> > global counter? The atomic would then only have to be touched once per
> > batch than on every update, which might eliminate the overhead of the
> > per-memcg atomic you saw previously? It seems like this would get rid
> > of needing to do any flushing altogether, as we could just read that
> > global counter directly.
>
> The memcg stats perform similar per-CPU counting and thresholding. The
> main difference from vmstat AFAICT is the cgroup hierarchy. In vmstat
> we have per-CPU counters and a global atomic counter for each stat.
> For memcg, we have the same for each cgroup, then we also have a
> cgroup tree. When we read the stats of a cgroup, we usually want the
> hierarchical stats including all of its children, so we can't just
> read the global counter.
>
> We use rstat, a cgroup framework that keeps track of which cgroups
> have updates on which CPUs, and then memcg has thresholding logic on
> top to only flush if the number of pending updates exceeds a
> threshold. Essentially, if the magnitude updates on a CPU exceeds
> MEMCG_CHARGE_BATCH, we add it to a global per-memcg counter. We only
> flush if that global per-memcg counter has > NR_CPUS *
> MEMCG_CHARGE_BATCH updates. So in theory I think we tolerate up to 2 *
> NR_CPUS * MEMCG_CHARGE_BATCH of stale stats (combined for all the
> stats).
>
> See memcg_rstat_updated() and memcg_vmstats_needs_flush() for this logic.
>
> Looking at this code again, it made me realize that we already iterate
> the per-CPU stats_updates on every update to increment the number of
> pending stats on this CPU. I wonder if we can replace this with
> actually updating the stat on each parent, then the flush path only
> needs to accumulate CPU counters. Or maybe as you mention, we update
> the global per-memcg counter when updates on a CPU exceed a threshold,
> and forgo the rstat flushing logic completely.
>

I can run some experiments and see if updating the global per-memcg
counter per batch and forgoing flushing could be a viable solution. I
can use my setup to test it for writeback, but for the zswap use case,
what's the best way to test if the changes are too expensive? Is there
a benchmark program you're running?

For updating the stat on each parent and having the flush path only
accumulate CPU counters, I think this means we would have to
unconditionally walk the ancestors + update its counters on every
update, as we wouldn't be able to early break if the flushable
threshold was already exceeded. I don't think we could replace the
stats_update update, as it seems like readers still need some way of
knowing when to flush. It seems like this could be a nontrivial
performance hit, but maybe it's a non-factor in reality. If you think
this would be useful to get benchmark numbers on, I can run some
experiments on this too.

Thanks,
Joanne
