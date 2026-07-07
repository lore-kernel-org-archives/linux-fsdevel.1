Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9F22A1D4
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443281; cv=none; b=ZwTyx23GEi4GZpXfhue5v9psTyIujXHvrGheG3FNpoRHGGYdh9DarNLdSLloD0rkL2bQ0Dfa+yMdrMNnITgWXb6V8HgvTMG5XkQewgXmNcX99/h7+JJ5/ECPGQhdPdvazz2T8GvMzJg6mUrTELnppvcwxdcDSH/AdVByZx1511A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443281; c=relaxed/simple;
	bh=Omuhh4w/zf0SDooRU/V40J3YBdkMf6Hj+qafJjaEjQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksQr6ZnoGmQT5TfsOA6VkIFOsIO9TLDtig/ot7/UUsCMGWrIASFGEw6Mdjoq0BKVNG7CgOe35uNwkKnr7TYeyHhNM2UhflSppEY8UIC9TM0oVAJHTXPAWKjIIiGza171Jp9y38wzG268zE+mWY84b8Oeo0ifrI4pSoxEcYwml3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCmxXxDo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCmxXxDo"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37e0a189b0bso3324097a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443280; x=1784048080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Omuhh4w/zf0SDooRU/V40J3YBdkMf6Hj+qafJjaEjQA=;
        b=DCmxXxDoXiTPGO9W16Lj6ZceO2K+2U3Myn40bky7TMfi91+2OF4Zu6cEIBZVCiQbMY
         jEbbSv0i7kHmi8D4fkGH2eI6FPqh9xVsB5b7IWSYczjTyL2zA2ynf/tW/DzR/WnFV0XC
         W81zawoIApArNSPIDYejJYUieiD3u9VHmiLgXvbm0fJgq6NEPRwp7cBOt7J4mVofhTVS
         UOnbzzaFlOwcf5Q8cATNY+b65WHSm00ofb/WmrRD4XtYjUpmM2McucO9KOFdM20+I6I0
         0ydhzz1GGTXOi9EiG2PZeFRm7/u1lHlRdBZxr9pl9IoFwX4/PJ8dR8jFpKCxC05Gn9e9
         aKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443280; x=1784048080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Omuhh4w/zf0SDooRU/V40J3YBdkMf6Hj+qafJjaEjQA=;
        b=Exb+TgSgCs9v4f9Ht3st0bHQBX+29XIJ9MsHydjYo/vpTeE49eoaVuvueOei2xTjIU
         ktarut3hd+YOfjkXm7ln8zQy96/uCVpIEtzd9f3WMO3fBvkUrepRIA46wUTu4TkbYx6d
         pQrTGvowsDTtHpT7gevCqdnq31Pns1j303JeqjOGwv1BxpRpdJE67wS5/RdpGdkvywwU
         ka2GfSTR5nLrvp3C+ApCZALAOHcTGD5P/bcHPQL6vU2/4FeEmc5YpYezMDB14rlFfExx
         1Zboo9jykb4QANb2pigk78Q5c7ngw+sghkJgCmt54/HPRiZh3pRSkl3NnxRXNuydPTnf
         0xGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwjBcW9d3ZlgtmP0b0H3gtUuBGfM+odfgicnw/AeqlGTbcPqmgpmuvu325FuMFvcl0G5TXVQUSQ6Z7KfOT@vger.kernel.org
X-Gm-Message-State: AOJu0YwHJTujiaefDSSiuFnovOrJwFT2wv1BVs8ugsDIGuU4X1rZWi4S
	mkDhh31brQP2LgAW8fVPQHVMOgiqxVvShxAabB29vFlYR8qN6B9Klmun
X-Gm-Gg: AfdE7cld0WUyXUJPIW9cOWG3ofVTtIGIrmG6YfGBjmMC0eRZJTRQD8FIiNBzfbOibDS
	61AU2sjeErrTWjiuBczpuSLtyDjhM+AibTh6NNuvmx2LzlElAfwbonL9o8O2ZptNOC5Q1yhG/h6
	ZAevHjTEgrB9uQdJ+O5YvG3tOkA0XrIN9FIIXecWt59kjJGcmZcpziKoRaWGnQKpUFvTIdcw1Tw
	51DPQijXlocRu0JG5ZnGQ3RH96TFusujgzPKjngICE7nSqhEU7kT0O7OeYBj2/QECBWYA6C5W3Z
	QuVAVg0wnQd1hH4N8CaSDiRDlhZHTXuA7RusiDjTGL6h2oyeK4PkvGJz7VdAsRVIXGaQ92A4FLp
	pVEFcenWlT4WYt78uB1LeB7455/Dz1qQN0wfOovYupH7zyiB5aI7842PSKdf+3lg=
X-Received: by 2002:a17:90b:2551:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-38754ea7913mr6387958a91.6.1783443279804;
        Tue, 07 Jul 2026 09:54:39 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d36676desm1443261a91.10.2026.07.07.09.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:54:39 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: jkoolstra@xs4all.nl
Cc: brauner@kernel.org,
	jack@suse.cz,
	jbingham@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] minix: define constants for dirsize and namelen
Date: Tue,  7 Jul 2026 09:54:38 -0700
Message-ID: <20260707165438.590667-1-jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <942891560.128364.1783370852771@kpc.webmail.kpnmail.nl>
References: <942891560.128364.1783370852771@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 6, 2026 at 1:47 PM Jori Koolstra <jkoolstra@xs4all.nl> wrote:
>
>> Op 06-07-2026 20:22 CEST schreef Jeremy Bingham <jbingham@gmail.com>:
> Hi Jeremy,
>
> Thanks for taking the time to look at minix. I have a particular fondness of the
> filesystem, so I am happy someone takes an interest.

Thanks. I think it's kind of neat to have it around too.

> However, I don't like this series. There is no reason for all this churn or the
> exorbitant amount of comments. If you can get iomap to work that would be great,
> but please don't do this.
>
> Thanks,
> Jori.

These two patch series were the only other things I had besides the iomap
patch series. This one in particular I'm not super attached to, but I had
noticed the bare numbers there while working on iomap. I wrote the minix.h
patch in this same series because checkpatch.pl kept griping about the
function declarations on the lines I had changed, and since it was a bit
of a hodgepodge of different styles I thought it might be worth doing
something about it. Changing all the function declarations was out of
scope for the iomap series, though, which is why I did it separately here.

The other RFC patch, which unifies the itree_v1.c, itree_v2.c, and
itree_common.c files, was inspired by Darrick's comment in the iomap patch
series about how the way the v1 and v2 files have specific definitions and
include the common file was "/one/ way to avoid having a geometry struct
capturing those details". That got me thinking about how not having to
worry about the different v1 and v2 definitions and just unifying those
three files into one, but since that would also be (very) out of scope
with iomap I made that RFC patch separately.

In re: the exorbitant comments, I had those in the RFC to explain what
I was doing and why. If the RFC patch was well received, I would of course
resubmit it with the comments significantly pared down. That patch would
make the iomap conversion easier, but it isn't required. Since that RFC
patch would be nice, but isn't necessary, I wanted to put it out there and
get comments on it separately rather than trying to fold it in to the
iomap patches. In the future, though, should I find myself submitting
another RFC patch I'll keep the explanations in the cover letters and
commit messages unless absolutely necessary.

Iomap and minix do work now. I just need to address Darrick's critiques of
it before submitting it again. Since these two most recent patch series of
mine were indirectly related but not required for iomap support, I broke
them out into their own patches.

Thank you for the comments, and if there's anything else you think I
should address I would love to hear it.

-j
