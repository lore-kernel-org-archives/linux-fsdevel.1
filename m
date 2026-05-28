Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E42BEC45
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978079; cv=pass; b=ZyOVqeyOZ8R4MTdH57nx7kuqIotab5umVTpgKCWHsBuZ7WyicLBInbRShhbCT/ntlKbcIK85IoXdUyzA1zcTp8F5qtmLKpCJbZcRfFNgwLeu+xhnL5/X2+V11MGw+aEQ4uqxtCqdmpppZz2a+Tl19XxpogpzeyfU9TipEnqaQ4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978079; c=relaxed/simple;
	bh=js34c//je42ehN93ZjJa3FU5a9BRF/ma1UygPPSGroA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAJbm+2PcPNt7KjjJ2sfd7LFZgiLnt7IFDOzaeOvtLUFfmF/HzOVNwgf8fLIWFnAbPNQ4TgLp3QLYoEm7OzbJafJaaRdCHKk4Vc1sSk79zQyHt+G0mSqXouL3Qm6KrIqzOId1fqpUC4MsgBKUACLRrCGLWnbSalTHPn1lBbY5GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=auhMhcSU; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auhMhcSU"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso137a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 07:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779978076; cv=none;
        d=google.com; s=arc-20240605;
        b=kIniufyfbyYFauyNGfRtMpSWF8wX2fQklSoYzyOG7Ig+xH5OUb0NrgSB4UaACIc6ef
         coAsLuVkE92PpJoOcZcBYdXolM0Ebswr5H5JsP6batR5B+1Gv+pm9jL7oaZJa3BvVnWu
         oTdFG+amKtzVtfrz80UcvkL7ojag+aTX/WjzsnOqId3MsCPIEinWMBlfhGnHkWyBbaHz
         Q4pGEMVw4Zdgh+4O82zffh2glkSCbDB988hLAVR6b2H5UNdHvZgQQugwHLqcY9IP5lh1
         e3k7Uf5OzRtH471tFhLupjhj1Nfeuv3JYzWee1edEOABNsKadiXBM4nKQBYFxq7/YLDT
         NG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KF8uuHRKhzu9ZemQbfUrK/7gicBvewdCR8gP+EPI77w=;
        fh=vi4LljKgyhhbrMGyY2/aaHSmRG19kHdZ4Yq3ICTCM08=;
        b=V8a/PzaV0vSNf2x0B9p5eKLe8fPme9mhFrF48jiS22/4n/Neu8iAuvHQ5HObgCQZgZ
         lJAbUd8qkwsV1HvzSmlDApiraBsZeT/1CzG8VPq/zXJ/xl8MEnuIw+Kv1fqP5+PMCzH0
         viKTbAv9BtJ6kZDVrLsGYlexdCCl+NsXp8aLSgEfOIICXFlKh7a70BuMeNIdLN2UdlYx
         9AVF8WMOkt1wrxTt6Ug/za3M6haEbH+n/T2bZ0SpD04Iys8v+1kWzKlcI3IiOsHH5HLr
         rF3ONVwJK+MV36oiSBgeNvcQQL4oKjvBLMScykShoJpdFAo1kNcvwPneLT9iQChMBKyu
         MdmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779978076; x=1780582876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF8uuHRKhzu9ZemQbfUrK/7gicBvewdCR8gP+EPI77w=;
        b=auhMhcSUOfqf1SDln+pkwcH1LO0LM5tOZ68iAt1WXhvNbtiGRp66D8KwdwOcsD/t7x
         ryxmnx+YviSbjQL39qcu4Q6irzP9DR8WHuNfXsqCRpHqNk3VzmiOhcRzq8bAVbxwPB9U
         ROSDkJmDHinuIw3bNFi5rm44TVwv5bYybATe6BgaEqaF6UeWy7+rrsQAMYVIYsIUqr+y
         0gu1vMUh5SjJtslG3q3DsPdoloEEixrCkYL+4hWB6hf5+JYDLGHU2IJUcSOKGliytVRQ
         8n8If5L/wsBLzkm2WDzrYLIUgxe1KbCfcBb9DLGH+Zvigg4cNPArmWPaNfekRm42qmG/
         DnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978076; x=1780582876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KF8uuHRKhzu9ZemQbfUrK/7gicBvewdCR8gP+EPI77w=;
        b=W+aS3pmHGi9o3fqCkM4Hlmel8w4cuBHs+5fs5RGBs5RTeOxyZUW28e8YtVN2VeLvE6
         4UzYlR8lXqTiaF3YGABJLXNHoA1t5HMNvAQQfMbqFCBey6oWJXfzuGC1c+cyQSFMc8AC
         RUKJcZc3eF/MEk1o25c8phqC0pufTeXGRf3JLdvWgM2osWultry3BN1O9N6cFP219XmA
         kG0Xgfle8frMZXthobfbqWUeEomghezAsmt0Isl4roHLdPE31DM/KRQVbMNgxUcQeyad
         XDlbQlXsrrJf7s37Y0MEn3ishagPHHj1jx+4zI+3QdaTCGCUEHSXlw85g4UWh3ZwwT07
         mlRw==
X-Forwarded-Encrypted: i=1; AFNElJ8O0v2DNjmx+K68QL5WD52Yzkw+OnoyEV8hhubRMCMkxmHX8+2mN7xpG2SuTY9d1/OH69P5phj2+o65TrP3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0aZl1Ns0z68/Alf9hqz4ajkt7vanGUgAUXizG+wAb3NxoxdA+
	j5Ij3R8DT8QMC8NpU5vhUUgNTsdou7EL1SpKmI/44V3h4Y74WbcRMSqvVpp0ltmaZXlqz892jqr
	LxJZ6NBip3ylfb9AD5Ev8vmZaeTlSXw8sbxIcPj8U
X-Gm-Gg: Acq92OFPJ9IKM3DaTcGYs51HD5TEJHWXUKwnrLb4Vr5RO7Kq4boBFEvGdvo/X9IyHo7
	Nv48fdk/mZofliA1jxi0A46NOBmLhbJMYDsW0ULG+KwqGwFWAKDrwBl+9vaiobL2rmUoIPwJFh9
	+vk0lJ2EvPEPxVU62aa1hjx/XpSnK5O7f0fM5fg6O6/2biNbaOIO0da2Jx1EQjTqKa59LCP9xFa
	009/I9ak52wex5Z5oibO9uGfV9tm4x3DXZcs42NDe/uuk19uyFPSsJSQUjK3P7NBVg+CxW/H1mP
	idacQVXrwk+U7rnQ2GX2JBgvcG9Vcdqa0KgnyB4mX7+p/4bi
X-Received: by 2002:a05:6402:128f:b0:67b:6d1c:9585 with SMTP id
 4fb4d7f45d1cf-68b1e0ba9c7mr37591a12.8.1779978075876; Thu, 28 May 2026
 07:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <87ik8b2rh8.fsf@email.froward.int.ebiederm.org> <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
 <87wlwny905.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87wlwny905.fsf@email.froward.int.ebiederm.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 28 May 2026 16:20:39 +0200
X-Gm-Features: AVHnY4JlrfOEpU_4BQJnUmH3-05d24mVTy1oiRn0qweLdreGyUfEGpJa7KT7h7A
Message-ID: <CAG48ez3Wp757fQh1gyTxf-k3p__utUOWM8xdJeUig4gPpSmTEA@mail.gmail.com>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with exec_update_lock
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 3:11=E2=80=AFPM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
> Jann Horn <jannh@google.com> writes:
>
> > On Mon, May 25, 2026 at 9:56=E2=80=AFPM Eric W. Biederman <ebiederm@xmi=
ssion.com> wrote:
> >> I have added a couple more people who might be interested.
> >>
> >> Kees Cook because as you have structured this it is an exec problem.
> >>
> >> Oleg Nesterov as he is knowledgable about ptrace.
> >>
> >> Jann Horn <jannh@google.com> writes:
> >>
> >> > My understanding is that procfs is effectively maintained by the VFS
> >> > maintainers (though scripts/get_maintainer.pl claims that there are
> >> > no maintainers for procfs because the VFS entry only claims files
> >> > directly in fs/, and the procfs entry has no maintainers listed on
> >> > it).
> >> >
> >> > In procfs, most uses of ptrace_may_access() should use
> >> > exec_update_lock to avoid TOCTOU issues with concurrent privileged
> >> > execve() (like setuid binary execution).
> >> >
> >> > This series doesn't fix all the remaining issues in procfs, but it f=
ixes
> >> > the easy cases for now; I will probably follow up with fixes for the
> >> > gnarlier cases later unless someone else wants to do that.
> >> >
> >> > I have checked that procfs files still work with these changes and t=
hat
> >> > CONFIG_PROVE_LOCKING=3Dy doesn't generate any warnings.
> >> >
> >> > (checkpatch complains about missing argument names in
> >> > proc_op::proc_get_link, but that was already the case before my
> >> > patch.)
> >>
> >>
> >> I think I finally have my context paged back in so I can intelligently
> >> say something about this series.
> >>
> >> The scenario you are worried about is when exec gains privileges,
> >> and we read through proc and authenticate with the old credentials
> >> instead of the new credentials.
> >>
> >> Question 1.
> >>
> >> Assuming the executable is world readable (which they generally are)
> >> is there anything that becomes accessible in that race that was
> >> not already accessible?
> >
> > I believe so - the gnarliest example I am thinking of is:
> > Memfds are always mode 0777 or 0666 (see __shmem_file_setup, which
> > sets S_IRWXUGO), so their access control is purely based on being able
> > to pathwalk to the memfd's inode. If you can race
> > open(/proc/$pid/fd/$n) with the process $pid going through setuid
> > execution and calling memfd_create(), you should be able to get
> > read+write access to the memfd created by the setuid binary that was
> > supposed to be private.
> >
> > (But I have not tested that and don't know if there are actually any
> > setuid binaries that happen to use memfds.)
>
> I don't know about memfds.  I do know it has been a concern in the past
> about opening proc using credentials before exec and then using the
> credentials after exec.
>
> We certainly closed some of those races, if there are still some
> of those races present we should definitely close them.
>
> In my thinking there are the set of races that exist because we fail to
> present exec to userspace as an atomic operation. Then there are larger

Yes, and exec_update_lock is how we make sure we can present the core
of exec to userspace as an atomic operation.

> set of races that exist simply because exec happened.
>
>
> Looking at it proc fd's currently rely on the permission checks
> of the file descriptors themselves and don't make any guarantees
> about the path.

What do you mean by "the permission checks of the file descriptors themselv=
es"?

> The issue you point out with memfd's definitely needs to be fixed.
> It should be separated out from the rest of the races simply because
> it is a completely different kind of issue.
>
> I wonder if anyone even anticipated you could open another file handle
> to memfd's through proc.  If so leaving everything to path based
> permissions assumed a feature of proc that doesn't exist.

I don't think memfds are particularly special here, they are just a
nice, clear example of a case where an inode is protected based on
which processes can path-walk to it.

As another example: Making a directory mode 0700 is also supposed to
prevent other users from accessing things inside it.

> My gut says the best fix for the entire memfd issue is to simply change
> memfd's and probably everything that calls shmem_file_setup to not have
> an open method.  That eliminates any chance anyone will do anything
> clever with proc.  But I can't see why it makes any sense to be able to
> open another file handle into memfd's, or anything else that calls
> shmem_file_setup for that matter.
>
> We can first try to remove the open method of memfd's set by
> shmem_file_setup, and if that doesn't work we can look at fixing proc to
> provide the guarantees that were assumed (as a security fix).
>
>
> As a quality of implementation issue I can see fixing the small race
> where when looking up a file descriptor through proc, exec does not
> appear to be an atomic operation.  I keep wondering if that is something
> that should be done in get_link or d_revalidate.

I don't see how d_revalidate would help, that still wouldn't be atomic.

> I suspect the answer for proc_pid_get_link is to either cache something
> like a seqcount, or simply to repeat the permission and existence checks
> just before calling nd_jump_link.

That seems like it results in complicated semantics, while a mutex
would provide clear semantics. Which is already what we use in places
like __pidfd_fget() and /proc/<pid>/syscall.

> >> Question 2.
> >>
> >> How does this race compare to racing with setresuid?
> >> Do we need to fix the setresuid case as well?
> >
> > Which setresuid case? setresuid clears the dumpable flag and has a
> > memory barrier that is supposed to make that properly ordered against
> > ptrace_may_access(); so setresuid() should normally not cause a task
> > to become traceable, though that could maybe happen in weird
> > scenarios.
>
> The cases where the dumpable flag get set are all part of exec.
>
> I was thinking of cases where we have a daemon that is started by
> root and then it changes it's uid to do something.

(Normally such a daemon would only change its EUID, which is mainly
considered when the daemon acts as a subject, unless it intends to
permanently drop privileges.)

> Looking at ptrace_may_access the uid based checks won't allow
> accessing of such a task unless it changes all of it's uids.
>
> At which point arguably it is on the process that calls setuid to make
> certain ptracing it won't be a problem.  I am not certain that ever
> actually works in practice but that does seem to be what the current
> code is saying.

When a daemon changes its EUID for some reason, commit_creds() will
change that daemon's dumpability to suid_dumpable, which will prevent
ptracing it even if the UIDs match.

The ptrace.2 manpage guarantees that a process which is not
SUID_DUMP_USER can't be accessed without CAP_SYS_PTRACE.

> Now I am wondering if dumpable should get set if setresuid changes
> a uid like I described above.

What do you mean by "get set"?

> > I think another case we should probably care about is what happens if
> > a process which is only protected against ptrace by being non-dumpable
> > goes through execve() - it shouldn't be possible to access resources
> > associated with the pre-execve state while checking against the
> > post-execve dumpability. It might be important for this that the
> > do_close_on_exec() logic currently happens after committing the
> > dumpable state in exec_mmap()...
> >
> >> Question 3.
> >> Do we care about the case when a privileged process calls a setuid
> >> process and drops privileges?
> >
> > I don't understand the question. Hmm - do you mean a case where a
> > process with ruid=3D1000, euid=3D0, suid=3D1000 does execve() on a setu=
id
> > 1000 binary? I think we probably don't specifically care about that...
> >
>
> The general case would be a daemon running as root forks and exec's a
> binary running as some unprivileged user fred.
>
> Mostly I bring it up is that it is easy to forget suid exec can drop
> privileges as well as raise them.

I do not understand the scenario you're describing. Can you give a
specific example you're thinking of - what the ruid/euid/suid would be
before execve(), and which mode the binary would be?
