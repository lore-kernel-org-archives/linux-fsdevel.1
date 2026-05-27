Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC493C457C
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889816; cv=pass; b=Bf/LwJGf5iTiJk/OoPBKQxuU4admkDifIG/oWljh/fyxb2BKHYJ0v6XJrY/tOuXnAP+hk5olqYtiZsIzhcbTMvdXiDaKN/X3pssAySxKEtNEuC7yQNGfVSJpWxOIXQVJpxsBwAlWjaWDUpG0hdU0sAz9yieFajtimjKlCC53GxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889816; c=relaxed/simple;
	bh=teG7HgD+sXuPo0808FMF2xn11EMUDIx5mRUB2y/ttYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dW7qenPAgxWBLW8FiOsSgXl6Iuxvwg2UJv3c/iteXDgk09KB2QoxOsVaUJXYBiEZkj68JAxr9dpbSSZUMNfwEZ7vCXNDDEYCt6H1W0rU93mCw/UVWqr7O3V5/fPi5SSiEX5zQ4MrQTG+LagATrebuFe5etQN9WLKcrTY1135sOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDHqsJYz; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDHqsJYz"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so175a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 06:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779889813; cv=none;
        d=google.com; s=arc-20240605;
        b=HufGqjTvCRgEB3jCnpm2kQwrDUhGphcsz1rTKbaX1rRk8xHAeR6qL53Usrqqjz6uQo
         pX/MmBxuluq0fKN+Byya+hjF1YGDCyl90REdvRqyohaOU0trFRNnR9yWFyHcCRKZs3MG
         4jUbDoXo+zHH+Tp4Ctnc0mL7WmE/zd80jYlZipMV+9qfTEG366xLvU67n6pyFYiMZUVt
         QkCY5pXMeSla16szkr4VpPzJFJNiY003ERF6S2Ql9wAot49muIBn27SXhPGNQ2DV+ubk
         UKH6Q/dqu89KMhCsumJxkHpl6nOGRkT7135jBEMjQm8L8AxprToKJWaUS2SKGsTg7ohG
         SczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=teG7HgD+sXuPo0808FMF2xn11EMUDIx5mRUB2y/ttYU=;
        fh=T0Q+vOXYkA30CvDfjn8k8JZcc+U12OI7oK9/AkJVIQY=;
        b=SlXIxnr12hDQthr2XqhRQtU9JeHaSG9ma9IBkI3ER5872XvPlgKDSal1uYTtpFfD+0
         lb2ZqRvbRxxQYtfIPLVOqy6JwkbIrNJjpGTWYhsOvu9xyTkYy2vkamqi0I1g242jfBaR
         QMNcSVnh8BocamRG5qV1m8g4L5H3S6F4JrhjwrULgLq3TSBS1/3adgMKxG4tmlOb0I6h
         /YE1P/XS9JZBowi2AE2UdKBFHXQ40+nLwka9RZ3+JRe3p7/WOT1JuctKuPAf32mGLear
         Bb9VdAZ90YbPJeVhEhaJ9kY8n/MqNLS93bmtxDCo+UHuEtJTgMXHzK9Lr+RqtKg+WJvE
         5XvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779889813; x=1780494613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teG7HgD+sXuPo0808FMF2xn11EMUDIx5mRUB2y/ttYU=;
        b=jDHqsJYzQCefOFQHrH7NSwID9QgwUReUY6SCUuOcfaK5l2BUn8HDrFdDMKFBrKOHuR
         upVSDjBmbv6iJDt31NmrB14y0SpCqYjVJXW997xLpkg9HiB0DXUkPpstnHaAFQ3Iap1m
         mSNktYZJrWHx7TILidrbg8a6RfjzOOoFpAUidRwhdOAvnATg7B34vxmCvcVMBmITkJgF
         P18ssryqvxVsnJUMApAGPzgmBXTj1UoPnfCoLuiDUW/gI46QdT+WjVISZGlBOI8xDhFw
         JYC06ILZpWMe5sWCdanVXMHkq1cq+pE/NJfD0LDbxjv6kZujO3eIsdFERm3f9EGhSuHE
         g9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779889813; x=1780494613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=teG7HgD+sXuPo0808FMF2xn11EMUDIx5mRUB2y/ttYU=;
        b=NK2f0CWqVvP0nbK/krI8uNC/CZ5iRS9LeM+55dZi4JNHUMmpM3mMq0AOnP/SrQAf8T
         JL/QOgU4MaT1S27/Q02mXujSXjKvQ/A3YXmXKt5Ax2n5oNj99qQ7asaOvUpyW8a5o6wj
         b7xNMhRgTE3kvGhY2QLyS6CdBzJELax/bTvEBTWDwjQOkajDpXLTzAv1LqFHlzhg7T0u
         WxwSB5NuSr04DvHnIQMgvY3aCCQIBfr88XDDFCq3EPEyVBbAEHAFWAIEVYdwvW0stfEY
         QrkindYQYAF4gFf8Lg4se2ha/DzCMmKvPYut3cMX2A5uln6YgdTKPlsImaU4CskULL6n
         7Y1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+495lq8BWquULEbi9aECAiGsxnUpeUid0Yee4Po9QDspMOulnD5yvI+QErdzzD8jUvhshxD/enbZ+E5mmC@vger.kernel.org
X-Gm-Message-State: AOJu0YxYVodWfQpRCZUXHweixj1gEzVQO58AlMHBCOQI8JhlqZSvl/FG
	a1IWfZyJ3/ao4KyYZw6n10wVNktNf/tE3NEn1armJ2XDqUo5QzeUxx/EvaZxUifVBxJzByF8tC5
	2Bd4KBBknNdsINbO+IdbFWGdEmvCRlZdWG7aXzEuq
X-Gm-Gg: Acq92OFWeKYGJ9uIYWlxFbRBzAGQ9FfYce9+3JhQMG1fuOOBc4UGsXU+95RXxRlAmGd
	GA28qIGxxYZDrbqocGwfL9KM0pp2f0wZzwg8PGIB30GLlt2q+ZHe/GodtBi2rHtd0z+tzsk0arx
	JbN1z8PpNCVg0Rfx3YWfHAMtOrqcMNsiifETa2uhPtJTRkLn/K7RFoEZEdbTAhhQMGFL2LLt2ee
	lZqtSET97/K7wEXaeZJDDnWdRa5PxjVzHkeDwevYpBpBOfmKm8Tqr6dvtbXc0Q0Mnd8uq60oSsF
	GcY0LbP7SU7ApNJeJKt+2LgnIIqjLX3PdjXKzratYgkzQa8=
X-Received: by 2002:a05:6402:a547:10b0:68a:7046:e64 with SMTP id
 4fb4d7f45d1cf-68a70460f0fmr56024a12.3.1779889812969; Wed, 27 May 2026
 06:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <87ik8b2rh8.fsf@email.froward.int.ebiederm.org> <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
 <20260527-kuchen-fassbar-hauer-4b6fc31e3395@brauner> <20260527-auslosung-checken-gebacken-e3973bd13112@brauner>
In-Reply-To: <20260527-auslosung-checken-gebacken-e3973bd13112@brauner>
From: Jann Horn <jannh@google.com>
Date: Wed, 27 May 2026 15:49:36 +0200
X-Gm-Features: AVHnY4K8zbPBuKTBWEXlAviNrxPN6iUbzDj9d-HHVmF1LwngbjbDIfdkBCDXblc
Message-ID: <CAG48ez3DUQPi=XK5iSaztgH-F_Lz1UYuYh-mPzVWeXdxOq1nCw@mail.gmail.com>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with exec_update_lock
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 2:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, May 27, 2026 at 02:01:51PM +0200, Christian Brauner wrote:
> > On Tue, May 26, 2026 at 08:22:38PM +0200, Jann Horn wrote:
> > > On Mon, May 25, 2026 at 9:56=E2=80=AFPM Eric W. Biederman <ebiederm@x=
mission.com> wrote:
> > > > I have added a couple more people who might be interested.
> > > >
> > > > Kees Cook because as you have structured this it is an exec problem=
.
> > > >
> > > > Oleg Nesterov as he is knowledgable about ptrace.
> > > >
> > > > Jann Horn <jannh@google.com> writes:
> > > >
> > > > > My understanding is that procfs is effectively maintained by the =
VFS
> > > > > maintainers (though scripts/get_maintainer.pl claims that there a=
re
> > > > > no maintainers for procfs because the VFS entry only claims files
> > > > > directly in fs/, and the procfs entry has no maintainers listed o=
n
> > > > > it).
> > > > >
> > > > > In procfs, most uses of ptrace_may_access() should use
> > > > > exec_update_lock to avoid TOCTOU issues with concurrent privilege=
d
> > > > > execve() (like setuid binary execution).
> > > > >
> > > > > This series doesn't fix all the remaining issues in procfs, but i=
t fixes
> > > > > the easy cases for now; I will probably follow up with fixes for =
the
> > > > > gnarlier cases later unless someone else wants to do that.
> > > > >
> > > > > I have checked that procfs files still work with these changes an=
d that
> > > > > CONFIG_PROVE_LOCKING=3Dy doesn't generate any warnings.
> > > > >
> > > > > (checkpatch complains about missing argument names in
> > > > > proc_op::proc_get_link, but that was already the case before my
> > > > > patch.)
> > > >
> > > >
> > > > I think I finally have my context paged back in so I can intelligen=
tly
> > > > say something about this series.
> > > >
> > > > The scenario you are worried about is when exec gains privileges,
> > > > and we read through proc and authenticate with the old credentials
> > > > instead of the new credentials.
> > > >
> > > > Question 1.
> > > >
> > > > Assuming the executable is world readable (which they generally are=
)
> > > > is there anything that becomes accessible in that race that was
> > > > not already accessible?
> > >
> > > I believe so - the gnarliest example I am thinking of is:
> > > Memfds are always mode 0777 or 0666 (see __shmem_file_setup, which
> > > sets S_IRWXUGO), so their access control is purely based on being abl=
e
> > > to pathwalk to the memfd's inode. If you can race
> > > open(/proc/$pid/fd/$n) with the process $pid going through setuid
> > > execution and calling memfd_create(), you should be able to get
> > > read+write access to the memfd created by the setuid binary that was
> > > supposed to be private.
> > >
> > > (But I have not tested that and don't know if there are actually any
> > > setuid binaries that happen to use memfds.)
> > >
> > > > Question 2.
> > > >
> > > > How does this race compare to racing with setresuid?
> > > > Do we need to fix the setresuid case as well?
> > >
> > > Which setresuid case? setresuid clears the dumpable flag and has a
> > > memory barrier that is supposed to make that properly ordered against
> > > ptrace_may_access(); so setresuid() should normally not cause a task
> > > to become traceable, though that could maybe happen in weird
> > > scenarios.
> > >
> > > I think another case we should probably care about is what happens if
> > > a process which is only protected against ptrace by being non-dumpabl=
e
> > > goes through execve() - it shouldn't be possible to access resources
> > > associated with the pre-execve state while checking against the
> > > post-execve dumpability. It might be important for this that the
> > > do_close_on_exec() logic currently happens after committing the
> > > dumpable state in exec_mmap()...
> > >
> > > > Question 3.
> > > > Do we care about the case when a privileged process calls a setuid
> > > > process and drops privileges?
> > >
> > > I don't understand the question. Hmm - do you mean a case where a
> > > process with ruid=3D1000, euid=3D0, suid=3D1000 does execve() on a se=
tuid
> > > 1000 binary? I think we probably don't specifically care about that..=
.
> > >
> > > I think another scenario that we ideally might want to care about is
> > > what happens if a process which runs with a normal user's UIDs, but i=
s
> > > non-dumpable, goes through execve() of a normal binary while another
> > > process tries to inspect its FDs or address space layout - it probabl=
y
> > > shouldn't be possible to get information about the pre-execve MM and
> > > O_CLOEXEC file descriptors.
> > >
> > > > Question 4.
> > > > Is it possible to use a seq_lock instead of reader writer semaphore=
?
> > > > Or is that only for non-sleeping readers?
> > >
> > > Linux seqcounts are 32-bit, which means they are always kind of dodgy=
,
> > > but they are particularly dodgy if a reader can be forced to sleep fo=
r
> > > an extended amount of time. I don't see a reason why we couldn't, in
> > > general, use a 64-bit sequence count for readers that may need to
> > > sleep while reading.
> >
> > I have a patch series for this that I started working after merging you=
r
> > series for precisely this reason: performance. It's a few days old now.
> > I've tried various approaches and I started with a simple 32-bit counte=
r
> > as the POC. See appended (untested) patches.
>
> In a bunch of cases we know that the critical section the callers cares
> about just is very small: creds + mm. So in that case it is easy to
> switch the credential computation into a prepare stage and a commit
> stage and then the targeted critical section just becomes:
> task->signal->seq_mm++ + task->cred =3D new_cred + task->mm =3D mm +
> task->active_mm =3D mm + task->signal->seq_mm--. And then the reader
> doesn't need to sleep at all and can just spin on the seqcount for the
> small window they need.

I think it's probably good to avoid creating custom spinning
primitives if possible.
We'd have to also disable preemption around the writer side to ensure
that you can't get latency spikes when such a writer happens to be
preempted by a spinning reader at a bad time, and then we'd still not
have the proper paravirt spinning to deal with vCPU preemption that
qspinlocks provide, which AFAIU could theoretically also cause latency
spikes in virtualized scenarios...
