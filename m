Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01247175A64
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715821; cv=none; b=SUaj/A8nl1cG6qCeV6OOQVspw1kdSDLfX8vlkxZksdvsligMC/p7IzxIsDce1TWBBgnNaUwYKgrZ//aDnOnfQAgq+/GbA6crpe0tNg1Z4duzxE/hR4FxATwwy00JcxeyPrEN7RLXuFL14UAyMOojD8sEUSig/lKqO9tWVvfB5lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715821; c=relaxed/simple;
	bh=+LE52oPYdPYqQd3xiD5X5H7b4w7Tq8xATIljQAJRUZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpmAWLqVeMZiYOhI6YUC6hM4boMjB5v1CkG3MocIIaiVj87gUsSmv/P4KRufyny6dUfBgHxO4hVwQjNbV/VPUzexZfpyTmQOB7dmbfTTtaEhqkVbmiRxMP0Bvob1V8AoSTf46bVU+cjjfAVSMxAnWF5l/lOEUbXtMIIwSsaHhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3qVESTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3qVESTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A901BC2BCFF
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 23:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778715820;
	bh=+LE52oPYdPYqQd3xiD5X5H7b4w7Tq8xATIljQAJRUZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S3qVESTrJwjYG6krGkXSBRYJHBUZiEnmkqQC4wNHhVq67/cMKbW9QulEiEwR3azHx
	 dhfPztLP4NQG0lP2Fy8hg+hPwZeuuojc/k2DKyMaTNm4a/tP3draNXecDtr56QDnYR
	 q/QPlwmgfcNQy2EpDFZ2chSy1pM0PDuH4jxrkkTsqnbI8KmI79kwClSK+S7aqL2M+4
	 EZrvxH+5WQpIaPrzhPiVWfsGJ1TNHHTd9R3kvFE64b2WOiXNUb2j5UtJtM7AQGv7DU
	 zz/t0lUnyTwfzgN3c3wp8fnJFgJOvb9BRTp8Ka1JfZBDOBObKACqPatt3Xluu2kVRc
	 uNmd69UD2LqWQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9358bc9c50so1130305566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 16:43:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/9F5ZzvlOWlypWTg7EfBIJz4uKeq/IQ1Bd+B3QlXA6wUJq9ytESG+TP/dDqe8Gxrgy84oF+DTRybq0j/Ei@vger.kernel.org
X-Gm-Message-State: AOJu0YydCUh70bg4COgFLV1YQ0VlvNZ7mxryqaIRdyQ0xsPrqDvpyyii
	qLTByhxPpxcB2nYjl/DwGeK+tU5r80pXGeFWVGCHZoZ1MDX6eTLKDSG9xKYSaccH6yzaNUGxVQ/
	GRKVQED/RFnG0S1I3xu16Tw32Nt+UlYU=
X-Received: by 2002:a17:907:60d1:b0:bcb:4046:63ee with SMTP id
 a640c23a62f3a-bd3e2dbdbe5mr329706966b.31.1778715819139; Wed, 13 May 2026
 16:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513112156.9122-1-linkinjeon@kernel.org> <20260513112156.9122-7-linkinjeon@kernel.org>
 <CAMrLSE5gy79ph8B_di8GpzzNSsvyOporLMFTSP3QPSroa5UK+A@mail.gmail.com>
In-Reply-To: <CAMrLSE5gy79ph8B_di8GpzzNSsvyOporLMFTSP3QPSroa5UK+A@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 14 May 2026 08:43:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-iJSecgj1zo-rt+4Y+mW+riXWLB4B3VpiJML+iOWUedA@mail.gmail.com>
X-Gm-Features: AVHnY4JGuENkgdsWu8etMUxrPhQ622CM3wnbYde6TBYhCrD55cQb6M9vSWThQxU
Message-ID: <CAKYAXd-iJSecgj1zo-rt+4Y+mW+riXWLB4B3VpiJML+iOWUedA@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] exfat: add data_start_bytes and
 exfat_cluster_to_phys() helper
To: CharSyam <charsyam@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	chizhiling@163.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 12:17=E2=80=AFAM CharSyam <charsyam@gmail.com> wrot=
e:
>
> Hi, Namjae.
>
> The calculation looks correct to me. I just have a minor naming suggestio=
n:
> since this helper returns a byte offset, while exFAT already has
> exfat_cluster_to_sector() for sector-based addresses, would it be clearer=
 to
> name this helper exfat_cluster_to_phys_bytes()?
Okay, I will update it.
Thanks for the review!
