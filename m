Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62124503B
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100480; cv=none; b=me1YAxX4qB9YJ9g5P9bSE9ysLgEAKDsPlwylvDKEmZCl4tb1SXKxanvuq7ihsnv/mpd2kLnlqbpBvbOYpC/c5yIiEcuvSmqI0iphPHqgNueUmHipcOZaJb6VMDBqjM6ZmPbwhwYR41t3W+C2rZ3g1cUu7sZyws0y3LKYF1Bt6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100480; c=relaxed/simple;
	bh=bu+E9R43HOu1Aylsnvy7nXZk/d36tLwAt0Zh5idjpgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Of3ChUvsOSwaf7EZCng/SPz3k4i53G7OYrQWMQWoAQEL3qa6snzs5zrY1PlzRNG7RlkWhe/Tn2Bjm9w+lTOj2nkq5RNlkbIS7JewoBveXZwZB4A7is4t7us+TV7uRYUucm3R3QtMi+11WJdTd8QAqSlgt/rW8mmAgNCEUkFSBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7AkJtNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7AkJtNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5299D1F00899
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 00:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780100479;
	bh=bu+E9R43HOu1Aylsnvy7nXZk/d36tLwAt0Zh5idjpgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q7AkJtNdQbikE9P6CJ7M9OKGHIBQVtViEJ4EcAa6U2PmmMcdC/lNYYlMg218s7sX7
	 KIwl8IrRMqBisN5mio+Fs26a/VRTf9GRJJ26jgwnQY8HEO154YKvmTDVvpbxrZVz+/
	 SFqXH1ZkVclJgS8AsH9Yb89m1T8EVFj/f7vw62Mi5GYlvt2QmElxv7junyt9B9uczo
	 tQi1E/TykiROOJnY/lH7D2xtVORHqXwfw+DeYUkAuWz3w1poLNBAPCZeh73YTrOQPj
	 CKvi8FvMk8IkEv+qmICVW90nxwcGmIpUhI6wnK8xiydKfTN/fKoYjA5YP8JqnCPpc0
	 lqOTMxVF16I2Q==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bdb3fd39045so1312384066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 17:21:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YwcENIQD4cd1IZVlIEZUxBvJ4rkQeDM2YYzBEwk0ELpbQ1LKdka
	d5B5xICn5BOrsAN9Hb9iemlE8CYDuU4yVBP91T3pdFmuwEG1+e+nAu9uxBIjofWy/UpnKISjwYD
	zZ2OnjjhAMoH47TAJCUzQjAR/0cNozMQ=
X-Received: by 2002:a17:907:8688:b0:bd4:e590:4238 with SMTP id
 a640c23a62f3a-beab5905e3dmr88265166b.17.1780100477983; Fri, 29 May 2026
 17:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528-f-0-byte-data-v1-1-9f36f5ce39b1@gmail.com>
In-Reply-To: <20260528-f-0-byte-data-v1-1-9f36f5ce39b1@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 30 May 2026 09:21:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-9JVWX_LkpgT1FLWShoEia5F_z3Jd4fPBLySTYkmMEvQ@mail.gmail.com>
X-Gm-Features: AVHnY4IR2Tu2zM43ZLBWQp8TFlc2SkjlNC0J3nuNvw6tbSgr502LBFcSaVJqQVY
Message-ID: <CAKYAXd-9JVWX_LkpgT1FLWShoEia5F_z3Jd4fPBLySTYkmMEvQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: not change 0-byte $DATA attribute to non-resident
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 11:15=E2=80=AFAM Hyunchul Lee <hyc.lee@gmail.com> w=
rote:
>
> When ntfs_resident_attr_resize() cannot grow a resident attribute in
> place, it retries after converting other resident attributes to
> non-resident to free space in the MFT recrord.
>
> Do not select zero-length resident $DATA attributes for this conversion.
> fsck treats 0-byte non-resident $DATA attribute as corruptions.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied it to #ntfs-next.
Thanks!
