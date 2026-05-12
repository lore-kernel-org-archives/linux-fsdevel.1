Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D119CD03
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619431; cv=pass; b=SDFXWOpy6sP5Go8YEwz5KmzrhC1p2Ztb3jd9Agb4qtwDtGVcNSL4FiTcE1HWaRgJXppTUOZM6EG0vm5r0nL1QG1E7GAoWOugTmqNNiAeBriFhKrkTA1dyQl6RVbwv8zoRWi4OXuqsAEegFMPMM5bvoYIrM9Y0/1ceJecgtKXh5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619431; c=relaxed/simple;
	bh=sH65genO9PSksSRgWawvOUfe015tcS5MMPhyerz5i5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPqD7Vjgo6xTksrGtlAxE1qf9Zh427jbbpPPhJc6QP9Y5ZZx7r/oshiFHtrvynDvsijVrfk1Gd8UBvp/NMJMbXijE7kG7tFzM8NwM1D5h1hsqlN3aoMeeFmTYYbarI9HenvplIEK4tevIIJ1ZttAI6mWzV/my8BBuyCxcMIUrQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L58HhpUO; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L58HhpUO"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43fe62837baso3114688f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778619429; cv=none;
        d=google.com; s=arc-20240605;
        b=BjUZWMsmF/sw4GYhVNfn5Bap0NXmz/GXmTaHRE4ZAE+3+4OvQ18yqeWzMZlwNdoc1P
         3aTStzw7eZhOrbipiVumISnU+Hh0eVI1LfVP+1Fdt5SAGEDjIx07X6DCQEsTaZ0ul4fx
         aBNFvH/zybfXSg2Bi8F9rA9cYhn0qoKL+Iu4YMR3vcapmxlxA6r3JKS8RCC25RrYFQPv
         yBIRsmzZW8q84WP6CkNhtjuP8sNPSWBT8Fd13h7SGOUjYf5YtIn/lYtVmoeKnSxDilnN
         gx7kmkDiSaZNQwLa3s8AfWMPNyDvAemhHHFy/T4jGfYfoOGMIYXxIbKsWmL7tsi2uCjI
         3hsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1GpjgDa7k7JEWi0ybDqpUw56GG9X3e/cpKKkJ3bjw+4=;
        fh=gUuNmq1QDg4A2C7K1d7nFQ0NLejLPeJNDyyghlasiuQ=;
        b=Ujg/TK+cH5jHZ//+bWn0Sycdqy4y8x1WQrrSlIlouOyjKVr4Dtg9mILhSf8dPFkK1L
         NUkD+k/P55gncCifihoF5UjHTA9L0pbU6v6eQzDnUEp7XEiPkDX3Ya47x6c5J1yRbP2J
         /OX+5plpp+d25p5Ck5HhEbe3fUJJE2F3FMezCMzkskufn1ygX1wrBigowpIYR4ZoDgfL
         M5iHSzjvQa33kosb2zu6Lx0G05W8GtjmsnBPVkjLWeBRO1JEgu2NMh16ByYxBsWaO6c+
         ZgA7v8C44noacp08OF/tRBQBU9hDXhwVEReSYwL4QFG1yVh+RbS7d2CKuA2uLNXe5aSt
         umwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778619429; x=1779224229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GpjgDa7k7JEWi0ybDqpUw56GG9X3e/cpKKkJ3bjw+4=;
        b=L58HhpUO097ocnq76Nq3TqkAbNoPb0zLO53iwWi6O0gwVRzK+IaKFeKWeP2EThBhN4
         XIrFTbre0UjnogR4/JcDsrmqMAmH04ShdW+1jvkXJK8/2AXHpP6jPW0T7WJqX2MtGCRP
         Drtxc2Yjt7ZRg9MlRcYN9Z2R2BM3atjBMwrFCv0J1nstp8AMsqn3zbKYL2c44gecnZqK
         e6c8b29W+TuNnQswjoUA4HqHJz1rFOFo8OG7455CuYy9yi08cZxkNM2tBzLtnHOhlRiS
         OzCucr5YHMTOp9EsmKgY8A0RgnmQmj4IU1ciiUjmt94m5XbTjmwbPK5tRzY+65y9Az5/
         ck4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619429; x=1779224229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1GpjgDa7k7JEWi0ybDqpUw56GG9X3e/cpKKkJ3bjw+4=;
        b=JvZ9ssZe9SAUINUlwS80TQm+U3pTroLtNjaYVL7fdQ6oJODNdP2KdP8C6h7YxoQHz5
         Na/sZMsuc9SzCaE8CZ6Z3VR3lo16JvpOCqQJFE9oskus4cS27BvwyuITD9OOPCk2HX9H
         Eb9XmHLMVIwGOE3nTBTAEeyz2MxiGxS1myhE3/vsiMgCwUsX/T+bt9t+gBBTha23TcBl
         omQ9sGZUfyYqFrlQEJXNvyVyFNot3+I46n7ZZIRChTYeg/deTYfWwbc+l9B3oon1zNeJ
         silijQ7CRlpudVSu4146J34Kqu0GShqS0RWFc/tQ5NFUn+W1sFiq/GLEsEh2oXC86xbO
         AAYg==
X-Gm-Message-State: AOJu0YwpilGI4rqkqbdZ6Ky8NJkwJqet3KGvrr1H01Btie3ej2G5Unau
	+yqjKPvw9CRKP36pT0MSU0ZLZz5l+aV7WxHQpsnPNnqIsDscFgZf/NPGneJZUbr41Co3n171Mj8
	/jPtUwnX4/+GkTImbrP8zOiENwQM0DGQ=
X-Gm-Gg: Acq92OHyiAB0ZMBaYye3b/4JpEaPXZjRO645bDIuaIFApFs2/5t8m6LASD9nCi2PfUl
	1GQItX3i4SkXFPppqhIqReCKaqZfE8hozPMQiBg8wS0fYFO46LExXy5w/hn3v/blWQyAxNfeyj5
	HeIHa4AHYio5CPrmCA3vpBCe1bxLbM2kqlosd4FgFtl4zEmikP7zUndbI0Zt8huMSWbQsAxCN96
	BROqeY6wxdAYXLS+QX9289UEfwKcF8aJCVPXiyRKGQ3YwB7oH4ewrFqZgg6+yevFD9UxV3sZwpf
	LTWnoQ==
X-Received: by 2002:a05:6000:22c6:b0:43d:2be:e54 with SMTP id
 ffacd0b85a97d-45c5ad49b70mr410442f8f.39.1778619428746; Tue, 12 May 2026
 13:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com> <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
In-Reply-To: <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 May 2026 13:56:55 -0700
X-Gm-Features: AVHnY4KEZ1Mmr0kDMENW8oEI36IhfcRB5Nub8mKis00I60VTCdS636HcgdgwrQU
Message-ID: <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 2:42=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Mon, 27 Oct 2025 at 23:39, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> > Miklos, could you share your thoughts on this? Are you in favor of
> > disabling default strictlimiting? Or do you prefer to have it kept
> > enabled by default, with some mount option or sysctl added for
> > privileged servers to be able to disable strictlimiting + enable large
> > folios if they use the writeback cache?
>
> So what I think we should do is implement some sort of slow writer
> test, and see what happens with and without strictlimit.
>
> Tried to ask claude to do this for me, but not getting very far.
>
> So if I take this maintainership role seriously and not let myself
> drown in the details, then the logical thing to do is to delegate ;)
> Which is hard (for me at least) but I'll give it a try...
>
> Could you please check how things change if there's limited writeback
> rate and we disable strictlimit?  And what happens if there are
> several such instances running in parallel?

I think for unprivileged fuse servers, strictlimting will always need
to be enabled or else a malicious user can launch tons of unprivileged
servers and eat up the global dirty page budget / starve writeback for
the rest of the system. Similarly for privileged servers, it could be
unintentionally slow or buggy and eat up the dirty page budget. I'll
read through the writeback throttling code to verify this and run some
local tests.

I think the question is whether we want to let admins opt out of
strictlimit when they're confident their server is well-behaved eg
through a sysctl an admin can set to disable strictlimiting for all
servers. Otherwise, large folios will always have to be off for any
server that runs with writeback caching.

Thanks,
Joanne
>
> Thanks,
> Miklos
