Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842C318EC1
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269173; cv=pass; b=LNGTtCpIWyc2gU9AoY+vsyxlb3Z0/A40lYuO6hyjyjUSsCHVRvDdLYjpbFnQPlQor/jVujuw3KwtHWcPo/A+yWCEJdKAUZlehSdDF+FsLEOlbFACxi2ebRx5Mf7aNE3DfUqy9w3veqQJ5vluDiiZ8dOCxJ2bhWub7jdshREIatY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269173; c=relaxed/simple;
	bh=uakSqtDmfHirt56Ih9c2dlFS7k35p9i6DyOchGy5ecg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a76HnTPQfL2kVugmHiaWncQlKeu5dvjCBPGns3yI+yxTApiBUgSCj9+QsmkdTUqDkU1H3Xnc3FFoO+xlpLGS+xm54Hk2At18Po/EYHdZvkbOePdX+v4qg+XsRjTWzNTR1YN/dVc48UX6YfbAe8KzeolTt/FebKqRsKqZ3CXkdOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+eJHeHQ; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+eJHeHQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso2359635e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 16:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787269170; cv=none;
        d=google.com; s=arc-20260327;
        b=k+ua1zxWyRpA4gkwiRDnzSegXlHmCR9j+LDOh5QI8JYLKXznM0Y9lkD6wFaAa2ALys
         4WECRwSAdQYP05Qj1cnhIqCmrPWgJWD46K0wyXLohwMr6J7lnZc2NeFiYXAxiZYEErZA
         mGbLi2mM2QKoxuRrOsyMm78Ik6rCF+uxmNsOpnylWl7ShkShCQlQdbupGTJABVfrxhPe
         6+kJQBEyYYlBCjwywMMkv2juI8776Npv4Z4n95CzLHyDas7ATlB5etEsk1eU1Zy0loyo
         P9nWqNW+hOqk+vVyU5R78P0cyuDmwxifvT9WQKCHueHUatw9/UTHwiyGktf7BeBDV4Xq
         Frpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6FWGDnWimdEuyVbIhKTlp9NOezQCpG6klu9pcGU95pc=;
        fh=UfwM0kekQOsQ0u/v7ymKgpyj25p9TsADgftdOFoOQWo=;
        b=sdaaeH3rb5uCdms1O/4o3eqYnVCB4UCj9u3pt+DMUnnTPrzAYzUuZ1d5b1RudphNIv
         3Fx8bUfHOE8KAouzMHZHhxfzHAzo5UAH1FUpnl/l7H9xFZQoFO3UuPztW1qIDazLZHoV
         BiuYVstOBPW7ypEQDc2Qg+DT64ki+ZIfkh1wKLSjbtLyqW3Db/V+pJbLMZ4lm18pHR0z
         mblF8++7V5ifHMcI4SArkiv3CtSKGVGbfG3HLpZjKV9Xsg1Ws//u8iFVUR7ucNxy02Tu
         uQ4wjAkBuvBc9jT9Z9mWCZwmb6NmQYaCip3VzWbepKOITY8FMMko4azMrpLhHq29DDD8
         kZ8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787269170; x=1787873970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6FWGDnWimdEuyVbIhKTlp9NOezQCpG6klu9pcGU95pc=;
        b=K+eJHeHQU99iLKRGTN0zGvU89hQbR5fMukf7LfPYLI6MgeGXRqkgKovCXx83n1H4qp
         l9ZUshx9CZ0tniQKrYTGdaOfHuXdaqmcm8ryDpfEZl48P7qTMcE7mVGvMRVJNfwSz7gI
         TWjTzCQI5fZ1r9TULeSSP6gHG8JAz15iuTmlnXEtVEcyfIq1MDLsen1I0/RxpYg/t6uP
         BlcOSlhQDeYmBYJFSzoWunJPBSrYIgw8UmoRs7Y3zCILdD3NJfzxLADZhz4YaMjnu0wW
         H8coLAMpb0uI78x/jtl2oD5AI/uqAh9TS8mqz+3ImPeF/pIUSs7WebIKpFICjRZhtHJn
         3+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269170; x=1787873970;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6FWGDnWimdEuyVbIhKTlp9NOezQCpG6klu9pcGU95pc=;
        b=qiScYcJMT6FYUQaekArKRtPffkKeH1NDrs4+nD43YU5qclelN9shXS/zxPMxfVXowo
         /5q1AAybCI1Fg+qFY/dQru5VsSspSDVqTHQmaTPi07gxHzVVEOj8TlXecUlttTiPVO2R
         Vu07kRa6qq1qBIc7vO0PzIN3gbzeo9bxID8ZuKKSHN4vr2uBrOISd1hQWyBRURC+Dr9X
         aqJnUiztUhhrMkT959vhq68UIBNpBUAafn3JwZAUYzgp9fIvndT1TSUdWOF6znm/kVKX
         VEHoIK+8OkTOggJVjxro22oli3DGMTdRU3d6rKCpEPyV8n/T3TxJIzsVCSb7fLJxQGDk
         +9Kg==
X-Forwarded-Encrypted: i=1; AHgh+RpzoJIPug38iCPmhwFGd9zaFn9RLkYDHoucTrCokr96ujjyToupN7G+GcJti5VMVaGgtabNk/MIZti7/8C/@vger.kernel.org
X-Gm-Message-State: AOJu0YwyvxhCLTLMxXeUaaveIvQEaOM8tU5MQ2wCuvbrMIF1l3H3h1TB
	8Vq2NHg7j2Tf1usM2XJKem5+WtprmTgkDdPlPongsNRQXvsOSDlgM2U1uTZ2F+b2FdNsTG7TGjh
	yh0RuD+lK1lT0T1ULoFcljxzVXcjD95w=
X-Gm-Gg: AR+sD11raR2fhzqzzJ6xFYifawOyffUjuoAiB1o9k5A/vVZl5edWCWz36Z04GwFW7NI
	g7Kfr2quT0gnsWC7QkOj5o6XybbWpFr+5Rf+uL4P31geWFSbQsIsjJBBoBWDulvuczbJXnF7jJr
	CRGeuxn6me2uD5IjVX3GH4BZre05aZKMt+xghkQLDyfGqwPpvA0pezqfIUqgRD7UAXzHc7FPw6X
	E1y+XhLvZB8ZUOmOadccLwwOHJM3sWlUSQ2fiKmQYzzmcKaX9suRIBMLPOVuhw0JPKpqFzWKoPy
	4WxbrhAcymxhiS3UAw15f4IeEpbw9UepJQRedaFPa8YVK4voIjuw/N090Ueropm15tBdNpNYocg
	L9q3vBTUHBm8nJG7QjjwMkM46
X-Received: by 2002:a05:600c:3588:b0:496:c18c:f9a3 with SMTP id
 5b1f17b1804b1-499b83184eamr33065975e9.5.1787269170200; Thu, 20 Aug 2026
 16:39:30 -0700 (PDT)
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
 <CAO9r8zPLipVW6bvyDK1ypSawbo=LHKvmLqWH0xA6WMR9GYNJpg@mail.gmail.com>
In-Reply-To: <CAO9r8zPLipVW6bvyDK1ypSawbo=LHKvmLqWH0xA6WMR9GYNJpg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 20 Aug 2026 16:39:17 -0700
X-Gm-Features: AcwNN1W2WwOZ6oRwPRAG9dZBaGHXMlGuhp9w5dO0dP8YLHD19Z4QrM5cxrAENkE
Message-ID: <CAJnrk1ai-TqcudPoK-qFRYAJnUjBmg1kVa6Vxg3eDm5w5ivqSA@mail.gmail.com>
Subject: Re: memcg stats flushing (WAS "Re: [PATCH] fuse: disable default bdi strictlimiting")
To: Yosry Ahmed <yosry@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yunzhao Li <yunzhao@cloudflare.com>, Song Hu <husong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 11:40=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Wed, Aug 12, 2026 at 1:59=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > d) vmscan (prepare_scan_control()): for determining whether reclaim
> > can deactivate, there's this logic
> >
> >                 /*
> >                  * When refaults are being observed, it means a new
> >                  * workingset is being established. Deactivate to get
> >                  * rid of any stale active pages quickly.
> >                  */
> >                 refaults =3D lruvec_page_state(target_lruvec,
> >                                 WORKINGSET_ACTIVATE_ANON);
> >                 if (refaults !=3D target_lruvec->refaults[WORKINGSET_AN=
ON] ||
> >                         inactive_is_low(target_lruvec, LRU_INACTIVE_ANO=
N))
> >                         sc->may_deactivate |=3D DEACTIVATE_ANON;
> >                 else
> >                         sc->may_deactivate &=3D ~DEACTIVATE_ANON;
> >
> > (and same for DEACTIVATE_FILE for file-backed folios)
> >
> > target_lruvec->refaults[] gets set at the end of the reclaim pass. It
> > stores the same lruvec_page_state() value that prepare_scan_control()
> > will read at the start of the next reclaim pass, which means if
> > reclaim passes happen more frequently than the 2s flushes (eg under
> > sustained/heavy memory pressure), this logic will incorrectly assume
> > no refaults occurred and deactivation is disabled, which afaict means
> > folios won't be moved from the active -> inactive list, and reclaim
> > will start evicting pages from the inactive list that are hot (eg more
> > refaults).
> >
> > This is from reading the code rather than a reproducer though, so I
> > don't know how much this matters in practice. Unlike for the writeback
> > case, I don't think flushign more frequently solves the problem. It
> > would shrink the staleness window but not eliminate it. Maybe one
> > solution is to keep the deactivation state for a period of time if
> > refaults were observed.
>
> We do have an internal test that runs a VM under memory pressure and
> we started observing OOM kills after the ratelimited flush was added
> in vmscan, so I think it's more problematic than just reclaiming hot
> memory, but I didn't look too closely.
>

Would you be able to share the test you're using? I've been trying to
repro it locally without much luck.

Thanks,
Joanne
