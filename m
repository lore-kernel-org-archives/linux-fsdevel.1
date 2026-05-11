Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617CC3FD14F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509915; cv=none; b=aAqe0ispCqBjGeuqqz5iHUROCc5nTAqZH9A050N9YpZVbzwQBf41jmYVOFwr99Fr0yjO/lByHiiWO2F1OHUX9puWyjUf/x/M9hSLZyO2ZnG0gm/jox51EhmHgzyW0ZIdCMwWNbX9qmxN0FHs76IgZGlyuMPgK/IjWTlv5IVHlJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509915; c=relaxed/simple;
	bh=dFYK6DZRSpsrPVK8O6z0h8kyH1FMhR4cdwbytSoicI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJrx6nZbvH04ZtBQSabvThanUEMSaZ9jdWk8WWwlAsXyfpUSOJma78ta0MKSXHeHC1n1J98XnF/Gjaf8Bn93oZYDoDzVPNbHvkVILU8BBd6qWT8w167cUnKPV+tRQ7CxvF7weBRVxQuM7b51ZEZMREi4PlgGnrJyqBA4GouIIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQn+iwCE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQn+iwCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38668C2BCF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 14:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778509915;
	bh=dFYK6DZRSpsrPVK8O6z0h8kyH1FMhR4cdwbytSoicI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gQn+iwCE14HBCAjXqZvuhha5b3L+K+qAoYjqIjuCMwBYOVj+2FKxA36P4N+fxQ1r5
	 QcJEbhhSNPMyHlJkPTWwLfLJoM0P3P+pHponOhjhBosDxX+xkHuN6Xu9BqesaeZZKw
	 V+LYW8HlMlnEUtnuj6V/4clGSGKl+mtorMG29f/lRRv2CnpXMc2lWzLttT8aUp9LYb
	 +MR63nyu9XQTSjagw3TU28MhbuarvIGhR20IQoxgMLL4NAcP71CsW+OsUrTinqNMMs
	 r1X/nZyfqVFVGQ5dBQz007yW4r/1ZVb3oe8Z1hd+KshG5xpDDHXRqMAvxtEj3GkBF2
	 q9hW2vIvd+5eg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso7714544a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 07:31:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9I2GytiuuzYgd55QrpmysNBQoNaQ0WwPL3+lJWv7Cm/gWCLaiNo/y8gELFgcWpYO7L1SL3MKDg3DV52lyg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8sK+RoGYXoTksj8CGr4LiSZCsqyX415hQqOgY13/u+bkF2h8
	GHslaqwnWdZSc2WCufy94LaJDm8a6gvmSKXgyo8kH5ZB+LTfWUNMaf7ymfA28LqLII3HyUCj7V6
	1LqXnkTR3GR1VDiqaUBV/vjf2Szamy5s=
X-Received: by 2002:a05:6402:4348:b0:676:9caa:f070 with SMTP id
 4fb4d7f45d1cf-67d642b23f0mr12711372a12.14.1778509913811; Mon, 11 May 2026
 07:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510171115.368494-1-charsyam@gmail.com> <20260510171115.368494-2-charsyam@gmail.com>
In-Reply-To: <20260510171115.368494-2-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 11 May 2026 23:31:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9x33GqJy82qYpfwpo-suqwCxXFFrOtB=rgmcB8Ev2O5g@mail.gmail.com>
X-Gm-Features: AVHnY4KSLF1wGEC2nLwQNBIeersMGRclzuQ83HjXbTR48TR7D2io9K6fSXP9BM8
Message-ID: <CAKYAXd9x33GqJy82qYpfwpo-suqwCxXFFrOtB=rgmcB8Ev2O5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ntfs: restore $MFT mirror contents check
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 2:11=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> check_mft_mirror() still computes the number of bytes to validate in each
> mirrored MFT record, but the actual comparison against $MFTMirr was dropp=
ed
> when the superblock code was updated.
>
> As a result, mount misses a stale or inconsistent $MFTMirr as long as bot=
h
> records pass the structural baad-record checks. Restore the comparison an=
d
> log an error when the primary $MFT record differs from its mirror copy.
>
> Returning false lets the existing mount error handling mark the volume as
> having NTFS errors and, with on_errors=3Dremount-ro, continue read-only. =
The
> default on_errors=3Dcontinue mount policy still allows the mount to proce=
ed.
>
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next.
Thanks!
