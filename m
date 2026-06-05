Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCC349CFF
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667072; cv=none; b=TFhpPaK2uMjpLuKF18kHyB7a92gCdTST5fU0je4qLWYT6u0mZqVoaqVjwU6QQJQvsBqcnXOClQXiA+CgdO6gDDFEPDhpJ18eFpTccQdGau5dPHfWAlHqltUk+jBgt7ekELEjRZjkX0MFKzD6fW4KLcq/uIxZwVUePkLDAPQL7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667072; c=relaxed/simple;
	bh=73QOiKoWSLkuRo9hOthqkHd2gzsRlpcew/fBy4bWKXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCT8iZHlUvjQA3ndvw11RZE8Iy73ClF3DkrTT45jQ/H0f0oBCu8BskKs5PDmCsITNtRm0dkQad9lOSCb2cSITDSDWo7UX0DeyWLR9q9Y0H2u80f8EUBIXt9NP7aPGlXSb9QfrJSibCGOgBCDmphD5Z3mxpZ6tgrRi++PMlGyou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8q1/3sn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8q1/3sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCB51F00899
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 13:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780667070;
	bh=SPa9mUTWEsfvUyOTZpH/ZfzNAj/i18wlxnjfagtw0jU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i8q1/3snAJpyYK2/mUB8YnAOt+UA0tPeHCseUZdXv4ylV53qCr5ey6/8kyA9CrSZF
	 zSlVhIY7FOmlHAT1s73LbSnPa8S9RvfXVRw/zHDU3TixTXBaafM0hLWa1x5kKYafkK
	 i/h7hrpwXkrC1o15dyE0tQRj/igcTcNZQbe0i78Qvmkl/ge0xuRUPII9585de4+HDm
	 KPj1DKXm/w7G1QNyPqIFviAaHyddv/ToioIAHTQvK7Pggw7q2ScuNVUG2pMhAcKBhB
	 4pSAXaYq4U3+F6nsIXikLrds81DFVTC2Xm7HRxPWZlFEoTRVwOt459WfgyS9yPaXog
	 NypzoxE9XaYIg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so3316194a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 06:44:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ//EOt0YAfPpVnftvmDoIM9SnNLNAR04ld2elMago2Ej6JrdOOpePag6ULk9aaN/yYwUhcdvxiukN38zRh3@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9GRJtAXutWSYgQhiSTk3HuD0ZztaF1LfLJ0XHd2rvLA9CE1G
	WL5kKyvioriwLtDKa5ec3Mr9+M3b1oPQWIjnD/II6YIKaw0OpYq/fzZUYG2bNlA31fJCXVgGSl0
	hK/bFNSbzs/POtlSGtfc6gtMOmMDkyiU=
X-Received: by 2002:a05:6402:1f4a:b0:687:50d3:d9e0 with SMTP id
 4fb4d7f45d1cf-68fa514bd51mr1804485a12.20.1780667069086; Fri, 05 Jun 2026
 06:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603174109.24493-1-sam.moelius@trailofbits.com>
In-Reply-To: <20260603174109.24493-1-sam.moelius@trailofbits.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 5 Jun 2026 22:44:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8LXeDoMuZDrj_=C96z_diG4d-2=fk_EdNWh2E85JscMA@mail.gmail.com>
X-Gm-Features: AVVi8CdQTyz1QFS2A8NZQ1VmoJ7tCYz8f0WIxj_U5XWIGKV_zgHrb_BegUo-1n4
Message-ID: <CAKYAXd8LXeDoMuZDrj_=C96z_diG4d-2=fk_EdNWh2E85JscMA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: detect mapping-pairs LCN accumulator overflow
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, 
	"open list:NTFS FILESYSTEM" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 2:41=E2=80=AFAM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> The NTFS mapping-pairs parser accumulates relative LCN deltas in a
> signed integer.  A corrupted attribute can drive that addition past
> the representable range.
>
> One corrupt runlist shape sets the accumulated LCN to S64_MAX and
> then adds a delta of 1 in the next mapping-pairs entry.
>
> Signed overflow is undefined and can turn an invalid runlist into a
> different set of physical clusters.
>
> Check the LCN addition for overflow before storing the next run.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
Applied it to #ntfs-next.
Thanks!
