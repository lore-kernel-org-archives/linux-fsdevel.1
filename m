Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB1344DA8
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191571; cv=pass; b=P1BEH6se8SyBCe2+x72kMg1qi5rV3nxo2hugYtto5O8U6jmkBuh4hsqVu+W/TSRNCQ41fCNmHeKW9JamhJ62vWuk4bcMPFCp9EYo19uNtLIu22o7s24dKa+tbvHQdIamkVMU5igY3hSlEoNGYC0KQtQdkph+gmI0gQpRs5OHwSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191571; c=relaxed/simple;
	bh=8M5lVANqt8pvA9R0yYrXjuuQijl0D587bVD80nlNZqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpwfGO3Mn/6mJJDesJn8xZ/o3AMM5ycOjLLsDlwThcRi7zAEhALO9BAjoibVlkAx21fH1bp24KyEzviyApAr5bKg3525e0IVWcbr8kNBS0H9Qc+nwpm5wKQslf5GdfP2i/r2UooJO4cR+PFgXO1giLzdTtCHCTuyzdWRPC5TVqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OI4j0W86; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI4j0W86"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68acf0a15b3so11831855a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 08:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781191568; cv=none;
        d=google.com; s=arc-20240605;
        b=d9QJPCpOU0bm5MLuLTwtd3ReJyfMES28XkClbuog45j5kkU5r0PtQgNM+0Curi6AuP
         JDjnn9s4pHDq2z1maHlQjT8s2DNUR5ubcD6+ZMamdyh3G0t3sHdof8eOG8bZU7iNZ2De
         6F2NkMuJp79kTHk/a3vCs5Wg9Dx1cj78vdktpZcbRnQlb2u0/eF22yNtS8Xj2xE55i/h
         SO2fK9Jqf9CYspimxJUNZK9vKIvLBMyGJYp6BmQ1SOxv9otmqe2vlJ69tMKdn/aQoUsx
         a84xQ6JWf3DobZMjt/paBSC9n7ZOG5uiHc0/aJK/GA1knQzFdqm2wJiTr9rlZwXRQ1/U
         FGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=53TZybIkp6fnkka3IPyZ104o3JMmvfy/w0imgV1t9o8=;
        fh=YHt3kYP7FCHHvD6PtrJ3MbBGaPHm9Ixi8Cplw0d2gek=;
        b=ifJELPtA7MkUEZTNGpl7ZG0JbK2owcw/qjv7+MqFDM3PJG4BGUBRXF88n1Qbv6I+ue
         VVqZ1WfNKp3xW19lEBe7GWqRnRb2ftxkROSL9sD8Y1ocoPLGmW4Gmm857a7OxKRZSBTe
         7E7r7ETgqDf/gCIKWi2YcsjK9RNznp8Xvj7byq1REvldaz8o1AoAGC5WJGhn0za9+cyO
         8M3D0zmAXHMOCDyT310ieiB4x+aLEUNpsm2OHoHSQtteavaocgSoQ8ol4kqeXOUvy3Le
         EB3hIQNXcb3q1Ci0JJ+D8zX89+yituZMZIvjRVKUoHN5GDQxCZwSBDAbpKnPtvsc4XDq
         W53A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781191568; x=1781796368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53TZybIkp6fnkka3IPyZ104o3JMmvfy/w0imgV1t9o8=;
        b=OI4j0W86O4+Ciyt4jJJPvJcOAdBi3z9KjkW9ywcPS5bWIXN6q/npga4KJ0z1FOVf5c
         IM7E9UC1RIhVilwWHp/ZNqdTxpqJBhXKiS4MTge6G5o1yMioGYuw1ClaP0W8BrSzQSPK
         W6zT/OnAXcd8qz0KrvvjAwNQ7q6vAYCFJRCmT0Qgcgl8IomtF2dObGSn8vmbN7ha1L9N
         fx50VvtsSSWz9TFSyi30AmFLmj45QC5TYWPZXsPLp36H8vs6m2DfeqVM4YZDZrYd0oJq
         Kvax8Fn0cZ5DEmM3t8YuctCtBAzt682k9TFLtHehy8lwIGlOUJAmTf4wfzpY5TCJHAbS
         8zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781191568; x=1781796368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53TZybIkp6fnkka3IPyZ104o3JMmvfy/w0imgV1t9o8=;
        b=Ld2l65SSCe/lRcuiu20k1o1dHwDZhd+I5FZv6jXaqf521B7yuKGQaDbO/V1vSCn2Hr
         4+QUBPVKQhUGsyngOfOLhCC4e3HsDZEFTk57WlWcI7qU0ZPoBWg4L32MpkZbgKQ2EGGy
         upsTbdEAcn0iO5I/7WowqjOoqHygxnBiWbZr10q8OImr6/+USB+tIlZmg1ymK14ypgrW
         4bQEbSfyzktQV2thPAiq2i93mKRI5MxhgMUD7Ylgl9U1YlywggWOZTTrpzOBR8bP+nV2
         CKyl3gOKDbmDZ6EMw0by5m2pl/1faj1sg9N33nvzqjEmEH/x3UafPR3SXhYslvolGNTw
         alKw==
X-Forwarded-Encrypted: i=1; AFNElJ9mPbvC4xF0VQWZVg/aGkugvpJBQrA7RKojef+OkZKae9dQOqUdVySowdjWFfgYvcPblM7DVfBR7NeUWse1@vger.kernel.org
X-Gm-Message-State: AOJu0YwQeJcU9aPhE1aksoLKSHoE/MVc7r0JBJ3KUrup81g37o/4lUvf
	B6IeEcW8IHnDceFcyp60Y5RVEKV+9ibNuhGvJeYZaelHSWCRjc3fZ8xCzmBUGbyaldawHLpo64B
	VC6IPvGGgqIeFy5rHllqWYKczQK0szwk=
X-Gm-Gg: Acq92OHQCYn5W0nwLUp5vtl1j0mvXVUF4iXBAY4TPJE1ahs0zOJDFfy5CT2CCmaD+Xx
	TTpxYMxo7zwsCgoLIdYyuOpevQuptT9nTkDW084pb+qfzKtujE8guGasOhReQgjZ/wyAU2g5n2Z
	jUcLCiFtyAHoV9/TL6Adf0l7gwFphSRIHehd9Cn/qgNVsqVQpUe81c3fGqFtfZievHL7UgUzrhB
	fiRPC4gaX7eOQVExFeavSUcQmkOOKA4pnG/ntaDxCdH3eBL25XgIh8GG05xmpGoHxnGifZ0pj11
	9texrvU7LUx4yC4Iy1dNvnhUgNLE4WTO6z8m/BqFSvWMpf3Hexs=
X-Received: by 2002:a17:907:961f:b0:bee:875d:af12 with SMTP id
 a640c23a62f3a-bfc823fed33mr167226266b.0.1781191567878; Thu, 11 Jun 2026
 08:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dff837f6-7480-4984-8728-802ddd78dda4@linux.alibaba.com>
 <CAOQ4uxi7DceKuh6+qGjuQJEFiE=HEFu4dMrc++VXUknRnX26JQ@mail.gmail.com>
 <95371379-97e9-4cb4-8358-ec014b765b74@linux.alibaba.com> <CAOQ4uxjh5VYkKLAKxhMsy-ZmrbRrgX4pFgBLFqsDqWMXeiqg3w@mail.gmail.com>
 <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com> <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
 <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com> <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
 <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com> <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
 <yguigvx3sapcemq2oudlc6lmiwmxr27zx572oyqocbvefnpt3s@z3oj2pzgdjuj>
In-Reply-To: <yguigvx3sapcemq2oudlc6lmiwmxr27zx572oyqocbvefnpt3s@z3oj2pzgdjuj>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Jun 2026 17:25:56 +0200
X-Gm-Features: AVVi8CchzGsBptOXcy-SJONCyA_QlCokAVtGjUYgorKj-aLUaAWtGAezRKGN2hY
Message-ID: <CAOQ4uxi2Mx4ZB48DhQJWOvt6UBur3LnrkttgRjo72U4+Cu81iQ@mail.gmail.com>
Subject: Re: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
To: Jan Kara <jack@suse.cz>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 1:32=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 10-06-26 17:40:27, Amir Goldstein wrote:
> > On Wed, Jun 10, 2026 at 3:18=E2=80=AFPM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> > > On 2026/6/10 20:21, Jan Kara wrote:
> > > > On Wed 10-06-26 16:17:33, Gao Xiang wrote:
> > > >> Amir just suggested that I posted a long off-list discussion
> > > >> on the list right now, but since it seems to relate to
> > > >> `sb->s_writers.rw_sem` locking design, I am not quite sure
> > > >> how deep I could help generally: But here it goes.
> > > >>
> > > >> The background is that we have discussed a generic deadlock
> > > >> timing for several months as below:
> > > >>
> > > >> fsA is a filesystem which supports fsfreeze, such as EXT4/XFS/...
> > > >>
> > > >> fsB is a filesystem which have some relationship with a
> > > >> userspace daemon (e.g. a filesystem with fanotify HSM hooks /
> > > >>    fanotify + EROFS file-backed mounts / a FUSE filesystem or
> > > >>    a filesystem backed by a virtual block device)
> > > >>
> > > >> Thread A                           Thread B                       =
          Userspace deamon
> > > >>   write(fsA_fd, mmap(fsB_fd))
> > > >>    file_start_write()
> > > >>     (take SB_FREEZE_WRITE read lock)
> > > >>
> > > >>     handle fsB mmap fault read
> > > >>      -> notify userspace and wait
> > > >>
> > > >>                                     freeze_super
> > > >>                                     (try to take SB_FREEZE_WRITE w=
rite lock)
> > > >>                                                                   =
           received/handling fsB mmap read request
> > > >>                                                                   =
           (do random something...)
> > > >>                                                                   =
           write(fsA_fd2)
> > > >>                                                                   =
            (take SB_FREEZE_WRITE read lock)
> > > >> The problem timing here is thread A does
> > > >> `write(fsA_fd, mmap(fsB_fd))` =3D> file_start_write() (rwsem read)=
,
> > > >> then hits page fault and wait for userspace deamon to finish
> > > >> the request;
> > > >>
> > > >> Thread B does fsfreeze on fsA so it is waiting a write lock
> > > >> (sb_wait_write(), rwsem write) and blocked on thread A;
> > > >>
> > > >> And the userspace deamon is a handler handling page fault,
> > > >> and trying to write to another file (fsA_fd2) on fsA again
> > > >> and blocked on thread B (file_start_write(), rwsem read).
> > > >>
> > > >> because of the specific locking timing is `R->W->R`, at least
> > > >> the whole workflow won't proceed so the related processes
> > > >> (and fsA above) will be stuck.
> > > >
> > > > Thanks a lot for the good summary! It has helped me to look at the =
problem
> > > > from a bit different angle and I don't think it's actually specific=
 to
> > > > filesystem freezing or fanotify HSM. Consider the following simple =
setup:
> > > >
> > > > You have XFS filesystem fsA. On it you have a file imageA and you s=
etup
> > > > loop device loop0 over imageA and mount it as some filesystem fsB. =
Now you
> > > > do write(imageA_fd, mmap(fsB_fd)) and you get a nice system deadloc=
k (tried
> > > > that and it really works :)). The problem is that write to imageA_f=
d
> > > > acquires exclusively i_rwsem in imageA, then goes on to fault page =
on fsB
> > > > which maps to a read from loop0 which maps to a read from imageA an=
d
> > > > xfs_file_read_iter() wants to acquire i_rwsem for imageA again.
> > >
> > > Ah, great catch, but mainly because XFS takes i_rwsem read lock
> > > on read paths LOL.
>
> Well, yes, that makes things particularly easy to hit but e.g. with direc=
t
> IO much more filesystems (in particular everybody using iomap) than just =
XFS
> are prone to similar issues.
>
> > > Yes, yet this deadlock sounds more like a fixed flow/pattern, which
> > > is somewhat slightly different than fsfreeze issue since fanotify
> > > needs racy between threads (causing RWR order casually and cause
> > > Linux rwsem model deadlock) and may not need stacking filesystems.
>
> This example demostrates that the problem isn't specific to HSM or filesy=
stem
> freezing. Yes, filesystem freezing given its filesystem wide scope is
> expanding the deadlock potential to more cases but the underlying problem
> really is that if you manage to do a syscall that holds locks on filesyst=
em
> A and then ends up accessing filesystem B that's stacked on top of A, you
> are violating the expected lock ordering and this can lead to deadlocks.
>
> > > > Also with the use of filesystem freezing on fsA, write to any targe=
t
> > > > file (not only imageA) in fsA can create such deadlock if the page =
fault on
> > > > the stacked filesystem ends up wanting to do some modification of i=
mageA.
> > > > So I don't think blocking IO to the loop device backing file will b=
e even a
> > > > complete fix.
> > > >
> > > > I think the underlying reason why that write(imageA_fd, mmap(fsB_fd=
))
> > > > pattern causes issues is that it essentially creates a loop in the =
stacked
> > > > filesystem graph which can cause all sorts of lock inversions compa=
red to
> > > > the natural order of taking locks for the stacked filesystems. So c=
an we
> > > > somehow forbid that? Or do we simply not care and if priviledged us=
er does
> > > > something stupid, he gets to reboot the machine? Any other ideas?
> >
> > Very unbacked idea, but something along the lines of:
> >
> > /*
> >  * sb_{start,end}_write() scope an "sb write transaction"
> >  */
> >
> > @@ -1283,6 +1283,8 @@ struct task_struct {
> >         /* Journalling filesystem info: */
> >         void                            *journal_info;
> >
> > +       /* Stacked filesystem write transactions: */
> > +       struct super_block
> > *sb_write_stack[SB_WRITE_MAX_STACK_DEPTH];
> > +       int                                         sb_write_stack_dept=
h;
> > +
> >         /* Stacked block device info: */
> >         struct bio_list                 *bio_list;
> >
> > I don't know what a decent value of SB_WRITE_MAX_STACK_DEPTH
> > would be but its not the same as FILESYSTEM_MAX_STACK_DEPTH,
> > because loop/nbd/backing device also contributes to sb_write_stack_dept=
h.
>
> I was thinking about something similar but then realized this won't fly -
> the deadlock chain is often split among multiple processes. Even in the
> case I've shown above there's the task doing the nasty write which holds
> i_rwsem on imageA and then a workqueue thread that actually does the loop=
back
> device IO which is trying to take it as well. No single process creates
> a loop, only all of them together form the loop.

Yap. I was considering whether we could copy the sb_tx_stack to the kiocb..

>
> > The rule is that sb_start_write(sb) pushes the sb to the tx stack
> > after checking no loops in the stack.
> >
> > In the common non-stacked case, there are no checks so the push/pop
> > should be quite cheap compared to the sb_writers locks.
> >
> > For the read side I hope that we do not need to track "read transaction=
s"
> > in the stack and that it is enough to check the write stack in page fau=
lts and
> > stacked reads in loop/nbd/backing.
>
> That's another problem. Reads can create deadlocks as well. If you do
> read(imageA_fd, mmap(fsB_fd)) in the setup I've outlined in my previous
> email on XFS, you are holding i_rwsem for read for imageA and then doing =
a
> write fault to fsB which translates to a read from imageA which needs
> shared i_rwsem for imageA again. If you are lucky, this can pass but if
> someone tries to acquire imageA's i_rwsem for write inbetween (and blocks=
),
> your second shared i_rwsem acquisition will block and you have a deadlock=
.
>

Yeh we could introduce sb_read(sb) scopes but that would be a bit nasty.
The two-fds syscalls (e.g. sendfile()) makes this scoping even more challen=
ging.

> > Note that the unscoped kiocb_start_write() in aio/uring will need to be
> > extended so that the write transaction scope will cover the io submissi=
on
> > to cover the page faults in input buffers.
> >
> > I have no idea about the feasibility of this and how much of the holes
> > this actually closes but if looking at the narrow use case of pre-conte=
nt
> > events it might just be enough.
>
> What looks like the most feasible approach to me is to record in struct
> task we are doing a read/write syscall for fsA

read/write_iter could be nested within stacked fs, so we really need a stac=
k
of transactions, but this one could be [FILESYSTEM_MAX_STACK_DEPTH]

> and in the page fault
> handler once we have the VMA we can check that fsB isn't fsA's ancestor i=
n
> the "filesystem dependency graph". Making the check cheap enough should b=
e
> doable (we could for example do the loop check traversal only if the
> stacking depth of fsB is higher than that of fsA, caching the stacking
> depth in the superblock, which would deal with 99.99% cases) but maintain=
ing
> the dependency graph will take some work...

My crystal ball tells me we are probably not going to do that :-/
But if we did, it would have been nice to validate that LOOP_CHANGE_FD
does not set the backing file of loopA to a file on fsB ;)

If we only wanted to protect the case of pre-content events in erofs
backing file (readonly), is there any solution that you see which is less
complicated?

Thanks,
Amir.
