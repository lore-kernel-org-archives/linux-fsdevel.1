Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC52868A7
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827284; cv=pass; b=RBqnKZnRmjNsdGvzCPne2Dw5e7MHSGUPaYZt57h4j5dUoL/fIengHVkvg4UAQGL2K+SSvLMKTOVpXpZueH42IVRIveU1dYDIpOc66hFuo1teyKs4B6syuGohsvmNGsV4BOHqwFMF0+fL1yfyzvaDBBSG4UtSiFjwi2kb89YXpKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827284; c=relaxed/simple;
	bh=8fQ8BWZmPSwh4bdtpg/8kD7kvYVzxB1dS+aP5ybbNxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjYfGkd1gIzSduDU+fsnnmAfXwvFKS3MB3C5+itayxTIqBTKUFK132/gryjCDk9ZLZUsBog0eDD9dEQKEK7bdmbjCc1zcT9IQkiKzLrl+J5k3s3/aMpFMS3VHT+xI78J8ZFXFfEN2SazQWQ7JIWUoOFMJaBAGEYzyFpMbg5gJ+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/L7LfNt; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/L7LfNt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso59534715e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 13:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779827281; cv=none;
        d=google.com; s=arc-20240605;
        b=l0pjcXJSPF81740+o3Cnd0vpZNYljBx+TD6zKmz8D6oJrDQ7H8khVVHo4XlJPDVEoI
         9gIlVUDulWBCq0bgefZAbmJ14oTiRVxUo8PjcEmynS5h8Iuuq2vpsDVYIs5wJGVM1ndO
         DDXl/ATcG7A+HyPrFwSVVgz28oszGBp5i7Y1QFyg3GYeDLDdhpUJTV3Jenx2QsjIUOzR
         cU9D90ZnB5s5MuP76J16Oi9eq0NWXu+LQLQZ9grtKso/2uO2nP/D9g6VijNaOkFhkMN1
         j4le5Hr5qWPu2kxIakmQvh1ESwxv05GnNN8gpe6nEJQLE/olE2Xbl2c9YTmM7t9uLHJk
         RW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0m8wCs3SjzJ/LtZeyVBgjUAWvRbr6Lt/h1FRuHrIfm0=;
        fh=ZeoS6nYw7rcli4sy9GS7kWMjo7OPFbkik5gRLSCTgkg=;
        b=lsH6oHuBZTNcYuf4h5EHrja+wxm/Ul0DfDbY6TgwJltCU5RJKeAsOWDoqTwOMv1Ov+
         FgaY7692AJi4vgi85PihuAxBIQtrCAcU+l0o2HUc4miPLTkG/ueLb8Yc9Uj1b3V6EfMT
         kV8VsRi2jUtMO69xQZftEk0yODCeeziQO41L8yV1bsPXtZxWIqyzs9z6OH8muklDv6//
         CW07ac7n6TMgC5chjLXU55nTKBrwgNzg1pqqUyJoA3/X/c6HkcBdqBQ7pendn5je1yRN
         uc2LTIm7CqC3EddA6qoqm7qMyluIbv2hIjoSdCIg2bK15yHzfqQWxnreK8AX17qmIyXr
         9kdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779827281; x=1780432081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m8wCs3SjzJ/LtZeyVBgjUAWvRbr6Lt/h1FRuHrIfm0=;
        b=M/L7LfNtiYNYZzh7+o3pvPqQrUMlYaO8CF4eoy07odwzOWibeVmi6xEbAn7Lk/eDOl
         1V/3/F+Oury/TiD5GhnUj46XC6DsIYpvGjKBl4CCeafrN9eZ2kJcsSoWQdhZroL0+kPT
         3Cou6dNxmw7hQM1BoaLYNhY/f/4iAoW7jpG+vN/tf2Bk9Z+IP0DErQoa/0iv7P0qqXcb
         8CDg3scTitKx0oYGqQQWOa3QhLHzcDqJv4Q9UohBJzx9fcNH9TuQBX/CTe3+0DVbaVRg
         b8h4gMEr5kirEQj3OB6oL/t5D4lSaqZYWq1Jw+lDNycKVH4gc/0LD6TsJX+0yfipHR6Q
         EepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827281; x=1780432081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0m8wCs3SjzJ/LtZeyVBgjUAWvRbr6Lt/h1FRuHrIfm0=;
        b=VvUo8HM8hy3J97PgRL1sx+N/YvY0B8k5QiBhhCQP1c2MRQnCFgf+Kz6ad7qd6qa5KO
         eHIGIGb2VjoDNEfMiql29dRvK5lB68J616r7KEJlXmOOuhiZHWWOR+d4xx+9z8Km+Lp+
         k65qQwixJMX6E3qrBOwE5WujI+8KRGRPDR82p35ZJmFO63NWFb3rwTWmff6Tj7vxT98J
         XYVhwFfX1uLYgqBjf2lrWWM4xttKVy/gXxNyksjJSeW2WpoPToNB2Wf6xkVCkx2Uhq85
         U5TWZ2eQnNv7G4Rh5vAqu9UBBiKnEj1C8aO2phGhGg+S/6723/tDLwL5PE4IvG7BOaqq
         GYBA==
X-Forwarded-Encrypted: i=1; AFNElJ+CHLSyaozXTGZk8tDYxo2tPUZjTjuZaseLAu1TVD/ojdrmYyDufBmx9L3HOE9QjZzQLhvTvlMAG8ibgSzQ@vger.kernel.org
X-Gm-Message-State: AOJu0YybuPOO+bj/pZAiIFgIrVu2EU4UCPVH9F16FpzMpI6X1YHnF5c8
	cGdKDDcEwUN2hs1zWhSEPLZaQWP1nUJC5FuHXlzvDf17pnj7YhxZ45lR6KtVQeD1Y3ZZluOY0fP
	LbRj7riNdLZahFleoAU4YwAAnt1bKoW4=
X-Gm-Gg: Acq92OEP0wR0gkveAOcuzujm00x8lrKYK+t5lIfSGaYAD2iMPAGkFYIlbUBpdYfc362
	LfI38DlERXHGqK2sfxfrkkIONnoBja1oP/LcfE8FkSm15Ncy+YK/gcsdzROOPPEaPc1/obfyW3H
	HIhcX2n36ZhsnbGGPG1b/YJP6vFus+g2ZYOXTu6t8hSQ1Sy6pnG2ZErRnxF8aaaj/XGUjT1zNaH
	wmkSM2vl/Lxgc05p8thORCN3ZExSUQhNrfkcQ0rnpQCV7bcOOZXOlvsd5oGKNiNkHAFuzuhwNKq
	hZkE9g==
X-Received: by 2002:a05:600c:6207:b0:490:538a:9c0b with SMTP id
 5b1f17b1804b1-4907dae371fmr29302855e9.2.1779827281038; Tue, 26 May 2026
 13:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com> <CAJnrk1ZVdWtGAiXLM+ax49jh6JOq5j0nvs8gQoS6HCV78hVGiA@mail.gmail.com>
In-Reply-To: <CAJnrk1ZVdWtGAiXLM+ax49jh6JOq5j0nvs8gQoS6HCV78hVGiA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 26 May 2026 13:27:49 -0700
X-Gm-Features: AVHnY4LSemBC4GOtgWwOGOUJLSd9037LXAhDMaYC4a1mhXH7hAwFuVLzkbsLElI
Message-ID: <CAJnrk1ZjHMBY3g08aEffp6h4KuK=Du=8GKVKuq=g3nrYTonyCg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] fuse: {io-uring} Allow to reduce the number of
 queues and request distribution
To: bernd@bsbernd.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 9:15=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Apr 13, 2026 at 10:41=E2=80=AFAM Bernd Schubert via B4 Relay
> <devnull+bernd.bsbernd.com@kernel.org> wrote:
> >
> > This adds bitmaps that track which queues are registered and which queu=
es
> > do not have queued requests.
> > These bitmaps are then used to map from request core to queue
> > and also allow load distribution. NUMA affinity is handled and
> > fuse client/server protocol does not need changes, all is handled
> > in fuse client internally.
> >
> > Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > ---
> > Changes in v4:
> > - Fix leak of ring->numa_q_map
> > - Fix q-imbalance due to an issue in static cpu->qid mapping
> > - Performance tunings, like preferring the current cpu
> > - Removal of distribution among queues, Joanne had concerns about it.
> >   As it is an optimization, it can be added later again. At least
> >   most of it was removed, some light distribution is still left in.
> > - Link to v3: https://lore.kernel.org/r/20251013-reduced-nr-ring-queues=
_3-v3-0-6d87c8aa31ae@ddn.com
> >
> > Changes in v3:
> > - removed FUSE_URING_QUEUE_THRESHOLD (Luis)
> > - Fixed accidentaly early return of queue1 in fuse_uring_best_queue()
> > - Fixed similar early return 'best_global'
> > - Added sanity checks for cpu_to_node()
> > - Removed retry loops in fuse_uring_best_queue() for code simplicity
> > - Reduced local numa retries in fuse_uring_get_queue
> > - Added 'FUSE_URING_REDUCED_Q' FUSE_INIT flag to inform userspace
> >   about the possibility to reduced queues
> > - Link to v2: https://lore.kernel.org/r/20251003-reduced-nr-ring-queues=
_3-v2-0-742ff1a8fc58@ddn.com
> > - Removed wake-on-same cpu patch from this series,
> >   it will be send out independently
> > - Used READ_ONCE(queue->nr_reqs) as the value is updated (with a lock b=
eing
> >   hold) by other threads and possibly cpus.
> >
> > ---
> > Bernd Schubert (8):
> >       fuse: {io-uring} Add queue length counters
> >       fuse: {io-uring} Rename ring->nr_queues to max_nr_queues
> >       fuse: {io-uring} Use bitmaps to track registered queues
> >       fuse: Fetch a queued fuse request on command registration
> >       fuse: {io-uring} Allow reduced number of ring queues
> >       fuse: {io-uring} Queue background requests on a different core
> >       fuse: Add retry attempts for numa local queues for load distribut=
ion
> >       fuse: {io-uring} Prefer the current core over mapping
>
> Thank you for your work and time on this series, Bernd. Our internal
> customers will definitely be using this feature.
>
> I left a few comments on your patches but they could all be deferred
> to the future as follow-ups. The only thing I think that needs to be
> figured out now is whether userspace passes in queue count upfront at
> registration time and requests are gated until the queues have
> completed set up.

Hi Bernd,

Do you have an ETA for when you'll be sending out the next version? If
it takes too much time/bandwidth for some of the changes, I'm happy if
this series just makes the upai-facing change for userspace to pass in
the number of queues upfront at registration time as per the
conversation in [1], and everything else gets landed as-is. I can
submit the follow-up changes after that. Our internal users have been
waiting for this since v1 from last year and we're hoping this gets
unblocked as soon as possible.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1by9O1JBH5W9jvkgYcBZK_t7nxz=
eSsmxm65jb4=3Dwv-ikQ@mail.gmail.com/#t

>
> Thanks,
> Joanne
>
> >
> >  fs/fuse/dev_uring.c       | 303 ++++++++++++++++++++++++++++++++++----=
--------
> >  fs/fuse/dev_uring_i.h     |  25 +++-
> >  fs/fuse/inode.c           |   2 +-
> >  include/uapi/linux/fuse.h |   3 +
> >  4 files changed, 252 insertions(+), 81 deletions(-)
> > ---
> > base-commit: 028ef9c96e96197026887c0f092424679298aae8
> > change-id: 20250722-reduced-nr-ring-queues_3-6acb79dad978
> >
> > Best regards,
> > --
> > Bernd Schubert <bernd@bsbernd.com>
> >
> >
