Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E833F5B9
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779545200; cv=none; b=u42lkoQ7hkd9s3qa2pZICTunV9Ptc3L9bSVQWtsFhs6/cGlJDjRh4egvnmuheq1nDgJIvTY9f617VcSZHdNtkKKEiK90gz3Ywjb3LcQT2JKMrZ3XU2Q0HA/9smXkiV21z79fUd7ytoxbW/0F/L1BdUFkAT70qUll2LpFeQ5SKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779545200; c=relaxed/simple;
	bh=QLj/GX5k7eFyGfeZf3Wtm2oB8X6vtQ/bwHDCPYzJK1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCn6hGFsPjgzd+egSDH6OPFcqTzmLpx9B4svwR8Y39lEKsTwWmXq/5fh01Ykl8lHpt2+AaGLe0cpIpQCW1i8kfwB7oblbR2+jIXWg7I7SDChqO065aOsWFsmICF5eb2t5xydHF3q5WIZayx5NNnNpxL0j2osfo6mZ2GiomaL3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bcc9a69ee07so135990766b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 07:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779545197; x=1780149997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WuWEfTQYjsCVqVvHObEiNmRNaaJS3/KGoVEjCdjn4Xk=;
        b=gXjPwUJbi7dw38o6tNLaslr7iMc2icAtgo8pxOxjpcZXvVJw5ARiM/SH856YcheLet
         rS7bDrslI/YuyweW5LgUH+UZR7KAZ1DwkGLXtHjW25ICJWboaLeASo0z3mgGvfC/BrKF
         LbY25qqA6ynbzFlLbo2/jyQOMu8gyBlAlekgbj9e9oLVR6nhhgHomvr7jmit820YUYJH
         q6vXqdjsZZoGLzzl3LOQWId7sCAr7Ca/L+uFY/mrRVfZG5KCm2Y8+na6/SHSy85nKGQS
         2XYfvcKVlhXrmHZB5+wz1txpsCzEXcDMzsgkH/iK6rjd/kWUU3sd2LH5nfh2fB3ezZm4
         8sXw==
X-Forwarded-Encrypted: i=1; AFNElJ+IsHHu1adfFlNzb4GRF6m1KKT8IWRRgBT5lqyA5y4M4ut4NybW9wHT/sDa9Vk/6EsPBUVOBIxW+rPvnLg7@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxpXOgg1v0Qox/4A5VpKy4DYuqtmENREITeVfzhnkX7mFeYWp
	peea1k89QgBFMfeglGMEiHHGXwUCsZjnWE/V6FvuFVQYePUtmmVRCXX8fiSWLf2YDhI=
X-Gm-Gg: Acq92OHwvCTsIu5gWB3jtiOHGE52TnuctJlTb0WrByhI1530BZp8S/wQIXKfI15Bqkd
	6NGKFkmlbqv2+kRH2l2V0PNbfgkany5ATbOYPspoOE8jW/pp/o+Qh6uPxiq3wwDtpsYaT9cR/09
	57JGlMboS+YE8N79buT/OmtnNgInkZgQAQ86WJoyJMZcqfw6g+WJTpzo8wvUhNFVHLhPlVZ6UU8
	k0UEB+ozHr/1xjz+YEfx4DrHJ4EsT9HJyXKejsNscLl/zsSNkmZXIAtDkqZuPT1gG58d1DnxkIu
	glhlihdMZ49ch4oo/fwmaiu+VMHVn7+8oKb/MrbOzuOIr8oKIIqn4AEJOPm83Gp8fi+ETdhKA0J
	C+XbZ3+e7ukmjBKZ0tXpA4XnA1X/1/Ltil9Iyc8i0UbRdu8vIvyOKXbUDUu2uLW/XsTFJROITWp
	fIe4e5H/uzfE+ZZa7UdxG9wgz3XrkHtu39ZwKbjG0oFCe5NxBKuZrofw5BltMqNEvaC7BTcJ/DB
	epPDnor9RCKZntAraUV3mB0Pt9fhC2U6tnmn24sr90sTlyyLsN1yxySvpnvIY/NW7X6HhrENCbO
	Zk5UYBaYKQ==
X-Received: by 2002:a05:6402:24d4:b0:678:9505:13b1 with SMTP id 4fb4d7f45d1cf-6889c433506mr1222948a12.1.1779545197183;
        Sat, 23 May 2026 07:06:37 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688bb622cd4sm2024189a12.28.2026.05.23.07.06.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 07:06:36 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490402da691so1347505e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 07:06:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9/pVnfMO7f7jkyV9q/9p3c2NI3OjVV+1pEfMQcBD02R/TxILBsIC5BVprmrqsYA7ojpHJb9LIw3Pqty/X9@vger.kernel.org
X-Received: by 2002:a05:600c:8484:b0:48a:56d4:7274 with SMTP id
 5b1f17b1804b1-490428ce814mr56748215e9.3.1779544847387; Sat, 23 May 2026
 07:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205071855.72743-1-byungchul@sk.com> <6b2a816f-eb3b-4e0c-a024-ee2e3743eb04@kernel.org>
In-Reply-To: <6b2a816f-eb3b-4e0c-a024-ee2e3743eb04@kernel.org>
From: Yunseong Kim <ysk@kzalloc.com>
Date: Sat, 23 May 2026 16:00:36 +0200
X-Gmail-Original-Message-ID: <CA+7O06GxeDLR9RcKDN2i-Rgc4kgzz6BfF4b0XAH4tFx=A723Nw@mail.gmail.com>
X-Gm-Features: AVHnY4Jzdbo-RS-M3p-EbMJdQhZ_EyUwot0ge9SpoXayUSqjrmRfCiJZJ7yo4J8
Message-ID: <CA+7O06GxeDLR9RcKDN2i-Rgc4kgzz6BfF4b0XAH4tFx=A723Nw@mail.gmail.com>
Subject: Re: DEPT (the dependency tracker) as AI review prompt? (was: DEPT v18)
To: Harry Yoo <harry@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, 
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, 
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, 
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com, 
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org, 
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org, 
	hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com, 
	dennis@kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	vbabka@suse.cz, ngupta@vflare.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, 
	max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com, 
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, 
	corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org, gustavo@padovan.org, 
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org, 
	miguel.ojeda.sandonis@gmail.com, neilb@ownmail.net, bagasdotme@gmail.com, 
	wsa+renesas@sang-engineering.com, dave.hansen@intel.com, geert@linux-m68k.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	Chris Mason <clm@meta.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Josef Bacik <josef@toxicpanda.com>, Yunseong Kim <yunseong.kim@est.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harry,

On Sat, May 23, 2026 at 2:33=E2=80=AFPM Harry Yoo <harry@kernel.org> wrote:
>
> Can we start DEPT as an AI review prompt, by documenting DEPT's
> dependency tracking model and false positive elimination rules as a
> carefully crafted prompt?
>
> While DEPT can identify deadlock issues beyond lockdep's capabilities,
> it is hard to enable in automated testing; without fine-grained
> annotations it can produce a high rate of false positives, and verifying
> them requires significant human effort.
>
> The open source AI Review Prompt has locking.md file [1] that teaches
> the AI how to review locks and detect misuse.
>
> If we can write a review prompt for DEPT in a similar manner and have
> the AI do the deadlock detection and false positive elimination, I think
> we could identify those problems more effectively with much less human
> effort.
>
> [1]
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/lock=
ing.md
>
> --
> Cheers,
> Harry / Hyeonggon

I think this is an excellent idea, Harry.

I've previously experimented with running DEPT alongside syzkaller fuzzing,
and many hung tasks missed by lockdep are caught by DEPT, but the resulting
high volume of reports makes it easy for issues to get lost in the massive
log output. Sorting through that output manually is a huge bottleneck, so
leveraging a well-crafted AI prompt to triage the warnings and filter out
the false positives would be incredibly valuable.

Leveraging an AI prompt to triage these warnings would be incredibly valuab=
le.
I'd be happy to help translate DEPT's tracking model into specific rules fo=
r
reducing false positives and establishing solid filtering patterns.

> On 12/5/25 4:18 PM, Byungchul Park wrote:
> > I'm happy to see that DEPT reported real problems in practice:
> >
> >     https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I=
-love.SAKURA.ne.jp/
> >     https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byun=
gchul.park@lge.com/
> >     https://lore.kernel.org/all/b6e00e77-4a8c-4e05-ab79-266bf05fcc2d@ig=
alia.com/
> >
> > I=E2=80=99ve added documentation describing DEPT =E2=80=94 this should =
help you
> > understand what DEPT is and how it works.  You can use DEPT simply by
> > enabling CONFIG_DEPT and checking dmesg at runtime.
> > ---
> >
> > Hi Linus and folks,
> >
> > I=E2=80=99ve been developing a tool to detect deadlock possibilities by=
 tracking
> > waits/events =E2=80=94 rather than lock acquisition order =E2=80=94 to =
cover all the
> > synchronization mechanisms.  To summarize the design rationale, startin=
g
> > from the problem statement, through analysis, to the solution:
> >
> >     CURRENT STATUS
> >     --------------
> >     Lockdep tracks lock acquisition order to identify deadlock conditio=
ns.
> >     Additionally, it tracks IRQ state changes =E2=80=94 via {en,dis}abl=
e =E2=80=94 to
> >     detect cases where locks are acquired unintentionally during
> >     interrupt handling.
> >
> >     PROBLEM
> >     -------
> >     Waits and their associated events that are never reachable can
> >     eventually lead to deadlocks.  However, since Lockdep focuses solel=
y
> >     on lock acquisition order, it has inherent limitations when handlin=
g
> >     waits and events.
> >
> >     Moreover, by tracking only lock acquisition order, Lockdep cannot
> >     properly handle read locks or cross-event scenarios =E2=80=94 such =
as
> >     wait_for_completion() and complete() =E2=80=94 making it increasing=
ly
> >     inadequate as a general-purpose deadlock detection tool.
> >
> >     SOLUTION
> >     --------
> >     Once again, waits and their associated events that are never
> >     reachable can eventually lead to deadlocks.  The new solution, DEPT=
,
> >     focuses directly on waits and events.  DEPT monitors waits and even=
ts,
> >     and reports them when any become unreachable.
> >
> > DEPT provides:
> >
> >     * Correct handling of read locks.
> >     * Support for general waits and events.
> >     * Continuous operation, even after multiple reports.
> >     * Simple, intuitive annotation APIs.
> >
> > There are still false positives, and some are already being worked on
> > for suppression.  Especially splitting the folio class into several
> > appropriate classes e.g. block device mapping class and regular file
> > mapping class, is currently under active development by me and Yeoreum
> > Yun.
> >> Anyway, these efforts will need to continue for a while, as we=E2=80=
=99ve seen
> > with lockdep over two decades.  DEPT is tagged as EXPERIMENTAL in
> > Kconfig =E2=80=94 meaning it=E2=80=99s not yet suitable for use as an a=
utomation tool.
> >
> > However, for those who are interested in using DEPT to analyze complex
> > synchronization patterns and extract dependency insights, DEPT would be
> > a great tool for the purpose.

Best regards,
Yunseong
