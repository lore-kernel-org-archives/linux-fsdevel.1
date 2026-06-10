Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851D4279EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106042; cv=pass; b=TAEBKgdifFxGvJ25qtWOPFE08jnvlCQkrzssw5GQExjaEKPiQAukT7xDrLSWgYjVI/A2CI4dcYqvSCuFxcysKJ45L4criwWrBFigLrEgwTzjmC39GuCDXTcmBfQXzT9/rqPk8FxSbDMlbFNSJEgzWvXYcB2h8URJ4pFvcVL/Ugo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106042; c=relaxed/simple;
	bh=rC4YhqZ1FS4bvpolaqRjIrIBJbr7OL7uGZULlrbKMEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlImtYjFhRwlpgn4kAO7E1u3f9sn83Qmv/7jVC+D0QLISiFad7adZkCufrVFogCpDer/tHnJxYlNWM/i6H2HG0Jsb0bPtHCYhnyhRZHlfgNm+eyc44Ob8wGxZRPYcnTytp5a7LsXh5NvsuJ4OEfA8u1naaO8VVw7TgHOeP5VAHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxZFTtJ1; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxZFTtJ1"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bed4f2f0898so885656066b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 08:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781106039; cv=none;
        d=google.com; s=arc-20240605;
        b=V6+gjYqOE1WNLSYCsXvxzIK8OfV8GePnldJoiNEct9TXr7CWdLmayCAB+CHfDUH1r4
         P2/lPQfpyK/HrG57HuA45ehXdS20/yzrwUKGIUc/FppmR8NNxAxyvS7aOnu+KioUJ/Kv
         SvWMG5fl01qHh+S4hfCJupJaqdTAn6cEbAXzSspRse8qs8d6nqSs56RljZ4jDfPHWI/E
         qg+hEugimFVMmZmBh1ZoepJA0K4FOC/LxteeO+viO1djJKzCMUAhusrnE0jVgWzZRsG8
         FeqDwZhDw4zRV5JgAUbLjr4Xy0YFD2DkdId++IV1I1p8bKXMqJvmNiqrqHS+CPcHz8D3
         Ur/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fOQ0ND7SPD41GK5XEhJ0IWZPloWUkgRYLsXMm+gmAJE=;
        fh=Hk2WIU9Dv9ChjSl1F3v4vO+vNYW6i0Q7PRKA8QnFUnA=;
        b=HdxYA4N0jNccRgliT+/ZLwxynzTDRON7pFjBKCsrWGEhOFVixLnzpAmLJyBR3uovWw
         npgENggzBzqjV3imrSe/xUuBFqdiMDXG0FefvRoQzFcXHLeJ4azfq/1hIR8olB7W9xmQ
         3c2E1jEcrOX1f1S1HcmP19MI4zw5z9YkbCP9vPIgoPH63zqCkthkAbdaOFQC9y/uVPba
         0s9zHt88Kj1FV2wRds190AEacG8cEX91JJ8/IWWgt91voNFLia+qJ/lX0sTTldCfy8vR
         Xl+ZHhmI23f44u60kPfaVdzYS00U7oFN3FT/tGOEug7+3nTnhn2IF/Ym9SQWvz0e9nqo
         B/zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781106039; x=1781710839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOQ0ND7SPD41GK5XEhJ0IWZPloWUkgRYLsXMm+gmAJE=;
        b=dxZFTtJ1c6pmSuu+OfApZOCA6vhLm+gjmNzqDUWmWJDL/oloPyJ1Vi2pG/aavEWZ0j
         ex57JdD9vRILCM39ozZCfWQGKUCB4lwHAKHXND/G/bTeKD+75gIuflhY0/Cc4Huxwlda
         AbIcjNZmwIXGbFyxbChGetFFwe5SODkTJUdOkG/86zTuDdkbbbGlGQ8b8nDklHjhNTxG
         9z1CaAO6+qR1xfjT2HyHTinzd1B1leISJJ/4y+qLx5UrL76C2YExcGNnBoESxNuFu1Gi
         mM9b9G2bcEowULaC0sDzCkCOKx5HKmwe8EEtiFs48UAtw9/oDV7IEc746TAlTQm8fW+d
         sunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781106039; x=1781710839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fOQ0ND7SPD41GK5XEhJ0IWZPloWUkgRYLsXMm+gmAJE=;
        b=Mt8ICEOAyoWdqHRSyB3lg49Nzn2Hb4eSfyTvGnLzYNN+fkEOoXqiPr9Y6rAXaVkNlN
         DAhgcWCgC2J4D7rwuZfxa5ig9ZM4p3chymzUdmIcnn+cn97us+lo0K3+NoR6FynZiHLe
         ziQm1bCwoULbdkEfn79DMIXRziTyYU+Ii6yCbw+j0mAu9AeiQfTg4F4JIuXrLEVELqxT
         5zUVfCnCf0kjcnYzs3vTJzJFoQTgdz9JLn4jIrj1E6c+gN5tmW+J3Jsc0QFDpTh0rj7J
         vZ3hE8pjh8hpmnwCn4n0RoJVawOuwXVAM/6BeHwP9mjvvCl7TZB+H5NoePhPDtIb7Ii9
         SmdA==
X-Forwarded-Encrypted: i=1; AFNElJ97SPNmnth9cQFagWdiwi07ObJcXMm46SIWS59a4aDcnLd+6syK2YXrmHGreC2zWcA/sX5pLzjnHO8qTccM@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNDXWo17GgktQ9OQoYnG3ClhVYdvt8si8bUFcL+SOn3Y9CZbp
	1uGeZoHQzSWHLIw1vnYTAsWOw8B3J2FIyNpphw02paG44ZNshJrq6VjRDbbUxOfKRsMwt1YjiDl
	RhnisNT8rodIkvjRQy9tAxi7jd2GcTWs=
X-Gm-Gg: Acq92OH97drLAVUkDg4NeT+X/xSiBMPxuGUaC/onDqdzXrVWJF0nMFgLMVAXEuVSsWn
	WOGOFhOou0XG95vmTNPp0Laq9q9FjEIE+BA15fQ1W3RTaadWTK/ea3pOn7PbuB4m6h1xsuumH6h
	s86zq4F3fSY1AAOAv6Ak33g9Rl9tTtU470RttFsc4IceWGQGbo7zZ3AmozovAt84FiZ3MiJa9b9
	LnIcSlA5iBd6xjlkUSoYqEPYIbkpepWgN2nQgE1r82BFsw8vVzJKzK/FGLoqCkeJXqlJzimDd24
	8W/u7xOhWSyekgEW+nPf+GiPFf/AdTdDd00KKMuO+4ko4+dhHhZ3K1Vxh2a8Okc=
X-Received: by 2002:a17:906:c112:b0:bee:d554:f332 with SMTP id
 a640c23a62f3a-bf9372cf747mr431129566b.16.1781106039216; Wed, 10 Jun 2026
 08:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5f62836-62d1-4b8e-9694-bbab27112e7e@linux.alibaba.com>
 <649fdbbb-64f7-43d9-afd5-a3076e3ec946@linux.alibaba.com> <CAOQ4uxj+WAe+99FFi9RfMd5tpSwwP=rSH4dNuJEdhV1wL+5CDA@mail.gmail.com>
 <dff837f6-7480-4984-8728-802ddd78dda4@linux.alibaba.com> <CAOQ4uxi7DceKuh6+qGjuQJEFiE=HEFu4dMrc++VXUknRnX26JQ@mail.gmail.com>
 <95371379-97e9-4cb4-8358-ec014b765b74@linux.alibaba.com> <CAOQ4uxjh5VYkKLAKxhMsy-ZmrbRrgX4pFgBLFqsDqWMXeiqg3w@mail.gmail.com>
 <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com> <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
 <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com> <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
 <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com>
In-Reply-To: <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 10 Jun 2026 17:40:27 +0200
X-Gm-Features: AVVi8CeGo_2B2ZyW7eFj7bphdGwcX5LyBNio_i5Wab7H0AIqV-UpfXnRu6dRYxM
Message-ID: <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
Subject: Re: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 3:18=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Jan,
>
> On 2026/6/10 20:21, Jan Kara wrote:
> > Hi!
> >
> > On Wed 10-06-26 16:17:33, Gao Xiang wrote:
> >> Amir just suggested that I posted a long off-list discussion
> >> on the list right now, but since it seems to relate to
> >> `sb->s_writers.rw_sem` locking design, I am not quite sure
> >> how deep I could help generally: But here it goes.
> >>
> >> The background is that we have discussed a generic deadlock
> >> timing for several months as below:
> >>
> >> fsA is a filesystem which supports fsfreeze, such as EXT4/XFS/...
> >>
> >> fsB is a filesystem which have some relationship with a
> >> userspace daemon (e.g. a filesystem with fanotify HSM hooks /
> >>    fanotify + EROFS file-backed mounts / a FUSE filesystem or
> >>    a filesystem backed by a virtual block device)
> >>
> >> Thread A                           Thread B                           =
      Userspace deamon
> >>   write(fsA_fd, mmap(fsB_fd))
> >>    file_start_write()
> >>     (take SB_FREEZE_WRITE read lock)
> >>
> >>     handle fsB mmap fault read
> >>      -> notify userspace and wait
> >>
> >>                                     freeze_super
> >>                                     (try to take SB_FREEZE_WRITE write=
 lock)
> >>                                                                       =
       received/handling fsB mmap read request
> >>                                                                       =
       (do random something...)
> >>                                                                       =
       write(fsA_fd2)
> >>                                                                       =
        (take SB_FREEZE_WRITE read lock)
> >> The problem timing here is thread A does
> >> `write(fsA_fd, mmap(fsB_fd))` =3D> file_start_write() (rwsem read),
> >> then hits page fault and wait for userspace deamon to finish
> >> the request;
> >>
> >> Thread B does fsfreeze on fsA so it is waiting a write lock
> >> (sb_wait_write(), rwsem write) and blocked on thread A;
> >>
> >> And the userspace deamon is a handler handling page fault,
> >> and trying to write to another file (fsA_fd2) on fsA again
> >> and blocked on thread B (file_start_write(), rwsem read).
> >>
> >> because of the specific locking timing is `R->W->R`, at least
> >> the whole workflow won't proceed so the related processes
> >> (and fsA above) will be stuck.
> >
> > Thanks a lot for the good summary! It has helped me to look at the prob=
lem
> > from a bit different angle and I don't think it's actually specific to
> > filesystem freezing or fanotify HSM. Consider the following simple setu=
p:
> >
> > You have XFS filesystem fsA. On it you have a file imageA and you setup
> > loop device loop0 over imageA and mount it as some filesystem fsB. Now =
you
> > do write(imageA_fd, mmap(fsB_fd)) and you get a nice system deadlock (t=
ried
> > that and it really works :)). The problem is that write to imageA_fd
> > acquires exclusively i_rwsem in imageA, then goes on to fault page on f=
sB
> > which maps to a read from loop0 which maps to a read from imageA and
> > xfs_file_read_iter() wants to acquire i_rwsem for imageA again.
>
> Ah, great catch, but mainly because XFS takes i_rwsem read lock
> on read paths LOL.
>
> Yes, yet this deadlock sounds more like a fixed flow/pattern, which
> is somewhat slightly different than fsfreeze issue since fanotify
> needs racy between threads (causing RWR order casually and cause
> Linux rwsem model deadlock) and may not need stacking filesystems.
>
> I'm not sure how this deadlock can be avoided easily since it's
> a deterministic single-thread timing, but as you said, at least it
> needs privilege (like fanotify which needs privilege too).
>
> btw, I remembered Miklos once mentioned some i_rwsem deadlock cases
> too, maybe i_rwsem could cause some generic issue.
>
> >
> > I would not consider this a real DoS vector since you generally need
> > priviledge to perform such nasty write but still isn't not great the sy=
stem
> > can be deadlocked like this and I think we should fix cases like this.
> >
> > Arguably, to address this particular case, we could block writes (and
> > reads!) to a file that's used as a backing loop device file similarly
> > as we do that for swapfiles but here I'm seriously worried of userspace
> > regressions. I've seen userspace scripts setting up loop device and *th=
en*
> > running mkfs or editing partition table directly on the backing file.
>
> but I think erofs file-backed mounts can just simply block write to
> the backing file to avoid this: I don't think support this is useful,
> but yes, it's also priviledged...

Block write to backing file? Didn't you want to use pre-content events
to fill the backing file lazily? How will you fill it without writing to it=
?

> >
> > Also with the use of filesystem freezing on fsA, write to any target
> > file (not only imageA) in fsA can create such deadlock if the page faul=
t on
> > the stacked filesystem ends up wanting to do some modification of image=
A.
> > So I don't think blocking IO to the loop device backing file will be ev=
en a
> > complete fix.
> >
> > I think the underlying reason why that write(imageA_fd, mmap(fsB_fd))
> > pattern causes issues is that it essentially creates a loop in the stac=
ked
> > filesystem graph which can cause all sorts of lock inversions compared =
to
> > the natural order of taking locks for the stacked filesystems. So can w=
e
> > somehow forbid that? Or do we simply not care and if priviledged user d=
oes
> > something stupid, he gets to reboot the machine? Any other ideas?

Very unbacked idea, but something along the lines of:

/*
 * sb_{start,end}_write() scope an "sb write transaction"
 */

@@ -1283,6 +1283,8 @@ struct task_struct {
        /* Journalling filesystem info: */
        void                            *journal_info;

+       /* Stacked filesystem write transactions: */
+       struct super_block
*sb_write_stack[SB_WRITE_MAX_STACK_DEPTH];
+       int                                         sb_write_stack_depth;
+
        /* Stacked block device info: */
        struct bio_list                 *bio_list;

I don't know what a decent value of SB_WRITE_MAX_STACK_DEPTH
would be but its not the same as FILESYSTEM_MAX_STACK_DEPTH,
because loop/nbd/backing device also contributes to sb_write_stack_depth.

The rule is that sb_start_write(sb) pushes the sb to the tx stack
after checking no loops in the stack.

In the common non-stacked case, there are no checks so the push/pop
should be quite cheap compared to the sb_writers locks.

For the read side I hope that we do not need to track "read transactions"
in the stack and that it is enough to check the write stack in page faults =
and
stacked reads in loop/nbd/backing.

Note that the unscoped kiocb_start_write() in aio/uring will need to be
extended so that the write transaction scope will cover the io submission
to cover the page faults in input buffers.

I have no idea about the feasibility of this and how much of the holes
this actually closes but if looking at the narrow use case of pre-content
events it might just be enough.

Thanks,
Amir.
