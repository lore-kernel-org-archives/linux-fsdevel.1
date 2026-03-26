Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F44336880
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547947; cv=pass; b=lGo4x3t3/8LIn0VVymSMSnIKTRFJCYmECw6hL1au2h8u7ttaoXE7tQLuW3J9B0j0jGWwa2Ux4TEhPEjJLluFoMi3qq2CyDecJ8m4w8uJZx8rgFhsG4hLGJTbgg/UXceOfPWBLowqd5iSe7sqVgHiExdvBj0uDKsg6c61XoECHlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547947; c=relaxed/simple;
	bh=gTz4UtnKH0w9cMFhxx+SfgWyHpwq0GIaUKSLnwF1E6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFhgX6+k1ANif7K3jFdDe0SXjQuEzPxv6oSquDB2ceadTOUvngqlFS7wxBBxSLtejDu+3sAxUgv+YgCKJKb5lw2ctJjiCbUdJe5OgKBlU9Ms2rNMD3d6i1rbCZ2u3E7v2wzpDR/ExSHh9/qvN2Mr97UEDRDyGYeI1c0oNM8WJXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL4L+MYQ; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL4L+MYQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so11894495e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 10:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774547940; cv=none;
        d=google.com; s=arc-20240605;
        b=hSStNp9OEhMevgc/AYmwCclEhAXAV1LTrran5+2XVKeSyqVdXa+6UPjtJYeuJyCNRB
         0jSheqRLl97AdcbpjjTw4jr4wwEVq0Wmniqe4vuvgxf0DI11QUaN6hVdFOCRASr1JeXX
         NAdgWUia8keV14m9sLjwdxvwjMt9QqvtOOEPjGmPrGIdExouDs47Rz8Tng5NqkdKhgrN
         IjyckPpsBEOosXT5JVBvO6KzemjgCj00/A9+3BxfT6XKtSv2k9yHzDELwmv9Riyskwzo
         TLuszk6LmAQgZlciw9CLPkv5fo9vRgGwEIL5uAVhTPeeygPbsR9wTwLKLinD78+QoLyY
         4e8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80Mb9whJ243IS3wLbxD0sRPngPj7V2/sZvWpg8pOWw4=;
        fh=ITDEvgmseCFcCyHEFh46nC/bgQREy4H5Pyu2LKM+CQU=;
        b=XPV6dwEgc4yMocMlcTvoB0322hEjPl8iIjpzl3yIO1aU0LOY2Il0KtAztDqM7zaX0i
         EYK061gU57dEwZZJzW5p+hJRUwqNppP1mwLIZCcAY/a+CRBQlWbt0w7jUrIfo22GLr3Y
         9vver6R6F4iGLuP1WvQk+pleLtF5wFLq7wtVPgPtZkO8lXKfJXLBQdOakHPmqPI8J1LO
         QTy/q/k25fTQCAQlobz4Imgo0wQ1+cM5IbaN4NO8L6GvpARVr99T49tjY0VhPMWNch5G
         Cx8f1QThJrsXuZ5ynJm5FfcFd1JBw1fHUpACta4X34J31YYRQKmmQBVgE4tDLqngqhNy
         LWXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774547940; x=1775152740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80Mb9whJ243IS3wLbxD0sRPngPj7V2/sZvWpg8pOWw4=;
        b=jL4L+MYQEMKrwrpdhCXfUIDJ30hGSSo+UogrfB6W1ckaI/KichvYxvnUhmhlWq8tZo
         LNqULavMhXr+RxWzhXoKiqCPWJJGVGvIM+cjHiIyfZpMQnm6d0TZzixdEpyzR0G8auXq
         E5FyxgeK0A6HlI2q+gklMLD2DvoNTSm4lNyabSnbdbOUSXYMqH3BKBlBKPHtaCLkeqbF
         bIxR9Wgjg68kzwIpS83J6JlKgkTuCgeaLta66YzatXQTK4XiJ44CYISXvWs+Kx9aH6dU
         6dWYur6SGykuuHl1IYZWXw3XF8QQvdI/Xisip1aLfdGiIACD4Qwxl+xOhoZHjJrPfLgo
         tJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547940; x=1775152740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=80Mb9whJ243IS3wLbxD0sRPngPj7V2/sZvWpg8pOWw4=;
        b=hHz5sn51zdRfw/5sOm5TBXvmdxR9XyUwk3TyqEECBp7oBiUkF3m7TRMf3eFPlGSqke
         QUJ9NUidrFI9DqW2G5bWFzM+hLPrsGRbWWM8zX80FOoszxjJMzxgLCVLp3ouUaqmAZ5Z
         8b/0u1bCdLpM5EU4aQ7lUXgpg0B2UZ3mjDrvIcYTLfjmQxTXrkZQe+bhKv1snwbK0xQT
         ydfGUccELyh9tiCrmWAMDMGj9y4esDQ7xiw9UuEQYJ2tLl6undlonj54zAvPbNvQq83Z
         WXzqERRfBaIBFqjIP/35c/YdXWlYfv4QxtL1NNwC1vcXsxiTguxbHDzqn6VtN7lqpAVj
         +law==
X-Forwarded-Encrypted: i=1; AJvYcCU/4hHS3n7R8tjxBLYUxpIlErkm564fFSxRZ2flpzgEkoBJa1yP/JSzoB+6IlLuYEEMF7ey0SWuBKQag7K4@vger.kernel.org
X-Gm-Message-State: AOJu0YxReLegrYAfpGEpoxuendv8EYQrNF1JMw1DCEUVEoIwVdzlVXmv
	NoicqnoPhCcXCXHI5lKfZ/80kLDrGSjW6Beo1BkamnUg+ZUPWhb9sNYAFks2YGr6nV7kGmBR5wx
	HuQwOnCl/65tKGP4TMbXKuuj4STzMs/4=
X-Gm-Gg: ATEYQzzJ7oQ5WHYt0a9S5r45+JFA7eBF/EmZl8WFLGosP3ujPgPgMGiX3tIx2juFBzF
	1n+Opbkr1gQyOhPyJ3tucwzqvSFNutGAIrvVmCwN0D+OKbjxlrZIFjcSzOkiN+dhNrQkbMp1flH
	4uO4gHTHxwt2Zp8vScuihW8GTzZeEliKD7EmwJL0Ya4Bp6q6ajmmX8IgP8/ArbJsQIwGWlJ80ZH
	KT4nIYl0waidAdaONyxg1j3CGolXsDPTvp0v+mmf9KtIKc7oOeXaxcAKHjZnRQrjm8Yb4wWLtd7
	G79lpQ==
X-Received: by 2002:a05:600c:3b16:b0:485:45fb:3472 with SMTP id
 5b1f17b1804b1-48715fc3a88mr128851985e9.7.1774547939665; Thu, 26 Mar 2026
 10:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326001337.828947-1-joannelkoong@gmail.com> <yet2ddivcs3v4g5wmr4zfjkwsbzfjmwjhq56zur7wjivd72abs@tq23xp4mle2o>
In-Reply-To: <yet2ddivcs3v4g5wmr4zfjkwsbzfjmwjhq56zur7wjivd72abs@tq23xp4mle2o>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Mar 2026 10:58:48 -0700
X-Gm-Features: AQROBzBJTNVKqxLNGXMdHzPrAm0v89gG-2H1rymc_kwPrrzGJPYjfQfe4mHTfyc
Message-ID: <CAJnrk1Y_R=bVQpugCwg39G75WXCpss5w9xzwd8fTrmrVN0YSRg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: fix writeback regression for strictlimit BDIs
To: Jan Kara <jack@suse.cz>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org, 
	miklos@szeredi.hu, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:48=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 25-03-26 17:13:37, Joanne Koong wrote:
> > Commit 64dd89ae01f2 ("mm/block/fs: remove laptop_mode") removed this
> > unconditional writeback kick from balance_dirty_pages():
> >
> >        if (unlikely(!writeback_in_progress(wb)))
> >              wb_start_background_writeback(wb);
> >
> > Earlier in balance_dirty_pages(), background writeback is started if th=
e
> > global dirty count exceeds the global background threshold (nr_dirty >
> > gdtc->bg_thresh). However for BDIs with BDI_CAP_STRICTLIMIT set (eg
> > fuse), throttling is calculated using the per-wb threshold, not global
> > thresholds. This means the per-wb threshold can be exceeded while the
> > global nr_dirty is below gdtc->bg_thresh. This causes two problems:
> >
> > a) background writeback is never proactively kicked off. The flusher
> > should be kicked off while the writer is still free-running, so that
> > dirty pages are drained before the writer hits the throttle threshold.
> > For strictlimit BDIs with global nr_dirty < gdtc->bg_thresh, this never
> > kicks off the flusher, so dirty pages pile up unchecked until the per-w=
b
> > freerun ceiling gets hit and IO is throttled
> >
> > b) while IO is throttled, the flusher is still not started, which means
> > the writer basically sits in the throttle loop sleeping while waiting
> > for dirty pages to be cleaned but no writeback is running
> >
> > This leads to severe stalls and degraded throughput. On fuse, buffered
> > write performance drops from 1400 MiB/s to 2000 KiB/s.
> >
> > This fixes the issue by kicking off the flusher if wb_dirty exceeds
> > wb_bg_thresh for strictlimit BDIs. This restores performance back to it=
s
> > original baseline.
> >
> > Fixes: 64dd89ae01f2 ("mm/block/fs: remove laptop_mode")
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
> Good spotting! I think your change makes sense but I don't think it is
> enough. The problem is that writeback throttling depends also on memcg
> setup so with your fix we still have a problem that when throttling due t=
o
> memcg limits the flush work won't be queued early enough / at all. So I
> think the best fix is to perhaps do your change so that background
> writeback is started earlier for strictlimit bdis but also return back th=
e
> unconditional starting of writeback (with properly updated comment) when =
we
> find out we're going to throttle the task for whatever reason.

Thanks for the explanation - great point about the memcg case.

I will bring back those 2 lines as the proper fix for the regression
and submit this patch separately as a strictlimit optimization.

Thanks,
Joanne
>
>                                                                 Honza
>
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index 601a5e048d12..3f89b08b11b4 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -1835,7 +1835,9 @@ static int balance_dirty_pages(struct bdi_writeba=
ck *wb,
> >                       balance_domain_limits(mdtc, strictlimit);
> >               }
> >
> > -             if (nr_dirty > gdtc->bg_thresh && !writeback_in_progress(=
wb))
> > +             if (!writeback_in_progress(wb) &&
> > +                 (nr_dirty > gdtc->bg_thresh ||
> > +                  (strictlimit && gdtc->wb_dirty > gdtc->wb_bg_thresh)=
))
> >                       wb_start_background_writeback(wb);
> >
> >               /*
> > --
> > 2.52.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
