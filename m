Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4585345CBE
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140016; cv=pass; b=MsInIbDBLZsgkRD678XF+tEiQ49fmOsfHEgaPe8uO6iFs3lJA+NT8D9RQyzRwXFq/0mGqEMntHif8lJ2IQr1EwTTysrpLSz6gzssD+Ttg8S+fDmjYd32y0G6YrxGjkgSa+ftDBDA7CfnhlyFVomd49ejRGogPEm4GfaPNhdlYfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140016; c=relaxed/simple;
	bh=Yk13UDKhHBWrmRCnNILsAJ9pW2ZdOFTsJD8wrftx0/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdOpBa7KEJF9/RLu6hyamLcIOFXokQ+KnutXUs5MwVc/0dP3Gx3Gd2EQXEkIs/cquIZRJVubjf9RSQHNrPjqO/LHW3Sk0hSrvmrMpCxPwLGL96TZ80/WuQ8HIqR0QE+vUHAbyHKY4SwL259jVDtc6jnJsZgMoswQAkRWZbv89JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBP6UMJz; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBP6UMJz"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d5fc2cd8so17361cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789140014; cv=none;
        d=google.com; s=arc-20260327;
        b=MCQiGooZZnam24i86t+KyVW9yKYMI8hKIDA06H1jeF7YtAMM7xjhllDJ0rKxx8JBiy
         53l9+oukaUUo66rqDsLMWDwNRFtBsPlmqlnl1rvkO3DPpTU3W3uKz40O7i1pUINe1Oa2
         bitzMGYlTyof0lWdyE9o9V8sRT3Hs01j2UddPXrNgz6FPm9YlfgwPAYTV1BmGpyZ7DNn
         1KBSSohXFo9QDoF72kdZSQKe3ZO5H26l+wPKc7Mp5Rz55kUn4BocIGArOc1onwtNHFyE
         b/WN1K85yFmNuuRV0c4EKWtrqpVj7ep8y+ev/qct8Sb8+ZQIYuwzTny/PK+kX/WhJnIm
         IQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yk13UDKhHBWrmRCnNILsAJ9pW2ZdOFTsJD8wrftx0/0=;
        fh=6SVue10YDtRygM/wLPq1+SS2X63vC0IvohohP12x5fo=;
        b=Q5kGBk+pfZL1xfrqgwiOUCp5yM1mtOQ96VXp7ZU7J+gKfUj74tUS8H4TT9qL3IOszW
         vEUipi7o003DIELPIVAK4htwkyICcpW1TXSDwSRLzgSHlfCuvePPU5ApZG+RKv7T0w7N
         T2xLwWmC7Sma65hsg73F2Ox0Gs17jh8JKaVuvY23VxQ4csNBszbJv8iqustBLG8bLwZj
         Xtxh8XniPYMvsbgKcPCzfX8Sizt8ZegDkzknlnh9xyGXhZHbLnLBIw6Uvg4HNCE/LnqV
         PH7WI7YDi1s2t7Z3ZqoZaDYHC74gKZd3WEHHJSzGQ8O4YHTFNDdXZvpEhUPF8UqHbPKG
         aUeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789140014; x=1789744814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yk13UDKhHBWrmRCnNILsAJ9pW2ZdOFTsJD8wrftx0/0=;
        b=fBP6UMJzPJ0KW/juIyKGox20dnrREJZIML5qBY7yeL/B/DZs5pFuhz0lAEXHBycPBL
         XyM94F/zx2KDpAW85sb0nleo/l+eyI7K2+bfK1LfcF4KAn16DfFF7SBzymDVhwohDA0N
         xZ7YAX9tAQdRFmUVTpB7Z2Z/dRQQrQk5vNjfA0gWLRI3drg3x8ntsurgXtNln+DLHPXF
         O0HK21flAY4PErWVsB+IJjMeUBBeiZsE1C8oAS+igJjSGzUhZ5Wv31s0AT3eBNHFoWPG
         t0yLrMHoJMMxKXicwe68gZgXkK/nTUlTVHTY+ekUZQ7hHI5KyD0w7NI+NpN5yG3EaZqg
         Yylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140014; x=1789744814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yk13UDKhHBWrmRCnNILsAJ9pW2ZdOFTsJD8wrftx0/0=;
        b=a5hlE2OzoMbpN5L0om6ApMyjl6lgXQFsDlrsgp+4AOsov5aP/yg9AsQNttafbsi/nQ
         Tu4CQcycxfwqHeW+8sFE7FcqwszmBx4jj/nD3h4Z8pctv/z3RD9gLtU9Iz7/Ns/sKx3o
         6iJrGWvo1ffPAgIAMtlbfHgBzCIg3oX9czrhU2VZtVRuzSVdkwRa1SyrijVYR5LV6Qet
         KKfta9X3dXliXoBhT+uXdlUL3prgsKxcXzgD54in3D02u5m4PFwa3MPI2uApdLO/Iuys
         rWixPpa+meRXjEV7MUwkEaGZGzsylB9Wg4dKDiRRCma1Bf1WAHF2lnHivbNyQ9jJg+eP
         oLPA==
X-Forwarded-Encrypted: i=1; AKwUvByMMi20hNTEsl+rSH32YZBxAmHk3Db7NdsEPDMFIxSBFiPtJKlQulbM7vfDP4CDTf+kUFBKfPP4ZcgGaPpl@vger.kernel.org
X-Gm-Message-State: AFuF++mA5KKdnTlYv0Rdq9KLj3hpvwT8POP7Ln8g5EPI20PvsAovQYMl
	tY0Tqpnp9Y1wPVZni/753qMkzJf29ySI3M2HhwzO0tPWWQWrPsefu8nY3Ihue39A6QiUIHAUwm1
	Z8fqYprh0NlV4lalGRi06Z6TH2zlZoN3BIo02jo+j
X-Gm-Gg: AYBFou2ueeic8AaSufoWiaJJ4Ppmgq9ffcoM3jT8ZEQIThkOVX71mGEZLQ1Ldk7ouAu
	t4xzRjVrdOS3hMvuCjsU1qa1mSYhwaL7n1mTdjOcOsKSLHXdKYlsNd2hk9xoWnG0Po0mhotCrEB
	EYIvDL7BszLQVBPP462xP9PDROBBcQQUkVulfzcYhybrOSjMEieLWWoAM0CkDVCElpLfq3LH4Nz
	0lK4RNdfZVX4ovXJSoB50euoCrZny5A7lflKnMTEVnsddfVMPBVdCfUetz/rVOwh7rIeUTZB7e1
	2iZPrebfRoIhhj/iGyltx9zdhhci/yfv8Dnk4kNsebEtw7GRk7BUKmPu73ow3gWGT1sBJ9nM8yO
	uhmZU/7A=
X-Received: by 2002:ac8:5d11:0:b0:530:39d7:ef48 with SMTP id
 d75a77b69052e-530cb49695fmr15549621cf.3.1789140012704; Fri, 11 Sep 2026
 08:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910234737.1340642-1-surenb@google.com> <20260910234737.1340642-2-surenb@google.com>
 <008dcaa3-2068-46e5-9e58-afb590d90584@kernel.org> <CAJuCfpF5CBrCxZWm+Luopf2gq_hHxsbw0QptNhfRT=+KjyWbJQ@mail.gmail.com>
 <88838d36-ea5b-4c76-b785-cf2bb71e34a5@kernel.org>
In-Reply-To: <88838d36-ea5b-4c76-b785-cf2bb71e34a5@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 11 Sep 2026 15:20:01 +0000
X-Gm-Features: AcwNN1Xk5ADz_rJe0NJkhhPYuxax2hrdjw3AnJOLY-8G8UUIe8p-ZF3eb2mA0Kc
Message-ID: <CAJuCfpEvyfR1K2ZjM2-AnrfQtVwHiD7zDvHLqfcSCUyfteYzkg@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] proc/task_mmu: remove unnecessary helpers
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Usama Arif <usama.arif@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 2:58=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/11/26 16:28, Suren Baghdasaryan wrote:
> > On Fri, Sep 11, 2026 at 3:52=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 9/11/26 01:47, Suren Baghdasaryan wrote:
> >>> When per-vma locks were behind a config option, a number of helper
> >>> functions were needed to simplify the locking code. Now that these
> >>> locks are universally available, we can do a little cleanup.
> >>> Remove lock_vma_range(), unlock_vma_range(), query_vma_setup(),
> >>> query_vma_teardown() helpers.
> >>>
> >>> No functional change intended.
> >>>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
> >>> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >>> Acked-by: Usama Arif <usama.arif@linux.dev>
> >>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> >>> ---
> >>
> >> I think you CCed me only on this mail correctly (the other ones went t=
o my old
> >> RH address, I thought that one would bounce)
> >
> > Oh, man! I used an old list of recipients :/
> > Should I resend to avoid bounces? So far I haven't seen any bounces
> > even from the previous version which also used the RH address.
>
> Odd, I thought it bounced for a while (maybe it has a new proud owner, wh=
o
> knows, haha).
>
> I changed Monday my mail filters to not catch to/bc to the RH address whe=
n also
> CCing a mailing list ... assuming everybody got annoyed of the bounces.
>
> I just reverted that change, so I'll just fish the mails out of the maili=
ng list
> folder and should also get replies to the other mails into my inbox.

Sorry about that. I updated all my old recipient lists now. I thought
I did that before but apparently only for Lorenzo :)

>
> --
> Cheers,
>
> David
