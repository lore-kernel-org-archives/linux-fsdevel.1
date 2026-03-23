Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70693279917
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 03:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774237700; cv=pass; b=CDA44hUf3xqQAEkEvrRbcqGWliMAkofhmbolWIv0+Tfq7rd8wOGps0IhCq9TUBrWcQ+czljGNl9ldCkrvdc5wrIumNIwwr6xbji7hsPXJQt0OxtBMVR48hF2XJq5IGwdCI1+udHHf/FReNFMbXNXtxJMMifjRNAGFzXXJUwtbzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774237700; c=relaxed/simple;
	bh=Q0mI2TwYycM5sgLrcd1zuOS4TrakRSO20fAXPQ2Ywts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTM3QRj4iX+Ygktz5QpBskvDLrJoTZFZl5jo/6Gg76lnM/MOnF5a5DMG5g7bWfkslUfQ6VaEJVLWz5xmkIQJlTY7sH4fzpEVM5w3n+kKxDE4KeDzonmTHJgonq8g5YPGOQSJuFFF3djH8uY6LNFXMed9KvrokQBObMFYYwfkxNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRKnIKUq; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRKnIKUq"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64c9707fc11so1476353d50.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 20:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774237698; cv=none;
        d=google.com; s=arc-20240605;
        b=K+1LiLwt/rgf72lgq5hyf1yruKMUtdc8H9sWdQ18D3vmE5euUqsEv6Eqifk0lqFeKZ
         xmj606EpkNujlFYPgFEKPz6LHqX38MM7+Q74/McalgPOXPHNof0Ovry5/CDqHAd+OQlZ
         fgM7I982VGzl2Q5lw2HMxC88U/MXrUKvaSWzP8+1WZWKiic5IhkeQvz7gdpWzvsQwrNo
         TWfp/SLCVM2wJrup1hwGYdMr8t4aehsrTuHpThwJqvP5ik+s6wLO+ripM/6mMTlAqHqe
         y8VRcYa9HZjV6AarwD9ImfLe+I7Mr6AnzKf/qKuTJM+0nwlMDe3BeduhffPscLvc9sB3
         9QPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q0mI2TwYycM5sgLrcd1zuOS4TrakRSO20fAXPQ2Ywts=;
        fh=zyJLYgI5LNw5cRQR6fJ/NAOgTwa4g/1qGlA3kSW3+mk=;
        b=CH67TEa4kOtJgGO2B68whTA9KYLgYuUMstuT8g0I4e7tHMA/F11YwpGxrZpcsG+AfJ
         WHu0kMP9YNpefWzt9IUKnunLnhDcE4RnC4iKOyCYykNgN66cqL+WfBYHVM9Sle7YTF82
         CmCofFlE8cudRvQZzkEwZ7SjR+KZtmMLShRfJbc5O9j6oCA6HZz8JOnay2mCZYtYGMvp
         bN+6hScNm3n6XmGMhwUY0s9+2MBU73P/sTZ/akhswAGq1vl2Zu9akWADyZn6MBGhbCHB
         8xYeyGEvB1rxeAGrMErWll5PVgcPHu8KM9AxhPO9tAf2DsBZlbOIYTCH5Wx4ZEjSnh0I
         aVEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774237698; x=1774842498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0mI2TwYycM5sgLrcd1zuOS4TrakRSO20fAXPQ2Ywts=;
        b=ZRKnIKUqHlbu9S4/u3j72jUfqdIoL18PVg5Gmli8BuuuKRm2xQKLnConJjZ1oFlk3Y
         xGs1kNsepaYHj5wv7m0TsRAyRPGrVz9SGMLsB+Lj5tYpR4yjT2LdeJNcNOhJlMmyR1Kj
         Po0s5IilZHVTbFvR0vgnUUDHbbDcEK6I7yZPXW1kpSe313JkD34rhMbCgTSCrACZbzSp
         eIjNLhNUsvr8vNQ6JVbOJoBuymfDGbIOT0W26KE1nbWwwVwvH8L0X8/dZvbpsNqI10A2
         tgJESBzL5i5r/iwAyvU5VlDcNlu16pshZV4YgDeSfA8KGNv3Pn3OY8q+Mw2OYX+9WDac
         YNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774237698; x=1774842498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0mI2TwYycM5sgLrcd1zuOS4TrakRSO20fAXPQ2Ywts=;
        b=C0tDqSJ3BKmli+MD+WoZL79Hc50l77OuCFHQ0BqeUwLFEayJLFjr/WBu+auxCA6yMW
         Dq7igIJaEk6a8c63Lqss8uJwdl89vYSJIyzH02GHVwRXvcNoFyLkO0Sbw5MfKrkRamQE
         o9fmjz53GoBbtZgW/ng547aiKpC9N5ngMZ3JBRS6nxdaLmXaMiM3D9ey8Cbm8QXNU8r/
         2uGJrfbgJVyujN+wHomznxslG3A+bYvwYsweRP+uHyd81IomCsXtHSoOrtvd5TrOPs/Z
         D1eLwNmog9gxOje5mTZxMkvbOQrXQnirfpRRp2W63jaD/qC59EXSZ0FFSKHOkc3Hoz+S
         49lg==
X-Forwarded-Encrypted: i=1; AJvYcCWAvOe6HRUsQZEOqe9EyrPYbyVlkzMA8igj5X2WMjblf7pcqa3Yfrlr0zDNWpCQUwzl+BwhaWtGTHW2oh+3@vger.kernel.org
X-Gm-Message-State: AOJu0YwnrlkP0BZe6Bt4bvFyK5kA2WynWxfUGI+pjA66b+I/tzg0rKHJ
	bfmCMIenN/w0flv+bh7951FusgC4wywKQj5u3gU8y/bgHS14Is7m+VQh05PPEcLphCzYifvp6y3
	uNL0SOHPcj6fCa9k3J4wpki3uQS7cmrA=
X-Gm-Gg: ATEYQzwcpwT4pNj8LKA41Sh8knuV1ps5kPcHbIdEtU+jHlKWIV7UKGIIp3rs1zaJ5qD
	LN4+IwJGn48JZeMBIJPJ6zK5Pg17fpXNjBs6K8yk29Y8Pu3mU2K6PINmcim3Q3egCZW/No4uLth
	vWpj1PUGlkguRV+c6G+PT9SxYcAssSn1Ma8CuSZ0M6IObU1gvsrIslZOStrlSkfcZ4PJZrDA5TF
	+nOl0OWD31QWM+65lk+GyJ9NdFY3bvhbB+TVMZTu+HQTEogT7ww1F1AD+h+wSRXIwhBGsFb4QsQ
	qcbmM3c=
X-Received: by 2002:a05:690e:429b:10b0:64a:ec39:dd4b with SMTP id
 956f58d0204a3-64eaa7deab5mr8770494d50.43.1774237698447; Sun, 22 Mar 2026
 20:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd45c86c-e1ea-4995-bb00-df83cc873105@landley.net>
 <20260307032258.2857157-1-safinaskar@gmail.com> <54f06055-c5ca-4b8f-9aed-065755e7c1b2@landley.net>
In-Reply-To: <54f06055-c5ca-4b8f-9aed-065755e7c1b2@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 23 Mar 2026 06:47:42 +0300
X-Gm-Features: AQROBzB-PQlqF6OH6A_aRUOwM_KQYLR0utQ15-12H2PLD6u8em4oEuDUzIPNaAM
Message-ID: <CAPnZJGAOPV26Owic+MoMUFaJVoofhLOjfmtVi2fi2GwtrVssYA@mail.gmail.com>
Subject: Re: [PATCH 0/2] init: ensure that /dev/console and /dev/null are
 (nearly) always available in initramfs
To: Rob Landley <rob@landley.net>
Cc: brauner@kernel.org, ddiss@suse.de, initramfs@vger.kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, nsc@kernel.org, 
	patches@lists.linux.dev, rdunlap@infradead.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 3:51=E2=80=AFPM Rob Landley <rob@landley.net> wrote=
:
>
> On 3/6/26 21:22, Askar Safin wrote:
> > Rob, I kindly ask you to test this solution to your problems:
> >
> > https://lore.kernel.org/all/CAPnZJGDDonspVK1WxDac2omkLJVX=3D_1Tybn4ne+s=
f3KyaAuofA@mail.gmail.com/
>
> Your earlier suggestion that at some point they fixed the kernel build
> so I can go "/path/to/dir /path/to/file.txt" (which didn't _used_ to
> work, I tested it way back when) would presumably solve my problem
> without kernel patches.

Cool! Please, write me when you actually test this.

--=20
Askar Safin
