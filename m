Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B15313523
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750063; cv=pass; b=VPgIkLvno+BUeDLOeFiptXKc7q619EZoMiVw1HECU0qcSJ4PFzZM7rJOMdBYZ0Hp8hoSZlm9uRKtISAgbh/edQaE0mPcSGZV3MSv9xZ1lahis2wZKM8I9gtlDP0/zEt7fIJ3Zu/Dd6izvp61FpQ/2DN5C4K6J4nzdzXfxZ76TWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750063; c=relaxed/simple;
	bh=CAeErOi2nYK9CzTITazgzHeJp0FOe9nj+LuvP7Z4L+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+co3ckbWNLHtTY/7JPyJ5aTehuxBwgE3k4qBlTP63vzf4rem+6lgpB/rfNFEsujCo96/OwtbNFtTj0HswTLhfALkEgVH4d6A8q0i4VYbA1W5TSnF3fa28/gZm3lLF8iyKZax9f0LcZ38NsDfW2q0btA4t5PrEBXcxkhwhGSoBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grsn0Hvo; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grsn0Hvo"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38ddd8d3b7fso8000831fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 08:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775750061; cv=none;
        d=google.com; s=arc-20240605;
        b=D4aBODDEMHMW8O0WGN0IFPH0GKHOn2slYHZBi1VVkx04VElEihWxoPQyOqxM7LBkuw
         3+Si0L37Nuvsl+/d7rxgzHY0KxHyvD3NzKmePkfotKExWFu5KepQM2yr+QxibvfhpAmK
         ExpzLC3WU8og1IcI0uEc5jhy2Im2m6BgtKm21O/QyEBkZOqcGde20xAApIGTNWLsnRK9
         6UdTx9wPryEjYYPImp+oVvtZBsLFWp9082UNcsQC1MDvllLPlD7Q6KXo0396ziia+2DO
         73RVgTMYiErYqd9zIDQUAYiMfOOaPKP+kb7LKhF2ZeeFowS9Yg0pA69NalRwUz+1bgVH
         a6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CAeErOi2nYK9CzTITazgzHeJp0FOe9nj+LuvP7Z4L+A=;
        fh=oiCuuyCd6bqZ6FJreNA9pXRupgeD9O/AksbKo+DmpCg=;
        b=IcEqMqvRh/Bm3Fa+ONVdseDI54l5CtABdfR20fdQhLLr2jSlfxadfqM7KaJa/9dbHL
         lOTVINjmDwKyNBZY1YyLIvgc5z4Qa/q8ePNcfzyvIZybLaOEscfvcqAS3jgdReqlvbgR
         pwF35h+wzbUEhSygBtHkcjK1azTN9qMTPnYkvLGXgeW863fQXRdeXOF6/GEfHdMEy8qN
         kqJTvOQl0L3EBaUy5CwNK/ow8jS+pqsH+TxbhMHN5gQMwXNqI3Zcbs/kdSufMwev0yag
         6L/DuXpO9MSr6KucJuwPwv6p/0sPWh1wzeRHSA1MIyDOIn0c9CWbUx4baiaZ+iWzputM
         nyUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775750061; x=1776354861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAeErOi2nYK9CzTITazgzHeJp0FOe9nj+LuvP7Z4L+A=;
        b=grsn0HvoKVafwdqNmokZrVYSeM9BDB+NGMGAIUczwtmPzKOVBleTLYag9hLgsFJyuZ
         JN8BakMGLvNl6wE3mEVKLpS7W+Fa07r3q/9fXZI7koUx8Ba5+bFtKCmqcKRGy3siJkyu
         ZEWO4A+qL4aitpJzdHUttwGhM7P32m0jy7kX+2Y+KX0UxJYBXF9U3aChoa3RP+lGSrXW
         PliCK5z7vCbQGMfFueWiYHbhf4xoC0uDHCZQmHbx2JToV2kPcMwdgD3/C990HeqKTLEB
         rziaAc27JXs5MEuSyrtBg2UwFYpfnbKK8oOMzkOdnFO0XBlxKI2CpxZS8OlKM6F/hE1U
         actQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775750061; x=1776354861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CAeErOi2nYK9CzTITazgzHeJp0FOe9nj+LuvP7Z4L+A=;
        b=WNgIlxtl0euEJH7cN4oSTD9Li6/Gu1Fu6lJFFfIG4aE6KRtxqnAfjYf+JadCr+hvrJ
         iEO5Dn1/4m8LiNymQglA29aA3wXOgcfdDj5uZJtUjlZsSepbzKmuaRROGRVK6eDtopBd
         NYY4flrE147nb8bMmr8mUkwSV8xRYZBYYomB3Lc97M5aBJWJ4JkWtuqO9s+dAtLSvdgA
         +Q9d/cOmVz9MpXygnmjoFR1u72CtxUx6Oca+Hdk+erNNWmkpKBRDrVVyJ3+oI3n+1nZH
         /BoLDDxeLYAp9pbauWMoXmTizwE5mJMmfwk9B4SY/2olXnB0A0kCBixsZQQG4Tt1qppl
         O11w==
X-Forwarded-Encrypted: i=1; AJvYcCWkuYok2LY995BjmyDhWdTJERA8yXS976wFxLB5vgEkXEuQ3dmQej46OBid3EamnSh71Nt9Id/yx2wnUtk4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyye49Ffk0hLKE5nLpYltB749ccf6ALRZP5NqSP7H5n1178MnYT
	EUZB+75tA3XRmfOmy2ZLUucpmrr63EaapHY/tp5WYPqM/w8G2CKFiit0brrcRJXqUwSXZuGVTEY
	RxcuhTNPLZGF7giJTlM4bDK0lgm0Bcgw=
X-Gm-Gg: AeBDies2xOrSpflXzErv0i4700U2utzAC0cZmdX4CXQUbAjQxMs3GZVod/vkubGTTBF
	Q93AU99fWSYkzY4Z6iLC7/WHtGRmIj0Jg8GAs3emTjqsCPdI0QUiVz4WV+dQclpZBA6SLtufRUu
	k79bm+zp0U4EMz7IPGVpVTGGEcFAlIFGSVMH8u+XciOTdFfykJjW74pD/3WYZOYTBd/i40OS+2y
	5GVQ7pzd3gV8NuVs7D1Sxa7ATlUfZLsi7g/LxEROmRYtatGB33eWjfbDUnXmbyXesn5Mgs/O+vn
	fICAvY0=
X-Received: by 2002:a05:6512:b9c:b0:5a2:c0f1:f729 with SMTP id
 2adb3069b0e04-5a337566f19mr7506790e87.16.1775750060342; Thu, 09 Apr 2026
 08:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409103345.15044-1-komlomal@gmail.com> <d4xigmgectqbv5q5dxsrlunea3ynexa4ym4nuxy2rokrawsqu6@yfhzm3hl5nya>
 <adfDCpTH9n2lG63n@kernel.org>
In-Reply-To: <adfDCpTH9n2lG63n@kernel.org>
From: "Denis M. Karpov" <komlomal@gmail.com>
Date: Thu, 9 Apr 2026 18:54:08 +0300
X-Gm-Features: AQROBzBmxDixh3DrVoiXKIPzHCcdgrsRneVlA9XfDga7WmsEQ-NmJ1QJsl6YSiA
Message-ID: <CADtiZd0NF8=4YDs9YR6vKYK92SKYOFd0LR1R3w9ZNoZW4cy+jg@mail.gmail.com>
Subject: Re: [PATCH v2] userfaultfd: allow registration of ranges below mmap_min_addr
To: Mike Rapoport <rppt@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, harry@kernel.org, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, ljs@kernel.org, vbabka@kernel.org, jannh@google.com, 
	peterx@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, usama.arif@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 6:17=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
> On Thu, Apr 09, 2026 at 01:30:07PM +0100, Pedro Falcato wrote:
> > This looks relatively safe. However, I'm not sure if we want this in st=
able.
> > This has been broken for 11 years now, with no complaints.
>
> I believe Denis has a new usecase that wasn't there for those 11 years :)
>
> Denis, can you share more details about your usecase for us to better
> understand importance of backporting this to stable?
Hello Mike.
Actually, there is nothing new about the use case. We simply started using
UFFD instead of the classic mprotect approach in the binary translator to
track application writes. During development, we encountered this bug.
The translator cannot control where the translated application chooses
to map its
memory and if the app requires a low-address area, UFFD fails, whereas
mprotect would work just fine. I believe this is a genuine logic bug rather=
 than
an improvement, and I would appreciate including the fix in stable.
