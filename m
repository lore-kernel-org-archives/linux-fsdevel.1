Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E403AFB1B
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359473; cv=pass; b=neh61CaxV+LBH2HEZo67zXp7JFnKMrNEAhbkY0R+5nfKPc4iUleU9LowmqGi2xMMgtJDsRNtq4SKBdXMU/y52x4nIJ9nYq4ACb+SACcrM7nUfJog1blZMEChCAO6/xrVrj5T6GMeD/zbccok3WySOnbE7Wme509YiPPDTrqfdKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359473; c=relaxed/simple;
	bh=/ov/oJDajg60+/1Jf5V77ysbHovwMkIoCAEQSrYcsfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X42Y6PWNcDS7TgfzDPVPR/hNEcOBj8lm92P9OFxTlWGFlZh2QDhiqQcEG9ApJh4mfkPpC6RK/On19NQZ3mSCXTqVpuvR+GNLlXs0umxiKkS/YQDYId7kM/uS/q0Oa6DHjEUpQhMQahCaI6IJJD7RTR1vVLvZVZ/CGfW+5EX4Tiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGmCy6ng; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGmCy6ng"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so1841a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 10:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783359470; cv=none;
        d=google.com; s=arc-20260327;
        b=nK5fZEWEF/U+tXGBvVdWUHsNPDDn1zmYzpv0XRlLljOO/+cRT58TwWgaYdmFwqEkjq
         Z8AmFou6tLdwN18qPIrP1HjhU3NaXjA+hhpHGY8i1OFFLfwJXD5ENaK4FWAUbZ8N8nPk
         3yz3hIRWXJfXffCg1uYdHK5BwFx2UDL/ELc3m9r03w6gJ9cuRYTeth0BKVGjUey5e6iQ
         jQvkgrHPcygFKhM6PCSqTiYWDJlGccIL/oPBWVgcEYHwwo2IOuh7GRxdu7vaQbbC55jU
         AQnQcg6RX0Om6CIGbGoUKQgf7IJMtQY2YVpxFxL2NOwAjUHvYBl04vz3SOGasTiPOgcn
         513Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0ToySm9sdXZDhUFhd22xgEZyfnQc2RHn2Z1qk1nCplc=;
        fh=5+rIq5joilyZSOjjmt2DQn4B98r7SFwFGpTAtybR2oI=;
        b=Pwgc6DwJnmLSz3B1FOt5VNs7eINAHb8fpebvaNdrbbEr1StxOz1dxgxEFBrVG/9axu
         98NrcBYhCYx409g8EE9qBUVJR22I8k6uHg8NfEhmfJp5cN94gTeIakQ1nQEWUgxbQmwS
         LN31dtTy484wGd+FunlzHGf39c2oDE6mGH2ttj8Am3RCgVrhtMGR5DE3XKDYBjguZ1mb
         L+OYQDuewF2OwYe19fG+CNJA1X2DpvriTFxVp9jctRALF+l1UHZFyh30eLna1G4W1vBH
         vSXHOPd3IMu2IAGFc5K+7bepwwKIpSA9usHpEm6gUH8sZrspl77orkK6qO7mAk30Vhla
         BhQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783359470; x=1783964270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0ToySm9sdXZDhUFhd22xgEZyfnQc2RHn2Z1qk1nCplc=;
        b=JGmCy6ngKu1ByMNZYiLES/IXUnRP3DDSVKkh1ilV3WnKDzPZagRxJzvl3vvNSBzhfW
         9+0zAcuv91jUbMA9zucdlc+umr7Hd633zEUoZAspke4MwRCLjfjTI3HQ7fH9JQ6DayUt
         evx1bFT2iiJ9Us9o71VcJ+agaVr6+MMRMD68KyjobXlUrKAt3WCQO7SJCwRE3vzNiXa+
         cDomVIHZZdrnZB4Dk7h3W4MMctL9mbzBx+iFA7FjM9IoCkou/SAdmr7h+vg71UQ10/Pp
         59sjnfQLzWQmEp/in85EHS13674QJyNrkDGzB2KHDdfDJyHjRJEb/o98dIQSOndjTF9b
         iK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783359470; x=1783964270;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ToySm9sdXZDhUFhd22xgEZyfnQc2RHn2Z1qk1nCplc=;
        b=awwGUXtV8BKKgl5JjJMTNC2SNT0fQCYZvObf1/XH4111U3dA1ys0sISSbgkBw0S//E
         m/z1+ZCnEL12KznKj6SRhbqNXz0bzWFMsUaLZ6migk3ipbUggYMeJE4w1rrYYJBM1Pne
         gwJJshP/ri6ulk6VcIO3Gx30xj1XXtn9/q9ew4mCJ51H28HqJ5sINu50gkfaLfwGmYmr
         S2EkNDqYVb4qV1YoT6mKV0pkxRbyZl6LRFSnEEfKvG/IA5YsnIOBiK1U08b2Qfwokyip
         aHFmBgkNuFBWHX3FkhcJvFUre7gamXVkUvUr5g5d0TWHwu0FRL/awL701fNtcUue86lU
         nnVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIITF9x7oNzype90Uo9uDzYabSX2HQdObpbM6qs801WH97dpMPaztiKxZJ9zEMPKXYD+NgrnnSdQcYrP14@vger.kernel.org
X-Gm-Message-State: AOJu0YzXDGjlAoAwubP6X9QREJ9TnlZID4Y/9BeSTBPov1CSGWdFBXcT
	88lgxTna9GEaAwRuJQpNNLH7tPC8sDsVNuSHdxoATu+Xj+uJaQ/QrKdR4poCFZr+kcQNh8Ip6x8
	Jt6LxZJ/V8nLwMYO1neg5da4NJpdaC3u2obZyOMj7
X-Gm-Gg: AfdE7cnXkw+OWYT4gVZGGSea/GMaxtfjeVGnlpi5v0gQIT52t1BxUW6VEPceK3m4kR0
	+A/zMQJk8olnvVr0Q/D1jxc7SuiD+paJ45eJT3xLAZtumwJP8P91c4tXKGOh/ESlMFTXIOazqN5
	YUEnUuDXNgl85VOzOHrpt/jFdmFCDcWpV720CG/EZFNj/0v1YbeTjYtJ57Q6D8aGaAZpg4kGYF8
	TY6bd6bspWkM6kB82vrly3C20dXr4tI7wpgFa8mVlxSd7G71xiBLLCP57rDxrNoFginNOcCfxYe
	qjkMAGGJ5KXYOYMUD9He4CCSzcaZZsS6PmOBEdZ8QZVe/jpIZbEs7VJ3Iw==
X-Received: by 2002:aa7:cf8f:0:b0:697:df76:63f8 with SMTP id
 4fb4d7f45d1cf-69a8d621d82mr8737a12.3.1783359469595; Mon, 06 Jul 2026 10:37:49
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com> <20260706170735.2941493-1-linmag7@gmail.com>
In-Reply-To: <20260706170735.2941493-1-linmag7@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 6 Jul 2026 19:37:13 +0200
X-Gm-Features: AVVi8CcVJXVs9Za7dkHp0FtOPRhNOtgRYHBgVe072i_oqyBaAQXTbXT7u5mkRfg
Message-ID: <CAG48ez0ebrMy8QGKLuz0Qwao_Eiav6e5pAJ5f6GrUPJLRkwNnw@mail.gmail.com>
Subject: Re: [PATCH] proc: protect ptrace_may_access() with exec_update_lock
 (part 1)
To: Magnus Lindholm <linmag7@gmail.com>
Cc: arjan@linux.intel.com, brauner@kernel.org, ebiederm@xmission.com, 
	jack@suse.cz, jake@lwn.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 7:07=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Hi,
>
> while testing my Alpha generic-entry series on top of v7.2-rc1, I noticed
> that several strace --pidns-translation tests started failing. The same
> generic-entry series on top of v7.1-rc1 passes these tests.
>
> I bisected the regression between v7.1-rc1 and v7.2-rc1, always applying
> the same generic-entry series before testing, and the first bad commit is=
:
>
>   6650527444dadc63d84aa939d14ecba4fadb2f69
>   proc: protect ptrace_may_access() with exec_update_lock (part 1)
>
> Examples of failing strace tests include:
>
>   signal_receive--pidns-translation.gen.test
>   so_peercred--pidns-translation.gen.test
>   tgkill--pidns-translation.gen.test
>   tkill--pidns-translation.gen.test
>   fcntl--pidns-translation.gen.test
>   xet_robust_list--pidns-translation.gen.test
>   xetpgid--pidns-translation.gen.test
>   xetpriority--pidns-translation.gen.test
>
> One simple reproducer is:
>
>   cd strace/tests
>   ./xetpgid--pidns-translation.gen.test
>
> The failure looks like this:
>
>   ../../src/strace: NS_* ioctl commands are not supported by the kernel
>
> and the decoded output lacks the expected pidns translation comments, e.g=
.:
>
>   - getpgid(2 /* 6 in strace's PID NS */) =3D 0
>   + getpgid(2) =3D 0
>
> Looking at the patch, the relevant part seems to be the change in
> fs/proc/namespaces.c: proc_ns_get_link() and proc_ns_readlink() now take
> task->signal->exec_update_lock around the ptrace_may_access() check and
> namespace link/readlink handling. strace's --decode-pids=3Dpidns code app=
ears
> to rely on accessing /proc/<pid>/ns/pid for short-lived tracees in a nest=
ed
> PID namespace, so this looks like a plausible connection to the failure.
>
> The kernel has the relevant namespace options enabled:
>
>   CONFIG_NAMESPACES=3Dy
>   CONFIG_USER_NS=3Dy
>   CONFIG_PID_NS=3Dy
>   CONFIG_CHECKPOINT_RESTORE=3Dy
>   CONFIG_PROC_FS=3Dy
>
> I also tested the basic nsfs ioctls with a small standalone program, both
> outside and inside "unshare -Urpf", and NS_GET_NSTYPE,
> NS_GET_PID_IN_PIDNS and NS_GET_PID_FROM_PIDNS all work there. So the fail=
ure
> does not look like missing namespace support or a simple ioctl-number iss=
ue;
> it seems specific to the proc/ns access pattern used by strace's pidns
> translation code.
>
> #regzbot introduced: 6650527444dadc63d84aa939d14ecba4fadb2f69

Hmm... running strace on strace, I see this:

669   openat(AT_FDCWD, "/proc/469/ns/pid", O_RDONLY) =3D 5
669   fstat(5, {st_dev=3Dmakedev(0, 0x15), st_ino=3D1792,
st_mode=3DS_IFDIR|0511, st_nlink=3D2, st_uid=3D1000, st_gid=3D1000,
st_blksize=3D1024, st_blocks=3D
0, st_size=3D0, st_atime=3D1783357140 /*
2026-07-06T16:59:00.713036792+0000 */, st_atime_nsec=3D713036792,
st_mtime=3D1783357140 /* 2026-07-06T16:59:
00.713036792+0000 */, st_mtime_nsec=3D713036792, st_ctime=3D1783357140 /*
2026-07-06T16:59:00.713036792+0000 */, st_ctime_nsec=3D713036792}) =3D 0
669   ioctl(5, NS_GET_PARENT)           =3D -1 ENOTTY (Inappropriate
ioctl for device)
669   write(2, ", child_tidptr=3D0x7faa62d54a10) =3D 7", 34) =3D 34
669   write(2, "strace: NS_* ioctl commands are not supported by the
kernel\n", 60) =3D 60

So... /proc/469/ns/pid resolves to a directory somehow? That seems very wro=
ng.

root@vm:~# cd /proc/496/ns/pid/
root@vm:/proc/496/ns/pid#

AAaaah, darn, ok, I see. The patch contains this change:

```
 static const char *proc_ns_get_link(struct dentry *dentry,
                                    struct inode *inode,
                                    struct delayed_call *done)
 {
        const struct proc_ns_operations *ns_ops =3D PROC_I(inode)->ns_ops;
        struct task_struct *task;
        struct path ns_path;
        int error =3D -EACCES;

        if (!dentry)
                return ERR_PTR(-ECHILD);

        task =3D get_proc_task(inode);
        if (!task)
                return ERR_PTR(-EACCES);

+       error =3D down_read_killable(&task->signal->exec_update_lock);
+       if (error)
+               goto out_put_task;
+
        if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
                goto out;
```

and that is wrong because previously, the ptrace_may_access() check
relied on "error" still being "error =3D -EACCES" from the
initialization at the top of the function, but now it is 0 from
down_read_killable(), so now a ptrace permission check failure causes
us to return with 0 without actually having called nd_jump_link(),
which I think means we end up staying in /proc/$pid/ns?

Sigh, I will send a fix.
