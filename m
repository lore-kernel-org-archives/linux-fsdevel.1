Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D554399365
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883935; cv=pass; b=kqRhG/TEX7ApKaHqNcAZsjyFmj3fqKc4rWMkys95PbmFiG/hs6YbnEBAvEDD0wz8Jl6NgF4HZJR1ZG+H04gqedS9PLDHODTvDlLByukHxYfpDvEuJ3IUoLBBn9Wmli8hdJffSQok2kPe6j/EYA3j+vYUQQ5HcZ3NfvG/R4ukTNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883935; c=relaxed/simple;
	bh=1bJ3BpJqL6XRVNYecItYKDdYwQ+H5PLoopg0tnRg59o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaoQy/hw40S2ptrdC7TUj+uYE7mZOlqGj8SdB0iiPeCBwfFBmG7LQpdIKvLwSOHOkQozHR2XQwbVzSKNKNnBfwEShhE4RYLFdZeH6SbVtKlB9HFlBBBV0Dy8coU+9q2U4WEBTxYuGzcZ0CJ39CEScgEvRC2fUwldnA8EQGokdew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkUFGJQh; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkUFGJQh"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-677d35fd1d2so2514045d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 02:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791883933; cv=none;
        d=google.com; s=arc-20260327;
        b=nAAKwEbcEkaFu1b3G0XzSFDAMPLIygp7QZDBas1ZoCT3fQP2pPSYwkf0zpkKv2R4nr
         4WvmGMupbcui9BB+chS6Mh+plLEk5f+Pu+ua53b1GD1udAcYjQRoFNZgvWomFZY0Hdkg
         BbNmooc1+9nfbVGnq+k6BAxRHpmw/ulrCnX2+sTKCnDv+2QGc7cmejfLOkCrk30E9LyA
         UtVxiuUB3q4uoynuQZI5c9dMOjbX70csr67NxIb+EzJ1carSuEiyaLhmPSXPt0thfhS6
         Hy5VM8mC4BJgop2ds1Ug9Ni49DAx2jtQVSDvBgcKv8u/8gs5yvAA4GsOPc6ngzf8+s7w
         RD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L3laYlGriIt8rJHKn52BHOyta5Irk/sF5+2l2dqx7+A=;
        fh=cwPyWiS7z/EKqG/5WlIkA08+TmeS409zqrzN+ylEMow=;
        b=jnw7Yhw9f6f7KW8enFba4IWlxIOwVVL+GnkCbV4EUlDq8wZ56l1Jg34GouwyU6uUwR
         MxyyFboxhXkQvl2/Xg/UoGFuAoJ6/OMf205/SVW0xIgKprFKE9KmmNm5/+mhJBwUcUrV
         bTulLEQAeJdfgtJ3lGdUXy+kDzb3f5cYz1a1bdY+hLJ7+z+NKst+vZ63dzI8wUIj8IwQ
         Aab+0U3Hiw9dN3jaDLqOLlMmUKKSiKF23DjF2U0919PK99ShF7clYUeUrHcyCTK2x7RO
         +z7xY3p09JjkSwPW7PDl/HOYvJ3Yz+mupxOE/oAdhaucVz2/INLE+dkqzEf1DrYnQI86
         7Dqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791883933; x=1792488733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3laYlGriIt8rJHKn52BHOyta5Irk/sF5+2l2dqx7+A=;
        b=JkUFGJQhZXY1iJElFEOb1mQkVDzR+ZklCw09pEp5d2tqzSbqp0tcH1FgzUhlYZ1Wne
         fSpqyNATyLWSGXWGXnGvSxo97Db0LGcX/YdrjUqJhxxM9FgP6gOzoA4Nhi1JZtleC+ZN
         OwW0k3gBujI81hhHP6oCNYFXCNRPCsaJ3eYxi3XMl0pkXGr/sd0lguJv78XJRxDjcHFl
         fIaKJ5oyl8QDdtKgkZ7rGkFAiYZTXTZ5/F5El1TtlMSpTwYPJLzeljXeleAVDkbcSjMX
         VAm9rhowyctHb0mSBnWlq4HkYgT64nINiFjd6++v2wMGF3YpEDq6K3p5xJ/aL2+rzyNH
         RRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791883933; x=1792488733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3laYlGriIt8rJHKn52BHOyta5Irk/sF5+2l2dqx7+A=;
        b=1j+EQL16XzaSKgt6aZZtwXlSJxHtIgFdWcq4FYr8+H7r3kc9/efAjbs+N0QlrxNPRh
         NazXLai+ku2Td1gQXIQOhV2g3VYTlLbhgLR852H+x7m0GtiBIHfbpJh52WOQjzA28htL
         vmv9/gtZCw6s5xMLHp9b3T44TWgmDlFO1kYprXCt7cY89rbcPt4s9wu1ql5ahbOiju7U
         ufs8p7oEFEkq+huKUwe7jfkXF6UhWVdvZwNaWyJkJQ910IEAtbjeRCxvcndzlXeP4ZtF
         qP965XQulRImBMkdYkh5tsGEtBR52ecxbgnnaKBq4TjYoCgvmgsNp9X1faqPSw0wrNnx
         ML+w==
X-Forwarded-Encrypted: i=1; AKwUvBzDtpdjTnTf6ILcscv4Cec/g2HGOnqHAE1Nqrp0kfxivQ2/m2AWzi9ywBjGS/QeWzT5BKidmhOsfqm6ONhy@vger.kernel.org
X-Gm-Message-State: AFq9FYLCRXfsyXA/iNjMKhqTGabNfFsNFqqPJrYmKtWCLtnPV6Oj58ZZ
	N3qKxvXQ16K2/2npB6awiEZJCOYl/B0yrLFW4SU6eE24XnQox39JUM6bK9jkhxpedCNqi/5wIR4
	aBb/EDSTI0pzPF/zXUjeyxlftFhKUPaDKOmY6pOo=
X-Gm-Gg: AYBFou1jMd/fA6RULgiIJKYnpO8jBSggVaOyuwWW6VMHx7gRl39ZeQn6U0vQlXXefXG
	3yfl7EkdCDiuyBLw6m0cLUCcBifbshU/K5jYJX3EXGvFSgdclLMbzJnPO3mM1hBUNGyA9ksNczH
	r2IqwlGYwb3P08BS6nhjvRYX5US04ogT145DqbHl8WiamW7MvgCiGWeZvFUQLvcVxc8CemfxydW
	MqA2LhXeeuMQMuPzNHaDVItjEgiiZY1rI/cq39SA6YyO7AjDsauRB7atDi6VtshRs0PMoGj3FgW
	+b4o+ULGS3V8tO4KuqNrq8YLyX5Hjfz36JbIXlblyJVVah6QLF9Dim/UakSulWfuPPOjhPAA0nn
	Ryj661pQHHA==
X-Received: by 2002:a05:690e:d4b:b0:66f:c1bc:c098 with SMTP id
 956f58d0204a3-67936288010mr2521640d50.96.1791883933466; Tue, 13 Oct 2026
 02:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908122446.56708-1-lizhe.67@bytedance.com> <as3gQ8jfa_6eBf15@chenyu-dev>
In-Reply-To: <as3gQ8jfa_6eBf15@chenyu-dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 13 Oct 2026 17:31:37 +0800
X-Gm-Features: AclHuK8ndsxhhlK5nTTn5Lujec0hKh1opnIku5qhG2TbGUlvVhns7ig0IWDcDvg
Message-ID: <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA balancing control
To: Chen Yu <yu.c.chen@intel.com>, "David Hildenbrand (Red Hat)" <david@kernel.org>, ljs@kernel.org
Cc: Li Zhe <lizhe.67@bytedance.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	tim.c.chen@intel.com, mkoutny@suse.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 3:52=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> wrote=
:
>
> On Tue, Sep 08, 2026 at 08:24:42PM +0800, Li Zhe wrote:
> > Automatic NUMA balancing is controlled globally through the
> > kernel.numa_balancing sysctl and can be influenced indirectly through
> > memory policy. That works well as a system default, but it is too coars=
e
> > for workloads where a launcher wants most processes to use the default
> > policy while a selected process opts out because it already manages NUM=
A
> > placement or cannot afford the sampling overhead.
> >
> > A recent per-cgroup proposal tried to address this by adding a
> > cgroup-local enable knob plus a NUMA_BALANCING_CGROUP mode where
> > balancing was disabled by default and then enabled for selected cgroups
> > [1]. The discussion also noted that automatic NUMA balancing already
> > operates at task/process granularity, that the knob is not a resource
> > control attribute, and that task/process controls such as sched_setattr=
()
> > or prctl() may be a better fit while cgroups and cpusets continue to
> > describe workload grouping and placement domains.
> >
> > There is also prior art from 2023 prctl() proposals [2][3]. Those
> > versions used a per-mm mode with disabled/enabled/default states, added
> > NumaB_mode to /proc/<pid>/status, and changed the global static key
> > handling so a per-process enable could override the global sysctl.
> >
> > This series takes a more conservative variant to preserve existing
> > administrator and workload expectations. Keeping the global sysctl as a
> > hard off switch means an administrator can still disable all automatic
> > NUMA balancing activity with one knob. Using a weak two-state
> > per-process opt-out/allow ABI avoids exposing a "default" state whose
> > meaning depends on global policy and is therefore easy to misinterpret.
> > Storing the configured mode in signal_struct gives the control explicit
> > thread-group semantics and avoids making unrelated non-thread CLONE_VM
> > users share the policy merely because they share an mm.
> >
> > The series implements a per-process interface: a thread group may use
> > prctl() to set or get its configured automatic NUMA balancing mode. A
> > process can opt out of new periodic NUMA scan scheduling and NUMA
> > scheduler accounting, or opt back in. Existing hinting faults and queue=
d
> > work are allowed to drain naturally as the disabled state takes effect.
> > When kernel.numa_balancing is 0, a process-local enable request does no=
t
> > override it.
> >
> > A separate task_struct scheduler snapshot is used by enqueue/dequeue
> > accounting so the scheduler can consistently account the state that was
> > in effect when a task entered the runqueue. This avoids changing
> > historical task accounting while still allowing a process mode change t=
o
> > take effect through the normal dequeue/update/enqueue path.
> >
> > The series also exposes the process NUMA balancing mode in
> > /proc/<pid>/status and documents the new prctl() ABI and its interactio=
n
> > with the global sysctl.
> >
>
> Can the global key be extended to tri-state, like the THP settings?

IIUC, a BPF-based THP policy is yet to be developed as prctl() doesn't
fit some use cases, especially mTHP.

> To keep it backward-compatible, echoing 0 and 1 remains the same effect.
> The user can also echo always, advise, or never to it.
> We have a similar proposal here for cache-aware scheduling[1]

We are also experimenting with the LLC-aware scheduler on production
servers, and we want to enable it per cgroup rather than globally
there as well.  Given the lessons we have learned from THP, what
about implementing it as a BPF-based feature from the beginning, so
that the semantics can still change when new use cases show up?

> In this way, the user does not have to disable NUMA balancing one by one
> across the whole system.
>
> Yafang Shao has a bpf-cgroup based NUMA balancing proposal[2].
> Overall I support fine-grained control of NUMA balancing, and I'm curious
> what the possible setting would be in the production environment, would
> something like Kubernetes be responsible for setting the NUMA
> balancing attribute via prctl, or as Yafang proposed, leverage cgroup
> interface?
>
> [1] https://lore.kernel.org/lkml/fd341106e7e6cbd2f047656650f43ee87c6633c1=
.1787955777.git.tim.c.chen@linux.intel.com/
> [2] https://lore.kernel.org/lkml/20261012120438.52849-1-laoar.shao@gmail.=
com/


--=20
Regards
Yafang
