Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1A41DEDA
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337572; cv=none; b=lufrEs8dY8DsTkSanTVu6Rxq2QwpoBgUwwIjaJlkG3crAHqmTW2uw3dCpXjcJIJq6MfK3krqTlgpB/MCyDp0T96wA5N8lhVQD5YDEFiJtjf8s8CRdeOIuxP2PEZYJxGp0gEiXN7GfhZLA0rZe005kK8O/LUCe/jNVCLWef+lh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337572; c=relaxed/simple;
	bh=OdR9Hn/1z5uZgCbGkXNB4LtFlNoV84HckzAwBSIr/eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1rSQMPM46puffiQhIZzYUwEeWZ+NaKHGHSXSjDuXephxFEPf1HYgxk2vYeEMoiJlHgqeAF7SpDO1g5tDssRQDwqnyjPfWqOk7jI6bOGe7OHhuccw1ibiouSbP5NZEcLI9j0qfjKXybJlh7elzgAWyYCG20snuLX7gngKSJA0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0YH++gJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0YH++gJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D78D1F00A3E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 11:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783337571;
	bh=OdR9Hn/1z5uZgCbGkXNB4LtFlNoV84HckzAwBSIr/eY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=D0YH++gJMjHRIxz1rUQXwA+shS/yzxNngZRA/YI2LLt2zx83MP0c52UhTU6nIoH/O
	 YBEu04axIGaX4t9J7jSTDWFenu18UWMHyiMhz+GL7Kc5mOirod80d3ZW5jJsDnTZNn
	 ytfSuM+f8IhISeOEXedmRMpVSAUJYJJuMljd3uaPZGCvQywHmaKn7z84VcAR0ZB9ie
	 /WuIIiPgVoWOIQFwj5NG+oYp0dcc2wQUU8KBru/ISVQMKgOI4TzYZ1UGJ2tZP7MNNG
	 9+7Cg0E8Q0nXI2/LK8W3d7R9mHjQIBLgpPnJHby74gbmFF3S5NlEO/SoQfcORaKucb
	 X1ddSx/VX8V2Q==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c0c15bd6b8fso273729466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 04:32:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8VXqro+m28710EdtB7l+/Knk+TuyMw+9hMnRlRbh1MkZXNulJ2GDhdEysOwwdCopAcEE0BXSktDpRTtgQY@vger.kernel.org
X-Gm-Message-State: AOJu0YwRMJHIFYghUfnQqVhk618hhBb29Yo5fmHCm1tbpmqHTZWAvoMJ
	31mmqgLSI1uJX29mHbiBLSAxEWb6a7MmwGQmVLN5j61lITSEc1GB+PirEDfmIyok+mcherLmmj7
	89dA+uRS3WtIzjQpGprM2gPRVwZ+3vC4=
X-Received: by 2002:a17:906:1d5a:b0:c12:1e33:8590 with SMTP id
 a640c23a62f3a-c15a681ac88mr5099366b.14.1783337569866; Mon, 06 Jul 2026
 04:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704144654.126437-1-mdshahid03@gmail.com>
In-Reply-To: <20260704144654.126437-1-mdshahid03@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 6 Jul 2026 20:32:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8+tTDk0UZu=AEo_inzOE+g1OWXnFoygxdmDKG6oetr3g@mail.gmail.com>
X-Gm-Features: AVVi8CfclKAed0yUYKtGkGeItj6a_cTdvT4cGYJWmEUTI2AvkooRpxnN_ijPsxs
Message-ID: <CAKYAXd8+tTDk0UZu=AEo_inzOE+g1OWXnFoygxdmDKG6oetr3g@mail.gmail.com>
Subject: Re: [PATCH] ntfs: dir: use kmemdup() instead of kmalloc() and memcpy()
To: mdshahid03@gmail.com
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 11:47=E2=80=AFPM <mdshahid03@gmail.com> wrote:
>
> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> Use kmemdup() instead of a separate kmalloc() and memcpy()
> pair, simplifying the code while preserving the existing
> behavior.
>
> This issue was reported by memdup.cocci.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
Applied it to #ntfs-next.
Thanks!
