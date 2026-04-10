Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7038F931
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851791; cv=pass; b=rIG66BxG69ljWToMOyOXXqSVxEwCO3CqoM4TrOkXt7TXx2yqY2Nm99hMWX7YJ9PfqLSfRv9mk8xc8d60YQcTBe/WPzNIOb911EJy4ptbibFKUAd0sUt7dapoPXzWirIjOdfLVMP2NMcoAmmaIPrAcdx5/YxmfqFmSwSbJY3LzXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851791; c=relaxed/simple;
	bh=ogOCvyyoZ9XSpNfyYtW2p4XJwVTVTXAMukOYXRQXI0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GASct//MpH/pUGR2RruA/+40IBNGIuPsvqaDyH6kWLw4Cj/fM8oxy9vKUoTj86l7NjLdOLXYqVmsiX0/xsWZ5eZ2dt+t+8YG8XQVRMiK+SE1SVstfMyRd/RrtppFlpccI8yVHuH3Sk6IDSNo5TX9tB6a+cAIXNurV26FOytyxWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEy7znA7; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEy7znA7"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48374014a77so33972245e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 13:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775851788; cv=none;
        d=google.com; s=arc-20240605;
        b=gr8n9jk2MLTeA/vhwVZ7UAfKhCLpmIYyJCZkTltzqZNYOrUYmexQ4UPHfu2MiVdM9N
         rKKbAQyCpKpN1Zx0JKj9yFhEaVWIAqKfXS58zzYN7iI014q4ohbps3D/5rEcIqNJxhRb
         ZudNLDDuMJTAoVtXVsn991iM5LJIs4J5TYD9TkMjFhG+LvExyi9k4er4CMPe7KaP4v6d
         TeLIYt2pb5MxgtL/Zh3EpDHYv6J3xzbjf1cY3uWkEgUKQTpPvZivAO6nvWtWOIBOc3Ag
         rRORBl68ywkpCkjFferp4DxJX0LMAw1OzsMB+p1DvDJnlJbiRYml8kaC57GL/egbLTfB
         rGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogOCvyyoZ9XSpNfyYtW2p4XJwVTVTXAMukOYXRQXI0I=;
        fh=ML7JcZGw/kG4Bp4LecsZjlmqFKTUNpyEva3b5RgqeBw=;
        b=ho7feQTFeD0bsqO1LujKUK43JwFmAwht9uQ0DXG/g/iutSomIXD35I7izyJxhJA/Rt
         Cn/23OsoZWGsF4PXntvC8CrEJTAPQHyMMmMI+Iia1wVVeqnGCOE7ERXZ8m2cRveTVU5w
         Kf2v+unTVe6cY0lf69OpfE+ArFIivYfg0MJX9XG8B4ZFq0H6E/duvgVRAbE0k8katxy+
         FKcBQdC+MneHGp4FC/bh60YaNtctR82l7EsuHDBcD3GzoLG3X/obwdKpDCE5uplJLACU
         BnbARzQOslwEysawSBIgNx6ZPkAmDDtOrPYxeBc+nsxR0IN6MaCXbbksHKEe3DsohmbF
         UjDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775851788; x=1776456588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogOCvyyoZ9XSpNfyYtW2p4XJwVTVTXAMukOYXRQXI0I=;
        b=QEy7znA7t6BHcgNXG3k87Uyr6WNh0DQE/C39tUBGWmRYuDiMxb/8EXiUrtBp/JHtu+
         welp1szQKxtYNlfdcO1yNRSnnSy7IMZ3Fon2vIonOshQT1sx7BuDbEGyXmFvkLLUgva0
         IMpK1Vb4u3+lRSDw8fFEErWRDC2ltmA/K81jwq20MlLRd1yf9qT/jrzYGzz8cDPaK8ep
         dpxvw0ddf0t68d4sQHQTaT0CBYZXfGhDDwavHWsw5PJ31WdVzA/ApFI4mogEYL/OjPuH
         JuHTbq4HEkzgPm2GMGrpxt0u8+Myg6fjKxqOUaSTykQv6g3HhSLLa1h+Mh7CRhvNnkfs
         2Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775851788; x=1776456588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ogOCvyyoZ9XSpNfyYtW2p4XJwVTVTXAMukOYXRQXI0I=;
        b=ShICZ77lOKcaEpsl8np2V7kNNL0qO8iSi9Qi0hZk6KcoXQVU7x82aeTH+UeM15jDEo
         a3QEdYLxzD8G6I7mTBWIJI6xkOH+9NA3n7c9pCBUBBEI5x5yLrBwbQL0TgV4saUkXiBA
         dRFRGe9LpTd9apoYz48hF01pThKtE7cD4RcN3siej4JES1xrZwSr9INQRnSN/mNEaaDA
         B4/pMeZBBPed6oB6aZqubSiH5F0nPmSQocaosioU7at2AMwPHTuxvvQRFYVP1hqmokZt
         DJmF43nSlRGP+yJ32iULGtiT5GzVMT34sGv1Td0I9/TRGeO69TuR8jIOnyu5HgVwuElh
         wJYA==
X-Forwarded-Encrypted: i=1; AJvYcCVnFhZhJew42eaUc4asR3Fj1umDLtq9c4u5rImC4u8VNQX6iaX0VraxZgaMObfNSvOcMbzwpMatbBmXlRCa@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUyx1EGfgwi4cvO1qjtxosJiBpiKAJmVKJviKMLPWMR02ez2S
	PvBJ0Z3NXU4/jvqXngdZ73Rosl8EOjg1bgmKFPGu8dVmn4shOzo0H/5guatNsDt9C2ZWbFjiYOL
	Ptfjp2TcKmuj2xw/yoYapmBDy1lKwGBc=
X-Gm-Gg: AeBDieuF+Z5CPrtWYM+g9X0PQC94yU3Y7OktyvjrEhvfwgnJzMIZgVUt4I3WIt7n5Db
	EoaPh45Ko6FRsUUpEIhxBlZtbq0APtSANlLDQKP08/9iAyQtSEElOO8uztJ75fMNCJPP4v9OQEg
	8k/jQus1/c+eCRCUII9ImN2b0nsE0UN7BVx2ym9EeQmtcb8tAdSbiIFI+qmJ6qQzqmGSCtq+8Og
	eESYzlCBiXIB85J8haPE/L1SWCGAdjH1BXr6gz8vCJUi49a461boLY90m/qKptXMzaJ/si+GXa3
	InXoog==
X-Received: by 2002:a05:6000:4285:b0:43b:f322:34e1 with SMTP id
 ffacd0b85a97d-43d642d9f0bmr6365691f8f.51.1775851787743; Fri, 10 Apr 2026
 13:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora> <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
 <adlE6dSPAlMH-ek-@fedora>
In-Reply-To: <adlE6dSPAlMH-ek-@fedora>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Apr 2026 13:09:36 -0700
X-Gm-Features: AQROBzDl5u9RsBQZJwaYp4PaanKuHfyGrgmk6Kp2qbDA6zFCLoRJLrmfHaTlQgY
Message-ID: <CAJnrk1acOQ4vm0bj+uLsx7vRodcwJBbfxjY=mn0BJ_j_eMr11Q@mail.gmail.com>
Subject: Re: Re: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with
 immediate teardown
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 11:55=E2=80=AFAM Horst Birthelmer <horst@birthelmer=
.de> wrote:
>
> On Fri, Apr 10, 2026 at 10:09:36AM -0700, Joanne Koong wrote:
> > On Fri, Apr 10, 2026 at 12:21=E2=80=AFAM Horst Birthelmer <horst@birthe=
lmer.de> wrote:
> > >
> > > On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
> > > > On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbern=
d.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 10/21/25 23:33, Bernd Schubert wrote:
> > > > > > Do not merge yet, the current series has not been tested yet.
> > > > >
> > > > > I'm glad that that I was hesitating to apply it, the DDN branch h=
ad it
> > > > > for ages and this patch actually introduced a possible fc->num_wa=
iting
> > > > > issue, because fc->uring->queue_refs might go down to 0 though
> > > > > fuse_uring_cancel() and then fuse_uring_abort() would never stop =
and
> > > > > flush the queues without another addition.
> > > > >
> > > >
> > > > Hi Bernd and Jian,
> > > >
> > > > For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> > > > from fuse_uring_cancel" email was never delivered to my inbox, so I=
 am
> > > > just going to write my reply to that patch here instead, hope that'=
s
> > > > ok.
> > > >
> > > > Just to summarize, the race is that during unmount, fuse_abort() ->
> > > > fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... -=
>
> > > > fuse_uring_entry_teardown() gets run but there may still be sqes th=
at
> > > > are being registered, which results in new ents that are created (a=
nd
> > > > leaked) after the teardown logic has finished and the queues are
> > > > stopped/dead. The async teardown work (fuse_uring_async_stop_queues=
())
> > > > never gets scheduled because at the time of teardown, queue->refs i=
s 0
> > > > as those sqes have not fully created the ents and grabbed refs yet.
> > > > fuse_uring_destruct() runs during unmount, but this doesn't clean u=
p
> > > > the created ents because those registered ents got put on the
> > > > ent_in_userspace list which fuse_uring_destruct() doesn't go throug=
h
> > > > to free, resulting in those ents being leaked.
> > > >
> > > > The root cause of the race is that ents are being registered even w=
hen
> > > > the queue is already stopped/dead. I think if we at registration ti=
me
> > > > check the queue state before calling fuse_uring_prepare_cancel(), w=
e
> > > > eliminate the race altogether. If we see that the abort path has
> > > > already triggered (eg queue->stopped =3D=3D true), we manually free=
 the
> > > > ent and return an error instead of adding it to a list, eg
> > >
> > > In my case (Bernd mentioned that I was investigating a hang during um=
ount)
> > > there were a lot of requests created during teardown, so what happene=
d
> > > was very similar, but for exact the opposite reason.
> > > In fuse_uring_abort() queue_refs was already 0 due to an optimization
> > > where the ring teardown ran before fuse_abort_conn().
> >
> > Hi Horst,
> >
> > Just to clarify, is this with running locally patched changes on your
> > ddn kernel? In the upstream code I'm seeing that teardown is only
> > called by the abort path, eg fuse_abort_conn() -> fuse_uring_abort()
> > -> fuse_uring_stop_queues() -> teardown logic, so I'm not seeing how
> > it's possible for teardown to run before fuse_abort_conn(). Is there
> > something I'm missing?
>
> Yes and no ... ;-)
> The original patch this whole discussion was started by had a call to
> the teardown of the entries and I had that applied.
> But even without that the problem can still occur that queue_refs is 0
> by the time fuse_abort_conn() is called.

Gotcha, thanks for clarifying.

Without the original patch, can queue_refs still be 0 by the time
fuse_abort_conn() is called? The only case where I see that is when
the sqes are in the middle of being registered but haven't grabbed the
queue ref yet, and then the abort logic runs (I am going to write more
about this race in a reply to Bernd's other message in this thread),
but other than that I don't see how without the original patch we run
into this case since teardown -> queue ref decrement only happens in
fuse_uring_stop_list_entries() which only is triggered on the abort
path. Are you talking about a subsequent fuse_abort_conn() call (the
one called from fuse_dev_release())?


Thanks,
Joanne
>
> >
> > > Thus the queue->stopped was never set.
> > >
> > > How do we make sure that fuse_uring_teardown_entries() has not been
> > > called by fuse_uring_async_stop_queues()?
> >
> > If i'm understanding your question correctly, your question is what
> > ensures the teardown logic in fuse_uring_async_stop_queues() hasn't
> > already executed by the time we drop the queue lock after checking if
> > the queue has been stopped? In fuse_uring_async_stop_queues(), the
> > async teardown work gets continuously rescheduled so long as
> > queue_refs > 0. The ent holds a reference on the queue, so when the
> > queue lock is dropped that async teardown work will be continuously
> > running until it cleans up that (and any other) ents.
> >
>
> You understand correctly.
> If the fuse_async_stop_queues() runs there is still a window where
> we have queue_refs =3D=3D 0. If in that window fuse_abort_conn() runs
> we never actually stop the queues and we can accept requests which
> will never be processed.
>
> I have never seen this happen without the patch mentioned above,
> but with that 'optimization' it happens regularly when you are able to
> kill the fuse server and the application using the file system more or
> less at the same time e.g. by an OOM event, when the kernel tries to
> free resources.
>
> To me this looks like nothing will stop this from happening, though,
> but maybe I'm just not familiar enough with the uring code ...
>
> > >
> > > Maybe I'm missing something?
> > >
> > > My fix was to remove the check for queue_refs > 0 in fuse_uring_abort=
()
> > > and make sure that even if the teardown was complete nothing bad happ=
ens
> > > in fuse_uring_abort_end_requests() and fuse_uring_stop_queues().
> >
> > I'll look more at this path today.
> >
> > Thanks,
> > Joanne
>
> Thanks,
> Horst
