Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F536E478
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197035; cv=none; b=VPJyFJa5USmsZHE8+RgS3rghHxzB4iqv2z90YKTdyHJ2n9871xt8Yv3E82V0sED61gDwLEQR2r++QMlpdvc0cP+mPe7luK6kdT+Y8Ik3zA0bVgUVqNPbHo7EvP9PUJJBbKlNqDqIEE9MEwSslB8FQzJeJiJCwnjOV5/bWKloBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197035; c=relaxed/simple;
	bh=Po+xDe1abN404mOx2PgIW7VcjjqbtoPVKIeW0TCog+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTVRveSgD6f82n+C/XkELbv7C9jfSd7ZdHYdyn6V8lYv47D1mCiPsZY/JgYv1AQYAs0C6Ykvmmm+VF968IHzMFq/2c+rSJZ5hSI9MHQvAjNjAD2gkQ2cyItIH10TdISeQEZ2wcPV2FidT5kHsFXbG7lFzqATi9BXGhuNRVJub4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG7Xwg8E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG7Xwg8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3D0C2BCC9
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778197035;
	bh=Po+xDe1abN404mOx2PgIW7VcjjqbtoPVKIeW0TCog+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YG7Xwg8EbcSA+VUHVp/MuvBo9eNbwas8CquluNo8wOehkwOat5AnaWmJDWG7NtcMI
	 Eqc47NYdFvdvfxX30z0k/Y5EFR8U9/VUnEzliM48LhaywEzS5FOKbP4PsLmNPgevIr
	 z5rwNLAMbDWJu86XERv08Io9FulIU1HWZvnxNVurmrSsZB0auk1OGbHKFeWDMvKupm
	 MB65w5bufFaXCKor/3GVqFapSv+neLUaUz0acrF2V+r5KbSrPvdbbotzqDtDZA6HDN
	 G5mL2a7OwU0YIq3R314nRsA6Ybo6x9I1iO3f/L1XSe/KcRR5/XwGDc+TjHxKxc4pTz
	 HyBjjXDZwyX4w==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso2077310a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 16:37:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9cn732EwH/huv1HK3cZ+jHTp78i8DDkbtl+3tUMdOv8PGC5QIBneo1VzWdzEUo0pzphcjUTSBhEUEsihpk@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQbFrf2BcnI7m3Rt1Tp5D+G6e2UOL5fYAvn3vFRyQnOBsuZG2
	Gd1ksff8J+J28KDRE01LLYabD1RLDyn5yuYVuElgxO950OUN2Dl1cX4hZTdycInYUJXz+zE/CEa
	Sy07K4jr3sbzgN4G96jHHw+2k87ySc4U=
X-Received: by 2002:a05:6402:a0d1:b0:67e:4802:1c2d with SMTP id
 4fb4d7f45d1cf-67e48022059mr1652414a12.3.1778197033600; Thu, 07 May 2026
 16:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-2-linkinjeon@kernel.org>
 <CAMrLSE4570TxqBgTZGz+oAsaVOM-_tbwRro=e4MMGM4aYnwmtw@mail.gmail.com>
In-Reply-To: <CAMrLSE4570TxqBgTZGz+oAsaVOM-_tbwRro=e4MMGM4aYnwmtw@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 8 May 2026 08:36:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Hea1kxR6Uz7K-F0Xb0xAB0FW3AjPPLyeOstdy9_0zpw@mail.gmail.com>
X-Gm-Features: AVHnY4Kg9cfiq4SEAXr7yvxtipDDamBQIJoInqfd9jVv-4VHtpo2MGEllTEnod4
Message-ID: <CAKYAXd8Hea1kxR6Uz7K-F0Xb0xAB0FW3AjPPLyeOstdy9_0zpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] exfat: replace unsafe macros with static inline functions
To: CharSyam <charsyam@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 10:41=E2=80=AFPM CharSyam <charsyam@gmail.com> wrote=
:
>
> Hi. Namjae.
Hi Daemyung,
>
> in fs/exfat/inode.c
>
> -               inode->i_blocks +=3D EXFAT_CLU_TO_B(num_to_be_allocated,
> sbi) >> 9;
> +               inode->i_blocks +=3D
> +                       exfat_cluster_to_sectors(sbi, num_to_be_allocated=
) >> 9;
>
> exfat_cluster_to_sectors() already returns a 512-byte block count, so
> the extra >> 9 makes i_blocks 512 times too small.
Right, I will fix it in the next version.
Thanks.
