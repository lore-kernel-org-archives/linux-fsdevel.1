Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9D382F0F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531308; cv=pass; b=L0zvOmDyMr0TMXVrVBKByWuKJxS8m4tncCcAG1/4bTmjQfGMZYkcSlipofRCHLyGl+NzFLMAUTyWH4BvZvJjDjBgtFuJEa1l/nnbTR4+JWWsEwh+r2WKLnGwAyMXKLzhr1CHzCx7lvv54BRfdw0Ad95iqANE4Wa7YpHpUATOTO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531308; c=relaxed/simple;
	bh=hTbYoner07O2PP3jB6etyoj2SkkDIbMpdGA9ETgA8QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOzVe/H30Zb8VX8fArt0umkbYzrGBnWezYKpb7HK/WN+qJ7QH6fvjRdvBhYUVI9/qMD3X9mekRriTFV+BbbddZy7G+3RTfFH3do8I/CNkKi7uXAvFjNBZyuPEWtwtGOywpuTwXheLvhsBM0zxbU3GIXKAfXvDBzHobtlzfV0hIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pqf2D/XX; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pqf2D/XX"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so8771298a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 13:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778531305; cv=none;
        d=google.com; s=arc-20240605;
        b=AB1IFujAVOgasCm9HacmjQlKhC+h3Qnfd85ycW54wLRndlW1CuHJG57mhtD5VH+7Mg
         IceovHDwfDL7f54vHXEHG2JHlC9/9IQtkqvsZ1B0Uubbhj/EjofD7z2zfn48sS/eQo/w
         uI8gI6RxVQtQUba7sJ5TWIL2YXSBu0dQthbLG3hREf76r+jNpGXCYVJ286nnro5hwTi1
         bEfvbvF6DhuG9/wNF/nDcZiN/LKM/A5TE6lj3+p+nLmuwpJZYgsImAvSWQHo3wHAiS2g
         97o7lk4zGl50PJbRDkvBhNVXuvryQDsEq7GI+N/M+2gj+e0jGGeHyh2MXtuWAMSyGyms
         4FOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        fh=dUHrfw9BWRdb3jiK3a4vF0Ftp+OqKu3JYtObDk6EGx8=;
        b=VNoVpX8fPVNtB8SRD7vaBUZ2qghT+y8gD4HROYwi5QnYGWbF/bOP5QsVXJwOvsnxoD
         q2hPyv2A+C7eFgufWBx0LJUyqJyu2Y51WfqGlAZtraHg+WCwGa28UM2AahFj8K7T13mg
         V8m3hO05EmkJYO8UyPXo6iuf4FTq+49wBPjCcAPtjeTu+eDjIX/9Gcwc5lvmdEp/4fmx
         MYnyKcD1feRp6+q6kXEB0kUsDQ27N/jtRjcode5sqH42gWDegt0XZHo4CaUUgAaltaWA
         RjdwVLHfzmXSot5f44/JzsvJEPftf1+HnIgXVyUxqbs+MOQJsrWfVqlW7a1IdMfoLqqT
         qntg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778531305; x=1779136105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        b=Pqf2D/XXkXoZWPZHQqMY9IBZsTPIzZc2s8hRWTLCIWWh/mCQNnoBCNusWpQOqSxv/M
         30btj8h0UrFnnMsiDnTkMr4mTshByweR1IFq8Cw7xpE5sbpgMjkfIWAIe6bmq2ud60M/
         lWdAm5DtQkIVu7LGk2lBHjld6eiUve2zjik9wv5Je1M48kL8miY1mC8QuCNlg0QUT9c4
         nSZfVBr2RZcJneAM++otv/6PpeB69KFfmV763eRrDzCDclvTtsgmy9FVK0C37xUfOBDB
         +8oxIhRLfsmOVYrtt2u1RAsjRCaJUQTwAW04tUyadp67+w3b8/KYFC5imeXFdAPE+sCl
         n2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778531305; x=1779136105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        b=jlB+lnt0LjTqh6uPeYSel5yoGre/KIlsZaQ0q++WTZv/p7BjfjyZmOTq6xUBTo8+JL
         ew5AesMJd4c8+5NgHjEUzLMsvXsIsQD52qM36/IrpKYbNx6dugy6ELP0iwKZeFvQPDMC
         DGux9IRU4olQHxFPXdh23Z965q+iNZ69Dsc4yCFVP49N9Esu0KmZF1L34I7x5V3SbRUz
         pIWNQqpBZcnnBeZmhpwvNwaMzHNK70xW8YyAAqIyOl/xLjWrSSOYgiQZQIlts+X5LJwI
         VWn23ktESz8SHPhjR5KJqUQr8qk//vDXhnVJ1N/y+iq/8abD0KjDanJFSohcV7H14qln
         VMOA==
X-Forwarded-Encrypted: i=1; AFNElJ/1YcKfvJD6/C1N+vDEXVYe12SRQ8vEAfOGR6nQlQQGxopZfFvCg15z0mNYdmSnpu3IDKqq6bg0JnRE4DQ0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb36sgVWlSqmqaKJqaG0my/DWPu9S9v4VrKdx4FNDujNOCC9G0
	5D5wLqrkf6zibHT6bTz66zopaMBDgsCRAFwpjaRuTPNmde6MmIXaVqA52xT4TkHNyeDSTNNJOgB
	Spcj0kUqWVNJF18JoU1TmPD6C9j0505ISCm1PWM7K
X-Gm-Gg: Acq92OFxZP2edYtAp5snRdm8654ydub35U5eRN476SlZ5waBxzgo/S7dDaBc8d/ZSbK
	aydx+FNW+3n4gQU+R3Ni1x61YKydagFub2mRnH9+cyeIjXa3J2aamKpv+lcjteAY5+nyZXBqn7T
	ojCVzBmPzgc2YQ88nEUNZ6PWj2r5CAkTat9vCwtFf92zUYoGqzfanu2Kh1fqNKC+VnZP1eAnw2K
	xgEQheovxTvDOvlXZ1pLyFoL8heaH42isD6R3BGWhjQz6K1WN9vy7eZmWPbFbpSalUTjdSec2xC
	Hd88j7ZLUCMkCoTEqg==
X-Received: by 2002:a17:907:782:b0:bba:5bc9:534a with SMTP id
 a640c23a62f3a-bcaac45410dmr950342666b.31.1778531304034; Mon, 11 May 2026
 13:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509213803.968464-1-atomlin@atomlin.com> <20260509213803.968464-4-atomlin@atomlin.com>
In-Reply-To: <20260509213803.968464-4-atomlin@atomlin.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 May 2026 16:28:09 -0400
X-Gm-Features: AVHnY4IuuqYYRw63FqWoEIYPWMqlZqNzlszYso7NSfFe-A6xx0Cnf7u9P8UUKq4
Message-ID: <CAHC9VhQthq7y2akbQSdJwBEex1MQYWG49wcJK3b8gSQuQ_d1cQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, jmorris@namei.org, serge@hallyn.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, 
	casey@schaufler-ca.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, chenridong@huaweicloud.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, cgroups@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 5:38=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> w=
rote:
>
> At present, the task_setscheduler LSM hook provides security modules
> with the opportunity to mediate changes to a task's scheduling policy.
> However, when invoked via sched_setaffinity(), the hook lacks
> visibility into the actual CPU affinity mask being requested.
> Consequently, BPF-based security modules are entirely blind to the
> target CPUs and cannot make granular access control decisions based on
> spatial isolation.
>
> In modern multi-tenant and real-time environments, CPU isolation is a
> critical boundary. The inability to audit or restrict specific CPU
> pinning requests limits the effectiveness of eBPF-driven security
> policies, particularly when attempting to shield isolated or
> cryptographic cores from unprivileged or compromised tasks.
>
> This patch expands the security_task_setscheduler() hook signature to
> include a pointer to the requested cpumask. Because this is a shared
> hook used for multiple scheduling attribute changes, call sites that do
> not modify CPU affinity are updated to safely pass NULL.
> To protect against unverified dereferences, the parameter is annotated
> with __nullable in the LSM hook definition, ensuring the BPF verifier
> mandates explicit NULL checks for attached eBPF programs.
>
> This change updates all in-tree security modules (SELinux and Smack) to
> accommodate the new parameter mechanically, whilst providing BPF LSMs
> with the necessary context to enforce strict affinity policies.
>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  arch/mips/kernel/mips-mt-fpaff.c | 30 +++++++++++++++++-------------
>  fs/proc/base.c                   |  2 +-
>  include/linux/lsm_hook_defs.h    |  3 ++-
>  include/linux/security.h         | 11 +++++++----
>  kernel/cgroup/cpuset.c           |  4 ++--
>  kernel/sched/syscalls.c          |  4 ++--
>  security/commoncap.c             |  7 +++++--
>  security/security.c              | 11 ++++++-----
>  security/selinux/hooks.c         |  3 ++-
>  security/smack/smack_lsm.c       | 11 +++++++++--
>  10 files changed, 53 insertions(+), 33 deletions(-)

I haven't looked too closely at this patch yet, but based on a quick
glance, can you help me understand why it is included with the other
two patches in one patchset?  The other two patches look like stable
level kernel bug fixes, while this patch introduces functionality to
an existing LSM hook; one of these is not like the others :)

Unless there is something critical that I'm missing here, I would
suggest splitting this patch out from the other two bugfixes for
separate handling.  If there is a patch dependency issue you can
always mention that in the cover letter.

--=20
paul-moore.com
