Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA14384CD1
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604591; cv=pass; b=mqllKXWDmu8QtHe7AerqETnDYR9wl26wQ1ws8NEnjdp+66+ZkZK98KueEm6SrODuvN1airNAEHoNyED1wOnO3UEYPKOOAlcZGoW3Wpuw4ymc8h5HFwyEIG7mLOFegtf5XPBHsNli+EqMuosgxZTIu2eMfWOiCWjS0KkXL8pD88o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604591; c=relaxed/simple;
	bh=8MTomgvndci6QL0zOaAHPeSzdW934vYd1zdRdj8UROQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5hIrkDnqyH0qtf30f9kwo0eyormJ849T8GBNNwqG2dIEKoMA4Kf3rTPUX8QjQBhB+E57bzCLhDyxioEUgJrDHed0TvlwTe7wD6kewwOJ4PROA6I940xSJVgN8qCxDoAoSCM0EddbC4ZOxDZ9trj81dyW+NzOrsQVne9FDzRvKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U91E2Egn; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U91E2Egn"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c01c79467so87691cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 13:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787604589; cv=none;
        d=google.com; s=arc-20260327;
        b=gWSiPWgTjRtXnZG3wmLQZ+W9j8zEl31/Av1BB4lYcbzP/skQmpXHa9lkZ/OS96JgNr
         1jZ2NFFcCm5379WuLv/ZBq4vQEiuMlyB44VJvM2Jcl2w1FLHxdtJlhgUx4ldZjmC20+J
         O49PuQNJZT9zYyGybz0id1Xc4GJuZQfCLDaXbidshvVO4LLagTPol+Ae+lEcUVMRHBIq
         CW8DwifXrLnBkcWY7NeqqlvRdJ0PztGKEg6w98PH4v93fZcnYsUcyEhs+FXArBuB4AFQ
         qIZ95JW/2YLI7qJ32otjy7G+yXoV3C373ey3aocZ4GliOkjzKNJG6Ca4AlcakEt3xuXw
         JtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rnrc6rgXkO/4siYHOqsGt2EqzbzE5rWSn7kKau8RpvM=;
        fh=WPnZp3kEn5CqbZgbvdtVUP0zx6LWE6P382XFKl9BK3o=;
        b=Hcn/MB7purr2NO7hZg2IStx3k+/EAoyS76FyPEPJPYxc+KEYbEOVeMzNi+7C1MsWk/
         TGz0FhoSG3ZaDXwOhfL955Czp1nPxElY5JRgUDOLndVJmGCpSXURFQYTH97kDRsTsxBW
         OExWYngsgzNfq8ksJiFZijqoJMUVfqkH5fQKOAvvdo7ThCDqo2okNKqpb3HiM6fKsY/L
         QagK88kKnQy+6xXK5K+b7XnIIRA6Kz1apXMLhOMrKLyZxp/Oj0shbkNWtHbZurvGwSfj
         HAHtjmP3O6GJxvuwsVy7SNdQQyWw3IYLa9yZqvpUhDtFhYLzxvf7sirczxSiTnr3MiOR
         gAuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787604589; x=1788209389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rnrc6rgXkO/4siYHOqsGt2EqzbzE5rWSn7kKau8RpvM=;
        b=U91E2EgnTOWq+oBcEShuBHdAA+asYkQFCr1Dz3NPt0y20dyqfvEUluMVnyfEVlStwV
         4J1jwWWOxoTLEBWJv6x0gYU5E5DMw3AJjPZA5Z5EJhUpJ7/Jguwwswo6xT9FOUFg/kjn
         T2B8Ic7oM1HhuJOgYWdgf3s2XOYYT71MCixIJyCleZdF87evh8ltez284txOS4acSJ+b
         Iq+ygtGdYNtA3OgBqE2R9YGXh6YDMy3aF+RPX+wSLZHAWJTBezMBPSSycOXwZCX29woN
         HU9Ct4Jarvyd28DPBLsHSJ8e6STzlU7VzhKEAO3Wz5GKvCmU4aE/aZGPOja8Bf5381vF
         Mh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787604589; x=1788209389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rnrc6rgXkO/4siYHOqsGt2EqzbzE5rWSn7kKau8RpvM=;
        b=VPc9BQKmtwrQkf1/h5/bVfFJcFQwWGGHEW/Y2qMYeMFxYhqKJU5EUDH5DhGcpYbzxe
         9FGex1P+ykR7UnJgG2iVROJ0sZI51DNvONp963SXtwj+PVH3wkbUCHO7v3YFnAYIO/We
         c7GxWZkAfuPO3M7f2Vr2OgDMu3vMx6Lq3lIdxA7GYj3yaFKmlyLMyLMCXYJQ5bvuhyev
         3MhEMNR0OKHPvN40JhhT26wLWs0IP+85CJrhJVsfygxI2UY0bgwkH9igUJOjN1HYQQK1
         Vw1lVSyf0TAYuKVqON5QniAmReTNfbO3XfD38/VQ+OIE/8cu7YTkRBHqeZLfEKDP6bZS
         moBw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2PmddmfSCgVrhjoN1S9rbRF50xH9CjA+/pvBMPpcnZ65PPrXRjwLtMtZrcuZRdUGjEquuu2K6Oy3AO4na@vger.kernel.org
X-Gm-Message-State: AFuF++k8PQcJ6ewMkPIl+gzj30HxDPotUoAuFqOiKzHsfVgILhDWd5dG
	5us2Ya7SxNCJCQCxwqO02PUNPUHJqC2E/ehGYRtpV885Xe23Td6X4Jb4Fb40RAQIRQEYEFwmORF
	j40jbKW/M7NaETkVBF9tYoVms5mPOSMWnhZukIy75
X-Gm-Gg: AR+sD11V4mIbWsAugxOkpYWP2+m69ICXaKy3BBk1c2j4i78NJPKdIPB3Axop9oPdjId
	M+nVNPNPtIlkdYDuwj55wJ4NlcmE4uakL7nBnBVkY3oIVta92kpisMcdB0aH4ZqRRzPgM8yHYVO
	KOe6Qb/JpQtdbsNbM3vlolBo7UjeKzmgH/A5kz/s/Gr5Kpfqrv2ueuLYXsECVCJbf1NUSb3FZCx
	j80tO/jwszXrRLF1Im7Xw6Smsl3viG0R2pOdxaNxOvgiUOZiBjSvNYK+XEQ6rI+cNDqgA6lt/D/
	HyqY6zTGjzkHxLV1UAXhA0ZfGZhFEdcw4n2MWRsi3L4=
X-Received: by 2002:a05:622a:22a8:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-52e308039c6mr3439151cf.10.1787604588512; Mon, 24 Aug 2026
 13:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808200312.6326-1-kmehltretter@gmail.com>
In-Reply-To: <20260808200312.6326-1-kmehltretter@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 24 Aug 2026 13:49:37 -0700
X-Gm-Features: AcwNN1U3QleQBnvzJTMW5EoRgp4utl8IsEYk7xBRzJCJAaM1F0xAu0phz7nBY1A
Message-ID: <CAJuCfpGTneUdh6xvZoeds0xt0Y=dc_xgOCninwqSv=HzVnPvoQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/proc: make proc-maps-race work with READ_IMPLIES_EXEC
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 1:04=E2=80=AFPM Karl Mehltretter <kmehltretter@gmail=
.com> wrote:
>
> test_maps_tearing_from_split times out when READ_IMPLIES_EXEC is set.
> This happens by default on pre-ARMv6 CPUs, which lack no-execute support.
>
> split_vma() re-maps the first page with mod_info->prot | PROT_EXEC to
> make it differ from its neighbours.  With READ_IMPLIES_EXEC the original
> mapping is already executable, so no split occurs and the test hangs
> waiting for the modifier child.
>
> Use PROT_NONE for the split mapping, which always differs from its
> readable neighbours.
>
> Fixes: beb69e817246 ("selftests/proc: add /proc/pid/maps tearing from vma=
 split test")
> Assisted-by: Codex:gpt-5.6-terra
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sorry for missing both versions.

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
> Tested on:
> - QEMU versatilepb/ARM926EJ-S: maps and smaps fail before, pass after
> - QEMU realview-eb-mpcore/ARM11MPCore: maps and smaps pass before and aft=
er
>
> Changes since v1:
> - v1 went out without any recipients in To: and received no reply in 19 d=
ays.
> - No functional change. reworked the commit message.
>
> v1: https://lore.kernel.org/all/20260720061835.6290-1-kmehltretter@gmail.=
com/
>
>  tools/testing/selftests/proc/proc-maps-race.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testin=
g/selftests/proc/proc-maps-race.c
> index 1026d8c400e1..415eccb70468 100644
> --- a/tools/testing/selftests/proc/proc-maps-race.c
> +++ b/tools/testing/selftests/proc/proc-maps-race.c
> @@ -490,7 +490,8 @@ static bool query_addr_at(int maps_fd, void *addr,
>
>  static inline bool split_vma(FIXTURE_DATA(proc_maps_race) *self)
>  {
> -       return mmap(self->mod_info->addr, self->page_size, self->mod_info=
->prot | PROT_EXEC,
> +       /* PROT_NONE differs from both readable neighbors. */
> +       return mmap(self->mod_info->addr, self->page_size, PROT_NONE,
>                     MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0) !=3D =
MAP_FAILED;
>  }
>
> --
> 2.53.0
