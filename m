Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A841B352
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819799; cv=pass; b=kvhZMQDpwvGN9qfg7L86uaAbNqS8zY1KzsMNqMf0YbpvwhVw8dhwbcJY43LH4+ITk8rOsdjvWkIPfl361WUfqrWVnaVwv9i9psOTdfbwMxf65zBPFcU2OcLMsc3YYEFFOOE/mZGc5n+kf4XkqXTK+bHIQPTQGBYpWzo/Ant7JrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819799; c=relaxed/simple;
	bh=zQBr4belhsTNyCJyonpmMKAiI4KEJa66cOTGg1/LrcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVk0yW1S2P0laOQlm7KN11A0nUbynLsuvGqZkAlyBXYl6UlVIBwdqn9l3OkUSKiifmyD2dNP7CdTBk9k5O8IZ0SKleoWKSpygyvx2RH28HWCnxSYYBUkZ0Ha/qsiXFee4AkY+J7GHZ3b9v39Kb3auLSCkdD1UKI2OPoViv6H5wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwdRnaiP; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwdRnaiP"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso73a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 11:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779819796; cv=none;
        d=google.com; s=arc-20240605;
        b=ZJGWfI3E2mDzV8n9w3xTzPLtgnAX1KBDGk3Jp5coCT3i8J4YJe5SO5rfZS4rDXJGkg
         94Rztw7DgkhabborxzzaVl1wSNzBFvceh4jRLpNidhFTTJFz2bxQ3BJ18lJzmRQbxewS
         PGb/xYk6ZsGiONxsxrSiDqy+Igd1gIDWttsIdCQO/hJ7M+CU1TXTg60r+s8RLfBSRMuG
         MQ2JhPqxDn6ly8ZeAevENCY/JuyN6xhpw4LDbGKlYPMRRs70HPdyjwf2eIETXGB51VPs
         dGOJ/2A8pArrG5CTY4O5riZphQOm2k5r004FMxEYbu9HUeb0TyH02okrSmnrywpH7Gt9
         pqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rb+pBBhSGJboZTGrNl43sSlX/tiZqbrSg2XBvPM5cq0=;
        fh=fzmFZ+3Buxvk3dXsQYQTj7Ti3ItAQX0JtWohv1GTY9A=;
        b=k3lMhfZTEjNp6B2dh1FPGlFJxEg0rzkFWwXEmn83YtrXjAo8uge/czxwpBHaOLzNrG
         Artcu8M9PY3Zwa6setKkq7bkP6nIJVt5MrRxXIWe+iDnlmTywxfkmRHwEZ+npkuQSjUm
         lg2owevCMISD8yda3mip9IxuwzNAS9em2r0sRChHqOWNAHNGo2xe9x7PIsIgewqvMCaj
         2JSWiRAjhobOn08zfQEKmJSzfl0MH5sdEAOCtdTlpRAlGEJz91Zn5oMmOt3bHP2WIspe
         2A/jlEes/LxIbsyitfc6FvkaQVtHMGHiLLyl8egqrZk1MDyCN2a+uXg4K7nFpg4N1SFK
         +77A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779819796; x=1780424596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb+pBBhSGJboZTGrNl43sSlX/tiZqbrSg2XBvPM5cq0=;
        b=fwdRnaiPr20GOWQPzjWSNL1XbmBIVWqfK6YK36oOEMsr2wpobu13SrIPZrnSjMQsGb
         cTfPiDGV5mgx/YBLScYvoKtbcdxbwyaEx2t/hMqO43CrJpljTI1H2tzmPhAwzXF1ZNSJ
         svUdkysKDSjXVx6glqWawrvRGExbfVrmV2BCdZeytY6FYqLa/orPPUv0myFbQgRNQPpy
         XqFlYfoQ6nymf2FdqOABQjajWpoFklEWrFTmY7cIHMCJKPMh80C9PpXGLf0vTs/YoD5P
         r9tcTujLrJZb1rh8doU4EajhnsH3EDMXjkjr13qESN2ds/IGPivWjSaBVD1zYmZ/nXnt
         LFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779819796; x=1780424596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rb+pBBhSGJboZTGrNl43sSlX/tiZqbrSg2XBvPM5cq0=;
        b=gstkIvnVrA6lbrpF3MnnoURYXTxyrYCg9eVnPT+9rV7hnm1v6yuSQn0zLp668DQDUX
         wTobkeFVdHA/B4h26VfBAI29j3+iLjC2DkZj4u7n2GhjNYrGySYow7yvDl6haAkF+kVB
         aZfbHELbcfcHNuTuUlxXX85+8KX8UuSMy0uzohexbxDcDhmZdcuXeLyItUXajJ8kxSCO
         CFEncpZ+7WLeIZa9EYN0QROvkfWhc5XVZ8RGxZU3UmtOLlkuHr/0zE3Wr0avPt+uAMoM
         M8oyNRUfJ9opfBX0WzGgP/w3IfxyDGJIFAb/Boz1lDyVnshnAqN26Nzj262LtcNpNY0R
         lQaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VZD2h2oQv/Z0B5YvK7joYCmse0SmdRz45EfAiQlrjBkmqwCooG9yQvua5xSyC6f5UCNoGMxA5egVDxq7r@vger.kernel.org
X-Gm-Message-State: AOJu0YzU8nUcD6k8Yuy5WNS8qyuFukjAlcWTKMdF6gu4AmtyXXtz7QP6
	e1eXkZQkCwXGhoEZDg3I5aVand6hxexJe8mJLEUoB22wV2U+PKnzyvtxSMCWG50skzBimI9Gi+2
	/mIM2unwp5BeKTK06mYVLJwlsnmZDhB5FDUdvory3
X-Gm-Gg: Acq92OHXyamzAPX3Wr1k/yBAXMlGCUR/+/qSKQ0eHD/buFLDVNeR7yCQ7URrhX1uD6i
	FqbLbpvPqWghJyYxAs5ynHwjgPKTN+O6bj1ssAoPttjffgxddx7WpPRTzeRy4E6U/6ELh2y0/9h
	ILA0gyMuBJI5t+cMoh5LFsKtjo8jRxFIzXGe4BW97XJ0CkYmoLMG6jdAdMlHwLuYfDoHtzND0zY
	oK/J25B4i1EZFmzjFDijp2MdC+cci9X26dCrKKH8cnxP18be2wBBKyp/+0MZWiRCBi1JOOCJgPX
	8TZolv8rkRpV5EkvRsIWzRGx9YIxrUTZqYsZjXvUmJgMuCs=
X-Received: by 2002:aa7:d350:0:b0:682:a2f:a15c with SMTP id
 4fb4d7f45d1cf-6890a91aa40mr121112a12.11.1779819795178; Tue, 26 May 2026
 11:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com> <87ik8b2rh8.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ik8b2rh8.fsf@email.froward.int.ebiederm.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 May 2026 20:22:38 +0200
X-Gm-Features: AVHnY4Kd5hpnbgFkWAObOULuz7Ozy8uVU638gZq5eQ2aCFurgCM5oWM6fj6Msas
Message-ID: <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with exec_update_lock
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 9:56=E2=80=AFPM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
> I have added a couple more people who might be interested.
>
> Kees Cook because as you have structured this it is an exec problem.
>
> Oleg Nesterov as he is knowledgable about ptrace.
>
> Jann Horn <jannh@google.com> writes:
>
> > My understanding is that procfs is effectively maintained by the VFS
> > maintainers (though scripts/get_maintainer.pl claims that there are
> > no maintainers for procfs because the VFS entry only claims files
> > directly in fs/, and the procfs entry has no maintainers listed on
> > it).
> >
> > In procfs, most uses of ptrace_may_access() should use
> > exec_update_lock to avoid TOCTOU issues with concurrent privileged
> > execve() (like setuid binary execution).
> >
> > This series doesn't fix all the remaining issues in procfs, but it fixe=
s
> > the easy cases for now; I will probably follow up with fixes for the
> > gnarlier cases later unless someone else wants to do that.
> >
> > I have checked that procfs files still work with these changes and that
> > CONFIG_PROVE_LOCKING=3Dy doesn't generate any warnings.
> >
> > (checkpatch complains about missing argument names in
> > proc_op::proc_get_link, but that was already the case before my
> > patch.)
>
>
> I think I finally have my context paged back in so I can intelligently
> say something about this series.
>
> The scenario you are worried about is when exec gains privileges,
> and we read through proc and authenticate with the old credentials
> instead of the new credentials.
>
> Question 1.
>
> Assuming the executable is world readable (which they generally are)
> is there anything that becomes accessible in that race that was
> not already accessible?

I believe so - the gnarliest example I am thinking of is:
Memfds are always mode 0777 or 0666 (see __shmem_file_setup, which
sets S_IRWXUGO), so their access control is purely based on being able
to pathwalk to the memfd's inode. If you can race
open(/proc/$pid/fd/$n) with the process $pid going through setuid
execution and calling memfd_create(), you should be able to get
read+write access to the memfd created by the setuid binary that was
supposed to be private.

(But I have not tested that and don't know if there are actually any
setuid binaries that happen to use memfds.)

> Question 2.
>
> How does this race compare to racing with setresuid?
> Do we need to fix the setresuid case as well?

Which setresuid case? setresuid clears the dumpable flag and has a
memory barrier that is supposed to make that properly ordered against
ptrace_may_access(); so setresuid() should normally not cause a task
to become traceable, though that could maybe happen in weird
scenarios.

I think another case we should probably care about is what happens if
a process which is only protected against ptrace by being non-dumpable
goes through execve() - it shouldn't be possible to access resources
associated with the pre-execve state while checking against the
post-execve dumpability. It might be important for this that the
do_close_on_exec() logic currently happens after committing the
dumpable state in exec_mmap()...

> Question 3.
> Do we care about the case when a privileged process calls a setuid
> process and drops privileges?

I don't understand the question. Hmm - do you mean a case where a
process with ruid=3D1000, euid=3D0, suid=3D1000 does execve() on a setuid
1000 binary? I think we probably don't specifically care about that...

I think another scenario that we ideally might want to care about is
what happens if a process which runs with a normal user's UIDs, but is
non-dumpable, goes through execve() of a normal binary while another
process tries to inspect its FDs or address space layout - it probably
shouldn't be possible to get information about the pre-execve MM and
O_CLOEXEC file descriptors.

> Question 4.
> Is it possible to use a seq_lock instead of reader writer semaphore?
> Or is that only for non-sleeping readers?

Linux seqcounts are 32-bit, which means they are always kind of dodgy,
but they are particularly dodgy if a reader can be forced to sleep for
an extended amount of time. I don't see a reason why we couldn't, in
general, use a 64-bit sequence count for readers that may need to
sleep while reading.

> There have been a number of nasty cases lurking in the background
> involving seccomp filters, PTRACE_EVENT_EXIT, de_thread and the like.
>
> Blocking locks, especially ones that get widely used, just scare me in
> this area.  Being able to see that something happened between start and
> finish and say -EAGAIN or retrying internally seems like it would be
> much less prone to weirdness.

I guess for do_task_stat() we could just switch to down_read_trylock()
instead of down_read_killable(), and proceed with "permitted =3D 0" if
the trylock fails - almost all the values shown are related to the MM,
and are therefore not stable across execve() anyway.

I think using seqlocks with a retry loop wouldn't work with the code
as-is, because in the middle of execve, there are points where the
file descriptor table still contains entries that we don't want to be
accessible with the task's current dumpability, or where we have
already switched to a new MM without having updated the credentials
yet.
I think we could make it work - we could add another set of creds to
the task, and let ptrace_may_access() check against both the
pre-execve and post-execve credentials and dumpability, but that feels
overengineered.

> The ugly with PTRACE_EVENT_EXIT as I recall is that if ptrace stops one
> of the threads (not the one calling exec) at PTRACE_EVENT_EXIT it can
> block de_thread, which blocks the rest of exec.  But there is something
> in there where the ptracer hangs waiting for the exec to complete.  So
> everything just stalls.  The ptracer waiting for exec the exec waiting
> for the ptracer.  SIGKILL can get you out of that mess last I looked.
> Still it is an ugly mess.
>
> Getting everything away from that mess is why we have exec_update_lock
> instead of just cred_guard_mutex.

And the exec_update_lock avoids that because it is not held in
de_thread(), only across the following part of execve, where not much
stuff happens that could block for a long time, right?

load_elf_binary
  begin_new_exec
    exec_mmap
      down_write_killable(&tsk->signal->exec_update_lock)
      mmput [brauner@ has a patch to move this]
    flush_thread
    do_close_on_exec [notably this can lead to filp->f_op->flush()
calls, which AFAIK can block forever on FUSE/NFS]
    commit_creds
  setup_new_exec
    up_write(&me->signal->exec_update_lock)

I think we might want to do something about the do_close_on_exec()
stuff, like deferring the filp_flush() to a later time, but I don't
really see deadlock potential here.

> I would really appreciate hearing the scenarios you are aiming to fix
> and how this fixes them.  There are enough races and special cases
> I don't feel comfortable reading that we just need exec_update_lock
> around ptrace_may_access.  It is not clear to me that is sufficient
> to close the small races we are worried about here.

The main thing I'm trying to address here are scenarios of the shape
"process A accesses process B through procfs while process B goes
through a privileged execution (in particular by executing a setuid
binary)". /proc/$pid/fd/$fd (part of patch 2) seems particularly
egregious because it can likely be used to gain access to memfds of
setuid binaries; other files are less egregious, but might lead to
things like userspace ASLR/pointer leaks (in particular do_task_stat()
and proc_map_files_readdir()).

A second scenario I have in mind is "process A accesses process B
through procfs while process B goes through a normal execution that
makes it dumpable".

The overarching logic I have at the back of my mind here is: If an
"incarnation" is the combination of a process and an mm_struct, then
holding exec_update_lock ensures that the credentials/dumpability we
have observed are associated with the same incarnation as the MM and
the file descriptor table whose properties we read afterwards.

> If I could trace through someone else's logic I could be convinced
> and the next people to deal with the code could look at it and see
> ah.  That is the detail that was missed when it has to be fixed again.
