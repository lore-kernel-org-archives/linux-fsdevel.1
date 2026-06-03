Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218B4C0436
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531046; cv=pass; b=WWQoprqrTbHIVHcdaNE5Qpq8uYKU1Cw2GqYby1W+TadSS34pwYBQ2ovhQXRwrY21Jpyfru+h5/H6qy3x7jx2tZ0TPhqU+QMzRzBIp8HkkIBpZ7SEzwMQNUlJeuyzJgIq8caPkAsDgaRPUSGHuS8dJom8rZoYCsybj/M/2y4y/s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531046; c=relaxed/simple;
	bh=/lSKt2U7pIdCGE7tCBBdr2fjoEgXYHG3evo2fbmpAxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRF15o3ZZz6n2Fuu8KDOITFRc3M9pAimfkt8jSHYnvXq/IAD6t28apIgiB2zeLTQKyvKQH71WOQTBmBgSqh9gJt62YpPP7j1xkqutB0bJ6PD6gVdGdasu6Y87roLhIwxJybVusNWjUhqMCOu9W21i+r9jFPgn04IHZFIqxwZoZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/KuuepF; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/KuuepF"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5175d339e8bso243591cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 16:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780531044; cv=none;
        d=google.com; s=arc-20240605;
        b=dssgAlxYK2CpkiiMwBsONDWy8ZZAPX0r4jzGWV/w7X/ELVgl2N2Om0Wk//ojF3HEqj
         fHJtUZYHu/P4MtEteT8AmivhmcPhNgkKXQCdAszul0g6UyiAiyb+GszrWmM1xKKbj4Sj
         ZqRgF4eW4c7GXzxPMLAvd1vv21d9VzeGEZv9nCX6WCa1q01CGFBHnz6lUS12RuLORZQP
         33rE4MT6Rhjx9nt4n+agCLDNtjtnLZgx4te0m4K2bwTr2ruqAcuyMMbjk1g03c/va5IO
         0L7AywtTj5enzeztJxg5eEGwcBcBxSANY+d44LSxGuRrd/2JXdrwEkqlpyj7YYnD6pax
         HOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mNur1Fonoy8Eha+exfChjghnGVF1uWKh6Gmh7Ox8d4A=;
        fh=2KSd61FWMaSG61bO0u9IR+qfyzwxOW0xeS9hIXy602I=;
        b=D8+8RDpua7j7mVn6w5abQI5rZliEnyIq/UUPhbQFqf0g0PCGqPefH44aX4RZMyCIWf
         LmDabV1WhzrfrQ/NbFpyjCzKSmwrMAeeVqsXDDNhG3P9EeTBfCbYY1TQSjjpjivYq0rq
         +UITBHA1kGqdBg4e6H9mazqWCrVDaREMI2SAZt4HeXg8J7cWWZ9YFs9licO50fwUofPE
         NOkhwE3AoUzaynXz7Yv8GwqgFQ6sedqsFqQFRr55iz27IG12kXZZc8HM2cmk9l+0OaQo
         wgg+AzIFNdXQBkDylNtdemDbF+P2TmW7VztVKtXotBxcYZHzIvH1WdKVSWFwMlJoBvps
         hWzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780531044; x=1781135844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNur1Fonoy8Eha+exfChjghnGVF1uWKh6Gmh7Ox8d4A=;
        b=E/KuuepFdT8P0TPfuUCXCk4ptijBDb9YrZJjH15BkQf4mtcjJT9IiSbtDuyJv8dzD9
         9zgChnASmeERVe7Ss+6zzHODxZg5hyL68PRUb2Jdk3mvzKCtde2GCof+6ou2LVErid6N
         Hge4tOXT28PTqT6R2lGjOUSWScXtxghWzRDECcafER7P0arsyxLp2geYwiAR4459+GYc
         e2Um7vExV1jSc2IJ5hM2DD7L2tcuDXvU6nvD7yPGWv58+bYiAHkYckBG6Wrm+5t8pYbT
         9GtMw+GxX9TbXMdEERPeNv+CTuWi+2QsiUevfjkO3UFiB7xWNCbVXUnN9lfE/+mvJGc5
         g3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531044; x=1781135844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNur1Fonoy8Eha+exfChjghnGVF1uWKh6Gmh7Ox8d4A=;
        b=JAN17mFT+ZrkqfKRtw1eliqK0EZx874u8uQSzxCLXfdZJ5N/ugAs9HolYNzUvQ/AWw
         2R521Ew4n33tJffu3fvE/QycBmQecDbmSSI32aTPFcJmpQvi9fnajFjno/t6JF0F/9qI
         Jl/fDGCmoIVRExKjjZOchmg8K0j3LfzOU1QtwHv1lvQudP4XsignWsfpqhAjNjpCv4bR
         tGrAO8CfiV23MejtDnq9w6dK40PmMZqYVlpcjPVlnMCHaZsao4enkHcV53Y0iDeD8saa
         T1K04nw+Y51UOCCKxBTs+THi/NesSzxb5lWZkRON8kaxyg7/wez1bwEYaZpmrgUrRV+L
         6aow==
X-Forwarded-Encrypted: i=1; AFNElJ9auCTQN60m2E0B1n0yDhmqJ6pGkAyk05Klwxh4rnv3z77KG4tetQD4gY/OD7FU32PWHqWSyitjLSNdqnx9@vger.kernel.org
X-Gm-Message-State: AOJu0YxU6k9bf3A0srNwnCTArXbtqwqCj4XiH2/89OQsgXt27H9y6Xyd
	bzVuq/rDqRikONJXfXIlkTx+vSD1kLYa5fK+Q6GPr74txL8VLV3hLtwAfKAaThKRIzRUxF7LqLW
	FXldSHpxbferG07gBL2o0xA75blnHW0NKnoWWqaQg
X-Gm-Gg: Acq92OEispOT2vJR7IPB6lhQtrl3K2iAkqks4e2tcbI6ecrHDkY9kmi+SCouQ5NTd8s
	QQPGWLchDx1n4zmXXN1PklFn/6Pn7et/N0Uznu7GOfHrKU5eAWMqHT8GqlcDZogGJ6JWnEXajqz
	gVFQFFLBiRdic7ed5LGP8rgC7fDE5gIMBaLFTiJsoS4ZJietfKbFs+nLwRFvagMLK9uH6tAGlHK
	7YWvpro8YKoXoATT0ibL/VV42LrBSgNhesA7uIYVVdppmMhLJ/GulviVauUVL8qOmJb1dZqFHMA
	DW5ZB3QS8owysU94
X-Received: by 2002:ac8:4651:0:b0:516:4f62:85ed with SMTP id
 d75a77b69052e-51787a79f2dmr3993231cf.18.1780531043458; Wed, 03 Jun 2026
 16:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426062718.1238437-1-surenb@google.com> <a27344e1-6f0c-4686-99ac-fc2cfcc5bb06@kernel.org>
 <CAJuCfpG3xZhL94E=yR1KsWs6fVwcdoAECoOaV3UOeB10TXmOeg@mail.gmail.com>
 <0ce6071b-0c99-4119-9ab4-a2d9c00b99a8@kernel.org> <CAJuCfpHPs54_hc_U9DCxtv=xikKHJMtqCEDN_4Y5aDqKhoBDnA@mail.gmail.com>
 <20260526184944.18c28d6980fd29ff12fbbe22@linux-foundation.org> <ahhdeYDAY7BvqxYU@lucifer>
In-Reply-To: <ahhdeYDAY7BvqxYU@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Jun 2026 16:57:12 -0700
X-Gm-Features: AVHnY4LIv-CCSzubXeLRacENeIWLGZDTxSTnCRRjCibVInHfLzdXyTHGiqn3Ug0
Message-ID: <CAJuCfpHqNJWVt2DUB_yi0Yj7Y=bB1xV4qYeAKM2RZZMW6xBFKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] use vma locks for proc/pid/{smaps|numa_maps} reads
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David Hildenbrand (Arm)" <david@kernel.org>, liam@infradead.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, shuah@kernel.org, hsukrut3@gmail.com, 
	richard.weiyang@gmail.com, reddybalavignesh9979@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:37=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Tue, May 26, 2026 at 06:49:44PM -0700, Andrew Morton wrote:
> > On Thu, 21 May 2026 08:16:01 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > > > It might be but the point of this patchset (and the previous one =
that
> > > > > made a similar change for /proc/pid/maps) is to reduce mmap_lock
> > > > > contention, not to speed up the read operation, which is not a
> > > > > performance critical part.
> > > >
> > > > Well, this interface has been around .. forever, so if there is a n=
oticeable
> > > > change in performance it should be called out.
> > >
> > > Sorry, I missed your reply. I'll see if I can adopt Paul's test for
> > > /proc/pid/maps [1] for benchmarking smaps but I would expect similar
> > > results as was reported in [2].
> >
> > How's it coming along ;)
> >
> > > [1] https://github.com/paulmckrcu/proc-mmap_sem-test
> > > [2] https://lore.kernel.org/all/20250719182854.3166724-1-surenb@googl=
e.com/
> >
> > I've moved this series to the tail of mm-unstable to permit more time.
>
> Well I'm not sure it's _vital_ to get stats for this, it's pretty much an
> extension of existing VMA lock work in /proc/$pid/maps -> smaps, and the
> logic is sound.
>
> There's no reason to believe there will be anything other than a reductio=
n
> in lock contention here at least under whichever workloads happen to hamm=
er
> smaps, but doesn't feel like there's a downside!

Just finished running Paul's test. I ran a smaller number of
iterations (20 instead of 100) because it takes lots of time but
results are quite convincing.
In the baseline, all runs had maximum latencies exceeding 9.7
milliseconds. In contrast, the patched version has maximum latencies
in the range of 1.8-3.2 milliseconds.
Median performance of the baseline is at 1.135 milliseconds and patch
series at 7 microseconds.

Baseline
./run-proc-vs-map.sh --nsamples 20 --rawdata -- --busyduration 2
    1.135     1.078     9.737
    1.135     1.086     9.834
    1.135     1.090     9.890
    1.135     1.091     9.892
    1.135     1.111     9.894
    1.135     1.119     9.896
    1.135     1.120     9.918
    1.135     1.123     9.927
    1.135     1.130     9.937
    1.135     1.132     9.940
    1.135     1.138     9.942
    1.135     1.140     9.944
    1.135     1.141     9.952
    1.135     1.148     9.952
    1.135     1.153     9.958
    1.135     1.153     9.967
    1.135     1.167     9.974
    1.135     1.168     9.975
    1.135     1.173     9.982
    1.135     1.199    10.014

Patched
./run-proc-vs-map.sh --nsamples 20 --rawdata -- --busyduration 2
    0.007     0.006     1.862
    0.007     0.006     1.937
    0.007     0.006     1.947
    0.007     0.007     1.956
    0.007     0.007     1.956
    0.007     0.007     1.998
    0.007     0.007     2.020
    0.007     0.007     2.027
    0.007     0.007     2.085
    0.007     0.007     2.100
    0.007     0.007     2.115
    0.007     0.007     2.233
    0.007     0.007     2.304
    0.007     0.007     2.325
    0.007     0.007     2.327
    0.007     0.007     2.427
    0.007     0.007     2.489
    0.007     0.007     2.500
    0.007     0.007     3.123
    0.007     0.007     3.151


>
> Cheers, Lorenzo
