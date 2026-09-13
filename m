Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E138886C
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789327595; cv=pass; b=JOXVvC7Kkn7KdVbY4/Gz61JGWKb7DJltZaD5OMUD4HujUXNHhx5XYBO1QWjpioxRjOUE96CCgaYyKPpr5VadfGVDxLW6LLgwbRMWum66FJmdR2fSJVxqFLzUfmi9u4julN2Ieqybq5uFWV83rx82qiV+iWOG1hbu+t5O5/RJb/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789327595; c=relaxed/simple;
	bh=QREsgIr79KScFcsG/Gnozu2UkRu3V+m1VR0YdJd51lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMW5zs6zvj3ed5CC3ZT8KciIUf5DbTcZdBnZ9+xgFiPGZagfWddSqHf4geWohxS/kNmc/DcuPGBNCvVzYLmKzcavsJ5i2dv69FjIEVcqCTpaqTi56d4D1in8ald4Pjx/fITkR0ArJQA+4fytCEeHHB+BXdvfOxTf9avvOgdi+ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdXoMR+F; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdXoMR+F"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5306706e89dso169101cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 12:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789327593; cv=none;
        d=google.com; s=arc-20260327;
        b=WhrzMBiQWtqrNo9YqReBu+iMA8599dAwgy40gRF9nLjOkwzsDpB7HJCRg0TA6aTi6u
         rnJfniwslYqRAxtVthstTHUszpHT/OQTu8A+XYup5BMD0S6/nmduck7pdJdOjhQmdSuR
         PcEl5TJRxLr0i/5EAf1Agm2qT03pWO/wPhgg5qSpAJmVNamqBEw11+YRMp86o2IjzWFN
         2Tf6rCs8si7FT82EuLjZEJzOr50GeFlBjj/87ttRrLZdbEIuYf5QCaJ7uGh/Xwg37ogN
         qK0z4EnQKjzvZxFU4Rjh64bxDln9V8qYN0/3tCDdHUO7HjC3NKVeVCSnGLjHe37IZT8n
         2YDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O3bm4p3XYFyhf+gjUNcp2hdrx1XIlgahhu2l/35xw9w=;
        fh=zcI4pj21JGEnqAso1uiHgAGJjqpQJNixg4pMAGUSCHk=;
        b=THuOF/LhGiqCLHkLa8KTX0N9ZBxWKreRv3Z8eb5Djy+whXUat32AAG2v62foZpHHPE
         IDexec0U/b/jv0lJuSK0t3qPgso1ci6lCcMDRRAaUxTvyhEkLjw0TTjefFJW86WsYk4/
         KqXVi4j8YYl4jQsoymTlhJjM3923J76ze4Tn3GvfeWeNeiR4j1PZRyxFzXTwVY9KrsLA
         psTbakPoQZOCk18hMp9a0ijmhSeK7D8fnNsXwjmgN2QiOXXu6+1ET5q68Vu9vPdEIPhV
         AmyHuRZ2//QvojA9xWHAN8Dmfjqam9bFaT98rc2n/TozpyKgPtH5Hklhs/iAMCH6hmUa
         AzcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789327593; x=1789932393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O3bm4p3XYFyhf+gjUNcp2hdrx1XIlgahhu2l/35xw9w=;
        b=QdXoMR+Fdg2P7lIn19udRWn4OxrOFRMi5xL8QM+2PxLGZ2KdJ/gXhhRPY6khHqB8uN
         D0YgNg0gotkGSSxGushhoTd6XOapHlwqenaASUtnTEB5UhRETHlU/81G1h36vN4Y0Mav
         O4MqAW/zf4VqSE7sWPjC56vh1fzGYWP32JUwa0MyPAckEwbkZriWHx/CPlVrg3NEv+wN
         OOukvW+UFMlNa4iM7sYxRpB6BY+XCVAXS1yluK23lW+RubtX+hB++eaC+48l3c976Os9
         cfsqh562yPvXS1IYNN2562Hk5mzwBpajwq7DGkIA1WtBxBjGILKOg56740QCqACRS2TN
         KlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789327593; x=1789932393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3bm4p3XYFyhf+gjUNcp2hdrx1XIlgahhu2l/35xw9w=;
        b=JCyR8LHnNhyweL/6Wb4T+wAom07/0r8wryZbYWAK2u3fSAhlE4q/iZ6sKC4dbPsYTN
         RE3JuKs1xjg7HG05ZCQAp6tWr5lUSmP97HFGYB7uIMQ68b9n+9QBFC2DNtJX3rtnRRix
         5WJRIlCfF3N0cSdyJz07Iys2uUoSUB5Jr7GccuMRoo7UorQUbPuI/wHUYj2nNqXL5ZkF
         JFZWmjF/uJ2LxeWHkPw7thgDsZoUXMU/mqMWjFLcurwap5kqlFsxZb98ToBDRTGEaEmt
         it8eZS5NUjW2fKzZg3CnhWZGDZNJb1d3d2ImHr6thU4Cj2h1jEPh99Vw5LYatEJ4Ezjq
         Kg6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwS19FHSv+3FmyZX/UkHcQRDToHKn5eBmF0wJChQ8HF/4vTbQ6aEyPGJ3ABr/i/ZmcMO3RnKUs4YiauvVtN@vger.kernel.org
X-Gm-Message-State: AFuF++m3rQAY/Ss54TFsYdkRPCNnZ9tcK21qHcFKxO/j6j3jOka8zwrJ
	o5U4mm+a9jVa2cJo+CrkqJQ21RvfCGIf9a4QdasKD0HaSGTdOnxi8866V7bP9BoGPlUhqkI8o9l
	bO6NZzVEAx50RrcsaqtY4/sDBRBV8mPBpVETeDFtd
X-Gm-Gg: AYBFou00OwSZ5oclhRt/zfvDvx3LY5QmSbJcGanzQlUxmJFQxZpTU5zHqabz9HsY7TA
	isOyVvqV5HeZlUfWGNFeFqd5aJ10ptXnUXokWpMowFst/FHDm6CvqKGbhjRx0casOkFaeK6gn87
	05fbMEVGS11HwjnC+YwAXp/zY96dW5ILOF/vTQssJ9ZZKglK23Ou0gtvS8dw6qrbewP488XuYn4
	bcZ3zPyPlzWEKQ9n/pSv7M9hM8c5QlIdHiZBUZy+8JYBD2b57+zRLH+ZMowgU7Ds/LJIFdLCQzJ
	QyV9nqX0l5igIPdXNq79Py/n98JVXxYhb9OYbnLGmiGt6AJyRs9KNP2qsxsXSyU0
X-Received: by 2002:ac8:7fc7:0:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-530f8b121dbmr9139921cf.10.1789327587349; Sun, 13 Sep 2026
 12:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911194145.1781926-1-surenb@google.com> <20260912002436.0605a85b912eb8ae406cecf0@linux-foundation.org>
In-Reply-To: <20260912002436.0605a85b912eb8ae406cecf0@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 13 Sep 2026 12:26:16 -0700
X-Gm-Features: AcwNN1VI8o7qgtAf7FpFyYAf_QiJM539hgJGQoLRqGdhk0b6X3b8GUp7lNPBUcA
Message-ID: <CAJuCfpHW24Vh2RSr7qwzV0jmWz7oirrG2F4JPCuBnnk0x09NyA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] read proc/pid/smaps_rollup under per-vma lock
To: Andrew Morton <akpm@linux-foundation.org>
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@kernel.org, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	xueyuan.chen21@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 12:24=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 11 Sep 2026 12:41:38 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > proc/pid/smaps_rollup can be read using the combination of RCU and
> > VMA read locks, similar to proc/pid/{maps|smaps|numa_maps}. RCU is
> > required to safely traverse the VMA tree and VMA lock stabilizes the
> > VMA being processed and the pagetable walk.
> > Note that we have to keep the logic to drop mmap_lock on contention
> > because even when using per-VMA locks we might have to fall back to
> > holding the mmap_lock.
>
> Nice.  Queued, thanks.
>
> The speedups described in [6/7] are significant, although I don't know
> how representative Paul's tests are.  Probably not very.
>
> So I don't know how much improvement our users will be seeing from
> these changes?
>
> And I don't know how much usage smaps_rollup gets in the real world?
>
>
> As I've no doubt you know, Sashiko is saying things.  About these
> patches and about the current code.  Its pre-existing
> clear_soft_dirty_pmd() driveby find looks significant.
>
>         https://sashiko.dev/#/patchset/20260911194145.1781926-1-surenb@go=
ogle.com

Thanks! I'll investigate the preexisting ones and will try to fix the
ones that look real.
