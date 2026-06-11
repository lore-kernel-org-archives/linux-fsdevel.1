Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE7389E05
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781215374; cv=none; b=DoutxUXzmYpm07SpuRcS4LVIQzqMhSDJ16Fe0LhTWfsoYFJiULR31z4q6fwjvUCCogX5cnkNZiFrhruZMp/YbGSZmPr9dEwmD/0h9FKISyu7Q1cYwFwIIUeu6db27PhvwtEdbEIv0eEZt3J85bIpsbNIZNpcoDI6V3jfCdwpZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781215374; c=relaxed/simple;
	bh=97vVDLPrP03BIn5ph9rMN1tme231GpO1711PQLoxlME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEqpCkBgMLnlqHq2aVO3uZ9fl5uANgyj+WDgCV3CzxK5ba6GXIlPtrlHIgWghKN8S/v4JElv7OPIQuMILW96Nbs/ghm72IZfnJ57udGL3bUC2AZUlNwH6Lp8ZaADgEfKh8HxeBg+h0LIU93oIYoF34TkZHw0DUQuMXQ4Jl0uNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvnZdq2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvnZdq2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6751F000E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 22:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781215373;
	bh=xmfMqMfejCGR9RGje03pNd5oaqqEX/syvG5DxLoqWRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XvnZdq2IatkEgweNzALXgVYbYLo1RTIz8pINp6gYn5q2iPLpPI66ipBsGm0aqP3Y2
	 uy9gaC7u1mQwJ/BZYfFcOtCrXwhn9NXE7GvxDzPEKkZfU9z8JFGu8esU92rZdx6mW/
	 /X9+nodjSXr9PoM4aRuEbUTgfDGPwHAKM7Jxldwrvgk/uKorYBbTUEfTyOmvV3m7pD
	 kmpGTEkxQEeIzPuZuWyZDMHGWr2u4IJqd7vtqHoe2tLYNcs+/z70MY7qHRk5YwnTQl
	 2xVhn7txT85Y1SX9PSH0xG3JpV/80fz3QjQOgUxAjrUYijv2vvolWU5T72LlLGjKwv
	 AMAua3IM8IEug==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6930f7e83b1so1587036a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 15:02:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/YA/bY1goGKF63//8hjNfu6r90zvdzkkj/Kdo46ee7MkRyl86AihXdKyK9MF94eRdNx+07rvinHyuf72rj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1e0cN0fPQ5NqBibeGKX47hvE8WnX/qFFAUA9N41gYyso8X0fp
	xtpuTh22NtH5BEXuoangFRRu/1WYbLEd1ar7Q2JPonCoJ+T6+rVJZF2VTrywARhtujHyZ3qZS0U
	mvCDOUFsKfwbFdlEgCwhEXPRFR+4oG0I=
X-Received: by 2002:a17:907:e117:b0:bee:280b:8bec with SMTP id
 a640c23a62f3a-bfdebf71ea8mr8828366b.4.1781215371732; Thu, 11 Jun 2026
 15:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607203000.700100-1-hexlabsecurity@proton.me>
 <20260607203000.700100-3-hexlabsecurity@proton.me> <CANFS6bZr3pR9PY0ugGFWsz7a9bjWeLEB0qJS5x7bq6-cFuhk9Q@mail.gmail.com>
 <tencent_7EB8BA466F94ABB2735EA6E423E41EC41007@qq.com>
In-Reply-To: <tencent_7EB8BA466F94ABB2735EA6E423E41EC41007@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 12 Jun 2026 07:02:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_==JzT=ohYvT2gwdfSMna52eHXDYPmAz+_qUnvfPVK0w@mail.gmail.com>
X-Gm-Features: AVVi8CeqMUC8DyrNbSDmf7e1rTIHjK_d9sLnl6Veabx2ZJDomkj6pTSZo6UoBT8
Message-ID: <CAKYAXd_==JzT=ohYvT2gwdfSMna52eHXDYPmAz+_qUnvfPVK0w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ntfs: bound the attribute-list entry in ntfs_read_inode_mount()
To: XIAO WU <xiaowu.417@qq.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, Bryam Vargas <hexlabsecurity@proton.me>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 1:07=E2=80=AFAM XIAO WU <xiaowu.417@qq.com> wrote:
Hi Xiao,

> ## Suggestion
>
> This is a pre-existing issue, but since the patch touches the same
> allocation site, fixing it here would prevent an attacker from bypassing
> the new validation by triggering the overflow before any entry is
> validated.  Two possible fixes:
>
> 1. Use 64-bit arithmetic for the round_up:
>
>      ni->attr_list =3D kvzalloc(round_up((u64)ni->attr_list_size,
> SECTOR_SIZE),
>                   GFP_NOFS);
>
> 2. Or check for overflow explicitly:
>
>      if (ni->attr_list_size > U32_MAX - SECTOR_SIZE + 1) {
>          err =3D -EINVAL;
>          goto put_err_out;
>      }
>      ni->attr_list =3D kvzalloc(round_up(ni->attr_list_size, SECTOR_SIZE)=
,
>                   GFP_NOFS);
>
> Either approach prevents the overflow without changing the validation
> improvements from this patch.
Could you make your second suggested fix into a patch and send it to
me for your credit?
Thanks for the report.
