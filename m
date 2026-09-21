Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98C0431E65
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022171; cv=pass; b=KDKRd+NuRP1imM2QbJit47BrGmh62FkgcT/711sCQ96cStFANYVzaT8iRG+Ui9LNkiyR8akSD9ncrJDQg9kDgXqcauRyoTR3KHe/2UP9URGYOkyTKVtnMSCdhmZYRa9sG752920ziQyHLu7NMLaOK9z3bfo1nyXr6yN7kz4M0/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022171; c=relaxed/simple;
	bh=5AoAm7kCydoLQsr+i6jrfa1JthOko596jNaE8bcwdh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/9jz6YVjsCdggChRCezG4hHihsKWJfem5hZy14ivhSmm7t8D/sRdqf/kmtjpZKmzHVWKfE9JWJKW56dwhgpSeDd0katxr5wAU/GLaXdNmOfxVppLzrWnZRxiSggy/fGGSzjJ35dlGfO6Rqnqdb3P7fa0qzIfQK95ea3UMMes9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NZPUSklz; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZPUSklz"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d8facae850so11225ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 13:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790022169; cv=none;
        d=google.com; s=arc-20260327;
        b=MLSMnDnfznZmJb8joOCMu30FOflMbFi6aWeHfXzYQbOLhMhCDagx5sRzX1sHTotMKf
         1ihjqcfNCdQB60bi4fhltNS9xo8LwqnIGsc9kpvlWthidyumw/7pNydRafGGUZ7mNp/5
         W/Db+r/AMaAKHhbF3bUyxp2PbBOUgIxekCUl027bJsLJ4vhHhDjd3Ny+D1dMaXpEDuV4
         CA6YvX1azfI8GyEe488wNSBabNvWkaowQ9+6G+Rhpj9FQAXIj6Aj+Nohl6A6LbxlruAm
         yDjFjMzwmqEzKujQ76f1fhbaupqJOyvSiIoFdnHBZZvnG8SBqybGUR8l3Ny16V2K91d6
         ERog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZjuQxZbTYuwf9RVKp56gufP8tt1Juurh+o7CdzjxoY=;
        fh=EoJMXULwcNdYqhtNpZCMKNl6w+cGMpZ9WMjNVFfYRX8=;
        b=dKW4WOoyetRxWrqvmNUZ7RGBhWyvG/RnwlTtpu+Vt6bymkxiox95+t8EorqY9rpUdX
         gB+fnK9aWZku9gxAsweKoummqxbcgPM+Ot8lwQtjj1hTcKZhA7e+XGJTC8OPs6k5JwqC
         4suf0SnQc/2E6Xr2pgmIdhtIblDtlTLmEbwoaLWm2TnkC2SnsmdHOkfLRTHP31RwYDDE
         Qqa9Fert8Bai2U5eZVIWw7oa1SFLLt8h7QzVcYaWHWdKOladBdrQwY6lfqfQHAvMKD3A
         fdeln4/gwT72UlSAZawojIvTl2eoPWqxtvQWHqKRV98sxFUWTxyw+F7rLIEB/fQkCYyr
         eZDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790022169; x=1790626969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZjuQxZbTYuwf9RVKp56gufP8tt1Juurh+o7CdzjxoY=;
        b=NZPUSklzX91cqloY9UWtg2FDsu0QfMamuJIYh37mCQ9uf8iUvDG0RLPZntzjk1dmtD
         j30Y3/Xf33ZxYFl6lIwIMluHu7nOiazNqy/dpeU9I8gUZtgdHC3CXbY6//v3bB87r+08
         grxj/3LDypylKj77WsDYjH5dtlSXr6AJWE24kb1caw3yYTfO0IQjz7vGOeCV1cSNR3E0
         JHrAj6AIC+7RYM+jMWLd0KQJ2JdAucmtx5xouyALxCr2ybiboglaHeksRYJhqo5wClAs
         UBu7Y6CRvu0ujbQHCqQIoHNsMpTGP6QF7M2O4Vjso6zCq4anfXZgyG2Wyn6sY/32aSCv
         m8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022169; x=1790626969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZjuQxZbTYuwf9RVKp56gufP8tt1Juurh+o7CdzjxoY=;
        b=az8b3sn0jomGmsy7td6eCw95vrspO8HMzqOkptH+YilJQwvlxtlZklGJt/3baQ4u/J
         AFYnRcTdD+x5uvcP14u1UJdD2VP75+dO97TVCc+m4HIzHPS/5KkR2HikvY40irCrz+0v
         0s5Ac68tGBKIUefOH6SdzQgMLFPAPeZwsvgzkaZ5+MbI+VR9uAd2NRQVBWQVk3zp025n
         weBj9WfVUdBuvuT+f44DajxHI2HwZJaimSLbL62GH06G0kOgBB4MBz8ky2IRNzetSOpU
         2bzOyfgpB2N9tqUGUOnJ/4Fju2aquQiK6QggRenY+DRpzaMXQF5c1sX/u07NIKr048QU
         zsDQ==
X-Forwarded-Encrypted: i=1; AKwUvBza8L7QPyxSI8v0m1J06OK9tPubDohnkXoXVHjrmOfOu/8wtFBD8shcnUGLsCWVrMZwKnXUrOvq3eZh1GGo@vger.kernel.org
X-Gm-Message-State: AFuF++lRaIbMdhDsIRaQDe5aW1DSfNR1cL67q5531KL4/1ACFFqX93hL
	bIYn9EsGMybw2nirqTqTcdJDy4pBydodyFbFN5DDbVesjdLk6GNsbpIMDk5wOAEJjECPMqga3ni
	pQ/Dy26u1+XRuqLXWxZcg3m7HypWwNgcmF5/zHV+j
X-Gm-Gg: AYBFou0osF7Uv0EBOZnn7WmyYzxzSARKKtPbnoFpcTds2l1gczVWBcMbsEuUfPd1ASx
	S4hS+pIC5zxiOoMfqaFSY4nyOVHS+/avBTBzatG8X7X7RZtrrhQerEs/HzlKD/khMqJTqrat9Ro
	0OIi5D4T81XfAzZMaWkr5zqD9cwpPDIFUlsrkQ8DJ0tyYzBQKxOSWVvUsezCwVS/v0By2d10zQz
	9rcZYOHCmLks1dJOnIB/DzfurLaegazMy7qPm7Yfew2ySGpe/lOPOJ61AaFCQzyVVoip9TJ5wA/
	LquGc1nWCoX5RQ7PevMOEj6rXlY0LzSPZVbDcGNQmqwitIYcv8A7LbA9n03ML35FZ6for7D3sQG
	mGUg94uB7RbumEqQ/LBe5ylJnr5k7d/uw6e7iLtV/
X-Received: by 2002:a17:902:d98b:b0:2dd:280b:cdfc with SMTP id
 d9443c01a7336-2df5b83676fmr449455ad.17.1790022168357; Mon, 21 Sep 2026
 13:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn>
 <20260831-tauwetter-werkbank-dramen-b37eb4025283@brauner> <CAC1kPDMK_D4nhyRmBHg6KC7SmmCkH73Xtc5DhXeJbSvf3LcqcQ@mail.gmail.com>
In-Reply-To: <CAC1kPDMK_D4nhyRmBHg6KC7SmmCkH73Xtc5DhXeJbSvf3LcqcQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 21 Sep 2026 22:22:11 +0200
X-Gm-Features: AcwNN1UtR6M4RsRB1V4M9ZXr6hSPfcvgRf-Sf3BDBnWgXtSIC5rk0Yng7pQuhSw
Message-ID: <CAG48ez1T5-tUHVK_iHsgUtWa-inVdrZxA3E-ZCW0iENJvasKfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfd: add task path ioctls
To: Chen Linxuan <me@black-desk.cn>, Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:47=E2=80=AFAM Chen Linxuan <me@black-desk.cn> wrot=
e:
> On Mon, Aug 31, 2026 at 4:49=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> > On 2026-08-31 10:59 +0800, Chen Linxuan wrote:
> > > Obtaining a target task's executable, working directory, or root
> > > currently requires walking procfs symlinks such as /proc/<pid>/exe,
> > > /proc/<pid>/cwd, and /proc/<pid>/root.  That makes the operation depe=
nd
> > > on procfs being mounted and visible to the caller, even when it alrea=
dy
> > > holds a pidfd for the target.
> > >
> > > This series adds PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT. Ea=
ch
> > > ioctl takes no argument and returns a close-on-exec O_PATH file
> > > descriptor referencing the corresponding task path.  The new ioctls u=
se
> > > the same ptrace permission check and nonzero-argument rejection as th=
e
> > > existing pidfd namespace ioctls.
> > >
> > > The target task is sampled while holding its exec_update_lock. This
> > > keeps the access decision and the task-state read in the same exec
> > > critical section, preventing a concurrent execve() from changing the
> > > credentials or target state between the check and the use.
> > >
> > > The first patch factors out helpers for acquiring referenced task pat=
hs
> > > and reuses them in procfs and AppArmor.  The second patch introduces
> > > scoped cleanup for privileged pidfd task access and separates namespa=
ce
> > > lookup from namespace fd creation.  The final patch uses these pieces=
 to
> > > implement the three new ioctls.
> > >
> > > Signed-off-by: Chen Linxuan <me@black-desk.cn>
> > > ---
> >
> > I really have difficulties forming an opinion on this. So this sounds
> > very useful but it has implications.
> >
> > Right now, pidfd ioctls are available even in situations where the task
> > in question would not be accessible via procfs, e.g., when procfs is
> > mounted with "hidepid" options or similar. So this would expand the
>
> One point regarding hidepid: for callers that can pass
> PTRACE_MODE_READ_FSCREDS, hidepid does not provide an additional
> restriction. With hidepid=3D1 or hidepid=3D2, has_pid_permissions() falls
> back to ptrace_may_access(..., PTRACE_MODE_READ_FSCREDS), and
> hidepid=3Dptraceable uses that check directly. In addition, the
> /proc/<pid>/{exe,cwd,root} links independently perform the same
> PTRACE_MODE_READ_FSCREDS check in call_proc_get_link(), regardless of
> the hidepid mode.
>
> So for these specific path lookups, hidepid does not block a caller who
> would already pass the check used by the proposed pidfd ioctls.

Agreed, I think with regards to hidepid there should be no issue here.

If I try to come up with scenarios in which this could introduce
additional danger, the main one I can think of would be: A task T1 is
running inside a pid namespace and has a unix domain socket connection
to a task T2 outside the namespace, with both running as the same
EUID; T1 sets SO_PASSPIDFD on its socket to obtain a pidfd pointing to
T2 on the next message sent by T2, then T1 uses that to get access to
the mount namespace of T2.

Christian, is there some mechanism that already protects against using
something like SO_PASSPIDFD to get a pidfd to a process in a parent
namespace?
Otherwise, should we add something like a "pid_vnr(pid) !=3D 0" check
either in these new operations or in SO_PASSPIDFD?
