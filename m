Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17343612E7
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718818; cv=none; b=EqHQEWXaujkV2EHG4dyPrhMxR7yG/OUX+maK+1Tz6QRDkpIsRNVOZqCjH4/Vmcfzhhd65SBQSNeVWVZUtM7HYESZpWqzh7obmy2m5H5EaDcwXFjGjj5OcosC/dtanmiZ30PFxG1JonlBAWFYdKuLlorcPGprysLohppaPHA4vLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718818; c=relaxed/simple;
	bh=QeRpSlxxQP/HZiyEhlyTkgytWamEe4JOXYdhQezZW28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeqrpYK4fFXMfgWeS5+1uGDfhU1d6zI/lCb1PIwjhDwawOX2xfLr0uMgkhN+i6UYJTYPJzTQ7G7KUtZ9/kyF+K0Us1hHzY0Co25Lvu8teb+Us+Nb1llxDXWoLMXRGhfhQZWFWGAlFb4pI1pooRmy+Z7rwrH3IEx65wEyCgYpCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6aXxKVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6aXxKVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9251F00A3A
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786718817;
	bh=QeRpSlxxQP/HZiyEhlyTkgytWamEe4JOXYdhQezZW28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y6aXxKVFOKzdLAGcZ9H5yNDNYF66K6lsaZfINJLte0UKRNx5kbKwVTxpeXyGPYeEE
	 YOkIVwKJ9F69k4j4G7TXQpagPXHHzLwCGuVAPzI3au/FVBf68IfSPIwRtO80cMBCLs
	 eGkU1HNyZTy39xcKMNO7ftmdC895K1R96pTIH7yXIauE9LS8RP5tf5Y5ej/F2A+iQz
	 vPQjv4nCPoTChWwBgdU3Cmo6+XjfdCumvubQpMTAAPRKHBnxV/84FHvTIcHsuxND56
	 fi04MizQGaWw+1nuQHRpZcB3vz/LlRU41N3LrJ/Ijltibw0TgPvLTTsLEwysAzaWDf
	 tIV+J4WeYNxXQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1fbe461f59so176606666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 07:46:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp9r13WD7sh5zddAcY1myASu5Uze0qzBDQK9iBw7GWyMJeyUkb2LwUaSsUoAozjl+uoefHLtEPL0G4faoI0@vger.kernel.org
X-Gm-Message-State: AOJu0YzeruBoN5o8/pXZwsXVdjR8wYXsYci8TALZGYjszI/X+duRurIG
	dafuHQ+9dEcloxrwSnW+rWeDb9e96BOMMsrOTQuS+tjmmFRjJYdDYV5HjPJxf/LmXJioe0lvqdf
	5q2MKYUqr/Fi1ZuMSr//iJ8Kiu8q1slM=
X-Received: by 2002:a17:906:6a0e:b0:c15:f26a:342f with SMTP id
 a640c23a62f3a-c212a23ffcamr226154666b.23.1786718816223; Fri, 14 Aug 2026
 07:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814041213.1216698-1-dmantipov@yandex.ru>
In-Reply-To: <20260814041213.1216698-1-dmantipov@yandex.ru>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 14 Aug 2026 23:46:43 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-kCqcMKkCgc+rqufO4_HsyLteZO_4RpGvqMaXe9D1=8w@mail.gmail.com>
X-Gm-Features: AcwNN1UgGNUhtED0xwLbnpgyIUkHpyjK49D4AH03bQTYnXS3noMP5u4bPxtOoH0
Message-ID: <CAKYAXd-kCqcMKkCgc+rqufO4_HsyLteZO_4RpGvqMaXe9D1=8w@mail.gmail.com>
Subject: Re: [PATCH] ntfs: simplify ntfs_reparse_set_native_symlink()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 1:12=E2=80=AFPM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> Avoid redundant 'strlen()' and use the convenient 'strreplace()'
> to simplify 'ntfs_reparse_set_native_symlink()'.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
You previously sent the same patch before, and it was applied in the #ntfs-=
next.
https://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git/commit/=
?h=3Dntfs-next&id=3D92e493cd205e8b105659946c53b7b9bfd59d8c58
