Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C413DFC7F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840992; cv=pass; b=FMDcP6IapCXU/16j1OkpbKT0vhq56ywI/wl6MHsaOEBx117khw2w++1HjVIfRKa/D5cBcddi+aLbhZ9ZHQ6xBCrd6XXwddteGu9XK2P/lTrf+J8ZftND/tEIruxJJy5mdjZ+FuH7nhfYfhiUE+ZV6TuIaj24EE2WWqcRklI/35U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840992; c=relaxed/simple;
	bh=AdRLWuRnA9WFkshkxgv4Av+3azQPL66RiuSI1tP85uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvc/u7X0q7DY+BExRDPDSegQ1k0LVtHralCrKd3WySOkebUeYmdYOFMhcbc6CI80Z/EtbNOudGmxQ5IiZ86bKE+j/rgMEJBYlFd44UGN5sD5rf8BIJKXGpG4Xs9oWdhlZDop5bVKJHBLZYZhM08sxfXYpjRF2cDklJrH/kVtgZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfplRdNw; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfplRdNw"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfd832155so1476423f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 10:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775840989; cv=none;
        d=google.com; s=arc-20240605;
        b=CO8qL7EAVc+NIYc+AQSiNdnP5YZimah+G9Vl0LnT32TK/suhTSg+SIKe2VdJFb1EF0
         ViMHhzQXdtUJTZi4TZ+6Ssrg/rGTlIufmRzetotkIf3IpQxbvBdQugyqFqJFxvGVsukO
         umkaNh+Spmw+RTnRZbcAtkko4ghVRYCX7Hm4ciU6xZtNarf9S+IWIlGxpuoP0jXyV2DX
         Ug168giWtH8Iqh6ehkRfxbMJijZeVQ4taUEBR/QoWQZbLudKvAV1ql2/oimHPMRfP1/e
         WFXYiT/oSY8+jhTbhubAgfh/Gv/3OKtGEenoXJgI1ipRwsPSa7NsL4QxXjRkE85H18pD
         AYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AdRLWuRnA9WFkshkxgv4Av+3azQPL66RiuSI1tP85uw=;
        fh=3QWE5N/PlFyTlskwiuvGxGzHy9u210vPt8bKhSHUBDY=;
        b=aZFBMMD3JXwjpkhrFo2hBCnzLNyw2ZYoAxOjwv4chLrpllhB3OT44zzqP9bvrHSSZ0
         XaqT/zxMvHGBdliDAboKTEfTWv/ZtfO3Ysgvu4tgndeoNmUZGq18lkrHnEecKEKUEOnA
         DCfonq3E9I2R5fllHkdPMPJEiJTuPD3hVDLrfGcvjTH3AcJmFH93Nka/8wSOzkUDWiVh
         LyH6NSjt2zPBXlMXmpR3TmLcB+aQX6jR7IX9itHh/jvnpTlTlTA1sjTc7IbLYdU5Tt5B
         3Wg0yve778hzy/unHRosN8NEx1dx58WMI//l0m+9l4CJ2t0bua0VVx95DwJSWippCEvl
         fA7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775840989; x=1776445789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdRLWuRnA9WFkshkxgv4Av+3azQPL66RiuSI1tP85uw=;
        b=rfplRdNwLmtq1485FcQYnG9yYcA4JqOjnRrd0GTnhOcjOWDMzTWZxHMu1UhSZvmJYE
         JKDJyeEtpkXeKIBSKBuOKchW5Ecwo+7TfwDN/ZJDBFK9PCbRuBXB2R9WnFVWwHfBIr6l
         U5eCWH3VErvykzhIYEn7jOaQDuvFUGQWrMTku6tpX7IMQ7nelXnrhZecJ4ybKbbwQa2S
         0Rpb7rTrSFYHk+EuHHbeb+gWp9a49TNq7+3oaZayWBcK7vxKo91a9k45udlvTCtrQlsr
         CRGmzh7YITLIHqGuNT1z+R884JxNWTgyNen4HuES1hU5EWI7JGDxPyugarqSWXbxSgx6
         ZxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840989; x=1776445789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdRLWuRnA9WFkshkxgv4Av+3azQPL66RiuSI1tP85uw=;
        b=dEz42+FA5Km66DXSPGJYA4v4+kG6jornguJYT9j1GRozZM1crhFKrA+/pvNifoqaEE
         kjrN6jiRoIfKcSdREElW7ye76mNkO4j/kuh6hsXCqVGBnCfiDImvBUauYbcY5WrNuA8J
         zHiMIgB79P+W/SaR44VQWNwjGIGOpWSij6tnMwj3fhH2+8LlMj3DfvhlRVSDWlLQRVRj
         R3MRGXO+kr2mC+9NIx0sGRGoELCtinvXG4k5JXT89kelco1aB82QM8wuD6nolA8N9d7W
         geFmRN0bcrxN69B+jZ0ydetlUg/vsTRgThlJx/hCDtV4Gu899vy0IT2EZJm+feQyDXPQ
         kCFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNQblG7vMzxO4rZAzn7vlI0b2WGMQQzdx52KpSL3fxgmMBga5H24RZ8/iSmMPmEqI4+Vqc2MLv136nQJme@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4vd5SCpP+44zYf/l3fhKudPBdvMMV7qSTE6tMMH3Z6BNn1p5
	TVa52ubhxLo+zUgEjLBF1Ib3AldLq+SxUZZO4DyJpY/4rzygTLjzGejvT77KXWrdz7fdbul9szV
	xd66SAj8u2DKzSsQq5/thpzaOoXDuGBE=
X-Gm-Gg: AeBDiesJ/Z2EN80TFBJe3XJe07sXaMUVBQ8iMz7McQdeWVtYA69D5gCFHAq2WnAmT19
	eDxRA+gVd8hh6V00OU8k1a0WgJQ+WBCwCLQGPAV4fI7qgVGwz+5stv/ipt0ouu+qvJmLE4NpdTy
	j352fmHj7XGk4aBTdjLf4HiGUaTYStxWzJ3At1BUyycknPJUxWUz1mmWp69/KkqZzBQ0NS1tsJ9
	w1EaQze0sJKxQv/UDfJ3omFHSn3/rneEuzoEv941bsDmpK2a9goKbuMrDNC9piKprJOyVqwgE+L
	s8MOXQ==
X-Received: by 2002:a5d:64e6:0:b0:43d:c75:9479 with SMTP id
 ffacd0b85a97d-43d642b6965mr6229236f8f.31.1775840988642; Fri, 10 Apr 2026
 10:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora>
In-Reply-To: <adiiTGjP1tqZfIrI@fedora>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Apr 2026 10:09:36 -0700
X-Gm-Features: AQROBzCpZMIPHwwS4vGwVuACseQ5RHtCi6FxKCwQuR_ShPf8SxJSWHzXmO8Ytvg
Message-ID: <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
Subject: Re: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with
 immediate teardown
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 12:21=E2=80=AFAM Horst Birthelmer <horst@birthelmer=
.de> wrote:
>
> On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
> > On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbernd.co=
m> wrote:
> > >
> > >
> > >
> > > On 10/21/25 23:33, Bernd Schubert wrote:
> > > > Do not merge yet, the current series has not been tested yet.
> > >
> > > I'm glad that that I was hesitating to apply it, the DDN branch had i=
t
> > > for ages and this patch actually introduced a possible fc->num_waitin=
g
> > > issue, because fc->uring->queue_refs might go down to 0 though
> > > fuse_uring_cancel() and then fuse_uring_abort() would never stop and
> > > flush the queues without another addition.
> > >
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
>
> In my case (Bernd mentioned that I was investigating a hang during umount=
)
> there were a lot of requests created during teardown, so what happened
> was very similar, but for exact the opposite reason.
> In fuse_uring_abort() queue_refs was already 0 due to an optimization
> where the ring teardown ran before fuse_abort_conn().

Hi Horst,

Just to clarify, is this with running locally patched changes on your
ddn kernel? In the upstream code I'm seeing that teardown is only
called by the abort path, eg fuse_abort_conn() -> fuse_uring_abort()
-> fuse_uring_stop_queues() -> teardown logic, so I'm not seeing how
it's possible for teardown to run before fuse_abort_conn(). Is there
something I'm missing?

> Thus the queue->stopped was never set.
>
> How do we make sure that fuse_uring_teardown_entries() has not been
> called by fuse_uring_async_stop_queues()?

If i'm understanding your question correctly, your question is what
ensures the teardown logic in fuse_uring_async_stop_queues() hasn't
already executed by the time we drop the queue lock after checking if
the queue has been stopped? In fuse_uring_async_stop_queues(), the
async teardown work gets continuously rescheduled so long as
queue_refs > 0. The ent holds a reference on the queue, so when the
queue lock is dropped that async teardown work will be continuously
running until it cleans up that (and any other) ents.

>
> Maybe I'm missing something?
>
> My fix was to remove the check for queue_refs > 0 in fuse_uring_abort()
> and make sure that even if the teardown was complete nothing bad happens
> in fuse_uring_abort_end_requests() and fuse_uring_stop_queues().

I'll look more at this path today.

Thanks,
Joanne
>
> Thanks,
> Horst
>
