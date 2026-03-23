Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B83AF65D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277539; cv=none; b=ZmFqyhaVEUDkb5cShfBoPNTiLiQdRoACYNI8QfP5FgCSrVr4QdC9Lfnq2xwBPN/zJ9s7GFbzX1xJNc9vz0Vg7av9LBH4Fyvf2JbMU27heOVyXD3BvU3PX8truYFZHSO1elU2XRnYnYmBhPYiD6J/dB0mE9defsByCa5J/LvSXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277539; c=relaxed/simple;
	bh=4UUjsSTX00Z3UIhHAHgx7Z/OnRnZL3xaxGeAqI2MLAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruCr7FDjV1E60BKIpb2b8T2dNRPxNI8i7aGi1jmwRCrJyg2Id6O71MuXV60Muh328jlV2BQGcN7LTP5Ks5zOyuNUb9J94IdX1+nsS+i/P8avo1N2IbmcNREl39fHe9Xq3QNYtZn4pGtK2g8BVef5IOTVgVdtkwllRn0IpxYcYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJ5dGrzO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJ5dGrzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5FBC2BCB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774277539;
	bh=4UUjsSTX00Z3UIhHAHgx7Z/OnRnZL3xaxGeAqI2MLAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vJ5dGrzOcXoh3fNeCoJxqhD1C8VLV7EgtD4cg3GBTveNBtCr5I0J0ipubmFOgvB7c
	 9qIwkNbW+dM9nLAu0rem1jf9rfXKeOGBx847qddxgztULDd6vogiruj0H14dxKP/zm
	 iLY0Z9MM2VPL36i1qhERDqt6zIMiQv6rzUshH4iAU62Rs53PsT95r4AFg8AZ8m9d7v
	 9A6tPKgHT8KahijgQPcrdQ6HGAcA7Vn88kaG21dmnZf8SNSze0+1kXcQ737516llOx
	 SI57BcCzfxjIDYFfRz1DFSlIDBRmPwIMplHg0zZKXKhcMIngFTTcBqLgqt1H/yY5TO
	 o1MpCbyh8A3Sg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-668c60b8f45so5346959a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 07:52:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVshGxKxiQeG+5wV9SdOUslRD38HmKa55kz3c/BArVM/pM0zXjUnmuj+YA4oYjPtV2a4j788CUqQOrFJ84@vger.kernel.org
X-Gm-Message-State: AOJu0YxaK4pl5jR1iCridQtxzfNgG3Mgzzwc5TuttPKFHXM8VVfITkHs
	7vcdOusrxmVWXlWry6FPszq8/BSftAMmZ3LANQ2p9H3qwFv85U6o1j7Kv3DDTBaPvYQfmv78b+y
	l1/UjZpkkEP8uvxzNQ1SurQp+YcA/9fk=
X-Received: by 2002:a05:6402:524c:b0:668:368b:38d3 with SMTP id
 4fb4d7f45d1cf-668c971df93mr8589561a12.12.1774277537791; Mon, 23 Mar 2026
 07:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322153206.218-1-anmuxixixi@gmail.com>
In-Reply-To: <20260322153206.218-1-anmuxixixi@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 23 Mar 2026 23:52:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-LhB6JzrVPxsrv22T39FNy_QSic2U5HnXGD90ofaWRZw@mail.gmail.com>
X-Gm-Features: AQROBzBljV1W55_kkxfJQBWTp0rc10BTsegoqn_GKELXQN3gi6-JH0C46JQ8bwo
Message-ID: <CAKYAXd-LhB6JzrVPxsrv22T39FNy_QSic2U5HnXGD90ofaWRZw@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix passing zero to ERR_PTR() in exfat_mkdir()
To: Yang Wen <anmuxixixi@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:32=E2=80=AFAM Yang Wen <anmuxixixi@gmail.com> wr=
ote:
>
> Detected by Smatch.
>
> namei.c:890 exfat_mkdir() warn:
>         passing zero to 'ERR_PTR'
>
> Signed-off-by: Yang Wen <anmuxixixi@gmail.com>
Applied it to #dev.
Thanks!
