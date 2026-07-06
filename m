Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D293BF679
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371606; cv=pass; b=TVYfits/KQhmsdT/+sctr5iBkmOW3Jz3w4d4vc79fcyey739qJ1gOhKy/s1PbWyst/KA+LX0dMwUpSN2D1s+RkgZl1c4c25VSr6NUKuQBJK733TABkECB8Lc+7KVqTd0T6t2q2L83YterU0eypQt3cifX4sQJkSMhGRV407uCk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371606; c=relaxed/simple;
	bh=XjLzI90BUr/vpbSzybl4eyfCI8tSGjIAmOs8CnRc3QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCEvxSJ6+s0Dsbf1FNOAPc+xeHYxwJ+R9OIVoVS5MqfxJoFwjI556rvHdxDEUHweliHsN7Z/RqPrmr43DnMVy/Jrc1tHifIVXP3PLz4BaThnVE09vthakB9e6w0/TsPKvUOaD1gK1EHqe7cK+7UUWPHkhwbk7AHSBLjoqMC2a5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=anZpke75; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="anZpke75"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so437a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 14:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783371602; cv=none;
        d=google.com; s=arc-20260327;
        b=IkH9rIAUq88vOkqnxqjFOAo/vnXw9xcvtTPfbZNVFAg7NKATRrBYy/0AQOnMywxVUN
         L6HiagwFeLQaNL4q99ZDyXWP5f7+jR0QmejZbK/wKYKRkZA8p8be13QyZ4Kvu8IxdwLb
         cC/itj5jUTGxKomQnbpvKaQks0LBzURAAgx9Kno+xzgB2RRBd5zGS5d9SCg9NyQjk1st
         wSBBklTLboxQqxC01dnuxD2yC676qH/9M7mAaLAW3vfTJC6VszGIzmBl6LAfF+2uxuyD
         BRfi/esfRPx8Gs8W//45taKITXYWk/E+QiYZ8h8RV11UfCR/5jdQOzNyAtvebUmxVHfp
         vcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XjLzI90BUr/vpbSzybl4eyfCI8tSGjIAmOs8CnRc3QI=;
        fh=OFMzrAd/trvf7lz4tjZLoA9N0CfzU3TITJbCx9+wr3Q=;
        b=ECHngM8fEZmdQv4HmoFD2mviRLlmE4vXHbL9CYtsOna/9ptSbcUibvSMv6FNsWfaIh
         /XonApLSRbscUcjGYM5IO7x7ZXWrD1ySSQ4IN9xfTp++f7mayQ78uDSS1dl/33WFvP5P
         Fdn3ZQQ6sdijAyfbTtWg2b0EEk3mV0ljIZFHKcPLoFKrQKyL2YMS9ygMG5o8E/4p+wWB
         WciiwI3dExUsXnEi6YUD9KYcZR7b2YL0rZgNMTTMEwjeexXYWXr8HCKDkXknqx8Mc4vW
         1y69auiR3XsJrVcA2rVqAcSoUDFDiDCr5id4aQPupN53iw2xzBUmWSr4scVTwHFkrg5G
         VTvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783371602; x=1783976402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XjLzI90BUr/vpbSzybl4eyfCI8tSGjIAmOs8CnRc3QI=;
        b=anZpke75kv9BWt1YU8O7S8ovnSnXmBjclhVmAcLDn3pkRVT67BpK8azd+F7i9+Zde1
         4fcW7U1/+veKA2j14mfugmmU9V7KKYHsWZc2BqDhgeggNTyWN+N+/ITzaZ8o85LmkwOR
         F6piN7L3XWuJBgt0NCwEx9xi7jr88Q8w5vwJR/LGd66RAXCZnXH5Z9rqTJWbcEK01lti
         b0RuOdAWRDgqxmLN+7jPsGBpwdapG59FavlDTNJjUsT65UfOpxPVYlh6qZxnoDC4QF+n
         iC8EgWfNo/zw7QWRaNQ92W2t9X2W6M4nqY9SZf/xVekqDSyAR5EyRiFR0cm1dPcNGa8u
         xIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371602; x=1783976402;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XjLzI90BUr/vpbSzybl4eyfCI8tSGjIAmOs8CnRc3QI=;
        b=m0lU8JsTfDPfM8N2JT+A06hfKzsXbsfxo9+wEEqBRXGkRw3e4TmfOYKc3ibghQloGc
         ZkEHVBExrv6jY6uS30U14LiOd9EbHbiIgJQzYscuW2Ri51JoS6tPH8iEBHnH4sUe6zXO
         jbB+y5hTSyy680Q6cKdRR6uk8kN5Pr5mZpjMfJ+CXsjEUJaoj2hsPhna3cAj5xElfDXh
         O+IOeCDzScEBYun4ynFm2bseKG8v/0DYh/APOEOG3HsJ4yVywnLLSvFSSCQvoCGEbWRh
         nLjm7xfprYBN2mLSguQozMTPOwZwCjV558FyhLOXMlpqOynXlrMgSgxhq0g2UJNlmuw/
         6C3w==
X-Forwarded-Encrypted: i=1; AHgh+RrD757R7Ozz6Cl8wzJMY7OkIGYRE9wx9/JiqmcnevWr0KYXzzkRaR3/xRA2PTEG59YRfLGEvKucB1WwbEiL@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTFAgkiWZQV2snMu+mA8nwP2iNd3Hv0eiqdG434Yk7zrdGURG
	sScUoXxc0XWu+q1JMVKvsu17zGkCHE7yV64+NrWgSRa3zbeAMaElx/et9bCGbU8TGofcsQVpP7V
	+gR9HgYnKqlowmlpc3kAZ+ygewSUbl/aGpCYLsw8a
X-Gm-Gg: AfdE7clLwFE6oWAQBi/YxIVsjIsngWK6JutADHEF/w431N6cBCvTCY+DfqhL2s3yTiF
	zfOtPvt6aPkCSUSifxQsFw7d7pFAHan4Ffxwzi3M36gDnYcuO2ueDGDxPchgVm89ZqSE2psutgH
	B9dyTTGBZV2z9solgK83lgjKRDPJ+pZ2pIYibMQdWuWIjbc+viRS8ibPCYwFREQEKmVcjRNHyXe
	2atjYzhhtzAxB3Um3NEx0Azo3it8fDGm4GpZ3fw0TQ3PjYRUjTuyfosLezmY142CX5uIl0Ia56K
	qh/ATegbWsOCsF1dqZXfQO68NUlJJhtQ6ZEuhAtzQz1wfwxJJ2EhSLNhYQ==
X-Received: by 2002:a05:6402:a581:10b0:695:4751:c044 with SMTP id
 4fb4d7f45d1cf-69a90c6186cmr3802a12.8.1783371601820; Mon, 06 Jul 2026 14:00:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com> <ua3v3vjbbyzae5twf2oywqysfwnojqy4fmhzfucqwahy75pgb7@bwq7sdgwyft5>
In-Reply-To: <ua3v3vjbbyzae5twf2oywqysfwnojqy4fmhzfucqwahy75pgb7@bwq7sdgwyft5>
From: Jann Horn <jannh@google.com>
Date: Mon, 6 Jul 2026 22:59:24 +0200
X-Gm-Features: AVVi8Ce7wKbDwrqIn-Ojy2Nx2LKJoP2IqoCHaxHLVTCiHU_aETZ8yxpu-NaWsuI
Message-ID: <CAG48ez1+unKRQQB1r_xwDpq6V62+0V+GZqbUTAUhcY0Nw+06Xw@mail.gmail.com>
Subject: Re: [PATCH] proc: Fix broken error paths for namespace links
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Magnus Lindholm <linmag7@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:56=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> On Mon, Jul 06, 2026 at 08:22:42PM +0200, Jann Horn wrote:
> > Don't return the return value of down_read_killable() (0) when a ptrace
> > access check fails, return -EACCES as intended.
> >
>
> This is the kind of a bug LLMs can find very reliably.
>
> In fact Sashiko did report it, along with something extra to take a look
> at:
>
> https://sashiko.dev/#/patchset/20260518-procfs-lockfix-part1-v1-0-5c3d20e=
0ac33%40google.com

(that is an older version of the series, there was already a fixup
https://lore.kernel.org/all/20260604155806.1402880-1-jannh@google.com/)
