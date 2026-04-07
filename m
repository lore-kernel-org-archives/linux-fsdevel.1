Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE83330324
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553335; cv=none; b=RG3n6a+HkDHrvlzEvRNj2XBC9JKXb33xDQ7xeMKhWttwey1b3SyXBUd9j+YFL1zV0Lxqs3byTLmAL+cpm2ztUwD4por3QPOBi/CFi3Uv/FYBaFxHXC0zrwm8oA36JcjWDjlQae6NzNXIKGcXvyE5TTD9LQDAFrMhYoigyLD6iMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553335; c=relaxed/simple;
	bh=Y6aRO3ICTF0H5klux9P573B9AGjFaGU3SYXHojvQGEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZwJVu/tcAYCST+uWEA7ySco7WbRK1D6eFMVrZhshsH2hUOwhXP9pGMyZnknQJYtjOxhyAN8Kt9N9/0KifEeCdjmzjprshZXhE25e8+VST9erU7FYbfVybAxKQnI+1n7YuIiGQZf9MgkjlUJR1Iq4svelEOY7gptT37220KCLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNZIDp2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNZIDp2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF3DC116C6
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775553334;
	bh=Y6aRO3ICTF0H5klux9P573B9AGjFaGU3SYXHojvQGEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gNZIDp2+T0pTWr9ZfQDAVr1FnCcSavy8gSId9h/Z4MYvKPfFBd7TzY3JUi5VaEe5Y
	 xuoPsxcSV826HMbsNIc0Zl2yDAU1CXCkuL2cHqi1zkPB0GxB+I8VSCXohOvPMZ0BQQ
	 Kb94lT0+xhvUi4G5CKKNNMRfDD1d9PlYtZrQAe5c76Of8xJAToZn2CqUXdNESrGS42
	 YX6MbBVvEBQkG4bRgkHvhsZ+vEiRpcYIUnxKvTAYwyBcZA8zXBCz39GQyAJE3DNKWZ
	 fm5oCuNfwhcVFD7gQ3tbzCIf/yTguzSWLCHbxpo+zTwNPoNIxgkNBTz44CMHTX5eO6
	 YgmBrFvC9H4gA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66e6d9610d8so4629070a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 02:15:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3jcOd1qWq8F5nGaXSkAPg1yfTrln7T7GbylnVeu5BI/icDJPHQaBenHp3wmQjWM4Z1EJLk59Ajir1MSfE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2tPhAKGT/a9Kwf/Hb4Of5XQQaD6EKqKAKgHxyvjmYAwKoOMe7
	Kb6yPhf3ARG3Uvc+me0GZY4U1u9OnnXl8Mrso/8UQVKYXnWmb1Gcte24Q6bLVReQ5VPTFrZl7xC
	yiuSfxukVxYLE33y0KrmneyagRokfNeM=
X-Received: by 2002:a05:6402:3554:b0:66e:6f1d:6d67 with SMTP id
 4fb4d7f45d1cf-66e6f1d6f67mr5433993a12.8.1775553333403; Tue, 07 Apr 2026
 02:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322125944.48541-1-dxdt@dev.snart.me> <20260322125944.48541-2-dxdt@dev.snart.me>
 <CAKYAXd_0TeNuruJznXjs+MT8cW2zwOiuNGwztF=A7t8ZgKiKQA@mail.gmail.com>
 <9e82ba4e-506e-4f00-ad06-67c0d541cace@dev.snart.me> <CAKYAXd9fENATzE7abUGMZ1uYARhFW=oG_7yvUSWvoX+25nv_Aw@mail.gmail.com>
 <2c8aa91a-184f-44fd-97fc-c02b0cee1b08@dev.snart.me>
In-Reply-To: <2c8aa91a-184f-44fd-97fc-c02b0cee1b08@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 7 Apr 2026 18:15:20 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_deZicF_rm3_SimQXbJ8SCk6GVrRVL8NV5B2eVTx8zkw@mail.gmail.com>
X-Gm-Features: AQROBzAhDEtF0EwnyntYfKoCUy2jMTKkG4Tr98dFI5H2j7Br5uMdNGKKD1AAJuU
Message-ID: <CAKYAXd_deZicF_rm3_SimQXbJ8SCk6GVrRVL8NV5B2eVTx8zkw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] exfat: add limited FALLOC_FL_ZERO_RANGE support
To: David Timber <dxdt@dev.snart.me>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 7:01=E2=80=AFPM David Timber <dxdt@dev.snart.me> wro=
te:
>
> On 4/3/26 15:19, Namjae Jeon wrote:
> > I have some concerns about adding this limited FALLOC_FL_ZERO_RANGE
> > support to exfat. It is already possible to achieve a very similar
> > result using ftruncate() and fallocate(FALLOC_FL_ALLOCATE_RANGE).
> > First, call ftruncate(fd, 0) to adjust the file size and Valid Data
> > Length (VDL). Then, call ftruncate(fd, new_size) or use
> > fallocate(FALLOC_FL_ALLOCATE_RANGE, newsize) to preallocate clusters.
> The method you've described involves destruction and reconstruction of
> the FAT chain. With the current cluster allocation scheme(just return
> the next one available doing O(N) search), the chance of the newly
> constructed file end up having NO_FAT_CHAIN is quite low. FAT chain
> construction is not particularly good on flash.
This is probably why the EXFAT_IOC_SET_VALID_DATA ioctl you suggested
earlier would be useful for exfat. However, to prevent the exposure of
stale security-sensitive data, we should restrict the ioctl so that it
only allows changing the VDL to a smaller value than the current one.

> > Additionally, The proposed implementation is quite restricted. It only
> > works when the range covers EOF unlike the standard
> > FALLOC_FL_ZERO_RANGE behavior documented in the man page and
> > implemented in other filesystems. This may confuse userspace tools.
> Yes. Fair point.
>
> I spent some time decompiling the exfat.sys driver, basically an
> implementation copied-and-pasted from FASTFAT, in Windows and realised
> that the problem being addressed here will simply go away if the Linux
> in-kernel exFAT would employ an allocation algorithm somewhat on par
> with that of Windows(which prioritises the use of contiguous runs of
> clusters).
Sounds great! I'm looking forward to seeing your patch
>
> It was just an idea but rather a cheap one. Ultimately, the
> fragmentation issue has to be solved by applying a salient cluster
> allocation algorithm.
Okay. I appreciate your efforts on this.
>
> Davo
