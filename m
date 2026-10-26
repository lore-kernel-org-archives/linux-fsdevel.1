Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057499;
	b=owCckunh29E/u34HOphJhyUW85kcixHzSuYc5KMsEOb3+IC4H2Ug+IQrn+ipYHCE/1wL
	 25qCUz0BxGu1igmrYh0LS5jcc2bunjNv23HaKdHCP4HCUzAkl38BT6kHilgixgxXNkmCS
	 PH1AFGVUcsbERwxw9lGYnSiZkNG0ns4U2yEkTgI5xa4+Y8J2HGdGjImd3sj9k7BPWxspb
	 rEtj6qkCoo354cNSN3yDfEP8uDXn7Fnf33A3431pRyY0dfo+KQrbZfjF23tsxC7ptHHZT
	 TyBIBPYp7PkIGd1UeTCROKro4h+biYMMrrYXs/TOMqHkuU1cztiqJx4fTy7pDttY6Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
	b=r9id45jj12tO+KuQJqp2LHJhv9d5tCToCHLKR0RGoggzcGxE3eHd3KDjb/Jx4JMy7WSC
	 rzC1tTsGiUUc2rGpztidWpwgmWOz2vxU+1V6ldOpFXNc5qGCCFznbkWd1rj/uxdwzkL/Y
	 602boyCOy+XnY+LCbRt2LxTyxcrsc0hOO49/m+p/PSEtCNRZZSFOKOYss7RuEcHLoPibT
	 33wRKqpGTpS2U7hVJInyo3nhV9J0zZb9caVvjJcxyga1Eg21LVPyze7Xreisf5t4o8o9Y
	 WIrgtm6a2LjMtRz9QHFyw1E8LVOKNKrj0L+43hkyuO5K8NL0zXGRqVbb7Izb3sAsnFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="NV/brdlI";
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ED0606A324
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 23:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41ED0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NV/brdlI
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ea0efd636dso28202985ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057499; x=1793662299; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
        b=NV/brdlIm/TuLhSF4NjeqNzM1PHfukJQnnGZ9bTpCILFizEdQUMsFtq7b5UMvLbjVa
         kxM811X6dWeM+zRT1gLhyyoBW2AXk9+oEm2z57RGUs1hn7oZvQNq7XV2HCrlhJde/HQV
         x5JcXglSOlEL7r82xWwt8HWzIyfCCM+Fg7vz5VItHODO7Ph3YdkCRyPnbRl6JqVOpL72
         AnGWWK0u9voc96aqUrn7GzvY1TcacWupUg0DdfWWRf03Qp00sf0OmelsWZfX9u6qb5yQ
         QCDFOCuUTy/G7BMfglpUlV9odeFRZhR7zjY3xDWStpxqyViOoVqufwZPc7J7LWpXtgzF
         K0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057499; x=1793662299;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
        b=FO4mXw/bzPLGJKpb01kcqoWAVMc1XaqqJn4o9b1sq2BgqQVOghVlLTyi50mQSNX5yN
         XDZ17uraAuESLw0WHNIXia0+/9L5l4vkrK0tdS8RWWOMYUuSqdiTT5FlkhnT76+Lz+M1
         MeBcAZ+RMlXpALQFXa/OglJF16Qr1C5BOgfO3fXyWjBn5iC5w+haXyY3TYZaBSlDuTdZ
         /Cfr2jQGbSfMFO0CJRfTWZOivQ8Ia6gCFO9FoSTcU5EAChyjG22Ve+5N8qHwo0sF9Uvn
         QdzlfE3eTk9x67b08CeBlhvISCU2O45bPmiOK20bQQvttwrrxpPm0zSbg6iubOYl2khH
         Vr0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxxNNuWFUJ0bakVtPtjL4uXiReO8jnpM1lEcJi1J+cYYc3UnOnhKkNIWpNjvUjbc1SKwmx4NiVOvwCG/ysj@vger.kernel.org
X-Gm-Message-State: AFq9FYIYD4WF0Ucjwag+W+8a8mOh0g2/q2xd3isZIzz/mCWW2T0ZVuIH
	s0fAFcTZj6SMjy86XvN4Ym0etRyBmUtSG6X9eCwKwB9TgJCqMUAbbC6Y
X-Gm-Gg: AYBFou2qQuRfQMDTvsJmoHHd3CKOQNGf+JeBZUQOIxMm99KRLu9vOCzZDFQeMJbVPmY
	yrr7HRxsN5ARajjlGmwFjroK5tw5Osl7R/NhGSrM9AhWTDtQ3ux3e+mnpYvbqCvO7+uONyU19fp
	gTf6QDsDf7voQoXxhMrSIyPPTSkFYEqtz5NL80WOb5+ch2+qLvYPYAqtd4nayfeQM5Tganyxh30
	F8nN1wzvrQbEjWQhZwG35cJe/aXqQxrYkMmfyfeYA0tvK5+nRJV+XMMgEch83NsX99OD0ZVfqtu
	YT1APXJG4OKlBDb5iWnQFBSq5b5Bg3b8NOV77KI6UEjByWU5XK44JcSJddcKEXnXF574k5jEM6a
	TaqKLvO+ROq9VbFoWn3gKzxDhEr9bDxIf3X+OVR9m710pEI430O7NJT6k/nsZkGzkBhpimjpw3p
	2bZnu08dHgaMpekur9Syc7Fq1Ww7wcmDTAhF0SCSmJpS5grqz+R9Fjt57Cuyx6xVm7gbQV8dsbJ
	3RELdDrcBOmdSEG84jVT3XNF7A1usWidLtRM5P4E8f+OyuD+tKN2iH+rucvvH6ZLqCLunCGSSD1
	j71JvuNWKVxtaXmKw3AvvNHvfgnkYcMhaAJCHRnxmPOQt7OLZvS2CbmTZy6ccUEwCTZOihCcrq9
	1hik/o+c=
X-Received: by 2002:a17:90b:528c:b0:3ac:8897:7b9d with SMTP id 98e67ed59e1d1-3ade9b2ee97mr7287988a91.1.1793057494026;
        Mon, 26 Oct 2026 16:31:34 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba38910sm6631220a91.1.2026.10.26.16.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 16:31:33 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 23:31:32 +0000
Message-Id: <DMF5U0PAK4HE.2QQ66SZMEMQLA@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <bpf@vger.kernel.org>
Cc: <linux-security-module@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Paul Moore" <paul@paul-moore.com>,
 <netdev@vger.kernel.org>, <stable@kernel.org>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Oct 26, 2026 at 02:57 AM Christian Brauner <brauner@kernel.org> wrote:
> I'd want to get the first three patches into v7.4 since the hooks are
> new this cycle. The systemd change I have for this uses the
> namespace_free hook whenever the kernel has it. On a kernel with the
> hook but without the first fix it would never learn about dead user
> namespaces.

Why not the whole series?
Otherwise 7.4 will be the only release where namespace_init sees
ns_id == 0 and bpf progs that key by it will have to deal with that.
Also the test for patch 1 is in patch 8 and it needs patch 5.

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
