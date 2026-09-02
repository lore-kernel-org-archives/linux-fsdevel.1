Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141BB3939D2
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331672; cv=none; b=eWHNZ1ZVMDWTmurV1CESMhlK9brGF+ijHlety5DHtrIkcNldHJgkH8dgAhmCS83kYkfhB+L9ljtLiyOOutiKnnkazszyB3U1ILBL3g9+z+Y0SYPExGq6ie4pDj21NXfDyjwo5yjfcFAQ1SGtaXSxkAJ8Tn7fusgXLHk7b1kAndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331672; c=relaxed/simple;
	bh=ixlWqFuSFl+kXQc/tcrrAFQiec5rJ4PZr781QjNJjcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjGhMQSeIc2rOAAopWzoDX1r8xn6a0ZSFXSliFHqK3zVjSpQMgSCEHcwBkaB/ClLeDkuIFGFahuO8D0UvQMjED2xBELyjZzj2Dh5Jb1xDLXl4ucV7qzORGcgmLGGmvAjHBocG4j4B1acNL0nxw2eFCAWzDfNTNUhuPYOfNdHp+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a34f7ebcedso4783681fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2026 23:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788331666; x=1788936466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CtlpH4A/FsfIicKK/MMLWRSJhN08nYCVAAoP5yOKMSg=;
        b=a2v5KQwS4BJ3uQuUu403Lf6cQi3ZFxbv4SGQt6JGBJQ8xUSvySFygGDb0B2pbwlmN7
         YMAIUUMeEeRhRDR70BsHoMyMUXR9oIq2U62PDX9PCc+6ZlX9A8Kqex9v5drFuLg1j5E9
         JORfbDNiV1N1vWJDQHQN0neqVipJgopRXCYTGFTUVcIj4AjSlskGI3iIrT6kOs5U2rmX
         wwowst7sCzrgo1dotZy1XiL20ao1xqUkfG17MEUYkrv2zaTEbSTLED9EuZVBjDCVcYKh
         ZilZ5dlZrlUPdvrkQ8fLUvsQ2+1aA2pvbSeFnDCLrYCzNpL7r8L/jPbJW9ZxRsj2l1mr
         x8jQ==
X-Forwarded-Encrypted: i=1; AKwUvBwG8pH4p14FaDKPyU5P3S/32REPw86ResVjISR+jKRqkUkKsOOHUC9Zm/0GuuzKlU2Mq9jrOh0MynSIhhLY@vger.kernel.org
X-Gm-Message-State: AFuF++msLcanfX8dnhRVitSdw9auipni9zuJpBpi0EQx1eK3nN83SMAq
	MBUrGgQ6tM47RFmiSKv7aF4DnY9ucYIMYQg/7z5bEsfARX9nD+b/dIGMFvsWrJK+Ynrleg==
X-Gm-Gg: AYBFou32iN8v21zhYs2PncTdxUOonnb5Ep47MOD32WGiS1VR5Mxbvp9fAAx48htg2cw
	IWlRjVCFsBj1/haocJZQgXmmPYQnbdG7J9l6h/KI+5QpGeTHasthu7O/0G41qCD22B0rR81fk2E
	HmmjNKt+/0qaJ/sgV3Deg3MQtiBgmqqNWlkWMdoSyT+gAVgufO5gR0HPNJ9yUAiXbbG6LNC9xAE
	PPHsS45LTt9PAp/SJ7cAtfGrOTIoat6OJn/19Gj/+sbK3jn89aS+YmCxWRKAuEQuFbZiKU3L4xj
	IuzD1bWmnklvHgzHdB8j1KbdpsYwNw0jcEwUSGjQNV5X/6rMJSLlSmodg5X+ZGTnT77xGS+qYcX
	sV0wGhNRhBbk8k4hM1XA/bnnOvUUk0pflLotzvgGZaWZ3vTXF5v0Wi7BozFJBHy19gUrJDnoKe4
	B3W/pf0MgvfI3Gm/R7PqDLuhgm1ZLvXm8EJ7PbyZSQ30DNSqERqMryl3OFM7EjCdfVyF47KH8Ci
	cM9AHwXu5ZzAB6aQaPdSpFVo5a3sTnG4buBuFZJ0QtLhHvfuGJn0Z89C3Oefio=
X-Received: by 2002:a05:651c:30c9:b0:39c:9955:9e00 with SMTP id 38308e7fff4ca-3a34fc9c509mr4390441fa.2.1788331665740;
        Tue, 01 Sep 2026 23:47:45 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a34a8f06dcsm4018511fa.1.2026.09.01.23.47.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 23:47:44 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b4ab40d839so514589e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2026 23:47:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwyoCSlRas3JW+RJoagKoRkAncySMnjOMG/1sw1WdcMS+z0ONfbn597165Nozi0vs2ORLivrjMbi/9JL6/X@vger.kernel.org
X-Received: by 2002:a05:6512:32c9:b0:5b5:e8af:a5f6 with SMTP id
 2adb3069b0e04-5b60831e880mr829854e87.3.1788331663502; Tue, 01 Sep 2026
 23:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn> <20260831-tauwetter-werkbank-dramen-b37eb4025283@brauner>
In-Reply-To: <20260831-tauwetter-werkbank-dramen-b37eb4025283@brauner>
From: Chen Linxuan <me@black-desk.cn>
Date: Wed, 2 Sep 2026 14:47:31 +0800
X-Gmail-Original-Message-ID: <CAC1kPDMK_D4nhyRmBHg6KC7SmmCkH73Xtc5DhXeJbSvf3LcqcQ@mail.gmail.com>
X-Gm-Features: AcwNN1WESqzlj5-w8dgp1OujQBVwB04y72AI-TKWGXGM1Ob33MtgcQyu2-BCfjY
Message-ID: <CAC1kPDMK_D4nhyRmBHg6KC7SmmCkH73Xtc5DhXeJbSvf3LcqcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfd: add task path ioctls
To: Christian Brauner <brauner@kernel.org>
Cc: Chen Linxuan <me@black-desk.cn>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
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
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 4:49=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On 2026-08-31 10:59 +0800, Chen Linxuan wrote:
> > Obtaining a target task's executable, working directory, or root
> > currently requires walking procfs symlinks such as /proc/<pid>/exe,
> > /proc/<pid>/cwd, and /proc/<pid>/root.  That makes the operation depend
> > on procfs being mounted and visible to the caller, even when it already
> > holds a pidfd for the target.
> >
> > This series adds PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT. Each
> > ioctl takes no argument and returns a close-on-exec O_PATH file
> > descriptor referencing the corresponding task path.  The new ioctls use
> > the same ptrace permission check and nonzero-argument rejection as the
> > existing pidfd namespace ioctls.
> >
> > The target task is sampled while holding its exec_update_lock. This
> > keeps the access decision and the task-state read in the same exec
> > critical section, preventing a concurrent execve() from changing the
> > credentials or target state between the check and the use.
> >
> > The first patch factors out helpers for acquiring referenced task paths
> > and reuses them in procfs and AppArmor.  The second patch introduces
> > scoped cleanup for privileged pidfd task access and separates namespace
> > lookup from namespace fd creation.  The final patch uses these pieces t=
o
> > implement the three new ioctls.
> >
> > Signed-off-by: Chen Linxuan <me@black-desk.cn>
> > ---
>
> I really have difficulties forming an opinion on this. So this sounds
> very useful but it has implications.
>
> Right now, pidfd ioctls are available even in situations where the task
> in question would not be accessible via procfs, e.g., when procfs is
> mounted with "hidepid" options or similar. So this would expand the

One point regarding hidepid: for callers that can pass
PTRACE_MODE_READ_FSCREDS, hidepid does not provide an additional
restriction. With hidepid=3D1 or hidepid=3D2, has_pid_permissions() falls
back to ptrace_may_access(..., PTRACE_MODE_READ_FSCREDS), and
hidepid=3Dptraceable uses that check directly. In addition, the
/proc/<pid>/{exe,cwd,root} links independently perform the same
PTRACE_MODE_READ_FSCREDS check in call_proc_get_link(), regardless of
the hidepid mode.

So for these specific path lookups, hidepid does not block a caller who
would already pass the check used by the proposed pidfd ioctls.

> surface of operations you could potentially do.
>
> But again, I do think it is actually useful. Adding Jann.
>
>
