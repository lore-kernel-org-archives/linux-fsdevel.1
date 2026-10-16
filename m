Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF48380FC3
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138738; cv=pass; b=aEaKWBrpfnQHxo8dgW64zKcZdPAX+DIGVLVG8DHUV/Tlc5ymA8JRHxEdst0QvJRx1A+sGmdOBlDD0Ote6c3wKoh4PfY8iboglMyq+6/wm1hH9jCl1BoBA9oqFSenVUOSlU0uL/PP9Rd1G1FpqzHwjCMw4YOJljAOdpRlakiSveg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138738; c=relaxed/simple;
	bh=TJpRkoynlry2geAXK8OkwmCvIsCu/qH7mlFTnmgK4Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfZPx+PofNr0thmbWw/UXkc+Nt9JexQAJ8MEZkjVWQ8ARQ+8wNAKBy6yFztwy0+iZ5CxB9Qyil4Z44sgGpnhWbeBr59iKXRuGeUFSSj8pe5PiZwjh8cPTpBFGkBAHhsnJWjGL2aaxpLNHlPt3tnERxIfN6Y282MotZ8nN1g5iLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDctdG3P; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDctdG3P"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66c9995ca60so802206d50.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 01:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792138736; cv=none;
        d=google.com; s=arc-20260327;
        b=oD8Kt00KukcQK5ELkoFvzlZqBUOJIYenxT+E6Js0xyxBJ8vgjMpo4IDvxz5aJJWBmC
         bf+9REmaebZAskzmmyZF7w1m7PyJ89aCCjAK25oB9BU+2vV6KZQl4WctROUm85t4jmxx
         FDlBpN+lqiRE7ADoLplJyGhaxEa7Ym6/YZ6ihpmM9u3Q2d/YnRlsuc1P75LClmXtcuUR
         hMm76Gly5I/UbopkG6LvOiJ8QRAq30kp4Wu9lcB11nhIafkHj74+Lrd9HexeeGaR93ML
         TSgr51O10AbKBReu7cQs8zRVvLga6ajm37xuC04xifcC3Jm6NPraXJkztEO2XXPw9zvh
         ek+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7jP1ajt49g9ePjtG83cMVBJePTr3Nno+FbpJNYv5nwM=;
        fh=90RC7zWNT5Qw/cCkKhaDBinm/rysrVW0YME20pOltTE=;
        b=f62IPikIlcWtXq4IcxL6rl9IsR6QZxvPwyT83Yn4RBdWBHLMoWKyUz9iBKglz7PDYg
         +qsQaaNDcrkDUtHXYQEdNp9KxkffsdTjUYzvS1sVCWKmrKEt1AXcuF1LegQUFZ4ikHD5
         L87QFk18HQuMNEbENffrrmRmMH7g4XgBa3r5Q/WaTN2pR6Pzq/T2ho1vkNsjqg6mjdsX
         uofTDciX0Vj1HsMl473wR7OewNtB3sSXY0fb7eNeB7szN/24nJOb1g1dmu3n1XXUWpVC
         jUUEgZ+N36Vg70lJTfidPHGGLtsCXugt64VKqlOlIVmEKWS2TNXOoX9lVXL5P0OEjYgg
         FuQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792138736; x=1792743536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7jP1ajt49g9ePjtG83cMVBJePTr3Nno+FbpJNYv5nwM=;
        b=TDctdG3P3hqBv7Kmp9O69TG/m8pZWfGK3WkV8CEODNgKQ4ETVbdNSk6ewwgHGYwaRe
         O8U2S4+OqkYRsjloampfShtwy4XKMrVtbQw3Bk1nlCT/uB8UyKFl9/Ozm+3UZm7F68ZS
         lcaH0omgr4sMqtAXnmzZbF40fWYU2J6/JGISbJTo1MlrLItg/f9eVjGcmGc/TbM1xPmG
         nVU23PzrABXRfa+WHOQJjPZDqcjmVNRHD9zxDs2V451VykC1BiHMn/woKRYcsSoyryIV
         slCadhfuKr0QSoyFzna/MrQ0eHMR/ZgjJWOWAq/l3I47zBkVdb9NFmiku2rGoa39pO0/
         iwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792138736; x=1792743536;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jP1ajt49g9ePjtG83cMVBJePTr3Nno+FbpJNYv5nwM=;
        b=wrjadMa+ZCn9Bptg/uX7onLGRkMtpBsUWdFWi1jEsfMmX2mxF858/D7/QF6YZ/+fik
         Jfk+IXKyu2BFSOaXhutWjUGh0GAd+Nad0fkG49nX6IenjpxZ0ksg2KS00CeJbH4Hu+zn
         7qtX/DKjd/o4/EhjakIN6KD0dLQjBYIWTVGbhmmTD9XsdMmwX/s43/eYfqAm5Wi/3FPq
         yabEpfAeeYLzytfifim0WOOoMUGukTJIArOyykYn4g5QC3ZNdcFoCapHJwThAlbX25Jx
         06RBLiqrzRnDZBXWRTx9f1KRSxz7ELoUx/aLCB1lckF/wxgeQCOa6zFS4UugAP50WyJk
         PH7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxNLb0bv19sCSieh4Upgxy3hWHTR0rDA9RYk4RpN+5ANSfICphwm7yg65BvP0yS0LF/qj8B/8qqriDkFP45@vger.kernel.org
X-Gm-Message-State: AFq9FYIAFc8JaXP8Lvl/HDIewId7DI9GDeJsUx0Mc2waLO1RqbG7PYuL
	oE23VkMUnkJXIs5gGd4ohuFbeaKEfJfIAaHfS99z9l3NKA+v7wROz31z8M/cqjBW9pG0B0ftJZa
	uZag2Kl0MmSwz2CK1J7nt61/rHPLQrhU=
X-Gm-Gg: AYBFou1sceE2gx6poBpc3t5EWvyxnUoCMRYv4od0bO+q5i/D6IQIWIPx8NSgfh/6EkH
	9vk1mX4YnsEOCU8/CCIqXrfFadBP/qKM8o+vud0jVHK+GOBeq3F9jrCcgcnU8iiwk2NW9eRAf2z
	l5Enn6M4jp233KiR+Lr7KcNkoGzCaL85+WX1DnrkTdXaCbVCQiMcojG0+BMZS0ah7dAG8JYWzHu
	LgnacDgqO62q4BrmxFP7t35SArKU7bYQHU03esFmK1VRBM8WVapzLLIAmRN67tiww6CB8z5C0jU
	N2fQMjL4XnDOdwJa4VK2vik3JxpAZgiUCFG1ckkmVK/l3pYfevXAQ2WhR+T/I4dpcGYzlwECyzd
	A9VbPcR3s2lK7zmODnSmd
X-Received: by 2002:a53:ac8d:0:b0:679:97d1:439e with SMTP id
 956f58d0204a3-679b0e651ddmr785846d50.2.1792138735738; Fri, 16 Oct 2026
 01:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
 <as3gQ8jfa_6eBf15@chenyu-dev> <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>
 <807eb0e80c76c3ccb85024b360bd47ace201931b.camel@linux.intel.com>
 <CALOAHbCt+iGGWMxzjrcRamdSqD48_v+V685-qi7_Qy7UL8bxxQ@mail.gmail.com>
 <atG4VXk4t-m8VubY@chenyu-dev> <CALOAHbDY6zLcEc4kGhC9GSFsOsREadkWN7Q4CmZuR_m_BMHAyg@mail.gmail.com>
 <bcabbe25-5b2c-464a-a22d-5375a342f938@intel.com>
In-Reply-To: <bcabbe25-5b2c-464a-a22d-5375a342f938@intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 16 Oct 2026 16:18:18 +0800
X-Gm-Features: AclHuK9l0UDwRtdZnr0wuccDYOekKzVCW2ycclDkqHbzyqX2JXnysUW2dhrKAo8
Message-ID: <CALOAHbALpHebACLUmvet_tFH_w-iK3TWpY52OhYTUVoLzoGKkg@mail.gmail.com>
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA balancing control
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, ljs@kernel.org, Li Zhe <lizhe.67@bytedance.com>, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	tim.c.chen@intel.com, mkoutny@suse.com, tj@kernel.org, chen.yu@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:01=E2=80=AFPM Chen, Yu C <yu.c.chen@intel.com> wr=
ote:
>
> On 10/16/2026 3:38 PM, Yafang Shao wrote:
> > On Fri, Oct 16, 2026 at 1:51=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> w=
rote:
> >> A more complex scenario is when cgroup A and cgroup B become threaded =
domains:
> >>
> >>                           root
> >>                          /    \
> >>                         X      Y
> >>                         |      |
> >>                         A      B          A, B: threaded domains (thre=
ad roots)
> >>                        / \    / \         separate memory.max / io.max
> >>                      A1   A2 B1  B2       threaded cgroups
> >>                      ^        ^
> >>                      |        |
> >>                      +--------+
> >>                    want to share one cache group
> >>
> >> In the above case, we might need to change the deployed cgroup hierarc=
hy.
> >
> > I think we can enable LLC-aware scheduling for both A1 and A2 =E2=80=94=
 does
> > that sound right?
> >
>
> Here A1 wants to share data with B1, but A2 does not want to share data
> with B2 nor B1 nor A1. Enabling cache-aware for A1 and A2 might not help
> in this case.

I'm not sure whether this is a real use case or merely a theoretical
one. I'd suggest we not focus too much on purely theoretical scenarios
unless someone can demonstrate a practical need.

>
> >>
> >> Suppose threads in A1 and threads in A2 belong to the same process Pa,
> >> this reminds me of the cgroup bpf NUMA balancing case: after enabling
> >> NUMA balancing for A1 but not setting it for A2, what would be the fin=
al
> >> NUMA balancing decision for process Pa, is it enabled or disabled?
> >> The NUMA balancing scan/invalid seems to be per process, so if we chan=
ge
> >> the setting of its threads, the whole process will be impacted. Or may=
be
> >> we should not enable NUMA balancing for threaded cgroups? Anyway I hav=
en't
> >> digged into your cgroup bpf patch set yet, let me try to look at it.
> >
> > cgroup NUMAB works the same way: the setting is per cgroup and opt-in.
> > For Pa in your example, since its threads spread across A1 and A2, you
> > would enable it on both =E2=80=94 enabling it on only one of them is no=
t
> > meaningful.
> >
>
> I see. I haven't yet digged into your code, is there a per cgroup flag
> cgroup.numab.enabled?

Right. I will introduce a cgroup::numab_mode field, but without a
cgroupfs interface file; it will be written through a BPF program.

> Would there be a logic in the kernel, when
> A1.numab.enabled
> is written to true, the kernel detects all the other cgroups {X} that
> contains threads
> share the same mm_struct as A1's threads/tasks, and then update {X}'s
> numab.enabled
> to the same value as A1, to keep consistency?

We have no plan to support threaded cgroups for now. If a real need
arises, the BPF program can be extended to handle it, which would just
require more kfuncs.

> In summary, if threads are
> spread
> cross different cgroups, when you set the enable flag for 1 cgroup, will =
the
> kernel iterates all the other cgroups to update their flags as well? Or
> leverage userspace to do that?

I believe this should be implemented in userspace, not automatically
in the kernel. Use cases are always complex, and flexibility is
important here.

--=20
Regards
Yafang
