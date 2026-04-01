Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2300262A6
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027583; cv=none; b=B8ZbQqOclvFAMFnUWvtH6jznSlTwoSr5pJZYOK0Ckseghq9+ZOTv9b253QbrCIgCsGbcF0d6SkAvAosHZa71IT5fFV0qFjHPe2ECNjZM1gQOl7AylQXEkN3PpQGxEQn8RKwR5gfAFTQy+A8z7OHM/Qcmu5WIoBjeGSRnd4HJ/gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027583; c=relaxed/simple;
	bh=dda7DSFZwhQCYT01QAeYbuWewimQYeIv5sO0w4QLygM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiFaHZwyYTwxwrxwOfeyZ3h7wrOYM7iJddAi0Q8MQsGRULbDykboHZe1p+p6zGYbshOVRdtxRfXf5XPi3SOW5/ZFW1rCtgvqY3bro2ZZQRJ8oJYRxqQKaDDvr3pcehL3tJZDhlTfwu7ZvXDvgOcPEDRcFXsNeZ7YNXyIsX2yF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anmR/Md8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anmR/Md8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF8FC4CEF7
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775027583;
	bh=dda7DSFZwhQCYT01QAeYbuWewimQYeIv5sO0w4QLygM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=anmR/Md8nj0z5w512wM8UCSkFc9w/A+ADc+SE7u52pEBn5HLiWnhkG5eH7vAtWmGz
	 nG1B4pxK+bgPqVeT+dmjATLn22CR7bbTYq6eQ2KQ40uwu3S9SSbqet5iHU2qv8tTV0
	 BUcF4i8zsdo0U17G40qPL922qGUaTh3OPHVqNUKfYLGmrgUjwwYnKqoWsRRpvbfyqw
	 USDWaKij1TOt2BwgPc0v2MYATxwjVTFgIbCMPoC9e/L6/E/xsZtrSVrs4YywDOKPkC
	 vcx5db+amQAp6JY+7HbQ3s1UnyKb+U2b6agHQS9z5OHDlXQXVY2TbWzIV75goxWNQs
	 WAjXzb3dH8ktQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66bf15430ecso5422978a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 00:13:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHSn2muTos3F4S5BdNuZEHHo8sW4ryA6jGd4GGx2NPpf2BGwJC9gfgo4UZV9LJgZP6+1NtsDzhlys8MWji@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5EgrHpDWGXTquzgU98geJ9sCMJZWI6gDgu6ggYZuvkZ9J74p
	PrCg3gyex+FMaVZK5DgvxbAmqEcw4sDkxB3V3n5YKQk5aG2GCaqFXT3U+EMJGGFhcMv94sX1Gha
	A/by3QrFUPOL3dkqKRO5qjMvJrTuJU4s=
X-Received: by 2002:a05:6402:a0d5:b0:66b:aa56:ee5c with SMTP id
 4fb4d7f45d1cf-66db3f96414mr1281696a12.28.1775027582272; Wed, 01 Apr 2026
 00:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322125944.48541-1-dxdt@dev.snart.me> <20260322125944.48541-2-dxdt@dev.snart.me>
In-Reply-To: <20260322125944.48541-2-dxdt@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 1 Apr 2026 16:12:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_0TeNuruJznXjs+MT8cW2zwOiuNGwztF=A7t8ZgKiKQA@mail.gmail.com>
X-Gm-Features: AQROBzCzUkNJEzKc6dsjObtEk-l9fBPxZj1wvucRwJE4MaMnCDHT47djW3x06h4
Message-ID: <CAKYAXd_0TeNuruJznXjs+MT8cW2zwOiuNGwztF=A7t8ZgKiKQA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] exfat: add limited FALLOC_FL_ZERO_RANGE support
To: David Timber <dxdt@dev.snart.me>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 10:00=E2=80=AFPM David Timber <dxdt@dev.snart.me> w=
rote:
>
> As means of truncating the VDL of a regular file while maintaining the
> layout of the allocated clusters, allow the use fallocate mode
> FALLOC_FL_ZERO_RANGE with the range that covers EOF, with the support
> of optional FALLOC_FL_KEEP_SIZE flag.
>
> To reset the VDL to 0, userspace may use fallocate() like so:
>
>         fallocate(fd, FALLOC_FL_ZERO_RANGE|FALLOC_FL_KEEP_SIZE, 0,
>                   lseek(fd, 0, SEEK_END));
>
> FALLOC_FL_KEEP_SIZE flag is for multiple users to guard the file from
> TOCTOU conditions. Without the flag, the behaviour is the same as
> FALLOC_FL_ALLOCATE_RANGE.
Why is this limited FALLOC_FL_ZERO_RANGE support actually needed in
applications?
What are the practical use cases or benefits for applications?
>
>         /* No support for dir */
>         if (!S_ISREG(inode->i_mode))
> -               return -EOPNOTSUPP;
> +               return mode & FALLOC_FL_ZERO_RANGE ? -EINVAL : -EOPNOTSUP=
P;
Why should we return -EINVAL specifically when FALLOC_FL_ZERO_RANGE is used=
 ?
There are already the checks for non-regular files in vfs_fallocate().

Thanks.
