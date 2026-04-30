Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668413FEE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522600; cv=none; b=acYXzv4uRevSxiqhgf/Mo5OGpGmlcg7FmSH1fdwPbV+AH9mYBVQol7PAtPAMF74Rb8UCmIAJH5x1jewxdgybvjf4McGTzv01i4pLxnL6fZUOEX636nicygeSzURZhQ4kp7tVjyerH6m+EjqGGX6Ysxp6lR6AETluO9dDHXRV7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522600; c=relaxed/simple;
	bh=O21kEOhjfByN54UZLdtuPwdAy6O3ToGBKeQrdJ/Hi38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twgsAoaUtsoZLnoSOweR9WW5f1KGJtEv5irxbQizhB/LmdfK4MB+p7+gTwLoQglsglO65QPIkJyTaKPVRQdxG9W2aT6y1XHxmc5qHlfzgcdgWEXQzX97yAbF4Un5Fr0I3TF+AobgIHmuFh4SqqCb5O02vTl4iMH0VxM+qlKVpZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHmkXUeW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHmkXUeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7B6C2BCB8;
	Thu, 30 Apr 2026 04:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777522599;
	bh=O21kEOhjfByN54UZLdtuPwdAy6O3ToGBKeQrdJ/Hi38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHmkXUeWUXdhYMqEwBbHkbhAeTRWh8sTUkj1HhgLzrq58N9144BeEo9Z/zGyuQOxr
	 XME9HbIPfJAYnBEYQJG/22JD8DvB34/evbrmR8COkLN+hW1uwMEH1Q43JTW4mdJi9N
	 xWy1wVNNP+H3mV6HzjLcHtKl7zsjMGmQJnOvEd0TWhKibdf5AU+Q8Zed3SZwxTLWe3
	 aUf/tSlYKYS39k1km1XuF4zVkL5lB1+tLVyb/ai9lGKH+/lTm0IPnjJ0OgG+cTutA+
	 d3tH1OTKU9MnkiZFX8Xtyek0aUp5uZiWOgC1jlDOVHoOn1AdrebluAJDWhTXZISAJy
	 8rfvMWAbqkQxg==
Date: Wed, 29 Apr 2026 21:16:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>,
	"bernd@bsbernd.com" <bernd@bsbernd.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>
Subject: Re: [PATCH v4 5/8] fuse: {io-uring} Allow reduced number of ring
 queues
Message-ID: <20260430041639.GF3778109@frogsfrogsfrogs>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-5-982b6414b723@bsbernd.com>
 <CAJnrk1aYYSVU-AdxRoqC5H8xk+4rt9Tf=3BPphsw4vvNxjpEyA@mail.gmail.com>
 <b7e93b2a-7096-4957-bf75-38e096a9dd3e@ddn.com>
 <CAJnrk1by9O1JBH5W9jvkgYcBZK_t7nxzeSsmxm65jb4=wv-ikQ@mail.gmail.com>
 <0a56969c-7fe6-428a-8eb5-6df5e61ff03f@ddn.com>
 <CAJnrk1ZFPr5AKULqMwz2ym3i9W9cJCQU7pFzF=FwOb-TtA8fxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZFPr5AKULqMwz2ym3i9W9cJCQU7pFzF=FwOb-TtA8fxA@mail.gmail.com>

On Wed, Apr 29, 2026 at 05:32:27PM +0100, Joanne Koong wrote:
> On Wed, Apr 29, 2026 at 5:24 PM Bernd Schubert <bschubert@ddn.com> wrote:
> >
> >
> >
> > On 4/29/26 18:10, Joanne Koong wrote:
> > > On Fri, Apr 24, 2026 at 11:01 PM Bernd Schubert <bschubert@ddn.com> wrote:
> > >>
> > >> On 4/24/26 20:28, Joanne Koong wrote:
> > >>> On Mon, Apr 13, 2026 at 2:41 AM Bernd Schubert via B4 Relay
> > >>> <devnull+bernd.bsbernd.com@kernel.org> wrote:
> > >>>>
> > >>>> From: Bernd Schubert <bschubert@ddn.com>
> > >>>>
> > >>>> Queues selection (fuse_uring_get_queue) can handle reduced number
> > >>>> queues - using io-uring is possible now even with a single
> > >>>> queue and entry.
> > >>>>
> > >>>> The FUSE_URING_REDUCED_Q flag is being introduce tell fuse server that
> > >>>> reduced queues are possible, i.e. if the flag is set, fuse server
> > >>>> is free to reduce number queues.
> > >>>>
> > >>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > >>>> ---
> > >>>>  fs/fuse/dev_uring.c       | 160 ++++++++++++++++++++++++----------------------
> > >>>>  fs/fuse/inode.c           |   2 +-
> > >>>>  include/uapi/linux/fuse.h |   3 +
> > >>>>  3 files changed, 88 insertions(+), 77 deletions(-)
> > >>>>
> > >>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > >>>> index 9dcbc39531f0e019e5abf58a29cdf6c75fafdca1..e68089babaf89fb81741e4a5e605c6e36a137f9e 100644
> > >>>> --- a/fs/fuse/dev_uring.c
> > >>>> +++ b/fs/fuse/dev_uring.c
> > >>>>
> > >>>> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
> > >>>> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring)
> > >>>>  {
> > >>>>         unsigned int qid;
> > >>>> -       struct fuse_ring_queue *queue;
> > >>>> +       int node;
> > >>>> +       unsigned int nr_queues;
> > >>>> +       unsigned int cpu = task_cpu(current);
> > >>>>
> > >>>> -       qid = task_cpu(current);
> > >>>> +       cpu = cpu % ring->max_nr_queues;
> > >>>>
> > >>>> -       if (WARN_ONCE(qid >= ring->max_nr_queues,
> > >>>> -                     "Core number (%u) exceeds nr queues (%zu)\n", qid,
> > >>>> -                     ring->max_nr_queues))
> > >>>> -               qid = 0;
> > >>>> +       /* numa local registered queue bitmap */
> > >>>> +       node = cpu_to_node(cpu);
> > >>>> +       if (WARN_ONCE(node >= ring->nr_numa_nodes,
> > >>>> +                     "Node number (%d) exceeds nr nodes (%d)\n",
> > >>>> +                     node, ring->nr_numa_nodes)) {
> > >>>> +               node = 0;
> > >>>> +       }
> > >>>>
> > >>>> -       queue = ring->queues[qid];
> > >>>> -       WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
> > >>>> +       nr_queues = READ_ONCE(ring->numa_q_map[node].nr_queues);
> > >>>> +       if (nr_queues) {
> > >>>> +               qid = ring->numa_q_map[node].cpu_to_qid[cpu];
> > >>>> +               if (WARN_ON_ONCE(qid >= ring->max_nr_queues))
> > >>>> +                       return NULL;
> > >>>> +               return READ_ONCE(ring->queues[qid]);
> > >>>> +       }
> > >>>
> > >>> Hi Bernd,
> > >>>
> > >>> Thanks for making the changes on this - I really like how much simpler
> > >>> the logic is now.
> > >>>
> > >>> I'm looking through how the block multiqueue code works
> > >>> (block/blk-mq.c and block/blk-mq-cpumap.c) because I think they
> > >>> basically have to do the same thing with figuring out which cpu to
> > >>> dispatch a request to.
> > >>>
> > >>> It looks like what they do is use group_cpus_evenly(), which as I
> > >>> understand it, will partition CPUs taking into account numa nodes (as
> > >>> well as clustering and SMT siblings). I think if we use this for fuse
> > >>> io-uring, it will make things a lot simpler and we could get rid of
> > >>> the per-numa state tracking (eg numa_q_map, registered_q_mask,
> > >>> nr_numa_nodes)  and simplify queue selection where now that can just
> > >>> be a cpu to qid lookup instead of a two-level
> > >>> numa-then-global-fallback lookup.
> > >>>
> > >>> Do you think something like this makes sense?
> > >>
> > >> Maybe, I need to check that code. However, does this really need to be
> > >> done right now? This cannot be updated later? For me it looks a bit like
> > >> we are going to replace one code by another, without a clear advantage.
> > >> I can look into group_cpus_evenly(), but I cannot promise you when that
> > >> will happen.
> > >> My personal preference would be to work on real issue, like getting rid
> > >> of two locks (queue->lock and bg->lock) and distribute max_bg accross
> > >> queues. And that probably requires the distribution across queues, which
> > >> you didn't like in the previous series. Anway, already finding the time
> > >> for that is hard.
> > >>
> > >> My personal opinion is that queue selection needs to return the qid, so
> > >> that the function can be overriden with eBPF. I didn't have time yet to
> > >> try that out.
> > >>
> > >>>
> > >>> Additionally, as I understand it, in this series, the ring->q_map
> > >>> mapping has to get rebuilt every time a new queue gets created. What
> > >>> do you think about just having the server declare the total queue
> > >>> count upfront and then the mapping can just get established at ring
> > >>> creation time? group_cpus_evenly() would only need to be called once,
> > >>> the cpu_to_qid map would only have to be built once, and we could
> > >>> avoid the rebuild-on-each-queue-creation complexity entirely. Do you
> > >>> think something like this makes sense?
> > >>
> > >> That is why I said in another mail that a config SQE would make to some
> > >> extend sense. However, the part where I disagree is that we could make
> > >> it all entirely dynamic with the current approach.
> > >> Only the logic for that in libfuse is missing. I.e. it _could_ start
> > >> with a single queue or one queue per numa and one ring entry. Basically
> > >> no memory usage then.
> > >> And now libfuse could add logic - many small requests - set up ring
> > >> entries with smaller payload size (or smaller pBuf). Many large requests
> > >> - add more requests with larger payload size. And with the current
> > >> approach queues can be added dynamically.
> > >
> > > Bernd, looking through this series some more, I still think it would
> > > be preferable if userspace passed in the number of queues upfront at
> > > registration time and requests are gated until all those queues have
> > > completed set up. I think this makes races a lot simpler. Even without
> > > configurable queues, there are already tricky races to reason about in
> > > the dispatch and abort/teardown paths, and with configurable queues
> > > that can now handle/submit requests while other queues are not yet set
> > > up, there are now races against both request submission and
> > > potentially concurrent queue registration, as well as races with
> > > mappings that can reference queues in any state. I think it'd be
> > > preferable to try to keep things as simple as possible, and have
> > > dynamic queue addition added/supported later through a new uring cmd
> > > if needed.
> > >
> > > What are your thoughts on this?
> >
> > Can we defer this to v6? I.e. v5 goes out on Friday with minimal fix
> > changes and then we discuss with Miklos about it next week? In the end I
> > had all these things initially entirely static and had an io-uring
> > config ioctl. In the mean time I see a good reason to have it dynamic,
> > mainly to keep memory usage low, but I also see the possible races, of
> > course (although I hope that I didn't introduce new ones).
> >
> > In principle we would need at least monthly meeting to synchronize and
> > agree on design choices. If I understand Darrick right ext4 has that.

ext4 and xfs each have a weekly community conference call.

> That sounds great! I agree it'll be a lot quicker to discuss this in
> person :D Looking forward to seeing you next week.

Me likewise!

--D

> Thanks,
> Joanne
> >
> > Thanks,
> > Bernd
> 
