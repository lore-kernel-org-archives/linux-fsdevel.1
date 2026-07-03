Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC877233937
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047958; cv=pass; b=jIodZgUH/HDQwWTMXAjArvJdUHF28Z0kN1tzwniljA1ZIkU1Xrxb1jjyXq1S6losQ4enZfaaLlU/OZbHXb4f4ceOG5oTqYkm9bIWn+5YClYuNaVfdEO/s+vmb9Nu4Rfn5o4li4rxZu3q8qsaAGdsTFcC3U/SL3vH0mkgwG/w2vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047958; c=relaxed/simple;
	bh=L+H3GdulcKLSn6s39Xisy3yxUPpEpZqQt/6NPjm2hT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiUNjLkF+p8IjQtl5XWl7XVecbdv0d83Ke5PovXb7RybrHlitzJvrT7DFgzdxanXbSqY3rnmEGsP27HvjkPbJSEM7YLcKowpuKGYbXFDRJwIcVtpPaCRA9unfh/GcR9BR/thPAehoKEMPd/0/5/M2RFwXOlV3iAGgjO4QnuyLF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeDkho1p; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeDkho1p"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so367125e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 20:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783047956; cv=none;
        d=google.com; s=arc-20260327;
        b=IJ9KA54B6ExAR3hR5cerFGQg/DlVP3drOi3Jj1g48+qqOepGGw/IzOZtNUjWBqhDpa
         whi/IEm6ldESMWz+xln/u1OM2bspIL3kZN3GANo31RgS7i5QlMfj85ttgcKaN2a+2V6B
         weWoYsRxInO3/YYgiErMOgVvV9uS79tFA+U4J+geuB+ZIEKDajahPL+Avr6/vuQcDPoP
         HNN/DnrKh6/8/0eOx7C1O7WguxpT6QQfZWj7bNOb17LAR2Q7wv6y2G6RPDZk1cdhFDWE
         K48ldFMp+96HvHpnpnvDf5/QpDOiS26sovNzPlLEsanG6/zRCrGoVW6qb53y68tXLLQ/
         WTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L+H3GdulcKLSn6s39Xisy3yxUPpEpZqQt/6NPjm2hT4=;
        fh=TAtfCxP2SklztdMeiwB+AZM36Ir2Cxp4oWm2NtN7joE=;
        b=G8TReJ4jHG4dL/pfc8DCi6mt1S3yu+dlEPQnm8/hKXAt6xuxqRDL93SxxXWjUagTF4
         w38EZMRHWwMKJiyqt3uNSTChTNMotJM5tNmPM4FeRPgva9QUB7/I54pV8zqYtJ32/b7Y
         AFcE3GzJez6vlZtdM6uiurc8eRW/mZ8lH6vbSZl4qsr/UnaECCNhW/0hQXkrzJvV7aVG
         coXsbC8q1b/y5/EjP4fywHum7kMCWuNoeEewHMxnMtdNkECyi0J/uzYDpY98zwQJYeZt
         1vq7lnyZA1eM6yFXJQe9u19uWc7t2GEGAjX0evVUmuHj+BWSsRZBSHfjK7dyZ0OASdwm
         UsKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783047956; x=1783652756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+H3GdulcKLSn6s39Xisy3yxUPpEpZqQt/6NPjm2hT4=;
        b=EeDkho1p38ZO22WDSFypik9GdRJBnA+hMGgltuEEi7yE5dOIEj9CVMtTfHZXnCeeh5
         5S3nGoLhb/sTUnk5InAuevla/JvQUID/1utipgwbUYEX0iHlWRZtgVke6p//pqLHct1N
         BeLworJR14NmtSnzoMrQjZDD7QNBrCWnJVT9EsYFsyOVGXxL6760xBoOp/3PtYJgEYay
         4LkzdbbfFhtCIq5Zulul3GTsnoTlZijODF8NTQy0/q9919N14dHXs3fRvTY/yFx7LSIM
         jVYnCfrOrRnwp/WCXDXecj4nyLPui8a+HFQ2IDvL/fLLQiFRfbbB58e6wrwns24iukZH
         gg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783047956; x=1783652756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L+H3GdulcKLSn6s39Xisy3yxUPpEpZqQt/6NPjm2hT4=;
        b=BvcfU9Etr9/TWuMBPlJbNjUMK1zZrS8naUQRIQ1DsQfQBAvHMdVC8ZoLJsQvpZ6r+9
         SPqS9leEk9ql550IzNB+E8xJPz076dEAiycsvZ61obgCkLia4hxgpCr5mWsl0ASQ/eTM
         42qifHJtOPx+XdRtJeBKSYyzgHpiiIbohx8VcV35SUShH4vO9OI/1OCtZRIiOYNoytAa
         9WwZqHjysOWfRvIarYtvFmyzHU6nAvovb3BNQvhzozTFDnuo75k36b7bScyGXWS+rJ5L
         i+sHKRXdGqMpFpl9S13xm+2kgXZDXjn7DbfYWEX6Jccy/quXPnNzD+dj/CLWACKvT5ty
         qMrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jgJCvY51VYhmxTN9kWJAdJzVTXTnuXy5Y8K8AVn4BSN3V0ktHjwIqnpjePfbkXX/B4BmbzOQxtuHNWL+5@vger.kernel.org
X-Gm-Message-State: AOJu0YwuIW8AJ1Whowi07rnp4T03aqilR6EyEfhEiN1wAJpCYYk2GaJp
	pfMSWkNyXdkpJ9gSRJcY0t8l0NK5IRgkgavBMfzRUN4YLrUjHhjBT9xmvilnAMe4nuICXevMD58
	L+6FA4cXeyfZ21EP5FXwJWO2bmZuxvgs=
X-Gm-Gg: AfdE7cmUewStvIhtYqbVxzxbmGxnaeemKRD4TySlZyoiPJdDoqt2e/NX4BNfqsqIzSD
	JBxDreqNT4WnLp0K4DwnKzOKZ7SSedL8EFVglyoAX7y8XhBij/UjCgS0jrnZW89XpIxh3ZlkbFL
	01HnIKuoU8Qz8gEX+iM/PUaIQ+ZTY5qOxddRLZG7iEew+Yul1wJNc8Km+Kq0/vlPYhYZVwcDWuC
	k0+lBzP9O8n+QmiJ+FK12ZJ9cgZHQMLP1/+7M0P7vtluD/jx0pabKIKDOhmDVnU4f1HAVt8C7nn
	9d7S1QSqXoB/LFwUem49pIHTApkuJa71pQJr2D+JZ06SShMtUzlr
X-Received: by 2002:a05:600d:840c:10b0:493:b9cd:1272 with SMTP id
 5b1f17b1804b1-493c3cf2f50mr85170315e9.23.1783047955834; Thu, 02 Jul 2026
 20:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701033253.46420-1-changfengnan@bytedance.com>
 <20260701033253.46420-4-changfengnan@bytedance.com> <akT4tJzFSfrBxqdq@infradead.org>
 <CAJnrk1Y3yPeXBeBNo+DjTt8eRN-mc2F9apBCUn+j=GV7GMzi4g@mail.gmail.com> <akZ3GErzJSTtOn-H@infradead.org>
In-Reply-To: <akZ3GErzJSTtOn-H@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jul 2026 20:05:42 -0700
X-Gm-Features: AVVi8CfZKbXMpL8snbpx3vl7cTayO8vf5li7UT5PBriPQUNElwm8EQYO8_inLP4
Message-ID: <CAJnrk1ZijiWYU8YOmRf24xxwX0kH6vCe3ta89LfoX7v7j_JYLQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] iomap: add simple dio path for small direct I/O
To: Christoph Hellwig <hch@infradead.org>
Cc: Fengnan Chang <changfengnan@bytedance.com>, brauner@kernel.org, djwong@kernel.org, 
	ojaswin@linux.ibm.com, dgc@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lidiangang@bytedance.com, 
	pankaj.raghav@linux.dev, Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 7:35=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Wed, Jul 01, 2026 at 12:35:24PM -0700, Joanne Koong wrote:
> > I think it ends up being pretty simple to get it integrated since
> > ->iomap_next already contains the logic to only begin the mapping at
> > the start and only finish the mapping when the iter has been fully
> > consumed, eg
>
> I wonder if this adds overhead that the simple path removed.

Ah I see now, the whole point of Fengnan's series is to k eep the
logic minimal...

Fengnan, I think you had mentioned earlier [1] that enabling
iomap_next brought the simple-read gain down from 10% to 7%? Thanks
for running those numbers. Would you be able to share the changes you
made to iomap_dio_rw to support iomap_next for those benchmarks you
ran?

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/e85e73bd-5fbe-4d11-89ba-7b42c237d=
d34@bytedance.com/
