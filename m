Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39AC3C3433
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299049; cv=pass; b=ObFII7cdL/xTVVRmlh5LJhqHnaeCrRVO6O9d4tmlQkqV7EvobxxGOsIYtNS/XZ5jHU8qQmVc0Eob4E/ucIjLz0gVX/oGOrG0XlDohyrrDLX4zRxaxvAv+oHTyaoFXgIQTcCPUb80F3ZRBHNch6k6PneHlTopgTj9PmaQQUxlrUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299049; c=relaxed/simple;
	bh=3clzcaKKnYn8k85th4NM/lvHtksusQV1grmbNtdDKqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfIqxp0sQfF1EAHRlcDDErMLSvDbd7ZEM1docofILFdsZfBh6QbslZwmh+zlDmW1HEI8FwodXpbe+Y6sjkj/5bKtfGaG8YsULOkD4xnbRlNA4MBp616UKMggtSbsLfMEug/ILh6aWNr7JRKQeR7OYWh6w17gEMTRP/N0Bz5CQB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMJhWgB7; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMJhWgB7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so51721485e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 07:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777299046; cv=none;
        d=google.com; s=arc-20240605;
        b=ApJP6DDKNuB0/xlCAUZ9PmNIYIOx7SZr170RsS+p1tE1VhzjXlU1OEVlKKqjheqZ2+
         2OduYMMO5cmFoaPnoIDA3sA9Fg0sY8pLoBioDTWlPAYL415kSPQtdgNcIZJfQ1XcULCJ
         8QUrt8xbeuQkFdlfpUXgjjZ2IEM8aKZO6KSuVauI6DOfm9vxTfz4lk8XHQaFIoXFho9I
         KX6X97a5lfTeqz986FFdvUuCJQoDl/165B+3UG+9v9s/g/SFN5OL0Dt8WfiJzPOT5fZs
         ak/2poolYMvlUAf/kwtoZyKyds6yLYiWOA6zeNKDz2oBqGhpx42XWQIcI1hK8QArY3Eo
         RgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BJNa7AQl4iRWqd9zI2tesKh1ZCj9xa6jdEk60mzTLhQ=;
        fh=lj1BzoAJVlPLoU5io5m/1aspTzITZMsKztDYgM4tuvw=;
        b=PGk3JG9r6/mKRNwp8mEbZmZvfONmWQt+FfzNSSXjXCJFTnxiPPx0wDnb4ipCHUQf8t
         jHYRF74RFSrI8M2AP+vN8TX6IYjB2FFekRTbF5g58j5kUMj0UnfOz8KbeGfBlas/B+SH
         ebRAhmiL7EmtXRdAFglsrOMAF7TVw5DcVhWBUjg/eUx6XKUx5v6d76iZaoute1VOloLp
         GnrKaffK/imGoCHLg+/otFaucN6dtOyKzYIVQZhNwd4zmqcHcRWG906sA10fQLJWSzs6
         3qO4DhgfbiepkOe4OJAs+++hyoyy2QhaON2eCPnFwnXB+EapNqPi3yYzheBgt1wGs+2M
         4oZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777299046; x=1777903846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJNa7AQl4iRWqd9zI2tesKh1ZCj9xa6jdEk60mzTLhQ=;
        b=DMJhWgB7PA+KQdbHWcHgSJntotiNu8JQL6OWwmseQYFsMsdg0xAom/UpHc2aMdnxWS
         1hEmBMSLWkGJM7gmZrLwsUR+ri8O8CdsFkKuUE6F+2q51eAkS+wun34QCAOhegRqYNNh
         GcKx/FlljBJ/SoyU3i0i7+xUOrDB5LBmvB9+h/0rGxcc8vDRyNPx6nrSR7S+mc+cB62E
         W4HctZN1/UicbIbOqBtMXgjtJxoxAu4d5JPkTmIYGFV1XTStKaQyqfitrjNZzn+fA2bj
         nI7g9WCYaYrZcWvUV3jxax2+30rBoq28LDlKenk6udH3+2PioM5CIFpYgfsxFH70RnK+
         QMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777299046; x=1777903846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJNa7AQl4iRWqd9zI2tesKh1ZCj9xa6jdEk60mzTLhQ=;
        b=Qd/2+fNVtfZmtW/fx3dwEoXWkFYJRyr7cew/OPdrOCaWMxZ9PZ634fVj8QGm98UxSq
         u5tnQ1ucijUGZ+9o0vlKHGgtDbnbQMA9ZgzTpHG63cBTy5sNElzLfSFP3YXOAgZ+GNPq
         G5W60VRTeFov+3jfOAnsI927+iWW3S/W0ueBSuwfGcwpOjVvkLJKz+VfexLSHFa+lRL/
         uD0LBjhyCcx1tDocsx71uPj8Zq5F0f6w3wX1Oq8NhnhD+jjLJ5uBmdK4t54ETLTJvlQU
         GCz3SOc9KdmMDVzp3FOZt85wz3TduQy8sPndbGMMcgwe0W8kDI9oSv0CkdjQI1B5SeW8
         P+7A==
X-Forwarded-Encrypted: i=1; AFNElJ907hnJSb2QoEHj6EVCW5BIY5XNwTXuFDSjtsaVWJT0kvQOX9dIk4Oj+M2HFY1ZvQmiqfSIExeiZKSYHWAT@vger.kernel.org
X-Gm-Message-State: AOJu0YztwXAHRMeVvlCbU2FqMx6boJXkUIN85ef0VFu8jqU8Ndr4kquX
	kHdXp+r5TJEslt8PSv/dJyBjSkYY2OvFfzbTJzxxSn+qRdnc+ldBF64A3x4WUFZ7bUw/vZRTs1w
	AXnkkIeHgy/Ejo7IAbZVqJmHH/VoZvQw=
X-Gm-Gg: AeBDies83CcqZilu7ph2EdCi82aE0A1QKkJhOWJ+NitSQAep47mdrnmmT11zhVHwFRj
	pFRicE6H0lYvUDx9m+I3NvdVXhlf1K0nfuPZ4GSgokxpNZs6ux9hN6Y+cvW834RBqsUW1mA15mA
	5fi/b1OTW/YpWauNsINPtHXFSVMaRkFgxnwZ75CBXpCc4BRN245WXZWrMDODXO1vJUV/xiXfm1t
	2wTg91Ki+g/2+EIdfPOqKy4bxMrmYKlYo/g8kDkjHwrkPynxYDiIANKnLeVpuRv3BoPqfhMv5qc
	1WFt+gUMTPhHlTvncYRadR0ByMgvhgg=
X-Received: by 2002:a05:600c:1d05:b0:489:1baf:8c03 with SMTP id
 5b1f17b1804b1-4891baf8d2cmr446366825e9.11.1777299046061; Mon, 27 Apr 2026
 07:10:46 -0700 (PDT)
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
 <e5a181d4-635f-4b91-b49a-e8d34b16f495@bsbernd.com>
In-Reply-To: <e5a181d4-635f-4b91-b49a-e8d34b16f495@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Apr 2026 15:10:30 +0100
X-Gm-Features: AVHnY4L8ay5B6WpR-sL80gv-Ns_gmbEDiMc2JbDZ_g3Fhe0xZ16nufWn4TCwBHA
Message-ID: <CAJnrk1Z1HgPXLzfcKMhOKjdZzcjuXbRH4de+4zQpoqvhSB=A-g@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] fuse: {io-uring} Allow reduced number of ring queues
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Luis Henriques <luis@igalia.com>, 
	Gang He <dchg2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 2:49=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 4/27/26 15:10, Joanne Koong wrote:
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
> >
> > Ok, we should go with what you have then and I'll submit changes as a
> > separate patch.
> >
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
> > For registered buffers and zero copy, the queue count is needed up
> > front at registration time. imo it would be nice to have the
> > registration interface for these things be cohesive. Dynamic queues
> > could still be added in the future (eg server sends a new uring cmd to
> > add a queue, kernel rebuilds mapping, etc).
>
> And that cannot be _max_ number of queues for registered buffers?

For registered buffers / zero copy, the buffer is contiguously
allocated by the server up front, passed to the kernel, and then
pinned. Our servers want to use registered buffers/zero copy with less
queues than the number of cpus on the machine.

Thanks,
Joanne
>
> Thanks,
> Bernd
