Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1050C3B388F
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295438; cv=pass; b=SCAOGKpdwKDgp3LuESQAAwxYqZfuL/2fcEQ6SXTpAlJmH4xOcPyX6cEReN4y4+SVKK3Vq9hC7yOOdo2yrXkBxkDRohdwJZOuIRqEooVGXWp+7emvDHIic7LPeuE4RemfAbQCyEmMZXDoV+imnxrtDEfl+7ciRmBHV08ay2rXhFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295438; c=relaxed/simple;
	bh=qyiHK2/ASeiBkMIXi/yw7NU6bJA/4fYWST2az6s0Lho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRZ+8EQ7X/0MydFoGTbmGDBkxVaSLkuHEHYdyzyBXSJn2wSjetjVblRHtcPjjQIAewELZu9UwKeut7TVnDykt4qjaqcksbSoEmrElcoDHQprQD/ThSUPomH4WnOs6btpKtxNeEuhC57hwYKSzVRh3/DLMgiq5CUuA7dkSIPCKss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=reAhqEEP; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reAhqEEP"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so8476799f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 06:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777295435; cv=none;
        d=google.com; s=arc-20240605;
        b=kMJuTuiD+cmOck9NSyw2YwGfWwyXmKyIB7gJxwSuuV14VvD2cMJND2uyMhHPul5gyL
         TPJP2u2HX2USAizMTEWs32JbNlpbWVxJAm4Cdlq3uxwtIY005I8xia9q0B5MMvtqQwBQ
         yOLbTX15csubEZhf7FzNeRsWm3jCGamSz0JYSZdPWEXcmxcBDa0oDSPzS9Zg/FKFAFEk
         0Du7Y4nDqA9f3is6Kao+ZnGlXAMHa0PolWEluBBwW1rqv8EDgh/2KaMpgdIIH3ltBEV0
         hTETV5uR5IH9tBWyLF2vR5Eg9gz3DaXyelbZWbsv7I9Hz4nTM7K7VqfXBURh7c3r7+7r
         52hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qva2am8uIIt99COCdRZ/jc+YAhfz1SsH6B/9iKHxVOE=;
        fh=A6b1TU5KaBUw/OyqByaLyJ0IyIbUnxTIWtHGZgIui+0=;
        b=PFdHUa1QgtbBJf2AYI8faaozQ0a3UaXcVP2nRdOWRKoraZ3vDLQMxGeTYds2QtxJk+
         zoffiHFHbrhkQ6u2sskr0sxM76uvztcJWlzFxZOX4wKgjWQOtcvUDj+l+KNyDhFvAJvg
         6BjZvfYeSdGSctBWEtk68dVJ3j9O8M8dQ4cqED4Lq3zWqKMe1o/4mKNPbKQt8IKatHIK
         WUZeTG1xIia6N8tC51i6AfcOVIvGdXcJ8HJQcj86mzEl6zZchFQktv1RiDkfVPkZzwgD
         VyMpGrlaaI396lUgPmAjguAzRjVPGXWGq/g+mDpL6LvearCVe7BZnV21V2aErDZ/mKqh
         2liw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777295435; x=1777900235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qva2am8uIIt99COCdRZ/jc+YAhfz1SsH6B/9iKHxVOE=;
        b=reAhqEEPd2urIhek+lpz6IYg67hcCga7pePH9D75LGO2hhyEdvT8VrqF08ICeb/EKS
         fKOYaWurk0paRvBhBvIpNOixaLFjo9l4ZsX6u+Yp4x7d990DX7WFj6JxbGOvJ71H7Aqs
         HCec9E8SFiRYX4Yh5MUbp6EbEBQOSVZRI+/SpZ8XVNvd2I16YeuriWYdoDpM4MwRpNZ4
         d3T7onyzjBLeZdRD7O9+5K0eKugYjSCIr6Gi01BhAXaTPdAjaAyGy8ZpaaZxeJWpkO/M
         3yET3xJBLjXvTTcL1FX4UpDeFpw1EdhkieRSov8h0Tqalczmc10Nhrt+yhvufxArbPWs
         m4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295435; x=1777900235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qva2am8uIIt99COCdRZ/jc+YAhfz1SsH6B/9iKHxVOE=;
        b=oLftdxhYiZetN1mLgq5hE4MuuZy5H0LB2F8zsVN9axsPtP+ga0J5tHptefTs7Giqpm
         VeEyICQFuhPK04yEc95ZnFOaP6wJq8twZJOv2xRMCFMTWFntpBEyP40oqaGwtL1XitDs
         F6z7nkQd0ZClNELXL6Nw9HET+kmClaaiJO0+tIovbkiERk0/VyTrkQJ/wKRhCvZPVvg9
         NfbQxOflApbAM4Jr9+uTJVLPAwaEyd2hubp7/Sog1Ik3KfLexy8Z2mvONR7+hKhUYsOw
         2YpDLM8BCi5yo2uNT4OCmP6EK64DZiyxeaP4ulJGhCik5WCpc2q1nBJTYj/6bfqMJaZD
         gefg==
X-Forwarded-Encrypted: i=1; AFNElJ9YSNZRkbvZeFM5XIOJ2AhQEWSaSOdY993XeulnpXWCi0W9uC1uI0qUlOPVvyfDEkSl+a/6yJqd/+WUKnn3@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNw/KUDmY4t+pDG5Czj5MzvvwMWtDjnvyDmCGoPBezlh3E3nn
	hHdHexpVC1M7SuuRYrUpSoZLq66szRYiVkucnE4uSzSxLd3AbroE0AidoJwZM/fy+bkGG9T0oh8
	NTRdQl7XyMXBGk7ZynW3j8GzY6TmitYg=
X-Gm-Gg: AeBDietAPH/iCcA881Ql+YZQ2ueQmHl2AIf3mKFEh1dmpv1Mg+F0dO1jGH/pd5yZjDx
	2sw3U3BUEBUTzeW54J8/He8Ny14FJ7Gc/KytvT8iNMmqLQAf2OB6yEGwcw8QyPivy0Dzbqw2TtA
	y85Uw50LrLrMt2k+7hjoj9QugMfth1SJPqRYgBZF/Z8WnjoMvBBXdXQLwnCCLbLOdu3EJMRRATS
	NHM/VN1MgCwqJ1oJAjpC0aWD89TasiSi8dYXCiW3zfXTzxigdhiQpZqUh09SP4aANtvyDoH+Y2T
	Vm44kDpJj27FiUolMnSPJ46tQgq45MS+hA==
X-Received: by 2002:a05:6000:2888:b0:43d:762e:76ba with SMTP id
 ffacd0b85a97d-43fe3dc2eb1mr67036543f8f.17.1777295435002; Mon, 27 Apr 2026
 06:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-5-982b6414b723@bsbernd.com>
 <CAJnrk1aYYSVU-AdxRoqC5H8xk+4rt9Tf=3BPphsw4vvNxjpEyA@mail.gmail.com> <b7e93b2a-7096-4957-bf75-38e096a9dd3e@ddn.com>
In-Reply-To: <b7e93b2a-7096-4957-bf75-38e096a9dd3e@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Apr 2026 14:10:21 +0100
X-Gm-Features: AVHnY4It77PLkboA6lsRRCaO0uQr6jeD1Dk07z2l-uPjbcSOPnqf65uLS0ZeP9g
Message-ID: <CAJnrk1aL7xW1Z+=ns=zaOtjcUvOZMRR9icz72B9Ye7d0jYgDeQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] fuse: {io-uring} Allow reduced number of ring queues
To: Bernd Schubert <bschubert@ddn.com>
Cc: "bernd@bsbernd.com" <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Luis Henriques <luis@igalia.com>, 
	Gang He <dchg2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 11:01=E2=80=AFPM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> On 4/24/26 20:28, Joanne Koong wrote:
> > On Mon, Apr 13, 2026 at 2:41=E2=80=AFAM Bernd Schubert via B4 Relay
> > <devnull+bernd.bsbernd.com@kernel.org> wrote:
> >>
> >> From: Bernd Schubert <bschubert@ddn.com>
> >>
> >> Queues selection (fuse_uring_get_queue) can handle reduced number
> >> queues - using io-uring is possible now even with a single
> >> queue and entry.
> >>
> >> The FUSE_URING_REDUCED_Q flag is being introduce tell fuse server that
> >> reduced queues are possible, i.e. if the flag is set, fuse server
> >> is free to reduce number queues.
> >>
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >> ---
> >>  fs/fuse/dev_uring.c       | 160 ++++++++++++++++++++++++-------------=
---------
> >>  fs/fuse/inode.c           |   2 +-
> >>  include/uapi/linux/fuse.h |   3 +
> >>  3 files changed, 88 insertions(+), 77 deletions(-)
> >>
> >> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >> index 9dcbc39531f0e019e5abf58a29cdf6c75fafdca1..e68089babaf89fb81741e4=
a5e605c6e36a137f9e 100644
> >> --- a/fs/fuse/dev_uring.c
> >> +++ b/fs/fuse/dev_uring.c
> >>
> >> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_r=
ing *ring)
> >> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ri=
ng *ring)
> >>  {
> >>         unsigned int qid;
> >> -       struct fuse_ring_queue *queue;
> >> +       int node;
> >> +       unsigned int nr_queues;
> >> +       unsigned int cpu =3D task_cpu(current);
> >>
> >> -       qid =3D task_cpu(current);
> >> +       cpu =3D cpu % ring->max_nr_queues;
> >>
> >> -       if (WARN_ONCE(qid >=3D ring->max_nr_queues,
> >> -                     "Core number (%u) exceeds nr queues (%zu)\n", qi=
d,
> >> -                     ring->max_nr_queues))
> >> -               qid =3D 0;
> >> +       /* numa local registered queue bitmap */
> >> +       node =3D cpu_to_node(cpu);
> >> +       if (WARN_ONCE(node >=3D ring->nr_numa_nodes,
> >> +                     "Node number (%d) exceeds nr nodes (%d)\n",
> >> +                     node, ring->nr_numa_nodes)) {
> >> +               node =3D 0;
> >> +       }
> >>
> >> -       queue =3D ring->queues[qid];
> >> -       WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
> >> +       nr_queues =3D READ_ONCE(ring->numa_q_map[node].nr_queues);
> >> +       if (nr_queues) {
> >> +               qid =3D ring->numa_q_map[node].cpu_to_qid[cpu];
> >> +               if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
> >> +                       return NULL;
> >> +               return READ_ONCE(ring->queues[qid]);
> >> +       }
> >
> > Hi Bernd,
> >
> > Thanks for making the changes on this - I really like how much simpler
> > the logic is now.
> >
> > I'm looking through how the block multiqueue code works
> > (block/blk-mq.c and block/blk-mq-cpumap.c) because I think they
> > basically have to do the same thing with figuring out which cpu to
> > dispatch a request to.
> >
> > It looks like what they do is use group_cpus_evenly(), which as I
> > understand it, will partition CPUs taking into account numa nodes (as
> > well as clustering and SMT siblings). I think if we use this for fuse
> > io-uring, it will make things a lot simpler and we could get rid of
> > the per-numa state tracking (eg numa_q_map, registered_q_mask,
> > nr_numa_nodes)  and simplify queue selection where now that can just
> > be a cpu to qid lookup instead of a two-level
> > numa-then-global-fallback lookup.
> >
> > Do you think something like this makes sense?
>
> Maybe, I need to check that code. However, does this really need to be
> done right now? This cannot be updated later? For me it looks a bit like
> we are going to replace one code by another, without a clear advantage.
> I can look into group_cpus_evenly(), but I cannot promise you when that
> will happen.
> My personal preference would be to work on real issue, like getting rid
> of two locks (queue->lock and bg->lock) and distribute max_bg accross
> queues. And that probably requires the distribution across queues, which
> you didn't like in the previous series. Anway, already finding the time
> for that is hard.

Ok, we should go with what you have then and I'll submit changes as a
separate patch.

>
> My personal opinion is that queue selection needs to return the qid, so
> that the function can be overriden with eBPF. I didn't have time yet to
> try that out.
>
> >
> > Additionally, as I understand it, in this series, the ring->q_map
> > mapping has to get rebuilt every time a new queue gets created. What
> > do you think about just having the server declare the total queue
> > count upfront and then the mapping can just get established at ring
> > creation time? group_cpus_evenly() would only need to be called once,
> > the cpu_to_qid map would only have to be built once, and we could
> > avoid the rebuild-on-each-queue-creation complexity entirely. Do you
> > think something like this makes sense?
>
> That is why I said in another mail that a config SQE would make to some
> extend sense. However, the part where I disagree is that we could make
> it all entirely dynamic with the current approach.
> Only the logic for that in libfuse is missing. I.e. it _could_ start
> with a single queue or one queue per numa and one ring entry. Basically
> no memory usage then.
> And now libfuse could add logic - many small requests - set up ring
> entries with smaller payload size (or smaller pBuf). Many large requests
> - add more requests with larger payload size. And with the current
> approach queues can be added dynamically.

For registered buffers and zero copy, the queue count is needed up
front at registration time. imo it would be nice to have the
registration interface for these things be cohesive. Dynamic queues
could still be added in the future (eg server sends a new uring cmd to
add a queue, kernel rebuilds mapping, etc).

Thanks,
Joanne

>
>
> Thanks,
> Bernd
