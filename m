Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5CC256C61
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362787; cv=none; b=FDpDILbLklsgxG184TMhiiEMsTw9Z51fknomjzDiJSWLDuoPh9n6cuO0AzLpkWHlwoUtGXCriMC4vl7xaJGNSRbktD7dngI4FvtzmBzOLgnTUaA3p3EV9x9GigBk2L3I568JupWmCMc4Zn5ejGEc0p1LDBzg6pOQtwPyNS8oOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362787; c=relaxed/simple;
	bh=o3x4DAb0eRLl4uNfaWIcn/L8/2cQhYGGAqgds80Yp7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qf6t+QA46+TTQ+6hsXcWbV0q8kalR0N03X61jB2povGWQKsRgVVoTM/IJTNPJ62pgdKwfta0+eUHm2SqpHxS1VRqgD/rECqQvK18+IhdXcmxcUuHvMCx0sMfdubX3MdUmT3H9K3bYdNA6ex6CDPIzuXVrx3oGj3PNGMG4Qjb6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2H3lVup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2H3lVup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D111D1F00A3F
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 14:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781362786;
	bh=o3x4DAb0eRLl4uNfaWIcn/L8/2cQhYGGAqgds80Yp7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=j2H3lVupqeeRVgj4TYQb1FiSN1EbP6F3jfILNN4rablpGtNW9hInzqsrYF+qejGc4
	 UJVOD9S7fzU/1DJwf9xYMcUGpRoDA4xPiwW+GFWwKJfVCNl7GiqgMV8wi9FsnpWHq4
	 ib99AbenYSVrSoJq3IZkKbvE1urv+0hK7XVtD5xifcN6xT5HJ9HTOJby2ZbnPtNV6E
	 Ai+spubgBiAsTBifZ4z5ndMfbSyWujETltwbcli4UOCBmMREdIsxub5viaxrI5/MOV
	 mrmbbFtnBHfdxZE7OySC8ZcEq73PnLhrMitr0n/Wds2LY0jUOvBOpZIdV/c0n7MwlR
	 x/oTQGFq6lGEQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69155ca09d8so2163985a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 07:59:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/4aogcnxZ6vavSCbY03/kZKttMbGY0XwgaLZftUX43TbUa60wOAQw+c0iWEb68A4fcgA9zGpzGf8zfF8DT@vger.kernel.org
X-Gm-Message-State: AOJu0YzkzZIzbFVM0Zgr6zXxPBITrx4tptpLO35R/2CTvPO9TT5GTAUM
	vKrhu14QLCkNEu/Z842j2coyqElNrwTca222iZuRfdc2WQ7LQmAz5cdr+CS5+kRLALHPiBSKUYX
	2anP2EnmKwYJjLFy9QhYFuka09lUGHXk=
X-Received: by 2002:a17:907:75ce:b0:bd8:f919:5c0 with SMTP id
 a640c23a62f3a-bfe29b3810amr241279166b.27.1781362785464; Sat, 13 Jun 2026
 07:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613133938.239009-1-anmuxixixi@gmail.com>
In-Reply-To: <20260613133938.239009-1-anmuxixixi@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 13 Jun 2026 23:59:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-9C5VPONHF4mq9ssVdyH0snfzmpb70jk-Q6g-DQEdPwg@mail.gmail.com>
X-Gm-Features: AVVi8Ce51TEKJ6nnNW9rIQ9j5jOjMkiPyGGKretOT3TLJFGWTwnqnEuEH6Ikwq8
Message-ID: <CAKYAXd-9C5VPONHF4mq9ssVdyH0snfzmpb70jk-Q6g-DQEdPwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] exfat: preserve the next empty-entry hint after allocation
To: Yang Wen <anmuxixixi@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 10:39=E2=80=AFPM Yang Wen <anmuxixixi@gmail.com> wr=
ote:
>
> Advance and preserve the empty-entry hint when only part of a contiguous
> empty range is consumed.
>
> This allows the next file creation to reuse the remaining range without
> scanning the directory again.
>
> Signed-off-by: Yang Wen <anmuxixixi@gmail.com>
a build error happens as shown below, but I have directly fixed it and
applied it to #dev.
Thanks!

fs/exfat/namei.c: In function =E2=80=98exfat_find_empty_entry=E2=80=99:
fs/exfat/namei.c:348:17: error: =E2=80=98prev_hint_femp=E2=80=99 undeclared
