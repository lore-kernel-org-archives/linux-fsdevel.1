Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82B3D5677
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485022; cv=none; b=rRPcMyuma+/3386MrZbZbRI2dt7oAJBwa0lRfckcjOcDL87fVRf5SqM9veHwhl/eZTEZL1CTpRmQ2lDQoZDewa9c3Hn0XtiBBtSJvhSq0VYb+TRiBp7Abl9/Zyh482sxMV9zxxc7AEvo3aA+tqpbPYeXrqPSnuf5oJLWYRunLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485022; c=relaxed/simple;
	bh=8SbDU2OlhnhxrGUXLIg2aQlLpy6y3WsK4EJfe8WYJxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzFy7YyqIP9wjVS2vf2oJvXfJ1H1ijfzm4R+8P349v82TjGCU3aSWUe8nuCOEiVrfo0p2wIE6exsnH7DygEsmZ2E1BLbewSb7QPlm6zzdf0q/02QiQbRCYApueBvchDy0HOJwPbi/2NJ1pxzdwAugePefIgxUZq0yF03EM2TLs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0gyBqnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0gyBqnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536781F0089D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780485021;
	bh=Nd5refc15GJrELtVphbXBTfZyjkxiEauqcgyfGIdZCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P0gyBqnIAivd0otXXfLKGPVVSqpFGx8Co+1hJYgJ7ETvhyPjZkzeUCfsr7dNDcYdl
	 yA7FPl24zmMyfk7twX7Qpj0gJP2KgaGkXNqhCK7KRzazRI0xc9DKfeivD81nB+A4pD
	 DtI4guogas+aii6VF9v+0NzEuQ2axinOClRh3zcvVmc2aWGYYZWYDSJ36wcRVP2pfz
	 GIHju/8Zb9oRX+ctGomMSDscdAS5nmnUTDDr/xloncwX6sEMQo68M8IDUciKZ6Lho4
	 vo4tuBEMcuyoLjEUSpL0X2sgI1J/ZS146LnrDfJTrAIV89oU9hcoAm1YvYc+8sv/bo
	 B3bIvNqO30e4g==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-beb7f26ed62so445701266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 04:10:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YyN7N8w/UCg9ptqgnGjL6mMSL2bVZTeM5VaraNzNUFHukkEFAyS
	lzo6eBA8GiGIkYTYaJuLeT1nImBWTUVDniCRUhtaXPXXJSFOCTkIHXYnLVE5zVAVuws+GtJ5Uhi
	UIOxW/+RDnmN9NAnNyEb16qlxALYIKUo=
X-Received: by 2002:a17:907:68a9:b0:bd9:a087:730d with SMTP id
 a640c23a62f3a-bf0b0fdc6bfmr92480666b.8.1780485020039; Wed, 03 Jun 2026
 04:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603110212.3020276-1-japo@linux.ibm.com>
In-Reply-To: <20260603110212.3020276-1-japo@linux.ibm.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 3 Jun 2026 20:10:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd80+UfzKaCR9YRK8dAQq9S+kEp_VVwr_p3dj1tEeyqUQA@mail.gmail.com>
X-Gm-Features: AVHnY4I-kSxHzCEyAjofTAvp9GqFmh54EvAmNsdlbztot0ApYQRsxVtPxG38L3M
Message-ID: <CAKYAXd80+UfzKaCR9YRK8dAQq9S+kEp_VVwr_p3dj1tEeyqUQA@mail.gmail.com>
Subject: Re: [REGRESSION] exfat: swapon(2) fails with EINVAL after iomap conversion
To: Jan Polensky <japo@linux.ibm.com>
Cc: linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Christoph Hellwig <hch@lst.de>, 
	"Darrick J . Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:02=E2=80=AFPM Jan Polensky <japo@linux.ibm.com> wr=
ote:
>
> Hi,
>
> we are seeing a regression on linux-next after commit
>
>   614f71ca1bdfaa2f25a6f147fe22f3ad031f8e2b
>   ("exfat: add iomap buffered I/O support")
>
> With this change, swapon(2) on an exfat swapfile fails with EINVAL.
>
> Observed fallout in LTP:
>   swapoff01
>   swapoff02
>   swapon01
>   swapon02
>   swapon03
>
> Example failure:
>
>   tst_test.c:1980: TINFO: =3D=3D=3D Testing on exfat =3D=3D=3D
>   tst_test.c:1291: TINFO: Formatting /dev/loop0 with exfat opts=3D'' extr=
a opts=3D''
>   tst_test.c:1303: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaKmkGVo/mntpo=
int fstyp=3Dexfat flags=3D0
>   tse_swap.c:196: TINFO: create a swapfile size of 1 megabytes (MB)
>   tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
>   tse_swap.c:228: TFAIL: swapon() on exfat failed: EINVAL (22)
>
> and from swapon02:
>
>   swapon02.c:56: TWARN: swapon(alreadyused) failed: EINVAL (22)
>   swapon02.c:73: TFAIL: swapon(2) fail with File already used expected EB=
USY: EINVAL (22)
>
> The iomap conversion changes exfat_aops to iomap based callbacks, but doe=
s not add a
> .swap_activate handler. The VFS documentation says that ->swap_activate()=
 should call
> add_swap_extent(), or the helper iomap_swapfile_activate().
>
> So this looks like an exfat swap activation regression triggered by the i=
omap buffered I/O conversion.
You have already suggested a solution. Could you please provide a
patch for this ?
Thanks for the report.
