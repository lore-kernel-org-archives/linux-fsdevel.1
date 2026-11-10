Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326408;
	b=pEnLU/8NiuxebOa7iqnsq8IE5oD/1PZOJHMREokKgITdahdyI333G4zSKDlUi4XGxDu5
	 OFsxqqqrzmerGNvOte1PwMf1PnOxOyv83DQLapEgkBqrCjeC3jXfxzbQNrU+WkZy+50AO
	 5+iHr+iiD+RB8FqK5YCc7lvMGqTCBgnonDcbspxnFlAf2Xz351t+mGBiEjES6XRiPPgbK
	 liHnqsSixeeoVTgCdb0GCvMIDeJi5yiAo75P82Dk816sg0fSbCWWjsRCEeoOr77m4BpTP
	 uXj5TApAvqpWKjwX4SCVGig8E/F5LtH7y/o5glyCCpef7B9p5llMb3COOb8je5T+5yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=yoTpJiTFsgbbX5VQxcP/im2cD0EvpkANc1CUM3UG8ys=;
	b=AJSNHNLlY0XE4nGzEmr6IukgJcGKr107d16GFeXFQC3LuIb6mIRmfBFOsghUsml43RVy
	 1S6EcA4/j9Rbfuypw3dySsKgdKL8/ifo3W3nLfI+O1fotKPRtuhUchuarmYYQEVk8OK/k
	 ZKY0mzaQS787Sgp9AAsuk0arlvNtnYhvb4PuB44uRJ2lNfjzXBKbWyG2vwt+PdYWY82we
	 xTQJpCm4tegoiXXZGQO120oBkcsqtfAWQNJm2ZY30N9gOD4WiaUpBK6ydVL60BoYt67ds
	 AvOHu74yi6eSbQ+0YVHNBodLpfuSAnn2CfiRo1EqoMmg0Z7ECLJf0UGadN/RD4hbJ8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=dAVazobL;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A52606A330
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 16:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A52606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=dAVazobL
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c5059958d61so104592766b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794326406; x=1794931206; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yoTpJiTFsgbbX5VQxcP/im2cD0EvpkANc1CUM3UG8ys=;
        b=dAVazobL7WEnRD3m1GaE8/N84RuM34V6Nv8br9UB7zEuozwVtSwiRKT1eQlXVJqdt9
         WTXhaQJo13ozfXwhBUFRbTacZIVvrew4Zc0hQxhZb6/CDRC02PtOLaY00whEAdaw/iUL
         odRUyXlGB4FtAcc0gXlPLbdVPFBSdgik0Izxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794326406; x=1794931206;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yoTpJiTFsgbbX5VQxcP/im2cD0EvpkANc1CUM3UG8ys=;
        b=LTCATMv8bozJucWfuSEC4JBoI+l9iiHCUq5/e4CEp1qolNtHAuzbcx7pDwdnS5d3g9
         NeBR8s6CAg5B0Dn+jxqGt6Low5XGLgJiFizSDDdX450Oin4zkXLbl5JGnA+ccg3nfmO4
         ggvjT+5XaGEgE9YQQPCLustse7HDPQML9Uuj6bbx4O7zxLQuA71bUWsZBwOWCIJeAFUa
         uTa/DfMOy7xy+9goHhjdsvex7BTlowfP2j1dQQ4O5sVOoFiVbcJviQWN8yDu2l1yMfNS
         VBO0i4Wlw1epStr+1Qi/jxDXyF6US2QOoMazvYXGrZERPx3fC7vNjx9pSQtCkwIIFAB8
         iKwg==
X-Forwarded-Encrypted: i=1; AL+hErHMhuT2JOzVulACw5WTF/HeBMZxKZl47IfRHeDMqCQT1Tut0pQr0Fj/V6PEQ3qwrZ38BocyZPkbeMZjAEJa@vger.kernel.org
X-Gm-Message-State: APuU4Z8NdILH27zFf4ve4/Ou4czqgwBgZx66DlBERXMf/0ArDgcbcmk7
	lR/z6At9GBMeX1BLigjFjd4YSE5ZO8YlogVTX6qp22LlCfhRjODeDrbDEYnwXOY42tXSciaJaKN
	DYE5v0D5PpA==
X-Gm-Gg: AYBFou0fgGsAN0gUNKmHjDsE95QvL7CpnrAjYZb2afrSktUBOTN9YY3pdi1JLEZrjmY
	3dcqT61zb9j1PA6B41Qbae7UE++OWaGCxXdKaFLpA3gqoYNeRlWAwv+BQ1dH5FL+jJSX0V3TCwU
	7N/QgndIGzt172qAjY+dPxAqUJdTjkeuXjxy5o0A2xAdL9qnuz45Sc6Kp/cnkYYeW3rz5d9bSuH
	cxZZoLzJMPNgw9vRgfdZqqF/w6Kf+O89uoyGCWZdP8DY/InfglafwjBDYV2eTjKhoFWLAhPaHWa
	cpHP/hwDVWs6arxQeakKcucgyBZL6KGwdxnZLUjV44IcXSoLyKJBgSDcdkTOw0bun+nklzOQcRV
	7i73M/uFZ0KlN7IIiKuf7SSrpgMLxbUMknb2QiG3tmnNKzRLQXDzX/5O0QzaIX539xiNgVtexOg
	9FliSEImlsPUwHefYV8ggBUr88D3c3WMqFfXpHqX8y5nUsNZxuph1Kmfp0+hQW4OiYPxE6L25Sf
	V5ZyZY6g2ZURiom916EkrGUcwXMl3wURb1mSFFsa/dQogQi0P0yMjae9W7HjeW2c1Z8FzmhlNtZ
	xnRFtiBEOiK64DxKodc0GMrxd+LeuciDZWOanNSI4DItX8/S3MP2L0f7qBSHPRqNc10EyihN6Nq
	eKzE=
X-Received: by 2002:a17:907:9349:b0:c4d:939:526b with SMTP id a640c23a62f3a-c5062ca32b7mr8952966b.0.1794326405514;
        Tue, 10 Nov 2026 08:00:05 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a6909sm128381466b.1.2026.11.10.08.00.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:00:04 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b58cb69927so3466316a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 08:00:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEKL0E0kkbhS7q66ClzRTuNrD2Xxki88uwmN4/mRnuz07Ngy7SZeSD+Ym2IFaczVELy3s22Zl7sAvb2jAcF@vger.kernel.org
X-Received: by 2002:a17:907:1b16:b0:c49:b6db:1 with SMTP id
 a640c23a62f3a-c50633ba346mr907966b.12.1794326403910; Tue, 10 Nov 2026
 08:00:03 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org>
In-Reply-To: <20261110145241.536019-1-kas@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 Nov 2026 07:59:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPq1g-kt_n4-crr0qs3rBNkat5OgLxLLeMjKirevRuSA@mail.gmail.com>
X-Gm-Features: AclHuK-OUBoi1ZcEDjO00AEWOGxItrkKuC6wgZXx5y_lLM7MJshUB6roN-XGzXI
Message-ID: <CAHk-=wgPq1g-kt_n4-crr0qs3rBNkat5OgLxLLeMjKirevRuSA@mail.gmail.com>
Subject: Re: [PATCH 0/4] splice: remove pipe buffer stealing
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 at 06:52, Kiryl Shutsemau (Meta) <kas@kernel.org> wrote:
>
>  11 files changed, 26 insertions(+), 360 deletions(-)

Ack. Lovely. I'm considering just taking this as-is now, rather than
delaying it. Comments?

               Linus
