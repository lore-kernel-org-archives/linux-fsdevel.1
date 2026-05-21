Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142F33A9CB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376576; cv=pass; b=QyboDNfZEHqVNyMSefT8EOGXP70grUzZa6AiPWGO/KDEhFLwCvUWeiN5rEcpS6szLfrEYA/cGI1DyuP8L3l3Z7WmjiK0Z5+7xwWMmxI/Iegn9ww1i/Vax+bCS0b12WHT4My/vYXWBIvo1BrPVAFwS+z57b9LWdUgN6NPustxNcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376576; c=relaxed/simple;
	bh=J01o1RM4DhFoqzfk/jOeARRHWP65H1t/fZlj1q1mraw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2s4emYmXqNkijsgjPuk2cT0iDirLSlq1NyAZDmYeuDmRfvwlHXJHENQPrLBDbh8cfAC2bICZuOagYpouztQt1nntw77lR8M6qjpQ2m9TqAotBPKgJPU9kjP6kFY0NwoJ3+bIfG6jLteWAMi81cTWnss4JqTXxFUcL99K5k8590=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azLFHh4f; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azLFHh4f"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-515548f390fso61cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 08:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779376573; cv=none;
        d=google.com; s=arc-20240605;
        b=LDAxMAewlpeR4rMB5VW2fmnypSEcuDe7wh6ByHTN3FqnBDu2caVsdMmuxbrLhRC5GV
         kUo7B02/7uQBFMQI9QZnUZ89uxdR71UwCwiyNaFEJPnoUWYjPM1gJl3W5ULjs7bLrbDb
         gPDhH3frueVJ5mUJUa2J8hFR4n17ZJ0LBedyGjrVYvZuORrQogJfRuC1oAfM+kW9QRoW
         uqwR7qdQJWcywsuzn+gxwbDRtwkeqIQNVb0zGCTYc4OQEAaEyfxb6F89b7ZALNYjYthl
         S0o3dG+TffHjl2zDcbN6BmaP1mQ9saf+y70CHBBelP9TI+pI/IPQ4Mo5r+Tb5jSWSt5b
         cfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J01o1RM4DhFoqzfk/jOeARRHWP65H1t/fZlj1q1mraw=;
        fh=aW7GCHSLr6dqFRqsv1Y+FAVq9/sVWcfvcRaXCJPZdXM=;
        b=fQclojwcXGb6ZI2RMEjf9x+wLQpEuSppOaqFppjIrouhmOjeZgeBd7A+OEgSB7CRXN
         g4rJnotHvA0XmpP0qDI+pdXmPW1Y/LyhKgQDJkBPkyi5nUI8yEtqJcVREt/IEF/k1J6D
         U2ahVRtXQj/aYGaxUVrvor1FQVtAL3udxj4oLUL6imFRf3m79FklpaJiu/flRaYlMaFE
         AdLV40YyuRNQ2J3jvTesm1KtDFZAw6fVNE9Njrps7k5R/kT67aGrJ45mXt9RG5zGu1c7
         PLXUI/4+C3OvY7faUAw8sxgMqRZT4E87qkkT/HwZQjGMucnrRQZhZeWBfZ86gO+CN2N2
         NZcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779376573; x=1779981373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J01o1RM4DhFoqzfk/jOeARRHWP65H1t/fZlj1q1mraw=;
        b=azLFHh4fWZwSc67JwU1+TLxpYF2u2GY9GVmMsNnPOrDroAsoSS5QXBrcGDAn24QCnW
         0jhnVyc8WgLBAMf0bChlQlFHJuWSb2tnwO1I4ryeKTtY85ts2MgZiIsVR7UyzVnO0ouk
         cPQ6U34S8ealZ4vOJ4qaBz+r+vMjPHfm9PK7DPcWTkpWz3sSlRKVPjLweKlD2N1eEmm4
         uYVxXN6Rm18+OUNJFxAJFqvFQZkseQehYYQ/vO2JK3VSdycl/a4RdDTnyjCO2n6mEGeK
         d1zMRceLJCTHc39QrTo6QNAu7SX+H1sZXrurpZ04d3BIHEPICd+HNeTlTIt4GjV396Io
         sy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779376573; x=1779981373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J01o1RM4DhFoqzfk/jOeARRHWP65H1t/fZlj1q1mraw=;
        b=HgKLnFea3RLFgIf0+jlIBImDAgEa26CvInbuf3d8yZOWc8vx7RLEBwP7uqP4cRcPru
         cMZ1q41BftXS1J0hezBZc/j2BgMgg2xDnGJY/m2eHPRYunlQhTzhRWRHQDof01u9vkET
         8q7s06SApn95EdSKrMQ89KEiigaD6FI/g8ugAVcsxR6bprMGOugkWoaGXsMh5UXOiGVp
         20uCZK0N7vvNNWSCpsvLrzFGID4JMHSTSoMydJmBY0fxMEEYMz8JANBR3fiVtvj0tliK
         EWT4dOVxZUBDANIFzLv5EYgmW2Io53XiHwW38jZDqYBX2iehPH93V0qHZGIW+FIhqrmD
         niKA==
X-Forwarded-Encrypted: i=1; AFNElJ9SoXQj+nYZ0gNh3XXIWaiw4SSeTG1xa8+7abb8zlIKQ2OMfr7NEkFljuBVdDryskVBZ/qlac8bLykeOi5p@vger.kernel.org
X-Gm-Message-State: AOJu0YyAPLKAYMzLoJgUwZlRQAx2Nid6+5xGfJMJZKQ0Hu79SkugqtZG
	4LTfBe5sOryFfmjhS5RFZniizbl78cn0cNdo46Qme7FxwHYbl4E/y2HZGdgiItyrSjj6Ki9htY6
	Rm989bZAD2Jv6KgfUb3rmHKUhu8CoefQK5AXp0MIQ
X-Gm-Gg: Acq92OFX2t8uX/CQKrKCam58w6zAToUnqIVI8scFS7VGSvTvbaQdvhqE6K3TjT5Oyll
	O4lgQGCCyMkrpxWSM6r9m5qgH8jD5ArkLn+Kc/OxnZl/W7TmP6ZGV3KXeuuaKtvpazV3dFXFR2y
	yMKyWz9Bcq/RfeNhYguFE3Zxub5t2pjy/tP6vVRuMRZrlDfJefS2WbKILbhM5kb7JbfVXgnITTP
	IGl8KKcrJdLVBy+ZAdZd5uXD3Xq805mAK8B6klal1Z+J3pFw1GCPNmiYRd1xVMZBDNdi868xxKE
	w3NoG94hOjjHPqPJEIfycGd5ONWqctn7vSyXweHTDsqal9jD
X-Received: by 2002:a05:622a:8c09:b0:510:fa1:73c5 with SMTP id
 d75a77b69052e-516c549f8a7mr9981991cf.16.1779376572049; Thu, 21 May 2026
 08:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426062718.1238437-1-surenb@google.com> <a27344e1-6f0c-4686-99ac-fc2cfcc5bb06@kernel.org>
 <CAJuCfpG3xZhL94E=yR1KsWs6fVwcdoAECoOaV3UOeB10TXmOeg@mail.gmail.com> <0ce6071b-0c99-4119-9ab4-a2d9c00b99a8@kernel.org>
In-Reply-To: <0ce6071b-0c99-4119-9ab4-a2d9c00b99a8@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 May 2026 08:16:01 -0700
X-Gm-Features: AVHnY4LLZAgoRouVjFmHuQ-Myz6Ah8QkFGgjPSrwBF-4h2eNKhs2Piibqid79-A
Message-ID: <CAJuCfpHPs54_hc_U9DCxtv=xikKHJMtqCEDN_4Y5aDqKhoBDnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] use vma locks for proc/pid/{smaps|numa_maps} reads
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, shuah@kernel.org, hsukrut3@gmail.com, 
	richard.weiyang@gmail.com, reddybalavignesh9979@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 12:39=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 5/13/26 05:58, Suren Baghdasaryan wrote:
> > On Tue, May 12, 2026 at 2:28=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 4/26/26 08:27, Suren Baghdasaryan wrote:
> >>> Use per-vma locks when reading /proc/pid/smaps and /proc/pid/numa_map=
s
> >>> similar to /proc/pid/maps to reduce contention on central mmap_lock. =
One
> >>> major difference between maps and smaps/numa_maps reading is that the
> >>> latter executes page table walk which can't be done under RCU due to =
a
> >>> possibility of sleeping. Therefore we drop RCU read lock before this =
walk
> >>> while keeping the VMA locked. After the walk we retake RCU read lock,
> >>> reset VMA iterator and proceed with the next VMA.
> >>
> >> With many small VMAs, is that overhead noticable?
> >
> > It might be but the point of this patchset (and the previous one that
> > made a similar change for /proc/pid/maps) is to reduce mmap_lock
> > contention, not to speed up the read operation, which is not a
> > performance critical part.
>
> Well, this interface has been around .. forever, so if there is a noticea=
ble
> change in performance it should be called out.

Sorry, I missed your reply. I'll see if I can adopt Paul's test for
/proc/pid/maps [1] for benchmarking smaps but I would expect similar
results as was reported in [2].

[1] https://github.com/paulmckrcu/proc-mmap_sem-test
[2] https://lore.kernel.org/all/20250719182854.3166724-1-surenb@google.com/

>
> > The original problem that Paul McKenney
> > described and which kicked these series of changes is that a
> > low-priority monitoring process reading /proc/pid/{maps|smaps|...} can
> > block a high-priority updates by holding the mmap_lock. You can see
> > details about this problem and the numbers Paul obtained with the
> > previous change in here:
> > https://lore.kernel.org/all/20250719182854.3166724-1-surenb@google.com/
>
> Yes, I know. A problem that has been around ... forever as well :)
>
> --
> Cheers,
>
> David
