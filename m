Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6A53FD21
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059754; cv=pass; b=bKNyPIXfwvU/vwI6oNL8Nid/m0pdlOfQdL8PksOweQXvMoYgY4b+gItU3YeuZwnIuCbFkw6DiHLPUJv5pgEi0cL0hqFNazu6mNsj1ynHiLG1joxpEGin5cNNgp7w0WD8C7YNHThbhffyRMNXJCy+2JA1zWY9ctVuZEUUCzhrxfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059754; c=relaxed/simple;
	bh=P+DLIY6UxOqANj9LNama4Ax3pwH1auByUeIWevB5eqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dA1mMVSOrkp2TLBb2m8ALUg9qLsY9Jfo/Z2FExdhHDSHO+N9t9DijvJkEiAKXoih1ZVRD0Fhlm8spEaLU5nyoE/F8zFaypvIFRHpAta0c1TPgsOJajoF9Z0V2a8NcaE060Sib/TFWjFblJqvV66kPh3GiBrERsK79/d/llwUZig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRYVyIwA; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRYVyIwA"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso358801cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 10:02:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789059733; cv=none;
        d=google.com; s=arc-20260327;
        b=KuAu9Ou6KM5S9++tYx6sa72KNWfn/i1B+Uubm/a1njIZFyTDovyYi0qJP+LYu3gU1w
         3BHHwaDf2PvfVkf286gVHxv/wNlenBsRfrvVObvX7GbNn9Pja8esJO1htRW2LFcvVZTo
         4xoqApntElodjKWpesqbGYyQH6z2BYrkmuUiw7o3LUTKrJhV5ztG7G4S34wZubz55hyi
         rDRw1v46zqHepnvVDk2VeQwUHI9aT/arBurcIbB9paa1Wjk1fhOlK7ijUKicCeXoHBZo
         YsHPLJcSnGEltUQbTjvnOGGJyg/ntV0XxdjmJypNemRonUe8n+zIepOPwNUHXkSOGUIR
         JawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P+DLIY6UxOqANj9LNama4Ax3pwH1auByUeIWevB5eqk=;
        fh=Gu5Mia4nS5Vcjkjrneo7hSVQgJiZT+crns4OoFO8KDc=;
        b=p1quU4oVaYmmMnJCo6F7hqAq5pZukVfg8y49LyW3j2iW6LsVBQdruYnnEtxdmSigQB
         BdgOK+f1je+dnXfvIa3W+DTGmrpR791Wrc287DDrSUHTx7I2tNlKiXSi6T0fk0+Uz1zJ
         kyQ6GqsQcy5j11L2wlx1taVe6cCxJsQYRzCCNnFPrswL4rqvaX6jANbdFHSQciyXQfgD
         bMRuMfKaeG/pTjlo3kHTVIzYLh2PzaLPU7UoeZO0JHwNYYFLRh4EjhsFd6k12cuV8sUl
         YJUulFe4TR561nyFpIeoZYkgfa7NqhZN3drXErTPLYEm/T2fvet6zInoSE7jQTJYCU0p
         Cvxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789059733; x=1789664533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P+DLIY6UxOqANj9LNama4Ax3pwH1auByUeIWevB5eqk=;
        b=dRYVyIwAVyu339djamiEiFX4SAIXxUXgS0xgDqPFc9GDmLwPm2fdxSsw5yF2LmTSfi
         +w7kQDvYxPrZLK/kJZ2ViksLmSK5vXi6f/SZTX+u/SZuOru6XbR9puXrIC1vLL3W9wAb
         BbtBvy+rC0pdB0R5mRELbzL5BAriG9Z0nmuIPpkAsqbtmZlB2nkoPvXqgvO86lAtBQCl
         HKQ7ZSi0tW/HgKzUTEm6cvevMfp6nsXggQaYaisjKqPA7FCo9QWKupc96/KLb128NvRd
         BirQbKKuVgi7a9lBmnrVjBTb0KHfWiaJO6ZHRqjUDO++nAyNmR+/DMslHsyCMd1nRRTp
         K+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789059733; x=1789664533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+DLIY6UxOqANj9LNama4Ax3pwH1auByUeIWevB5eqk=;
        b=X8mnNqIQuYheZNMpM49SqLtfedl/Pueg/1m1nkxDfKNXLGmfzchwnM2PDu3JQyWbjg
         m7ejE6QcRcZrcYp8XK6LoBQn+BfPK9EJXsxi8d3ZRU2iuctqXN4TS0bUKilKFfe7dvNq
         mbtPgnkAKWzD8KQf+xoESneAzwNLdvXPQ6nNAtk6aK+4fj04G6PTLLD4Wc0Aasjq/shI
         5BoRHVKE9zY7ykTZ7/DIarBcVwFwLYsx1JRX2V4IaaGj2pHFqSlUJE33BkkHcIEd7i1V
         fIl8tKsQcokk7w9F5k5nhpnrSk3pWWAgy1Ut+DJHF9a+dWV7lT3YEGT+msHctV3aTrsc
         o8Kw==
X-Forwarded-Encrypted: i=1; AKwUvByQNtgCix4+nIEP8fe+t3ggu3pyh/iSwbntuF/eGueLEv2iaFr+/EHkfLuyDhR76oHRaoq+m+L8svsOWk6M@vger.kernel.org
X-Gm-Message-State: AFuF++kzyGvx9jM6NoOejvXyHIMDoyS5Ut9grOF2XyyPAA5ATWkObvEh
	g5tXRsqC86rW5rFnYbme37alLzUm/EpVMQVKUAkjUpUayB5H+L7AbI2FUD9xUuL0U5PPZtU5xZP
	mMybXs7UydAFuoiu2ezSt71i6mf81fJM6VNnjPd+o
X-Gm-Gg: AYBFou1fExahGhLaVHaCopciU0PuXKo0GIQ8rcdoxQfC9MEb8Z14OcIz3baYW4GP7af
	cTr1PDnxy7HjYiSg8HlF1ORVT93GP+Dc8u01CQ8STYUwZb2XL1Irzg2ph7fQr1aVLydEyy1YwTP
	hiP8Qp9l0sIjWp7lZdqZdk5/7SA6bjUc2/Trjv9dhCTmMxfE4rnlzYvm0ojwVA263QX7KWDVXhv
	Mm7dpeyw1BX7a2MzVqv3WZoaVUURNnZCDuHZ48HTixmmOB+UZDydL8k1QoTrUp+xA9uVS+F8tkK
	bxCqEm7+Si6Y9YPOHVF2fFoAaPrY8rpcMyMwxl0lKlY+LTmrWA5TnDiHBA4sWI/NI7E8MbocsYO
	RYascgPBzoQ==
X-Received: by 2002:ac8:5750:0:b0:52b:806e:2633 with SMTP id
 d75a77b69052e-530b601f181mr19081821cf.1.1789059732422; Thu, 10 Sep 2026
 10:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260907063918.3432401-4-surenb@google.com>
 <4825a2fe-f064-45d7-a7c9-e98de7efe86c@kernel.org> <CAJuCfpFL_g7tELjT8p8ExM3tX_v2gNDM9rRKwwefPV_KW=fHfA@mail.gmail.com>
 <8e643f51-a47f-428e-9443-678326288fa6@kernel.org> <CAJuCfpEYdj=u0wczKRrsB8uDkbSzPy+hrsCo9TW9-3J3r3p0xQ@mail.gmail.com>
 <2336140f-c993-467a-b2eb-e99dc9427a59@kernel.org> <CAJuCfpEL40p+vk6-km6_BBuE3+YY0WqkpbvQnQGFEo_73MAomQ@mail.gmail.com>
 <9e48cf7b-1700-4a85-af83-8883789ba87b@kernel.org> <CAJuCfpE9_1VYqHp6bctUEihSW35TaTw_LZuOGP2UAnF7SA_UAw@mail.gmail.com>
 <CAJuCfpGvi10sibu_=cE76h2O14WA4KNOd1vARu0r1CYmAiCMEA@mail.gmail.com> <dd134a0a-8fe8-4990-85f2-7b524754b451@kernel.org>
In-Reply-To: <dd134a0a-8fe8-4990-85f2-7b524754b451@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 10 Sep 2026 10:02:00 -0700
X-Gm-Features: AcwNN1XzTzo0tLArJpTqgDsm55TNkm9hrEOzHQgtAQph4QFYlsjRry6cHR3SJSA
Message-ID: <CAJuCfpEN-CWLh__rpzOHaSOpb24ikR5_y=yC_Aqyo3BScq=_RA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 9:33=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/10/26 18:21, Suren Baghdasaryan wrote:
> > On Thu, Sep 10, 2026 at 9:09=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> On Thu, Sep 10, 2026 at 9:01=E2=80=AFAM David Hildenbrand (Arm)
> >> <david@kernel.org> wrote:
> >>>
> >>>
> >>> I meant as part of this series of course.
> >>
> >> I understand but this particular patch cleans up smap_gather_stats()
> >> function, so if would be weird if I move the comment change in that
> >> function into some other patch. Unless I completely misunderstood your
> >> suggestion... Maybe you are suggesting to split this condition and
> >> comment change into a separate patch and making this one a pure
> >> special-casing elimination?
> >
> > Ok, after re-reading I think that's what you meant. My first
> > impression was that you wanted this part to be in one of the previous
> > cleanup patches. I'll split this into a separate cleanup patch.
>
> Just to clarify: I'd put all COW mapping changes (using the cow_mapping h=
elper
> and rewriting the comment) in one cleanup patch that can argue why it is =
a
> correct cleanup and doesn't introduce a functional change.

Got it. Working on it.

>
> --
> Cheers,
>
> David
