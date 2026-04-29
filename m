Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412A377EBC
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777480365; cv=pass; b=Ld+DVd7Ggvr6NqCVUZ+m1brQ9JgGkbGw3XdUwvF5xNlbdahKJDT9ChAevYFTNCNqw827LmIi++yllLpQs3quQrXL/cX9Nxhxi/wua7pRaA3vsbr/1EyNtiPca34mzAJ5c6W1YUEi7LI3GwLsKTOfAAvcD491/vxfC1jIXfjdB+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777480365; c=relaxed/simple;
	bh=NGjY7d20JrIs6lzlvMZT5zTwORqueNVkq9xXuZOzIeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EB8Xr8EhoxyP5IsDpaX2s98MeizmH2xH/Iv+quNcCNm26wMFVs6k0bEJWxkjr92mnpaHRdhUviRPwRp6UIghXejgGPTpP4Q1ctyJd4dF4T/onMMjYObrvetJ3gc9iffh2dvJ1H+oaK3t6Ot1Bi3lbS7lIEFfW1R8G49IKI8rG7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3gqmdut; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3gqmdut"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891cd41959so111755175e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 09:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777480362; cv=none;
        d=google.com; s=arc-20240605;
        b=C9x1VbbX/08ewdYobhLNMJSPzhcISszWRd+lGgoMSq1ZSYQ4I11ly1oYxTRFOL2+PG
         XUgOnQ5clTalWyDptLdWrWLfxzH7RGVfeAHKdh2nIOCjgLAphBJl6cU3kVHwPiw8Cgf7
         UmkxLTFB6v3t9EJXYEkaw5u528GHEETrnwbSJKKKpt5BbyPLC3Ar1ZhMLsMwkyCTlY29
         qnxyggSa1JlVRAGgRUZN064DKjjvGsYCCYGpMfQnXCpAKao+FXU1fLsGR2scqiWq/1+6
         YbLT9ZAmmDJ/AUrlN6z+2G1nuu2ucaDd0v6nUjEyl7RtayHFJsy7jW1QN9pCJrUXQDeZ
         j6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9DjBdLtDPV/Pbs8gHt0kv/uul3/OW0C5u/zsfKVbA+Y=;
        fh=+FLGYAHxNChktO0YOIYKBRK5HbGoQ1VAaczUiF1JGdc=;
        b=Sgmor3v0P4WnyeNfmhs4z02rNhzRMsxYAFqa4J0HVNir4IoT0kPiWNa2ZgzQ5wc8CU
         nChyMxv1h1sFy0pqVtB4/cBDApe7jFM/kJ2+mXZThz4PxHu32ZIH6VY6Xjwf/LyioVg0
         5mgpUHXJPYuSZjqIK6cc585TRlcV1K0P3JBYQ1iV1hsnqJ11EdTdGWyeDHa2zuSY/JDp
         nP9FxoY0Chhp6z+a2dZsHys4VF4UVkDPA+d9yLxAol8LlAJKku4/OHA+RoD/VKSbao2M
         PZG45IG1s9HenyuuEeWesxFUzYlEbCz4YMmw/QipeEeAAvCNwH1OIU6iEdUf3kVQS+fX
         Thug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777480362; x=1778085162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DjBdLtDPV/Pbs8gHt0kv/uul3/OW0C5u/zsfKVbA+Y=;
        b=I3gqmdutpwgtzcNdaN3O5kb8pB2VehC/aWLX6faRqdNHNsWNVqG3bnznUSCeqKIP8B
         Zg8ZJfAWtv4xdnCgUFUO4EBbqtRss44MNuOp0lvXsi+sOvpq+5ngCnXXxRZyt51wzQCg
         Kt+B5JjHkKLE9GWq8bebbUOGwv6TgAD8T1T4eVEAwGDMcKV7DfeViSUUevIUPORnnrjq
         plmnVSvz4rxxvEJ0NfYYlzVbICHwBRDIbWXQZ5uETqjaWkufWwUWAEv/4ZLyirrKEZK4
         73rj5DC/hnSUhfSDs+3grprs083IEmFS9/sWLEAOlqG9yI0ZTeRHjG9tSkfrteVzJ0TB
         33Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777480362; x=1778085162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9DjBdLtDPV/Pbs8gHt0kv/uul3/OW0C5u/zsfKVbA+Y=;
        b=Ula1HNy78YA593X5qEoZW8k8WSsO9KeJzH0aKabblyWZyMq/hpHAK8Ne4qgVjT4pA2
         q3p3nFVOu7NXJ0vz61H7vI+iIAl2aW1Q8aI1po8jbIwxwfkwWJS/azaf9Q7aUtRPO8H1
         h0mPKpitmyvhnPndlQrJ7LPBU0YvDzYqkFB6TX+f+1qUnG0iy3D4bAanDHROHWDEEqXD
         21Ab0Mq05zSmudnttNvrIAlOq8+niP6H8ESo8vPCyzT2Im2TWNqWuXmQwA60XCdiUWBo
         JwlfsIqpNMiJWlRVdfG1zDFC20U1eWAH/W8xxhxG+av7iurEwfC+hBTuzzuZ1dlRC/h0
         MLLg==
X-Forwarded-Encrypted: i=1; AFNElJ/ki9rH4f8L6vOFKh0L+NUVjTqm7rWfJc8XxPOMq8QtGs/UmYiw2bD9KdNqZ9YyjMha0MaerLSTG8PMn+I0@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1FRZOlaI7Heer3gYuZWypBxAC36ocTPgewLUrYOE5u8AKuIn
	e45BMAY2nES+ZSPR82W8Jc8ENgC9j2RD6dW2AZMiSdvuTvQZJp4H5ABzkOQdPAEm9ekwfsdnibG
	2QqP1+F3LqoMnM/iQ/NBr1VaHICm7GU0=
X-Gm-Gg: AeBDieunzVvSZcmrXTNe88fWrw1/V7kD6X2b0Cfe5vMhNopxd9g7qhKQJZF/KHtHt9M
	YDENmI4w9YcS5oVNRno3HaZyBa78HzCmYk8Ra5sDX3mmSs7EVscynZ0/lb0MGI3sMYrOFO5w6fW
	UyPgVUgzWqdcWr2Li+3sqYxGcmIWzGDO0T8VS4JQ8vE8bBGB/QsNFirIMssbERQPwJBD4zNpqV1
	+63I84VaN2pO/w4ejd6fYjqvFKTqaFD1I1f5GnOGAWGH9MPM8tMEJn8MyfyrlahR05XL/vJ2BcS
	WvQyH9bAwxZEKH2clFM4EfGy4bEfkdnrytK5Ku59r+Mx
X-Received: by 2002:a05:600d:19:b0:488:9ed3:1492 with SMTP id
 5b1f17b1804b1-48a77ae0202mr101445845e9.10.1777480362118; Wed, 29 Apr 2026
 09:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-5-982b6414b723@bsbernd.com>
 <CAJnrk1aYYSVU-AdxRoqC5H8xk+4rt9Tf=3BPphsw4vvNxjpEyA@mail.gmail.com>
 <b7e93b2a-7096-4957-bf75-38e096a9dd3e@ddn.com> <CAJnrk1by9O1JBH5W9jvkgYcBZK_t7nxzeSsmxm65jb4=wv-ikQ@mail.gmail.com>
 <0a56969c-7fe6-428a-8eb5-6df5e61ff03f@ddn.com>
In-Reply-To: <0a56969c-7fe6-428a-8eb5-6df5e61ff03f@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 29 Apr 2026 17:32:27 +0100
X-Gm-Features: AVHnY4IqqkTWbvSM9890F0rvTMS6YuUlJYoQD43qHLuQ8xuQW6jagzThlA8af60
Message-ID: <CAJnrk1ZFPr5AKULqMwz2ym3i9W9cJCQU7pFzF=FwOb-TtA8fxA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] fuse: {io-uring} Allow reduced number of ring queues
To: Bernd Schubert <bschubert@ddn.com>
Cc: "bernd@bsbernd.com" <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Luis Henriques <luis@igalia.com>, 
	Gang He <dchg2000@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 5:24=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
>
>
> On 4/29/26 18:10, Joanne Koong wrote:
> > On Fri, Apr 24, 2026 at 11:01=E2=80=AFPM Bernd Schubert <bschubert@ddn.=
com> wrote:
> >>
> >> On 4/24/26 20:28, Joanne Koong wrote:
> >>> On Mon, Apr 13, 2026 at 2:41=E2=80=AFAM Bernd Schubert via B4 Relay
> >>> <devnull+bernd.bsbernd.com@kernel.org> wrote:
> >>>>
> >>>> From: Bernd Schubert <bschubert@ddn.com>
> >>>>
> >>>> Queues selection (fuse_uring_get_queue) can handle reduced number
> >>>> queues - using io-uring is possible now even with a single
> >>>> queue and entry.
> >>>>
> >>>> The FUSE_URING_REDUCED_Q flag is being introduce tell fuse server th=
at
> >>>> reduced queues are possible, i.e. if the flag is set, fuse server
> >>>> is free to reduce number queues.
> >>>>
> >>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >>>> ---
> >>>>  fs/fuse/dev_uring.c       | 160 ++++++++++++++++++++++++-----------=
-----------
> >>>>  fs/fuse/inode.c           |   2 +-
> >>>>  include/uapi/linux/fuse.h |   3 +
> >>>>  3 files changed, 88 insertions(+), 77 deletions(-)
> >>>>
> >>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >>>> index 9dcbc39531f0e019e5abf58a29cdf6c75fafdca1..e68089babaf89fb81741=
e4a5e605c6e36a137f9e 100644
> >>>> --- a/fs/fuse/dev_uring.c
> >>>> +++ b/fs/fuse/dev_uring.c
> >>>>
> >>>> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse=
_ring *ring)
> >>>> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_=
ring *ring)
> >>>>  {
> >>>>         unsigned int qid;
> >>>> -       struct fuse_ring_queue *queue;
> >>>> +       int node;
> >>>> +       unsigned int nr_queues;
> >>>> +       unsigned int cpu =3D task_cpu(current);
> >>>>
> >>>> -       qid =3D task_cpu(current);
> >>>> +       cpu =3D cpu % ring->max_nr_queues;
> >>>>
> >>>> -       if (WARN_ONCE(qid >=3D ring->max_nr_queues,
> >>>> -                     "Core number (%u) exceeds nr queues (%zu)\n", =
qid,
> >>>> -                     ring->max_nr_queues))
> >>>> -               qid =3D 0;
> >>>> +       /* numa local registered queue bitmap */
> >>>> +       node =3D cpu_to_node(cpu);
> >>>> +       if (WARN_ONCE(node >=3D ring->nr_numa_nodes,
> >>>> +                     "Node number (%d) exceeds nr nodes (%d)\n",
> >>>> +                     node, ring->nr_numa_nodes)) {
> >>>> +               node =3D 0;
> >>>> +       }
> >>>>
> >>>> -       queue =3D ring->queues[qid];
> >>>> -       WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
> >>>> +       nr_queues =3D READ_ONCE(ring->numa_q_map[node].nr_queues);
> >>>> +       if (nr_queues) {
> >>>> +               qid =3D ring->numa_q_map[node].cpu_to_qid[cpu];
> >>>> +               if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
> >>>> +                       return NULL;
> >>>> +               return READ_ONCE(ring->queues[qid]);
> >>>> +       }
> >>>
> >>> Hi Bernd,
> >>>
> >>> Thanks for making the changes on this - I really like how much simple=
r
> >>> the logic is now.
> >>>
> >>> I'm looking through how the block multiqueue code works
> >>> (block/blk-mq.c and block/blk-mq-cpumap.c) because I think they
> >>> basically have to do the same thing with figuring out which cpu to
> >>> dispatch a request to.
> >>>
> >>> It looks like what they do is use group_cpus_evenly(), which as I
> >>> understand it, will partition CPUs taking into account numa nodes (as
> >>> well as clustering and SMT siblings). I think if we use this for fuse
> >>> io-uring, it will make things a lot simpler and we could get rid of
> >>> the per-numa state tracking (eg numa_q_map, registered_q_mask,
> >>> nr_numa_nodes)  and simplify queue selection where now that can just
> >>> be a cpu to qid lookup instead of a two-level
> >>> numa-then-global-fallback lookup.
> >>>
> >>> Do you think something like this makes sense?
> >>
> >> Maybe, I need to check that code. However, does this really need to be
> >> done right now? This cannot be updated later? For me it looks a bit li=
ke
> >> we are going to replace one code by another, without a clear advantage=
.
> >> I can look into group_cpus_evenly(), but I cannot promise you when tha=
t
> >> will happen.
> >> My personal preference would be to work on real issue, like getting ri=
d
> >> of two locks (queue->lock and bg->lock) and distribute max_bg accross
> >> queues. And that probably requires the distribution across queues, whi=
ch
> >> you didn't like in the previous series. Anway, already finding the tim=
e
> >> for that is hard.
> >>
> >> My personal opinion is that queue selection needs to return the qid, s=
o
> >> that the function can be overriden with eBPF. I didn't have time yet t=
o
> >> try that out.
> >>
> >>>
> >>> Additionally, as I understand it, in this series, the ring->q_map
> >>> mapping has to get rebuilt every time a new queue gets created. What
> >>> do you think about just having the server declare the total queue
> >>> count upfront and then the mapping can just get established at ring
> >>> creation time? group_cpus_evenly() would only need to be called once,
> >>> the cpu_to_qid map would only have to be built once, and we could
> >>> avoid the rebuild-on-each-queue-creation complexity entirely. Do you
> >>> think something like this makes sense?
> >>
> >> That is why I said in another mail that a config SQE would make to som=
e
> >> extend sense. However, the part where I disagree is that we could make
> >> it all entirely dynamic with the current approach.
> >> Only the logic for that in libfuse is missing. I.e. it _could_ start
> >> with a single queue or one queue per numa and one ring entry. Basicall=
y
> >> no memory usage then.
> >> And now libfuse could add logic - many small requests - set up ring
> >> entries with smaller payload size (or smaller pBuf). Many large reques=
ts
> >> - add more requests with larger payload size. And with the current
> >> approach queues can be added dynamically.
> >
> > Bernd, looking through this series some more, I still think it would
> > be preferable if userspace passed in the number of queues upfront at
> > registration time and requests are gated until all those queues have
> > completed set up. I think this makes races a lot simpler. Even without
> > configurable queues, there are already tricky races to reason about in
> > the dispatch and abort/teardown paths, and with configurable queues
> > that can now handle/submit requests while other queues are not yet set
> > up, there are now races against both request submission and
> > potentially concurrent queue registration, as well as races with
> > mappings that can reference queues in any state. I think it'd be
> > preferable to try to keep things as simple as possible, and have
> > dynamic queue addition added/supported later through a new uring cmd
> > if needed.
> >
> > What are your thoughts on this?
>
> Can we defer this to v6? I.e. v5 goes out on Friday with minimal fix
> changes and then we discuss with Miklos about it next week? In the end I
> had all these things initially entirely static and had an io-uring
> config ioctl. In the mean time I see a good reason to have it dynamic,
> mainly to keep memory usage low, but I also see the possible races, of
> course (although I hope that I didn't introduce new ones).
>
> In principle we would need at least monthly meeting to synchronize and
> agree on design choices. If I understand Darrick right ext4 has that.

That sounds great! I agree it'll be a lot quicker to discuss this in
person :D Looking forward to seeing you next week.

Thanks,
Joanne
>
> Thanks,
> Bernd
