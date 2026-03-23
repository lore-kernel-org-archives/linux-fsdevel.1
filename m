Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F404C19EED3
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774227209; cv=pass; b=bn7kE3BRL00S8e4gMqgogAcCWxOBVRr3ZKW3Rym3K9tPUyd59a4raoVjmo9I1chTCcHRo9qsH63N7p7ZH18EQGk8bjryiXrAPfGg2gmA7v2IKxY59W5bFuYab2xDmT1MqMJ0IAF/Et+MAeqnKlXvZimsg+ozR+CBkzNkpoZF45Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774227209; c=relaxed/simple;
	bh=rRhGncVzOuqtvNEIm7RC8peMNae0fGmlnYmGiKI+kL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bn0laUL1dYDMfb8Ai4eCi75fVu5lz/2lqBv1TdEkS8N+zp0f6O6aWmAG3s2GXp9pmwPa+6yN7Fo406g/h9zUkbxcLwlhiKptClL4CZ+53Of2l7eHto9Nga2Db4STVvUrEK1pmQZ+188UZRj9FYir8U73APlLybhQVJYTZov682Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aBMa//k1; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aBMa//k1"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82c2239140aso714684b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 17:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774227206; cv=none;
        d=google.com; s=arc-20240605;
        b=hM5v0YVVit7K9s4nlrlTPtLuFSC7HTtl9+qYGETTdoaYB8yD4Cr9UEYSRgsBqaqWEM
         n9p2c8vgx8RSyd8dxVPVbzVoxtFxRby/cLgzdo8cSRUvlCMPLbukwQ7kvf4oVhAqtfsX
         dZZsoR/cMoeZGnG316eb/3OIprpDDWomU0H2Co7tQJxeUu5j+NuXUo6DSzpkdQLiz2dD
         czSUxH29xTMbLMYy/wBhu4TUy1f627ZNlRUH1q3GEEx22nYSmqIkISFcVcsSri/DwbvC
         HnQ3g/Slmu2K72vOGwNe8btKBRXUDBHManhO3WAbwCJRkc7pfQWbTHYh6Hs7szL0j/PN
         jJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ggzNGz/SGUWadMqqe4YJLZfPXqSPbNVa/hSKTjsrBp0=;
        fh=tdg2iyk02BxI/bthgvnR4lW5DI3MgMKTSpNk/591DWQ=;
        b=ZcKC4TAAyXqha6V+4MD1oHOPsoONNQ8Xb8nX2QluhM4rVXA7Tr3KfTVZxEOueLIx3k
         /cabwu+nkRVjXnDfsWbYpKN0kUgoEoTPiQqwBEPvYeME5aWi8Iyjun8aTj8N6MkruAv2
         GYQ8MORQdr4xA92z1TH7pK8Nkp6EYw5zGOR3KVWu9huC2wRItSCJvfFdicBbEtucFNV8
         u2/R8En2FtsNTl+DP0poGONpuBCj6baqQbskvjC90uW8Ip7ifWhDNESDudSP4nu9JLK+
         5xuMKyuNq3TFx1S8gCIc22dnrjZs+rczE5nSmsMMWXYqLpaKMaaCbVpqmgMutR2R5g/s
         SOrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774227206; x=1774832006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggzNGz/SGUWadMqqe4YJLZfPXqSPbNVa/hSKTjsrBp0=;
        b=aBMa//k1cXpGjQa+ngHUXwJbYFLu3yVR93eow8osXDJnX5UhHe9bjC7v1t7GlH9tYc
         vhbXGKorSbcgrFqT2utr+TzYJ0YnQ5ieH1NE7UzCXsuiCUABpgT+Hh9USiqrsaqeW5EP
         RkbVTQLuxr/KRFD+3pEwuuCF8gX8+exlqCYFIJ/HiUQbMwWvgJbF+gHAcNLC7VAjTacQ
         xSVY4MzrDIiJES4PBPExpJhvqleOEXPUewlqacJ44D934nKzWGFJ5AcGmcBrpSjkBdEd
         fQ7brbAceCYRSIPwjGYVIIWYBC6qgSqbxgEdKi8OrNRnOrF2qgEjGUQ8iPDpYju+SFPA
         poFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774227206; x=1774832006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ggzNGz/SGUWadMqqe4YJLZfPXqSPbNVa/hSKTjsrBp0=;
        b=lbR90R1zCsXJwYnCB5YLm/GlGbQTiu1us4bgeGJE1BJhCG2imQqNu8uY74UAbOo4CT
         278DB6gH4w1CwkHsBiDtJzxmyKzH+LQ8godxNYUz6Dz5HI/9hxc4hjGaR3gscRBUTqDy
         5CXXev9pK1Tv7qTmDXroHyxbG8FSC6qxo5av+qgeYLq18Ba8781xVOvw2e/D1OHe2XcO
         g14k6ZIdwJCpUHGb3g5bwdIj3P33+0aFY1ygpzIFlMdOLGWniQ1GKcUiPUdSY0yA/O0m
         KlRvCK4xYJw0zvB62bi4p3RNkicDo+cz0dcxxsTTSWh5EpQSCwQ5CQuR8BiO5m/P5SKE
         WFiA==
X-Forwarded-Encrypted: i=1; AJvYcCXDxPbiRrO6TV8ruiWrOqhHzalvvXQtzR9JQt5I9xIewSij+fMeb9LCDlrwoH0zLtos7sVbdreWuByZKFWa@vger.kernel.org
X-Gm-Message-State: AOJu0YzA94WVfgk1t0yWvQahN0XoGriuyQ6raCNQvq2ERW+Hp+5TUYb/
	IwYK4q9hUZnxW0kJKxiG54ngQ65Ut7XYgRK51NlAZBZ9sBmvWEU5wkfkAAA78EWAyHCPa7bFhT8
	UXbThVbpXulFevcZFnU5OvTHxthRRfElH4pVlMTws
X-Gm-Gg: ATEYQzySkI7bHngc6B4OX7zTWAvaoDGsKFIiXoU2X9cpjINCRAdwYN7HFChM3/bDGkV
	bOWB9mXgNCx1/PYluM9jhH5vArDwPomBI/+84R3NDIo3dkt2psV57C0GPHkM+p17J8XfBoWo95F
	8CFoSfpJO4bA+l/O62iRjynh5G0ArtgULnMJ7EAjB2Hs6NBnDl1rAr1My6gWxL8FtT2e0cvYN3k
	NKTpp3n449tcaU5UYO9o577bKSB+AXAeEC5GzFEK5yLFel0fOeKu2MSS+QyZ1jvE0TJegdA0kG8
	XRZAuUs=
X-Received: by 2002:a05:6a21:6da6:b0:398:7ffe:472f with SMTP id
 adf61e73a8af0-39bce97cfd8mr9154922637.2.1774227206233; Sun, 22 Mar 2026
 17:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322232655.1164614-1-ethantidmore06@gmail.com>
In-Reply-To: <20260322232655.1164614-1-ethantidmore06@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 22 Mar 2026 20:53:13 -0400
X-Gm-Features: AaiRm51meZRf6qx-sbzP8U1o5Lk6inEYXTppkqRsf2IKSxXxqx_EBlN2bmo12dU
Message-ID: <CAHC9VhQ61k3_PfqP_uDeQ22oqrw4vjv=Ej=e-ffj41UaJdeXWA@mail.gmail.com>
Subject: Re: [PATCH] backing_file: Fix error code swallow
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 7:27=E2=80=AFPM Ethan Tidmore <ethantidmore06@gmail=
.com> wrote:
>
> The macro WARN_ON() returns true if the condition inside is true. So if
> there is an error with vfs_open() 1 is returned.
>
> Capture the return value of vfs_open() then run WARN_ON() on it.
>
> Detected by Smatch:
> fs/backing-file.c:52 backing_file_open() warn:
> passing positive error code '1' to 'ERR_PTR'
>
> fs/backing-file.c:77 backing_tmpfile_open() warn:
> passing positive error code '1' to 'ERR_PTR'
>
> Fixes: 7ea30795d6b7d ("backing_file: store user_path_file")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>  fs/file_table.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Due to other discussions (see the related threads) I have removed the
patch{set} this targets from lsm/{stable-7.0,next}.

--=20
paul-moore.com
