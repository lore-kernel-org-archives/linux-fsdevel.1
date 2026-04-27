Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2763264FE
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302636; cv=pass; b=tNXCYH0mmvUJEhyYSjS/J4nJLIQOkR3J6jt/gGFsjh2hE38V7MowxNr6gXB+2NsBY4U3gLw+Z90qbvcygeH745H5atJc2oX3uIt2Lrb01KnfFfffrcHHVAXwyXZ36whdsEFMEgpXjzFbJVjUo6XHrlhYkzKesk+efAbnPfgBQls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302636; c=relaxed/simple;
	bh=9vcKBXMQPRkmwk+vPuT9zuFZdcI2+HLp2EqOAKdwOaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEL0EHS+PbbuI+Kv+chvYxIonZH6mrK2WNAUyPsQLOahi1YGHrC26nSRKXTHYFo/P9oFn8qKXAqsBsvLpF1/h67BetbbcEsQ5BDts5uzzhD4WzxjBq8teEnaf/aa99qaFamwuZ8VCwUtuzdu2h+kexES6bS/+i0aGp4zaEPvX4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4cmIQlx; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4cmIQlx"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d7650202fso7878249f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 08:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777302633; cv=none;
        d=google.com; s=arc-20240605;
        b=kjbYFvMUKlFyFk9+xTg9PHoNw8VahNTIMbwW6WN0vOFfEvTWAZ0ub6muB+WlOAOkCy
         mZENozjpicx/bDADv8pJoyFYxMhBrsAg9iDcXNAYtHUzwPO7KJxgTAd3JqVUu1+Kj9UI
         YxehoOtrbsjAUeD4oUxvQFBeDDdkqr6ZSPHu4MyDpcl4zbJZKDnQtVxsZ31UVsmkn7+P
         eCZKF7e8aE21D1oJ10p9TJ+iLmyHq6EzjkdoX3Z89MMsjJJsmD9//KYxuUvFPnC8EA/F
         k+qMg/POujNT12cwoUYAaJj2KYUy8EY3PGJK6g/yE50Vytu4EU8FJnLTIfYhpq8RFzTV
         Njmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pdGS9/vASJn5ssUfOgaEIHlBL65wpHYCb1ML+lehcGk=;
        fh=QhHHEPvlWXDGaDGY7ON6HzsZZSgZ8Kj3v9ytFAZtQSs=;
        b=RW3lLKdbvFuTQOsPKU6vbhppDdesLJrWbiggs84LjVpHkPv4XIwx3OVe9d2dyoz8z4
         hHd640AXAewqcG2FSs7fmRPUcWr0Q8bxWUYGyqfaGctXMKPZkIMm2Leh1MWhDKrNVME4
         gb9p3g14n2G3HdY2JGbII1VlPgxQBTm/khbsfQm4j5hPWHl9HRb6/C6PCYV9SdsVbj++
         eFgFePk8KlhrOuCghdYCpn/6NrjLbxMtOHk+/fH5TvWoKGXwju4cDlnfIOTYBNVEunbw
         Kaa1nmrOmwr8ztIgEO4Br+mRkD59yO6yrpdqx4hPVEdHc/u2p5JoMkEwayNYFxW8MhPZ
         By/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777302633; x=1777907433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdGS9/vASJn5ssUfOgaEIHlBL65wpHYCb1ML+lehcGk=;
        b=Y4cmIQlxxPuX6aBeUzgiwIGrORwUEt78AtQsVuWpiqLOiGpPiax8+2jB92CNT3tNro
         mzX5aqxOZ/zl3sHHfCUvssKeGnGaeE30I0UjvutUK1cMjDkFOYKA+mletl3hNSZO1HTr
         20ZrWOr3PsinyToym1PSzTauKfCnfUvXIItedpOeZs0/Y68KgrWayew3NajZR0MvV6hh
         cSUc/uc83g07wNfGBM214jqXCXvs+jXzno7K9MnhXu1hsbTUoGSLaer9iG8K77VXSr1h
         PFqcRUfzS8wVzBykr/6yrNFHR3bhOEKzkvKE1nmHOqy5x07BS55gBnyjd2mUXGxoeaip
         rW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302633; x=1777907433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pdGS9/vASJn5ssUfOgaEIHlBL65wpHYCb1ML+lehcGk=;
        b=T0udvWJX390U60VsTFvfVIXq8Rpb0dRBM58QQE49su1pFuD3cmRedCUeLhuzvfSibi
         qjbRhmU0XQT3JcSGIAAuKxRJisqkhw3X65JzVVdKG4EtYkzOQ5ohGGBX4JFu87u7Htev
         na+Bfig+4mitLsDnZOd1bf/RANFzBOc+jY1nFdpmPdEko88dUnfqwOzhu/vOBgiILvbY
         qqCS+KDpd3H4deXRW6Uu9zMQ3zcI67IAb0GllY2Urd0rhzHIQcS+Uc0ypgrne4R+MP9a
         nY3yDLkaLfhcl0QYptVyu+KgKGIlCvObg434rn8PlyUbawoRiTD4vJxy3MLW4thujeT4
         x0iA==
X-Forwarded-Encrypted: i=1; AFNElJ/YRY+WGmeRhseumHaAJO2Qt8QMhzAWqSzHmU2WWq4C8Ez4zKztgJ2N6pOYR60q92JdAjKw8CKajZPG6oHr@vger.kernel.org
X-Gm-Message-State: AOJu0YzALIPnRZOQTN4QGqsB8qNwdK+PSWHuCdQyl80WnaIcfxcnEYfX
	b9HqonG9A3YXkf9BqlwEufaqESdkY3Z+aqQwAlycJK/Q+dcZPyBgbDzfUBeq11QiYXNmqc2s3n4
	N1e/3NR6byHgM794Tr/FCAC8TZwQJzcM=
X-Gm-Gg: AeBDiesJVxUaSzqM6qCiijP7Q/Q4R/sdIptGmInl3xb9bo3qcBfiFt3J9mrF8xYcjL9
	a8rz4GjyiLHjzYSrlfY98XRu4s5qF2iBlwPfgSun/LNt4VyFxF9yGRpY8ZzkaIYRAnfbnp77kZQ
	1X7nz9IXWnjcg2xbCFGM66YoXTzbBX5GO/yQqoer3Mi1RcO+0AFiRVN48MuoK24KFWZKyK/iatc
	tMbrakLoWHJHrpaFwBAzymWhGE3PBtTZwm6FirEUYkYndVvF3LoQ+rKCqF0Dm7eVq/N9wzVqdp7
	2ewCFsUP9uYiVsgCzV4Kk/MoBp41/Ng=
X-Received: by 2002:a05:6000:22c5:b0:43c:f66e:f24 with SMTP id
 ffacd0b85a97d-43fe3e14e52mr65840345f8f.35.1777302632919; Mon, 27 Apr 2026
 08:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-5-982b6414b723@bsbernd.com>
 <CAJnrk1aYYSVU-AdxRoqC5H8xk+4rt9Tf=3BPphsw4vvNxjpEyA@mail.gmail.com>
 <b7e93b2a-7096-4957-bf75-38e096a9dd3e@ddn.com> <CAJnrk1aL7xW1Z+=ns=zaOtjcUvOZMRR9icz72B9Ye7d0jYgDeQ@mail.gmail.com>
 <e5a181d4-635f-4b91-b49a-e8d34b16f495@bsbernd.com> <CAJnrk1Z1HgPXLzfcKMhOKjdZzcjuXbRH4de+4zQpoqvhSB=A-g@mail.gmail.com>
 <981c9f40-5555-4f3c-89c0-cd120c6fc768@bsbernd.com>
In-Reply-To: <981c9f40-5555-4f3c-89c0-cd120c6fc768@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Apr 2026 16:10:18 +0100
X-Gm-Features: AVHnY4JGOfLSAkV5CvNqJkTcJerPpvrcIalNJKqXegCcWQDuk2YXJq1FThRqbo4
Message-ID: <CAJnrk1bRYqXyp0uhQYLUG1FV_bgA5B8Oxe9g9vVK3-GojqNURg@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] fuse: {io-uring} Allow reduced number of ring queues
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Luis Henriques <luis@igalia.com>, 
	Gang He <dchg2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 3:42=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
> On 4/27/26 16:10, Joanne Koong wrote:
> > On Mon, Apr 27, 2026 at 2:49=E2=80=AFPM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> >>
> >> On 4/27/26 15:10, Joanne Koong wrote:
> >>> On Fri, Apr 24, 2026 at 11:01=E2=80=AFPM Bernd Schubert <bschubert@dd=
n.com> wrote:
> >>>>
> >>>> On 4/24/26 20:28, Joanne Koong wrote:
> >>>>> On Mon, Apr 13, 2026 at 2:41=E2=80=AFAM Bernd Schubert via B4 Relay
> >>>>> <devnull+bernd.bsbernd.com@kernel.org> wrote:
> >>>>>>
> >>>>>> From: Bernd Schubert <bschubert@ddn.com>
> >>>>>>
> >>>>>> Queues selection (fuse_uring_get_queue) can handle reduced number
> >>>>>> queues - using io-uring is possible now even with a single
> >>>>>> queue and entry.
> >>>>>>
> >>>>>> The FUSE_URING_REDUCED_Q flag is being introduce tell fuse server =
that
> >>>>>> reduced queues are possible, i.e. if the flag is set, fuse server
> >>>>>> is free to reduce number queues.
> >>>>>>
> >>>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >>>>>> ---
> >>>>>>  fs/fuse/dev_uring.c       | 160 ++++++++++++++++++++++++---------=
-------------
> >>>>>>  fs/fuse/inode.c           |   2 +-
> >>>>>>  include/uapi/linux/fuse.h |   3 +
> >>>>>>  3 files changed, 88 insertions(+), 77 deletions(-)
> >>>>>>
> >>>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >>>>>> index 9dcbc39531f0e019e5abf58a29cdf6c75fafdca1..e68089babaf89fb817=
41e4a5e605c6e36a137f9e 100644
> >>>>>> --- a/fs/fuse/dev_uring.c
> >>>>>> +++ b/fs/fuse/dev_uring.c
> >>>>>>
> >>>>>> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fu=
se_ring *ring)
> >>>>>> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fus=
e_ring *ring)
> >>>>>>  {
> >>>>>>         unsigned int qid;
> >>>>>> -       struct fuse_ring_queue *queue;
> >>>>>> +       int node;
> >>>>>> +       unsigned int nr_queues;
> >>>>>> +       unsigned int cpu =3D task_cpu(current);
> >>>>>>
> >>>>>> -       qid =3D task_cpu(current);
> >>>>>> +       cpu =3D cpu % ring->max_nr_queues;
> >>>>>>
> >>>>>> -       if (WARN_ONCE(qid >=3D ring->max_nr_queues,
> >>>>>> -                     "Core number (%u) exceeds nr queues (%zu)\n"=
, qid,
> >>>>>> -                     ring->max_nr_queues))
> >>>>>> -               qid =3D 0;
> >>>>>> +       /* numa local registered queue bitmap */
> >>>>>> +       node =3D cpu_to_node(cpu);
> >>>>>> +       if (WARN_ONCE(node >=3D ring->nr_numa_nodes,
> >>>>>> +                     "Node number (%d) exceeds nr nodes (%d)\n",
> >>>>>> +                     node, ring->nr_numa_nodes)) {
> >>>>>> +               node =3D 0;
> >>>>>> +       }
> >>>>>>
> >>>>>> -       queue =3D ring->queues[qid];
> >>>>>> -       WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
> >>>>>> +       nr_queues =3D READ_ONCE(ring->numa_q_map[node].nr_queues);
> >>>>>> +       if (nr_queues) {
> >>>>>> +               qid =3D ring->numa_q_map[node].cpu_to_qid[cpu];
> >>>>>> +               if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
> >>>>>> +                       return NULL;
> >>>>>> +               return READ_ONCE(ring->queues[qid]);
> >>>>>> +       }
> >>>>>
> >>>>> Hi Bernd,
> >>>>>
> >>>>> Thanks for making the changes on this - I really like how much simp=
ler
> >>>>> the logic is now.
> >>>>>
> >>>>> I'm looking through how the block multiqueue code works
> >>>>> (block/blk-mq.c and block/blk-mq-cpumap.c) because I think they
> >>>>> basically have to do the same thing with figuring out which cpu to
> >>>>> dispatch a request to.
> >>>>>
> >>>>> It looks like what they do is use group_cpus_evenly(), which as I
> >>>>> understand it, will partition CPUs taking into account numa nodes (=
as
> >>>>> well as clustering and SMT siblings). I think if we use this for fu=
se
> >>>>> io-uring, it will make things a lot simpler and we could get rid of
> >>>>> the per-numa state tracking (eg numa_q_map, registered_q_mask,
> >>>>> nr_numa_nodes)  and simplify queue selection where now that can jus=
t
> >>>>> be a cpu to qid lookup instead of a two-level
> >>>>> numa-then-global-fallback lookup.
> >>>>>
> >>>>> Do you think something like this makes sense?
> >>>>
> >>>> Maybe, I need to check that code. However, does this really need to =
be
> >>>> done right now? This cannot be updated later? For me it looks a bit =
like
> >>>> we are going to replace one code by another, without a clear advanta=
ge.
> >>>> I can look into group_cpus_evenly(), but I cannot promise you when t=
hat
> >>>> will happen.
> >>>> My personal preference would be to work on real issue, like getting =
rid
> >>>> of two locks (queue->lock and bg->lock) and distribute max_bg accros=
s
> >>>> queues. And that probably requires the distribution across queues, w=
hich
> >>>> you didn't like in the previous series. Anway, already finding the t=
ime
> >>>> for that is hard.
> >>>
> >>> Ok, we should go with what you have then and I'll submit changes as a
> >>> separate patch.
> >>>
> >>>>
> >>>> My personal opinion is that queue selection needs to return the qid,=
 so
> >>>> that the function can be overriden with eBPF. I didn't have time yet=
 to
> >>>> try that out.
> >>>>
> >>>>>
> >>>>> Additionally, as I understand it, in this series, the ring->q_map
> >>>>> mapping has to get rebuilt every time a new queue gets created. Wha=
t
> >>>>> do you think about just having the server declare the total queue
> >>>>> count upfront and then the mapping can just get established at ring
> >>>>> creation time? group_cpus_evenly() would only need to be called onc=
e,
> >>>>> the cpu_to_qid map would only have to be built once, and we could
> >>>>> avoid the rebuild-on-each-queue-creation complexity entirely. Do yo=
u
> >>>>> think something like this makes sense?
> >>>>
> >>>> That is why I said in another mail that a config SQE would make to s=
ome
> >>>> extend sense. However, the part where I disagree is that we could ma=
ke
> >>>> it all entirely dynamic with the current approach.
> >>>> Only the logic for that in libfuse is missing. I.e. it _could_ start
> >>>> with a single queue or one queue per numa and one ring entry. Basica=
lly
> >>>> no memory usage then.
> >>>> And now libfuse could add logic - many small requests - set up ring
> >>>> entries with smaller payload size (or smaller pBuf). Many large requ=
ests
> >>>> - add more requests with larger payload size. And with the current
> >>>> approach queues can be added dynamically.
> >>>
> >>> For registered buffers and zero copy, the queue count is needed up
> >>> front at registration time. imo it would be nice to have the
> >>> registration interface for these things be cohesive. Dynamic queues
> >>> could still be added in the future (eg server sends a new uring cmd t=
o
> >>> add a queue, kernel rebuilds mapping, etc).
> >>
> >> And that cannot be _max_ number of queues for registered buffers?
> >
> > For registered buffers / zero copy, the buffer is contiguously
> > allocated by the server up front, passed to the kernel, and then
> > pinned. Our servers want to use registered buffers/zero copy with less
> > queues than the number of cpus on the machine.
>
> If the buffer is associated with queue, queues still can be registered
> dynamically? I don't say that your should be forced to do dynamic
> queues, it is just that the current reduced queue patches allow to have
> that. And with pBuf I don't see why it shouldn't work either.

I got the buffer pinning mixed up with dynamic queue ents, not dynamic
queues. I reread your patch and it would be compatible with the
registered buffers interface. Dyanmic queues would work with
group_cpus_evenly() as well I believe, we would just need to rebuild
the cpu-to-qid mapping for each new queue, but this seems ok since
it's a fixed registration cost.

Thanks,
Joanne

>
> Thanks,
> Bernd
