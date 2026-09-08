Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593533344A
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883716; cv=pass; b=KoNRb1Bkd9/TRL6XZwJkaiw2Ev5+q9DdEnEa+cqV1Eahid5T84hgVjP1TqbMYSAbx6nTU5oCFRrh1P72sGHSyRW5L+M03S/8AbOqQSykCZ5ZB4FGs3N/akuRTw2rivFURs4Zk8qUG3rM9+3n1hf8PA5oY/RLSPTtwGI9SLJ7tf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883716; c=relaxed/simple;
	bh=BuweEasqZa4FcA5KIdPQe9NpHrOVSkXVRDcRoAAtry8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cou3RXjcZf0UDhEOaNXpRf4Cxp2uKQRjnL9hWO0N/0N1TRmYktclC5RRfWW+yGN5iQqtLv2F/frDDk7ucBsg2A1VXNXORuPyS8NNfv5t1JjLSkx6e9OIRqDF/Sn2hhK5SYX3XlTTbvF5sKYgdwCCSMu9yCKzzlm9aQcqTkEe42g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UitvwMzL; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UitvwMzL"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fd8d88so32235a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 09:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883712; cv=none;
        d=google.com; s=arc-20260327;
        b=I8eq97N3SxAXcpSFyr2vG0gPaVvI34tA/+9No/FXDK14SeuNNw6zNcZu/8dkq8iLov
         ovSeBX7s6g49qbtMeclrnMibLEpplsxJV5zgZIgGPa/7e4p4Kh19ARspyE8ehDKPAXR/
         12QiC50ZW0FQK5+uWlE7UouagpJi6dAj6dYXCThqFKxY75/oHa+5BCQdy+pRUBqT/PAT
         aoX+lXF3cK2GUPHudsWpTFRMl6lPdAnlhJSBdgiEoAXCl57hNCn+hHio844XZgv79KXX
         UUykeDH5n/xj0x0jDJbWyfg69Py16tFZ1HXOwenq/YMZCIxr42KwVJOI53bpLtoWDkrJ
         7OqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ZRky5Q4Vf1326tpyqcdGWIP2cKltS6aBzaezaZXYDY=;
        fh=/DcS9jojz7GgWHocB8M093/5GIMG9oYNG4IY5sEhNHk=;
        b=R0GUVS0OGjeqKT8+BdGvh+EEMeaA9sNz6DPHWzTmh4k5YbWv0dMP5QDZhfo0v0sbzg
         VAxsVR/ohSGVTfBzSUTITH2WZC1Z7j6qqI/1KGEsAR7CKrT2C6SFBA2U8KILN4njCdBz
         88+gFLO2CooIjx+d03DFI+FQYaiBv4ZeTWluK0kSuszCyNbPM1UMDS3KTMgGvvQ61Lug
         6HrXVJrrEaHEls9tiGrqlO2NEKNzzKol2InSqiWXh3Zfq5UC/JzIxjYkfTVDbeaddtzo
         AamBVKc8GE+egwkGMQXkeOQ8Hv92YKk0LR1ckq+cqLOSQH7RcIloviuzSf/MMdAIrhsA
         eyYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788883712; x=1789488512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2ZRky5Q4Vf1326tpyqcdGWIP2cKltS6aBzaezaZXYDY=;
        b=UitvwMzLPIw1DhPGO7Ytq8MT2YW6tdGh5kGfOc7wLCkmN7WkMmnTjM4mE8i9YdsY2D
         QBZMRuulBy0HJ4nqdzWaHnPbeit7Z53HwI5VnQPdqbtg4C5+mTVQHumf2Ambugw4nJ+b
         Sg3/swSmrHnZUyHLAFu2ecr0cNKGRQkNyKucVxrqvl7iKExENslfe2JQg1wrCAilJR1z
         nj//WiKqFEMolZ8GeJiN5wOFouXP4Z19hRd53IGIBwJe9EzyBzVbe6kES5G182V72hun
         S1LLN/lPYzyxycwzk+cVMHYZpXfT+03ovIn9CF39qJJ+BQf105W+fkq4fsVnhzPsrYI6
         LeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883712; x=1789488512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ZRky5Q4Vf1326tpyqcdGWIP2cKltS6aBzaezaZXYDY=;
        b=K2WqZ0Nyt8PqoLlRzXWXusAPIIqb15Hr5TTQi6mLlmHRMos0jrqt7PO8+mqLOidMwq
         10m5e5prtQPO1cfzETZ6JUsRv6KLxZmDlBq3MzQ4MYvwdrZoWRU7ptNdzFbnU28tGHTB
         antLXEHpeu8HUaq6GX+389FuEeNIr3YiJeHGyzMopz4rdv+BqIrXsFSAToM9qU6L+Ld+
         Lo1+alRQK6mivPQ01u90jfy73nNvNEerGMo9AbvvMdvrI7vvIJwedOCm28BoB+dNEYRL
         xXkTelMZoogx2s9r050jzWhzp3kQeZhdP8WKdBMa/tnevguSxEobNjyCgq90ImnYBc5b
         6IQw==
X-Forwarded-Encrypted: i=1; AKwUvBzdX2+zQr1ayGeaq8ApHTCleBThnP2k23yPi0q0x7JfosBsg74Ds4MX+pxJM/rCPXQAJZOvKDipOrtzB8Hv@vger.kernel.org
X-Gm-Message-State: AFuF++mzhv9Ua+fk7+4MbKKTgybdKY3BUelnxooc4aM8S03wjP1PkA+s
	kPaIbSPoaDJCXYRpjBoN9IzorbbH0f7Wgn228AvPrqv42vLXIkkdhkr6I8Dnvhatg8i22mUcUZi
	ogKypDsH9j/fu4DNAwLnjXOueufjYb348q+83vXis
X-Gm-Gg: AYBFou0QxHZqWSfUOSVEmO9bT8q3jUKtIoy/JlzZeBT1DKMMWNjOPJxozzhlA6UuD7K
	FznxrbJYrpvaHNAyWWXTraXakLgqWE+uCIwpRWmPlqDJMaweAveXTxcfqkxde9qbkQUEuhcJudM
	G8Sr3JderPjbM25zsTYnrJYPy257IDjB+iBsmpKw26S4mrS8xeldIcxpmIAa+vxsLaGSwi8fB8s
	AaFvjuOpXk8Q2LTRpWCmqjg21+I+XCUzDo1mGDJC0R1pLhC+woBX3aqDRfVyrXvN8bREPF+Upko
	f4f1W4b8iLmwOH4efTvlcssoXiYZomtNVpsbMakSGiC+nE2wJyI8AHJhX+X+12mqSrNrovtF1i8
	=
X-Received: by 2002:aa7:db59:0:b0:6a6:8513:7e14 with SMTP id
 4fb4d7f45d1cf-6a98df30f3emr443a12.9.1788883710869; Tue, 08 Sep 2026 09:08:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260908160452.1548235-1-xueyuan.chen21@gmail.com>
In-Reply-To: <20260908160452.1548235-1-xueyuan.chen21@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Sep 2026 09:08:16 -0700
X-Gm-Features: AcwNN1X03USG0tbC7AUd4gWC5PsyFgweG67SorhUtWJ-m6PW4b2RwVrgEorognA
Message-ID: <CAJuCfpEwbMQsax4TG6egJ+nD1C0JB-tY1BZKX0LeiiNoMev7MQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] read proc/pid/smaps_rollup under per-vma lock
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, david@redhat.com, willy@infradead.org, jannh@google.com, 
	paulmck@kernel.org, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 9:05=E2=80=AFAM Xueyuan Chen <xueyuan.chen21@gmail.c=
om> wrote:
>
>
> On Sun, Sep 06, 2026 at 11:39:13PM -0700, Suren Baghdasaryan wrote:
> >proc/pid/smaps_rollup can be read using the combination of RCU and
> >VMA read locks, similar to proc/pid/{maps|smaps|numa_maps}. RCU is
> >required to safely traverse the VMA tree and VMA lock stabilizes the
> >VMA being processed and the pagetable walk.
> >Note that we have to keep the logic to drop mmap_lock on contention
> >because even when using per-VMA locks we might have to fall back to
> >holding the mmap_lock.
> >
>
> Hi Suren,
>
> I tested this series on my arm64 24-core machine, using the same
> command:
>
> run-proc-vs-map.sh --nsamples 20 --rawdata -- \
> --busyduration 2 --procfile smaps_rollup
>
> baseline:
>   Median   Minimum   Maximum
>     0.132     0.121     2.600
>     0.132     0.123     2.768
>     0.132     0.123     2.804
>     0.132     0.125     2.835
>     0.132     0.125     2.837
>     0.132     0.125     2.849
>     0.132     0.125     2.858
>     0.132     0.125     2.888
>     0.132     0.130     2.894
>     0.132     0.132     2.896
>     0.132     0.132     2.915
>     0.132     0.134     2.921
>     0.132     0.134     2.927
>     0.132     0.137     2.945
>     0.132     0.141     2.984
>     0.132     0.246     3.004
>     0.132     0.270     3.381
>     0.132     1.316     3.533
>     0.132     1.321     3.551
>     0.132     1.343     3.924
>
> patched:
>    Median   Minimum   Maximum
>     0.006     0.006     1.950
>     0.006     0.006     1.955
>     0.006     0.006     1.955
>     0.006     0.006     1.956
>     0.006     0.006     1.956
>     0.006     0.006     1.957
>     0.006     0.006     1.958
>     0.006     0.006     1.959
>     0.006     0.006     1.959
>     0.006     0.006     1.961
>     0.006     0.006     1.962
>     0.006     0.006     1.963
>     0.006     0.006     1.964
>     0.006     0.006     1.966
>     0.006     0.006     1.969
>     0.006     0.006     1.976
>     0.006     0.006     1.982
>     0.006     0.006     1.995
>     0.006     0.006     1.996
>     0.006     0.006     2.043
>
> So the median is 0.132 -> 0.006 ms, about 22x, and the worst case
> drops from 3.9 to 2.0 ms.
>
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

Thanks for the confirmation!

>
> Thanks,
> Xueyuan
>
> >The first 3 patches are cleanups making later change simpler. The main
> >change is in patch 4. Patch 5 extends existing proc-maps-race tearing
> >test to verify smaps_rollup content.
> >
> >Changes since v1 [1]
> >- removed helper functions which are not needed after per-VMA locks
> >became unconditional in [2];
> >- added a cover letter, per Lorenzo Stoakes and David Hildenbrand;
> >- removed is_mmap_lock_contended() as it's no more needed after [2],
> >per David Hildenbrand;
> >- fixed typos, per Lorenzo Stoakes and David Hildenbrand;
> >- refactored duplicate error checks, per Lorenzo Stoakes;
> >- eliminated special case of start=3D0 in smap_gather_stats(),
> >per Lorenzo Stoakes;
> >- updated comments, per Lorenzo Stoakes;
> >- moved original comment about 4 possible cases when mmap lock is
> >dropped into patch 4 changelog;
> >- added smaps_rollup testing into proc-maps-race test.
> >
> >[1] https://lore.kernel.org/all/20260606015729.1837935-1-surenb@google.c=
om/
> >[2] https://lore.kernel.org/all/20260813193433.3318288-1-surenb@google.c=
om/
> >
> >Suren Baghdasaryan (5):
> >  proc/task_mmu: remove unnecessary helpers
> >  proc/task_mmu: remove unnecessary inlines in function definitions
> >  proc/task_mmu: remove special-casing of smap_gather_stats() start
> >    parameter
> >  proc/task_mmu: read proc/pid/smaps_rollup under per-vma lock
> >  selftests/proc: add /proc/pid/smaps_rollup tearing tests
> >
> > fs/proc/task_mmu.c                            | 280 +++++++-----------
> > tools/testing/selftests/proc/proc-maps-race.c | 187 +++++++++++-
> > 2 files changed, 291 insertions(+), 176 deletions(-)
> >
> >
> >base-commit: e3fc12b08aadde9cec7b3799ac0e0c9a1aa245c4
> >--
> >2.55.0.979.g7e5102b832-goog
> >
> >
