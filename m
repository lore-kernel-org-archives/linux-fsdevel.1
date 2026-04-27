Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A313054EB
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289500; cv=pass; b=FXG6WliO2dBI74sj/HFGI4njvNlhd+YQEwW4vrqQf8sS5HKN5qmTkUWAAAgN3N7etQ7EohL2KtIrbFFFhDQYVDOCwJrdVVweGXsIXU4Lru/i8ZfvhRg/R7CPbPQhtUT43K4m/Xd3rpMCH9vm4H8YmU1hptoAh6RmUqEV4ZSdSGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289500; c=relaxed/simple;
	bh=pqZSTIBtVaiqlDTi8evY4BHveXRMVmcBtBJmpRyhw1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLv5gNA5dwUmf6LS2QZi4uC33Ra520FeavwN+IwXF1IB/5fxxPmrFtJN0m+cIdGbV/XRKhFL+6NOFK1dSQrp6STqiwgNqbaFF4NpvHZvO9n3vWtuolS8GJ/KBe1p1enx+h/vWBlq1kBOpk4UsyK6AAzuW+p42pDrqxgtfnQU43Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf+lfPYH; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf+lfPYH"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d77f6092eso7053244f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 04:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777289497; cv=none;
        d=google.com; s=arc-20240605;
        b=DPWKHFGschoAFiE3PusffCccUs7dieFYs5MvRBHdEpw57CtYbfN/vTI5wCaTVn8Iae
         M9cL0F4eeObrO7uZug6qUKWw+GKg7pcfEhj/tGyALY04k0WWogs6XXg7YPOcIMi1TmxA
         RRaEni2PZa1ZG14mF1VDtY3XzqcfPnNILwq9wmATm8vrEh5GqzBbzUovaLy1ZwArNfwe
         VPf2fhN+qIMoOa9G32dhWCnBZEQV/cSr8f3e4JL5cZv38r8C8PzrmoLMpTuUbnRBQm+P
         yGAWQ4TPDAkI4M3St5D08PYiotrauhKsgg4ixPClnUTrYXiiUi/ZMW3jev8DbWPc+4Dk
         v/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pqZSTIBtVaiqlDTi8evY4BHveXRMVmcBtBJmpRyhw1Q=;
        fh=trxMExRoltZqSfDiJKxUG7cKnCdd2ehuKu0O38u7vks=;
        b=eSduSqJ6K33Z/2eZQM/yKN10bBqgOlkrJZX4ieRwWcj1gSffqkHR4m5nRkJGu7KaRl
         eg6+k2nFq7f3GL77Djc566lljXjdxIlZ1nEEPwPWe8IPp1Hqf9qLviZBN22I3mcirapL
         Ag+9pHwPTJFqac/oeVAhmj2NZJ9tbig3/3FzvBVVfJDEAZNIE+QeypKRi2qP3xHNXKWc
         eq7GG7o7th+KSVEiRpCjEB1zPybayr1iokW0dTx052d2I+ANBtxN1g6HFGVqQH4WKdlq
         B7lOh2YWhU8tVrKiz55n1iYec3FRGe78/tLy2sdwM1sH4a0NfQdg8eYAS67GFgyohjqF
         iwOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777289497; x=1777894297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqZSTIBtVaiqlDTi8evY4BHveXRMVmcBtBJmpRyhw1Q=;
        b=Sf+lfPYH0pPDk8TeTPKYyKCye7zSeIhLPrIlC5R+btAh4E40B/DKQqORvTLGq2HZNA
         LWBEGWnReiEIMD9wsTCMz6Jw2XhPMgYqA8ClmemiB69/HANCEB1OsVMz9NylygNyEQW6
         qmX5AAfcmfhIZgUNqbhVcKDi7EjYlXPJKjtuL5lMIYhxOHwpAilSA3lObD8FZJt9BIn/
         LkAg0LAk3mf9dM3oMqyyPrLO9bkXL7wYDGaPyaDoX5N0OI2isMMWeB5DW5A+DOn+n+ld
         RocygRUlj8THnLL/DRGev0p/6eA4UypivBo/z14NpZFI/O4bgX+sTblPgCyqaITqzDec
         zSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777289497; x=1777894297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pqZSTIBtVaiqlDTi8evY4BHveXRMVmcBtBJmpRyhw1Q=;
        b=D9C2adCe84XaYQjF7NpXUQsSOVgQYiFxmL5VMNW/Nka4dlMYNNzvyR2Lbmm3j1h7ui
         eDtokHWI9LlIPQg6QcMFTwVNPk+i9rjoi2q1e2G8P2mjeB4EzAsIUVn41jsLuKsQKPZp
         kg/SqSVik6Rwn65A9GJx+aqOf5tMlfriscnxRJ7tTKOTL3uYmIb88EU056DBfvtEsReP
         NuwRZ4KZ2rols+2vIf7cPKOW4v6BVJVAPUqCTMzPGy0cnzjJEoGmuVG7TCGDqksh1q04
         VhduTTiW+kVkXC6wbg6C1mBofdcbm5mmckfM99KEUJ/K12wJpsofM/naucpVNPDTEySt
         J58A==
X-Forwarded-Encrypted: i=1; AFNElJ8fFC1XlX3fmw9+sCP+E1zb8EokLJn69DQJNNtmVsPCqbigm5SN6fgtMXz0/qL45KujGLMmhZdk04e9B6eQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwucSYzuZ+xQdPs5BeDQvNLb9Xilu1Gv5ihHC/pXciRzJuOEWdS
	ucnVy4u0A7+JyQNmXbFvRqeQtr3f4Y9vU+BDZopWXAfPbULhmOg+XDk+Yin0kOl0rrquOB2zzrU
	yGYwE1bDGTWOZ27wzx0xLfWHNRye/V2gCTe3w46F6Sw==
X-Gm-Gg: AeBDiesfL/z1qyqEjpKfF78JyIalqWKqQOAYt6z/zFlNJzaxkYwZ5IdfOSZigNgkAfb
	QJxWsb2IvGbxgf5E9b4kKcXreG16VwcOwTzYL+xVo35uohob7HMKtyqP9KJPKI8hGFCyTpfaHeA
	E2txef/IF9kek6LLpMQbB6UyhmJXg/W4BJH4PJMxgTJDSyE8yWnU6HR7QPRQabMrAB/iaLzdbad
	DOj+kABKXaWvCy1USdCiHZWmFphT8y+rfrJnRovysr/gt/5+d7yP+E4VcYubRWa60sz0LydD0DG
	jUKvB4r/i5R/jpRATrgnNSMXsd0EhF1AcA==
X-Received: by 2002:a05:6000:40dc:b0:43d:7b7b:ab77 with SMTP id
 ffacd0b85a97d-43fe3dcbbeamr62105257f8f.11.1777289497130; Mon, 27 Apr 2026
 04:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403035752.20206-1-liwang@kylinos.cn> <20260423110954.2676-1-liwang@kylinos.cn>
 <CAJnrk1Zb=+syR_aOLVs4aXMTOUO7BRBi=MU-20xQOcDpf2iQ5g@mail.gmail.com>
 <1a25fd7d-f122-42b0-91e2-487235263af5@bsbernd.com> <25e00efd-c0ef-446e-a246-6eebd7a68c9d@kylinos.cn>
In-Reply-To: <25e00efd-c0ef-446e-a246-6eebd7a68c9d@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Apr 2026 12:31:23 +0100
X-Gm-Features: AVHnY4IK9HKRRHKJtVDrDvM515G186X8IuI74vIgHFkXWMOsK9Hjm-mK_8n-8Xo
Message-ID: <CAJnrk1ZyucU4LMn6UFDAJpmpUJzhzroLTvJnA-hL5SHR5zedMw@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: optional FORGET delivery over io_uring
To: Li Wang <liwang@kylinos.cn>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:56=E2=80=AFAM Li Wang <liwang@kylinos.cn> wrote:
>
> Hi Bernd and Joanne,
>
> On 26/04/2026 23:48, Bernd Schubert wrote:
> >
> Furthermore, in the current implementation, forget and I/O requests are
> dispatched through different paths and handled by different sets of threa=
ds.
> This means we cannot guarantee their original priority order upon recepti=
on,

I don't think ordering matters. forgets are inherently asynchronous
and there's no correctness dependency on a forget arriving before or
after a read/write request. In the /dev/fuse path ordering isn't
preserved either (eg the order they're queued by the kernel is not the
order they're delivered to userspace).

Thanks,
Joanne
