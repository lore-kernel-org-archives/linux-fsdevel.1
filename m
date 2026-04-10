Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F073B3881
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856275; cv=pass; b=MTQnTMhXQ+rHuVlzrs8UnwDmqAaGzDp3lH2FwN+sTJvXAUubMP5Z63IfMTAnL1HS7AaXq0P03TrTwLkjuKrM5jJEJBt/1WMIntAaCRK3KiVi04CokxMftrDqOkYSAwHhItfOfWNZbuoiU/h6rxqj8CQ8i1jLY+Yz8YL42Kfqbd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856275; c=relaxed/simple;
	bh=zkaXCvtPYPHy1ZBzr3tpXsi6yhSAdlJujQEn8EAWZGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bt/wgPzVdbI+U0k9ESpmy41bNebNCX+w07vgCi9k7pZ7RQDJCfrstHXiH0X9/vgp/hFUxXCgksTl43x0QH+Dt55xdebHU3FdBSMfostcQu5GLUFx4aS1ZweECgc0zFGFRmhcAW1c1lyMu4e+0idk37Uwnis4dzjES1IRq6W0Uyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8MvbtRc; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8MvbtRc"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso1605700f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775856261; cv=none;
        d=google.com; s=arc-20240605;
        b=WH6xteTEv2ItEGe7Kc7iHXd9rLZXvLwRokb4I7Ul4I0Ac7jDLZEcOPBhGPJjpK1XgQ
         gRki1+6ZDbFozsCBrv6i//UOzmvL3vyi4xod3lvT+WXP6Czch2AsZsARPUnRwIXksM7w
         iaarxXNWhKN5GXBce6MMwqMoAh2Ih+hjEJDRzysjCxJ4JqBJxaSEe1tpZZLCa62Gdy4f
         9eQeQKHeggfvm62u2Wdvx2I50m6jolTtAubURKQsUnxmjOFIFuBdxMsgqnvP/oaC2BQp
         S9qIkgoDmaXbPiFn4TRk0yNEe2SHPCcQekX6xExMOyIOJxePUIc0HjoZKmtcVxkcr/TU
         1H5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X2dvKV4jbDMqVk6/DDYhxXddTP8/XZH2vB6dqDAL3ug=;
        fh=pZ0mjUZPQ9NZnA315aRGP21/csLutJgzsQvhmzqYhqk=;
        b=lJMr0mE0o+Fw/KviYL/FxNDDZQuoNAuN3w0TfAiQPOzbKCnFTM6HB4y5n/U6MpbH3Y
         rW6wqhDvXq1TEfhMKyU3n6xNfBJaHzrcZcGYDkY2oesLktdTPKlWP4/oYS4vL7ibMyAB
         ijfxDYLcTig7UWjjmtADpRjVIpffZSJKyvRX+rF5PkaA4La1xlrGbQ14L0daw9ZrcleL
         BCefr+XUP3MwjLL8cKVhGHuA6eSyPQBTt+cYEWIUABE74oyzh3nQK52yyBaiMvP3CTWA
         AnZ8flZheCG7Gh9OYOysgeANC8ZaPe/tBVsAFVyVpTHy2JcLIJ+0XbNFjxnskKlgQR8D
         v7MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775856261; x=1776461061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2dvKV4jbDMqVk6/DDYhxXddTP8/XZH2vB6dqDAL3ug=;
        b=g8MvbtRc2Tv5YguwWveJjo5rY0MYiRIfeP4VodyebILmx8+GwveogQrZerv3gRMJdW
         vDugUoW+jJTBDLVl7FBaEMYFhSH3atp/DbjxLAWRjlBt3n0CgsJHGwWWbz6yZswp4S6/
         bkKJczQ47/iJr4OPYYjWsOIefEk3guZWwwJv7xpHlFRmGMuZuoIVFZk/Kv1Ysp63MEFf
         fos0I23rhIO4D3k7rw/rC319sH7n8NiBxnDV10CG7v2BhQWzO/jPex0vvoytKD2GBeCo
         7zHZVizFh3gg/Gi51PVLrAfsebn+ER9caCv2j6UxHT1SujE/ut5PGh2pedVplGLC+fUa
         i+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775856261; x=1776461061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X2dvKV4jbDMqVk6/DDYhxXddTP8/XZH2vB6dqDAL3ug=;
        b=HuK2Az+wrOXFOEBB19VtX5qeUXElBPd0nBp0GL42aEaP9lcTqkQ0Ap2CT4GaTedyVQ
         nrCJXTM9FO/hZi21Kfa2A9dFcCtSTwOE7W/sdQq4B4sMfbVGQ0oUwH0/DPtiAAf6V910
         QJKzI+ZtJGuk/RlLzVG67j3BUd/o5hVKJyF1x3sqwaOv8yNLvE/aP+AWi3Xgict72daj
         t8tSCO+sm1FxyqBtOXOQXPRhK9rup86jPIKxpaFfo8ZDctnt/052oKgWkDcvB2jAeHqy
         amrhx4IT8PnQvJiMOYy+PN1fOklIJKpgwMM5yg9bSQbp+BpESlFlPJKxOKEr3ccA4QNR
         u2SA==
X-Forwarded-Encrypted: i=1; AJvYcCXunfCippbJQcsNn6bX2KgngD5WTL5zaqYy226aUJyc6IesQFRXCHSSaean02R0exmn+jHRO+rc3I3BqK/I@vger.kernel.org
X-Gm-Message-State: AOJu0YzcpOmcp3s8CPiTKsQaUxze7FFCgAGnYf7iHDNi5I0R7EizD3Bc
	ufv7CQ5QEwt1G+r1LxVMCtNQmKp/YrnwZ/yMmTV1pMyOR+l4KxvgD+mpgnyhH/fi2mfqc4fv8DX
	6DWvUzRy9K1fv5U2oxcNFOqgHwdcMKD0lfGiile4=
X-Gm-Gg: AeBDiet9bTV/XpfpEUZgDlY1WnrZdeiNpFVvy5cR8iil/tmRwVXJRw5VXIDxXrL6gQE
	LKt4fIDQUpw/3jFO7ySXe81PStcCL6Ym67rpW7A2oAGvqJSeX0tWh93kz9hreMQD1henG783lBf
	ydgPIwB8ZagQ+LMLOzPFpXmiRSCe1RE5T79akWupLpLtIeYf9QsoMI4rAMHwwtNzvUJN+kSN+4W
	re2kHDuXuhdjCweU4GmWkGEVF1khe9gvl29pHQtFsAtJL2/JpwheZ15MwqdNzl6+dG9f41y2mr+
	x4QP+g==
X-Received: by 2002:a05:6000:3108:b0:43d:1c7a:8b5e with SMTP id
 ffacd0b85a97d-43d642c13e0mr6991085f8f.35.1775856261126; Fri, 10 Apr 2026
 14:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.com>
In-Reply-To: <3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Apr 2026 14:24:08 -0700
X-Gm-Features: AQROBzCtZUIp49iMh3VP-6lW73EAvVQpDZUDAAv1pKKJjQe8XToOSqBpiQAnPe8
Message-ID: <CAJnrk1aoxGMGNZi+OwdoET6ahhGHp_7dw__=dmOWW+PMxnsj2w@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate teardown
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 4:26=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
Hi Bernd,

> Hi Joanne,
>
> On 4/10/26 01:09, Joanne Koong wrote:
> > On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbernd.co=
m> wrote:
> >>
> >>
> >>
> >> On 10/21/25 23:33, Bernd Schubert wrote:
> >>> Do not merge yet, the current series has not been tested yet.
> >>
> >> I'm glad that that I was hesitating to apply it, the DDN branch had it
> >> for ages and this patch actually introduced a possible fc->num_waiting
> >> issue, because fc->uring->queue_refs might go down to 0 though
> >> fuse_uring_cancel() and then fuse_uring_abort() would never stop and
> >> flush the queues without another addition.
> >>
> >
> > Hi Bernd and Jian,
> >
> > For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> > from fuse_uring_cancel" email was never delivered to my inbox, so I am
> > just going to write my reply to that patch here instead, hope that's
> > ok.
> >
> > Just to summarize, the race is that during unmount, fuse_abort() ->
> > fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
> > fuse_uring_entry_teardown() gets run but there may still be sqes that
> > are being registered, which results in new ents that are created (and
> > leaked) after the teardown logic has finished and the queues are
> > stopped/dead. The async teardown work (fuse_uring_async_stop_queues())
> > never gets scheduled because at the time of teardown, queue->refs is 0
> > as those sqes have not fully created the ents and grabbed refs yet.
> > fuse_uring_destruct() runs during unmount, but this doesn't clean up
> > the created ents because those registered ents got put on the
> > ent_in_userspace list which fuse_uring_destruct() doesn't go through
> > to free, resulting in those ents being leaked.
> >
> > The root cause of the race is that ents are being registered even when
> > the queue is already stopped/dead. I think if we at registration time
> > check the queue state before calling fuse_uring_prepare_cancel(), we
> > eliminate the race altogether. If we see that the abort path has
> > already triggered (eg queue->stopped =3D=3D true), we manually free the
> > ent and return an error instead of adding it to a list, eg
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index d88a0c05434a..351c19150aae 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -969,7 +969,7 @@ static bool is_ring_ready(struct fuse_ring *ring,
> > int current_qid)
> >  /*
> >   * fuse_uring_req_fetch command handling
> >   */
> > -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> > +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
> >                                    struct io_uring_cmd *cmd,
> >                                    unsigned int issue_flags)
> >  {
> > @@ -978,6 +978,16 @@ static void fuse_uring_do_register(struct
> > fuse_ring_ent *ent,
> >         struct fuse_conn *fc =3D ring->fc;
> >         struct fuse_iqueue *fiq =3D &fc->iq;
> >
> > +       spin_lock(&queue->lock);
> > +       /* abort teardown path is running or has run */
> > +       if (queue->stopped) {
> > +               spin_unlock(&queue->lock);
> > +               atomic_dec(&ring->queue_refs);
> > +               kfree(ent);
> > +               return -ECONNABORTED;
> > +       }
> > +       spin_unlock(&queue->lock);
> > +
> >         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> >
> >         spin_lock(&queue->lock);
> > @@ -994,6 +1004,7 @@ static void fuse_uring_do_register(struct
> > fuse_ring_ent *ent,
> >                         wake_up_all(&fc->blocked_waitq);
> >                 }
> >         }
> > +       return 0;
> >  }
> >
> >  /*
> > @@ -1109,9 +1120,7 @@ static int fuse_uring_register(struct io_uring_cm=
d *cmd,
> >         if (IS_ERR(ent))
> >                 return PTR_ERR(ent);
> >
> > -       fuse_uring_do_register(ent, cmd, issue_flags);
> > -
> > -       return 0;
> > +       return fuse_uring_do_register(ent, cmd, issue_flags);
> >  }
> >
> > There's the scenario where the abort path's "queue->stopped =3D true"
> > gets set right between when we drop the queue lock and before we call
> > fuse_uring_prepare_cancel(), but the fuse_uring_create_ring_ent()
> > logic that was called before fuse_uring_do_register() has already
> > grabbed the ref on ring->queue_refs, which means in the abort path,
> > the async teardown (fuse_uring_async_stop_queues()) work is guaranteed
> > to run and clean up / free the entry.
>
>
> I don't think your changes are needed, it should be handled by
> IO_URING_F_CANCEL -> fuse_uring_cancel(). That is exactly where the
> initial leak was - these commands came after abort and
> fuse_uring_cancel() in linux upstream then puts the entries onto the
> &queue->ent_in_userspace list.

I think there are still races if we handle it in fuse_uring_cancel()
that still leak the ent, eg even with the fuse_uring_abort()
queue_refs gating taken out in the original (jian's) patch:
* thread A: fuse_uring_register() ->fuse_uring_create_ring_ent() ->
kzalloc, sets up the entry but hasn't called
atomic_inc(&ring->queue_refs) yet
  concurrently on another thread, thread B: fuse_uring_cancel()
->fuse_uring_entry_teardown() ->
atomic_dec_return(&queue->ring->queue_refs) -> brings queue_refs down
to 0
  At this instant, queue_Refs =3D=3D 0. fuse_uring_stop_queues() ->
teardown entries (nothing left) -> checks "if
atomic_read(&ring->queue_refs) > 0", sees this is false, and skips
scheduling any async teardown work
  thread A calls atomic_inc(&ring->queue_refs) for the new ent,
queue_refs is now 1, the ent is now placed on the ent_avail_queue, but
it's never torn down.
  the ent is leaked and there's also a hang now when we hit
fuse_uring_wait_stopped_queues() -> fuse_uring_wait_stopped_queues()
where it sleeps and is never woken since it's waiting for queue refs
to drop to 0

imo, the change proposed in my last message is more robust and handles
this case since it guarantees the async teardown worker will be
running (since it does the queue state check after the ent has grabbed
the queue ref).

btw, there's also another (separate) race, which neither of our
approaches solve lol. This is the situation where fuse_uring_cancel()
runs right after we call fuse_uring_prepare_cancel() in
fuse_uring_do_register() but before we have set the ent state to
FRRS_AVAILABLE. The ent gets leaked and continues to be used even
though it's canceled, which may lead to use-after-frees. This probably
requires a separate fix, I haven't had time to look much at it yet.
Maybe Horst or Jian has looked at this?

> Issue in master is, fuse_uring_stop_queues() might have been run already
> - entries then get leaked and fuse_uring_destruct() later might give a
> warning. That part can be reproduced with xfstests, before it starts any
> of the tests it does some funny start stop actions.
>
> Initial *simple* patch was to either add a new list or to just remove
> the warning and to also handle either that new list or
> queue->ent_in_userspace list  in fuse_uring_destruct(). The comment
> explaining why it is needed was much longer than the rest of the patch.
> The hard part in the long term would be tranfer the knowledge for that
> requirement.

I think the initial simple patch doesn't address the hang. When the
ent is canceled, it still has the ref on queue_refs, which means
fuse_uring_wait_stopped_queues() will wait for queue_refs =3D=3D 0
forever. I don't think we ever even get to fuse_uring_destruct().

Thanks,
Joanne

>
> You then asked to handle the release directly in fuse_uring_cancel()
> without another list
> https://lore.kernel.org/r/CAJnrk1YaRRKHA-jVPAKZYpydaKcdswLG0XO7pUQZZ4-pTe=
wkHQ@mail.gmail.com
>
> Yes possible and this is what the next patch version does. However,
> given fuse_uring_cancel() runs outside of all the fuse locks, it is racy
> and I therefore asked in the introduction patch not to merge it yet.
>
> https://lore.kernel.org/all/20251021-io-uring-fixes-cancel-mem-leak-v1-0-=
26b78b2c973c@ddn.com/
>
>
> Turns out my suspicion was right ;)
>
> Queue references might go to 0 when nothing is in flight and then
> fuse_uring_abort(), which _might_ race and come a little later, then
> might not doing anything.
>
>         if (atomic_read(&ring->queue_refs) > 0) {
>                 fuse_uring_abort_end_requests(ring);
>                 fuse_uring_stop_queues(ring);
>         }
>
> As Horst figure out, removing this check for queue_refs avoids the
> issue. I'm rather sure that the check was needed during development and
> avoided some null pointer derefs, as that is what I remember. But I
> don't think it is needed anymore.
>
>
> Thanks,
> Bernd
