Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3FD3AF668
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123381; cv=pass; b=iue8WfA4zUONuIoO6F2tGHn84TgQPQ34QKWbI4jyXoGO9DXmsjwYruGTou8oGJW4SWPxSJoXvJV0MbEFxRlZ2reoYWLyWBtqm7rt+iGyZEuYn1veeR1EE38CEXDh64sYlnLvh6pF8g1NgaShKdq3eVx0g3hzsXp3L4XmVdxvaIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123381; c=relaxed/simple;
	bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFFfW2uQg6fHk8bU4qXwmZmPqdK409bfDktFrPm7uvkLU0H1+WGMwWJM22nNH0EyFYKuhTWXl9k8cIYF/BizBkIM2gXnW35i9L5IN4ZFX3Dv5z3PVE3bOoFCLeYvJv0WorEDvIVkzTJFQz7VMU+UlF8Rf7YcWBHPazrnkwwdids=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWpDCS1V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOBaqdFG; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWpDCS1V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOBaqdFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775123375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
	b=LWpDCS1VjflzmgDG/PxwXOMQq+9TmI6g72ySxcoGjYJx86B22ZGpBNNOGyczK0CLBpFoh4
	Z+boYVlLSfcLF2qNjIQDZH6tN3GhXS47XzQRCSPvdY9SQIbBadL5ecNnIqA5E3IremL6A8
	MDNxBAG1/5rJDanUEPB46P3Pd5oNAHU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-TMfWuO8KMxixNFfiGwsPEg-1; Thu, 02 Apr 2026 05:49:34 -0400
X-MC-Unique: TMfWuO8KMxixNFfiGwsPEg-1
X-Mimecast-MFC-AGG-ID: TMfWuO8KMxixNFfiGwsPEg_1775123373
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9c029c06bcso52280566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 02:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775123373; cv=none;
        d=google.com; s=arc-20240605;
        b=EI8f8ejvc9TmPL4NpRELpqS10xgJQjLceSLiaNxBk25padGdPfcPmgt1tnaTDdRwyT
         orgHqZtXu/IY5NbFhHM31IYGLwtRy3ewmOsbyYE6HEQevPOKZBArdZqLpEiW2bMZPigB
         eezTeZWDMQZY9Ito4fq7FDzXtLGMBc0I08+sj1ul7+CZQ6K+Jq00mteDVB8eYmH55NrP
         JrbYKTGN3qA4WWCB5hNQN/5suCC14bVSRMGAafmhiGECQir87qWnOlDDXu/fSrk0oG9d
         5rjWh417ymd2wDF6c7iOOHrUGuPPH3TztjwdDvrs7G4pNTgXBbpUWGU4gNNNCG6Ox5F6
         IxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        fh=57KD7oHWIfPv1j4pCa7B0QGPhzb+r3sHgnSBHr7QQGY=;
        b=CsX4/ZkwyCPkgOvINfgGUfLf5DsnDgpMNozZizPGEw2673w+Iv0uDTmDz2nKDzggsz
         4lFA8UpuI5zSNEXLOfTlRpJlk2IpY1BOtQu/WWoWG0jiWXSQlo9vsyMzfX7SedTw9qml
         RnZe0m/BFDi1bSUi4ZhLtxPpydMWj4x7sQN7vKAgfV31ma/CTBHUaWk2thhZCFSvXTXz
         bzaW2pSrny/j/NrVhI3rLxUnLE08mcmerPa+EF1WdDciL9Efrp487uL6YhMhYFYTIguH
         Qx/y9XAHcrGfyPusQRbsfpZ7yXIhcefp2RLh9LDci0ZzxVvqH8G1INStd5ZYohstMXE6
         tdXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775123373; x=1775728173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        b=UOBaqdFGTixDkdR6S35LVJjoFbXZ5cM2ZGgDD2OKMOrb5dXOS99tH6hYnIB9FMO31j
         W3m4oqmXQVWZkuTX4oU5da+LG4bfp8WKh5eHuorBEOw8HPAKoN8YjguP2zEJs3Qy53Aa
         UHu6VA9+QkhuwqHdjW2qw0MTzGH4gBJX0z9TwXqAvhKZXNcU9G46DspqjGbdJYTwGqCe
         4aa0i/yIVs8EH5wAphwGc8TUHyce31EXOiCY9e5s1uuRmzpC/wHS0dJ8KIYvWi7E8E4W
         O5SxzTTb1PbFk7/YYfhnWTaEDCrrKlnaIOmuCVM8YBgEWRe0Vw1t92KGJb+aQZEJKkce
         MYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123373; x=1775728173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        b=jmnPH/fnerxppVHEqchyYGV+N76ns+TuY7L48E/s9ch/W3KtZfx634P0bXRzMcWlt5
         5HOaOQCXPiOKpOM2Ch7btoS1Q9fhp6f3Ojdl1eGkbtvxn1cv80+oiByb8Lmxrw2Iue3H
         FqvuBwIHvkX+fFtecV7NlFNHc/9jql6Tkp0AcVIA5NaLHsQlj0n9Gk6naSAYJE0dhQzo
         CI3dWwsXoIomLxxf4D29t3nU1FhZzlekXQ5C4pMjX58FltOB7JPeKf/GGywDoy50Cxpa
         5oo7z6BL6dqPPF84FM0pd9Mbe4QCf7JHtwz5YliIRq8DMfm9eC9jLV4w+HMMlkj+j11V
         LCnw==
X-Forwarded-Encrypted: i=1; AJvYcCUbHTNlEHRAGCyoCSC4kwcB6/ctzE/MedxtgcLOaY8BF6jGRzSURj6ND8LxnuHSp+xu2P4CNjb27wmkF9vD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Pfjmihhp6rt0/nIg6EGGUFgEzLb8ss9LmKS7C+ziwa02ibc0
	1lmVbKV0c3T8nLXjo02Z00IOgUtT4Ws0Jjoh+QzGy/EQ+OyBxRAhWNHpyVPqJ68frHvvezzqNna
	t27+XhlJ2zonymzoWfgrtGh4UIu7nHKDVawuBc1qg9z3eDmyZL6FX6JkiF9ouzgHV5vzwAX2bju
	WcbVCnZsBoSAhR4KqASQe/sdbehfN9K9mwztH5ML5eog==
X-Gm-Gg: ATEYQzx/iJmX+/aRnm1ZB9fx1D8yeCuCVpf7nuc2+OphBXgW7G/end6Elw8DSYYrYgE
	CDyaxgVj3qZc0aVsOhYFP9R6V1v2AJOktUQauBGScTT42MsLA5TVAVStzcTMjRimSBz2FHE2szS
	9PjtQNKL5lVuYZjrWciSXaONTe1OWCpUrW97awKq6eplK+kPoLqnaRYx1kukPRdas/Uwqc6V5Fl
	pv2EA==
X-Received: by 2002:a17:906:6207:b0:b98:2d0d:fc00 with SMTP id a640c23a62f3a-b9c13b0b08emr475388066b.24.1775123372884;
        Thu, 02 Apr 2026 02:49:32 -0700 (PDT)
X-Received: by 2002:a17:906:6207:b0:b98:2d0d:fc00 with SMTP id
 a640c23a62f3a-b9c13b0b08emr475385466b.24.1775123372331; Thu, 02 Apr 2026
 02:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22ffc044-4cc7-468c-b11d-9b838c92e82b@siemens.com> <20260401165841.532687-1-ionut.nechita@windriver.com>
In-Reply-To: <20260401165841.532687-1-ionut.nechita@windriver.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 2 Apr 2026 11:49:20 +0200
X-Gm-Features: AQROBzBJw-tLhM-lD_x8-woUH2LWxJHrMMtqB3L4YgOqRmMqBGl5_Aj9bKxBLJU
Message-ID: <CAP4=nvQehXtd2AEFzuRzcqfXOmU6U3LH9M-nQTvNkdCtAV8YTA@mail.gmail.com>
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock"
 causes ~50us noise spikes on isolated PREEMPT_RT cores
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: jan.kiszka@siemens.com, crwood@redhat.com, florian.bezdeka@siemens.com, 
	namcao@linutronix.de, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, frederic@kernel.org, 
	vschneid@redhat.com, gregkh@linuxfoundation.org, chris.friesen@windriver.com, 
	viorel-catalin.rapiteanu@windriver.com, iulian.mocanu@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 1. 4. 2026 v 19:08 odes=C3=ADlatel Ionut Nechita (Wind River)
<ionut.nechita@windriver.com> napsal:
>
> Separate question: could eosnoise itself be improved to avoid this
> contention? For example, using one epoll instance per CPU instead of
> a single shared one, or using BPF ring buffer (BPF_MAP_TYPE_RINGBUF)
> instead of the per-cpu perf buffer which requires epoll.

Neither BPF ring buffers nor perf event buffers strictly require you
to use epoll. Just as a BPF ring buffer can be read using libbpf's
ring_buffer__consume() [1] without polling, perf_buffer__consume() [2]
can be used the same way for the perf event ringbuffer; neither of the
functions block. If you need to poll, BPF ring buffer also uses
epoll_wait() [3] so that won't make a difference (or is there another
way to poll it?)

[1] https://docs.ebpf.io/ebpf-library/libbpf/userspace/ring_buffer__consume=
/
[2] https://docs.ebpf.io/ebpf-library/libbpf/userspace/perf_buffer__consume=
/
[3] https://github.com/libbpf/libbpf/blob/master/src/ringbuf.c#L341

That being said, BPF ring buffer is not per-CPU and should allow
collecting data from all CPUs into one buffer.

> If the consensus is that the kernel side is working as intended and the t=
ool
> should adapt, I'd like to understand what the recommended pattern is
> for BPF observability tools on PREEMPT_RT.

The ideal solution is to aggregate data in BPF directly, not in
userspace, and collect them at the end of the measurement, when
possible. This is what rtla-timerlat does for collecting samples [4]
where it was implemented to prevent the collecting user space thread
from being overloaded with too many samples on systems with a large
number of CPU; polling on ring buffer is used to signal end of tracing
on latency threshold only, no issues have been reported with that. To
collect data about system noise, timerlat collects the events in an
ftrace ring buffer, and then analyzes the tail of the buffer (i.e.
what is relevant to the spike, not all data throughout the entire
measurement) in user space [5]. The same could be replicated in
eosnoise, i.e. collecting the data into a ringbuffer and only reading
the tail in userspace, if that suffices for your use case.

[4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/tools/tracing/rtla/src/timerlat.bpf.c
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/tracing/rtla/src/timerlat_aa.c


Tomas

