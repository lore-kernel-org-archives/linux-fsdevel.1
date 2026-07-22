Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C02EEE62
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679883; cv=pass; b=g/sDykrk6agsMlddagV2jsAwtY7Z2DJIGo5Tg1JUlzwRM5Znr2ebHbyBXprSlRwbD758cUeLlFiOGC6KD30w0F8F7z29sziJ3UI4NpTgaVm84WfTmG5Dp4RsyDQWsU+tMxFU5X8xTzVM7aTi0SHuX/ePLRtRERIyr4s1MkT2QGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679883; c=relaxed/simple;
	bh=wO7woZ6adHFlhWukDJ+j9jCC8OWRvViWKjbfbKDaXms=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UFmFfNoE6DcEWIO91byZ70KF70Vzd760c/V8GzGa+aU+lhO74/hfmAszkSa5O6R/fvmaNR2+5PV4l4+24Cjook6Z2dh7wfpnVuEJdEelK4ZClYeds8Ob28tJc7taLaqRmxRo5vxWA2BSuoyBgV6GrUdyxTOVQe4Hd3qmzLwzR0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgLTnAkT; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgLTnAkT"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c01c79467so1229431cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 17:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784679878; cv=none;
        d=google.com; s=arc-20260327;
        b=HEUtS24+MV6zPfW23L6xtlAKeXtYIZfL1Mv/dSiW7Uj1t6OLBrri0iBpp4wbXoKhQB
         7U1vR8SglBSeriOKi6YVyLo4wzKxyr6zLACE3uJ4ug/YQSYMTQ9SJb10TSUBhqGRPYv3
         1Bq7p/OiJpOvHtbhH82xT5Ua2wZD9LAegqVvf1VcQkR86d5R7W8sjeF1Uvew7/01ofrm
         Uj4Hk7d4yGBopdFeSWeY6GhFgX99Ftqdtxx1h1viFwT7//VImYw6vinK3e3FxyLOICKJ
         /4UIGHDA6s+TKPS0wtWoPgoDM+DE6HV5WkdPAh3/INxTLtZa29jMk0ORFHdZ9OObRvHf
         uSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=wO7woZ6adHFlhWukDJ+j9jCC8OWRvViWKjbfbKDaXms=;
        fh=E0/lMSs9R/NXT1udxPIfCc5s+kxCgIGMD4XIzif6k5o=;
        b=sVXToltEDStOWPzj4IIO7IuTYeZ62SiDkeMiSQ8C0C0TvgFaFTohenHZf/TmQFdOpx
         i1KLXmOHA+TMrT3LFsgmfWUna2nc6I4VDm0sf0ZVoUx+64QqaP5kQka1vhWbs8nlUNe/
         G+ikUvAEgiOQunPq5WwjM/9SQG5zAgtDhCSo8WOoRurRw2y9Z2dTwNEwBDSbnd4S2Q/L
         PJB/O9EaDWIkYMxfsgSXfo1un8HzCyTBCnrDaOf814I9PjHz5PuCtV026lM+gsAI/bQf
         ZZSbyOArwrVqltSLaJrCkQiuL/71su011OU6NOgwJOkmBmYwFxcDpc7kPBnBYWqEf5bu
         MeyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784679878; x=1785284678; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wO7woZ6adHFlhWukDJ+j9jCC8OWRvViWKjbfbKDaXms=;
        b=AgLTnAkT96rgrkyBrOD+wwLJqfKlBy/TOuPenQp6pTLjAGRx2yxCmOO2goDTTF/zO/
         UMzcZcy9HgP+ys23xtaPOwI3kPVNg5HP+gN7dwqa5EHULW8gpxL4L1eWrxyfT59R8kQu
         WAMtPUCDnwmgt5R6XKPw9aCnvCYPx+pXUzUEFoJirBJmLZccGduVOqmclq/do6n7Ut06
         6tz7ZhJf2kecRqHoMUijzhuatQllExyaR1vR6MqUCRM0C7FCJBlmgHQzPgHPNdQuguL5
         0HxpY4kFNa6o48xjWCvLtK4rte3JIJkkmdHigXfeTL8afewhQHLz3rWhnGycGyEoK62i
         q/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679878; x=1785284678;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wO7woZ6adHFlhWukDJ+j9jCC8OWRvViWKjbfbKDaXms=;
        b=FvD41w/IP9KwaAOCEyMt0gXMVwscHs0h2ffKKz+V6P0vwzzRu/bLd8RAsbkFBiMDZK
         LY8ZVwx9picG79vU2LXXNBeIVuruJxYxB6bnz2h2f/yoeC0f2M+6vuMSElFx+NY8mmfj
         kL8r52UzSK99cJaBhFbfPWvoaon+lVUkkjJTwN59JjbrCNxvXpmmO4r1V2iEqsZRhIBe
         MNN9Sy30VOuKFQbe81pbHTzLeh0KhzkWiCGkQ1IrtrD94jFEn3kwXvYM9W+NbKE0Snol
         cp2RLz3UGOrk2pzGr0IR5Z6twvOPGkFM823YElhqcH6tiSEeKT/FegS4NoUwoJ9kbO4a
         Awaw==
X-Gm-Message-State: AOJu0YyGemrxPAYJdWt1H3kHb1YQvWRZJD5BZKVKUmHbp2U0OZGlis4C
	c1q/rQcF7CRbFSCJ696DKF/8LHh/6sPlAFNDdC3ItBMZXx/UtMTMuTQenPNW5s4huTnJ45MZ+wr
	1GGlCn4dAiUwmirBZDfe78JXyKQrKQdPbdVr7nHKripa/7JGMkn27e5w+PoQ=
X-Gm-Gg: AR+sD12ZG2uSTHmligD/x9wV/OfD7sR/DKBsMSl2jiCYPnSVyLxbPIfR5EYQGFPll5f
	RWCKfQj0ur6L6/yfVbD5tP7oeVaOQ3i5UN73izcaFUUX77xtqhbKkJM7fvDrn0Vb/Q1L+CTFdzE
	NkoVTuBZQsj6A2D28MXPgVlsvV9eQ2Fwnm+Aj7I7PazadZJ5RkjoLSGehOGKnPjKDLX8rg/kDRT
	kuXq+C0kC5SjuKdCULIEyxoXzWa59uDw9ljvdv8vXmQL0r2R1TcfEzvYeI1vaURgsIJw2A=
X-Received: by 2002:a05:622a:a98c:20b0:517:5ac7:332e with SMTP id
 d75a77b69052e-527c24897d7mr4537231cf.6.1784679877427; Tue, 21 Jul 2026
 17:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cole Faust <colefaust@google.com>
Date: Tue, 21 Jul 2026 17:24:21 -0700
X-Gm-Features: AUfX_myJkAUwpP2hPjbeIxghW1MhIYCHVir4buposaaFOB6MEPdK81-F7KgGf_k
Message-ID: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com>
Subject: Questions and concerns about BPF-selected interpreter
To: brauner@kernel.org, farid.m.zakaria@gmail.co
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Christian, Farid,

My name is Cole, I work on the android build system. We have similar
goals for creating hermetic and relocatable builds in our build system
(a custom, android-specific one). I was very excited when I saw Farid
working on $ORIGIN support, but then somewhat disappointed when I saw
the new BPF-based solution.

Our usecase is mostly to decouple the glibc version used in the
android build from the host machine. We've had several instances where
our CI machines are running old glibc versions that cause problems,
and they're not trivial to update. Ideally you should be able to
download the android source and build it on a modern linux kernel,
regardless of the userspace.

To register a binfmt_misc handler, you need either root + modifying
global state on the host, or to make a user+mount namespace. But if we
use a mount namespace, couldn't we just mount the interpreter we want
to use at a fixed path? I thought one of the main goals of this
features was to avoid the use of namespaces because they don't always
nest well; Farid called this out as a problem with buck2's sandboxing.
In android, we don't yet have any nested sandboxing but there have
been conversations about increasing security of the build using
something like gvisor to isolate the build from the kernel, in wake of
the recent AI-discovered local privilege escalations, after which
these complicated kernel features are likely to stop working. And
requiring root is definitely out of the question.

I also wanted to ask about the security of this bpf solution. I
understand there are some security concerns about $ORIGIN. Why is this
new binfmt_misc + bpf solution better? An attacker will still have
more opportunity to place a malicious loader relative to the
executable. With the binfmt_misc solution, you will be able to only
have it active for certain things, like a build, but that's only if
you use the user+mount namespace to scope it. From what I understand,
Farid plans on registering the handler globally and persistently on
NixOS systems that want relocatable builds, does that not make those
systems susceptible to these concerns? (correct me if that's not your
plan, Farid)

I can't really think of a better solution than the originally-proposed
$ORIGIN support for build systems to use. I don't care about setuid or
complicated filesystems like memfd, so I would hope it would be
straightforward to just error out if AT_SECURE is set or if any issue
arises like not being able to determine the directory of the
executable. IMO it's fine if it only works in simple, known-safe
cases.

Thanks to both of you for working on this, please let me know what you think.
 - Cole
