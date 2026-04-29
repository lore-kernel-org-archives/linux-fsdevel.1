Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB633A4F5C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479052; cv=pass; b=X2ozYH/cgt1Ieo/F1gz05/ku5UDlny4dfiLBgrD6OkbTHthO5o4z/1Ubv+2UURGnHBE6bnoun2QxCWfmSNBBToAY7vITbbS/peTzMeVdR7/giqwto79cYTvfmHtPptlgkpM/p3Kkd4xtR+JNrESC5jXNEG6UFxObBGSUaCVukyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479052; c=relaxed/simple;
	bh=mCJmotQ7OTx8yLqp8L65eJdD4XeDVfyXmCsnIzT/k0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adgjIVsWMU0OmrwnEfVLItckUV8ZFQHdj2HgAQc7P6ySiJ6nHQbMZnGd+g/pwUKJ90JBCcKHk4JFy6lqCvYIj2rD1ZfpgknsFQsIPIwITRPX0sTrpw1/32r4y+hTlaa//po8qwlsT4wyRU6uPm8STvfe+faozvFNYg3CH63yxWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOiu0t/F; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOiu0t/F"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfbd17589so3072f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 09:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777479042; cv=none;
        d=google.com; s=arc-20240605;
        b=XGVmP0AkMZygd8HKRCqSL3l+iR6cLIEhFAAVC06ColmBD3uE2GPurNIYiDLUHasuhO
         Em6hQWpT8VLl5ypVzfEsXPP7B4QRmhZrFHenLCtv/Xlmeg9DYFsskmf1uXwwYfpCw/Fd
         8eDmJJMCf5OMzNY5mOsuG4w7B2F0QMYv+OjvhmPZlQvPwrAL2OKWWaqseY3ymOkDBG3L
         grZPe0JJd4UBUZ6mEfzKFKae8Fsb79gwt6xJYWgUUEcITOYAO581YmPQKKruG/Aw7mXQ
         HyCEtXityDNlMUtU5lL6MCU4rHxjaatn33hmqORP2l7s1D4Mue/qInVQVzqUkC52Wd3L
         UDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eYdFf9lItomYI0K7p0KuMIqr1TwrsxLl3tNCErRx5Q4=;
        fh=ZF6n9Hqp7y70mdkS54mY7hMWXgxDcmBu8DcHGjuZIVc=;
        b=B8EFi7OrAFy0d5KpmTC3t6s6EDkXnrbkouoTb3ZLD92Qno/qB3WANIuMzzOMlKAU1F
         aUudbcQjltq7wMdWR1z0Oseja7DDiSSHodQKdvGXNPdBq2QL/ly7XAgc2A1AHm98o+g0
         t3zOQiDny7Jn7n8s1FVJZmLs/qOGDeNaITu2zu5jDsprxZcQtydUBsK9ePcwYSoBEg0a
         ofW2ngIYCq5T3BHQgZG+qik6U8nXLw1oKJsRmqRbPrpAN6eCeJduLbE5+MJaKGNOMdXJ
         oLO1JCPZIw+oGtlOyXeLDfaAocG3D/dfnbAoGJU429gb8D4sLlU9ZSoRIC91DdookkQi
         z7Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777479042; x=1778083842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYdFf9lItomYI0K7p0KuMIqr1TwrsxLl3tNCErRx5Q4=;
        b=aOiu0t/FAl92rJcAY5Gw9Us2hDSr5Y+UkpLwbpsgJ5j4kyfXT2DzKSTh7qu1mFDVtv
         mzrqHBHOUCsnFaxvZWCdygt8a0GiVHKnCCWL8xbIj/mLjiujExJGLDCEFDDqRlRUTb6Q
         XQx05dHzfzVhEEQ6YSwNp1g1/BmWAW1gksd8CRMFFwoP8OQU9XXGPQ5JJ/CP8HQA77co
         Fx8VYsb6j8WmPOhQLN+P19+J3/OzIezgCMl402jiR2PV/aJb7TH7GvXdQFBw3efA8azM
         eay3wnYTsvbz3QB7mBa9aMPEdIhqjUo25a5t8kzD2S4LOwHHRMAoUg62yx65VZ9BUD0U
         X56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479042; x=1778083842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eYdFf9lItomYI0K7p0KuMIqr1TwrsxLl3tNCErRx5Q4=;
        b=IInf8RvwizB73Q1C06JaBbRUrp9ztqaKNGFDHnweavMcDbclolkJxIeriyRZ3paLfq
         F+rvgvL6zjtuoPxmx6jG2oZMXuzdZwQPwD/cNrWWx/8xY+7yTh4b5VrKtrJpFdSPWSyG
         uuMkOeIEbZo0S3+xwrtY2sFxeMpIw/rodx0PapGCSAePY3yLhpWc1ENkRuzeF5pV13EG
         Pr/e2WFpXKGeaVdghX2IIwgjba08IiPF3GdfWqQ3bCD36ew6IWvJknvdQX4DsllfplXE
         KbWciJHaHAFnJuphBsiugeBSb2eJGK7MWlr6v8Ng2KLmicZqXnz3gUm8PxYy7QvFdvn2
         2ecA==
X-Forwarded-Encrypted: i=1; AFNElJ9NWMziXNqvsDNor3X2wn45zg/xVqQPyg8N+2IPzgTxw48IoyXG7cGWf2EQNxW8N6+tGsZBHwdOsbLeWs7/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0NiehJcOREYP01WVuHL2Q0ur43ZhQ8tZMrjiyWOeCqE+Ul/Be
	EjHbASvzRWAPcSh3dlNhYkRBWZ2aII5+xACCCddmYNvm+Cml0jB57ZIasjTB1JiFDEfZqy/F0AK
	J+h/cSHcuDHyRP/j9i6gtST6AMYOlBJ554xqCJ0E=
X-Gm-Gg: AeBDiesS8OfmpC1xjNwwdw6ib8/IaQh0wFRGWopW49OokEucsfsYA1F27il3v4WAFw0
	WDVR7L0BiNEMKYSCtEJgsUr+OqF9mt32gYbO7I9+5Bf6TzFo9Fxx+rNLa90l4aZfAwyMBR5T6CS
	d+40Eklojh2+sZvRh00i0x5c/WDFk8pVKdqKC/ZISyo1/cwZqMMU4XDBVQLUcd8mPwMFdnLL8SS
	mXmFd5xNzXOSy/6Lchb2j0i8l51khSLJQgb74o7AGIGDCP8wroh62v3nVyoQb6T6FwiJie1Nvih
	SY5PwrFLLZAgZkmY6r59TWoHvAl7tWAseA==
X-Received: by 2002:a05:6000:2212:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-4464839c55emr14802642f8f.20.1777479041713; Wed, 29 Apr 2026
 09:10:41 -0700 (PDT)
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
Date: Wed, 29 Apr 2026 17:10:27 +0100
X-Gm-Features: AVHnY4JZt-tih-dISMx1TkqJjvMWTBaNDvuQbGk-MJlg71FAKRWKZdtkpMRl7DQ
Message-ID: <CAJnrk1by9O1JBH5W9jvkgYcBZK_t7nxzeSsmxm65jb4=wv-ikQ@mail.gmail.com>
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

Bernd, looking through this series some more, I still think it would
be preferable if userspace passed in the number of queues upfront at
registration time and requests are gated until all those queues have
completed set up. I think this makes races a lot simpler. Even without
configurable queues, there are already tricky races to reason about in
the dispatch and abort/teardown paths, and with configurable queues
that can now handle/submit requests while other queues are not yet set
up, there are now races against both request submission and
potentially concurrent queue registration, as well as races with
mappings that can reference queues in any state. I think it'd be
preferable to try to keep things as simple as possible, and have
dynamic queue addition added/supported later through a new uring cmd
if needed.

What are your thoughts on this?

Thanks,
Joanne

>
>
> Thanks,
> Bernd
