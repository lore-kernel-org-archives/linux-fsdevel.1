Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795518852;
	b=l09cYp0OZGFnoF7PDp815r/gM3eGGJQIeD8xlrkhUv/Jv0IIyNvZh4t+inYkrbDFnXN6
	 WSgGpxuS+0whCst+2yqeq07SSQBnN5LKsYMWAiKl0Iif3cwksUaU8I/PBnLsrSIJtYGcE
	 /OG9Yr2M2XtHz+IPlEerXo9zDPjFKmMF6ul0jIjB6/magRhi5l2oy206t9XsvVGmHZela
	 k95miQY3/l82cBQuHXXCXqj7NXXKnWkF6cuCkBc2dAKaSpmqKWm0k9I3iUhHCxPaA1+NT
	 2xQ6JyCVDpk8pV2qkfmZBN+M9wH0x6UX0G13mi0L9AfetWl9M4AKRojS7rutLaqzYMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
	b=4zK8M6rc549K2Z3cBRVDeh419/SoYtK0nwS8U/fdO0O6UI07XnrrCojXIeVXo2/s38FP
	 VT9YFgt0PFWzLmGGPfayxQTpm1IsjEe8nEjUq8RpLbtey+G8aHaN56GWuE+VS1+r/lXia
	 /sDH2qbit0pUgV8vLWHIKBOrR6MpSlh6bIzAn8LoHpTPmD9tDCaMPdWzuq82FlIg5Tjmn
	 oEnlPEhLqlNR9ZJOjf3Kp2CXjYmi7R9a28ukrfL+sAmWGG1wBWqsu/J+U784vQjcvL5VY
	 i96SWYfdJ8wV+ZQc2Izr5y9yXRW3GYLfBLMUX9bMHWOD7be4LpSoH20rih98j2Z/WtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b="h/p4yZ02";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C96606A33F
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33C96606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=h/p4yZ02
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9496473b511so524142085a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 03:14:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795518851; cv=none;
        d=google.com; s=arc-20260327;
        b=F0rOXNNJapMMw80k9v94jKQKCTDw2r7kG7WV/E1BUgqrBuvxzxibtRhMa7VRgiyYVt
         KSuKz9ThhnNX8z057zxi3gzvQN/vCrigWPD8qVt9IMEOG4ZZM2MxsDka7JOLuFEWjw+l
         NdmvUiJvhJmo3krqGzGbHGkd1OuGLxqI/GbVJ1p9C61NNmHvDBW+wZuVGoKfMfk5tKyW
         ix4aU+Q7J4x6CIgaEcYSuCWSo3cDe0JPXFzdOz9bRutRfiIjG5ExBGGrxQlTe9chqswq
         sgQ2YGYdRjkdl0w9bhpiXobzKJkEwod0MQUrcKvPJwfd0f5705PyCqwDRGQv3OHtmduv
         Y63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
        fh=IOL/Vw5nK8BTVDes1hga8sK1hR9Smjr+u7/onG9r6lY=;
        b=ePxaKy5nm6131p5Zsc/pgti762O1cmr6mf/G+lfvpWQMOIy8J9wTyj5BuJYT7Q6kzS
         lrbFmCjEE8UHJazHzZsvx3F0teTpA/E6o9WiKnN1MugnyzDDOU0wxMKtU0bKQXxsT7zb
         ibSU6o3+sWaXdvilhkfEj52gmaAz7RaciJBiPMFIMBS8tfdVl1oz7rP6zjHb32RnYHzH
         tZ5AVt/Y3ynWB+nZU20dVc26Z93MwGm5A3ncXL1xiw3GBfNQD8suI7+5HKT4cKpLqrBs
         lOKYXL02W5n+OHzv4oxUiHOA4qTSGqfr0YDzPZfpstWyxh16ttE1sD7dVUVxNFswCWtI
         z8oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795518851; x=1796123651; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
        b=h/p4yZ02U4/9YorTdRcFj1AzztFNUc6zGhMvin/RU8AE53rgv/XgEKAANi+OJrH/Hb
         H3pfpLwut6wQ0jbKJxTL4/LkT2405RPKemcfeGVMmbJHbw0OMA6hfBLY72LYHcRGn+oo
         779ap2foD0F7/vLzKqMMfI7ezHLrPzgdDeXqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795518851; x=1796123651;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
        b=F8ln7BtKr9tSt4ZtOQeH2pwIFbnrI476VLSo9PFrriHr37QFXKZjg0GpX8Bt0BWSwZ
         pSxXGGj9z9/p04ZgthPhoAb6PN6jSytGbwbzegh+lKBhiTaR+wSWPSastszy3F3EQ/w3
         OgH6/7YqsplvhhZHwxelE/a3vmkKNhbnyhLNE+mNwqhUZu0kWt98mP6nxQI6zdDzNMrL
         5Dkw1y9RNge4hHoZBhIAsQ/eTo6gKRiZKbwlXuu+PvAfW6t1hT9yl8cC82iv835MlT+z
         Nq6zVWgPkMxdA/9hWcE8qA1GRMtmLUTmdLWBEnsUauUvWGGRWG6WGHyrmgAN+EGNE4Ut
         nauQ==
X-Forwarded-Encrypted: i=1; AL+hErHTRiiS56fHxD4R/fAGPQVNLYGptxUobtzdNQ9MqmC/1rLIUFwU3V2zETloWAVhCH1U+XV6F9CRngIX03Lr@vger.kernel.org
X-Gm-Message-State: APuU4Z8YaMABYIMOEVhiMMC+sgSen8QP3OwpRqXGY6jRxlFUeijyvSld
	RnfsUi5JyABSKoo0ft9DYbgqMjbmUAS28+yNpjz2IJJ/Ra4CY+qMvPkBzpPfzBg9huIhSBcalt6
	k53IDSOtGbr+/SYHiuedXBbXDBCJVT2SV/FGq/+aMIA==
X-Gm-Gg: AZFdTZdLVsvnlmaJD6tSgjwSV+8jo1hYPJRv3maeDguu7pf2UTptX3LT91yHqgb7TL2
	PE/m8f/X1h54ajDf1xLkSyh0b430d/fXKkqA/P28JBvg8uFPyksC2z6BVVfGURZe2z+QXmBwwSp
	2XoH33XP6fW3cDrAK0zmOby64g5jmB2Kq7ihljMbTqooEeDjEDhdPIorV9ipd1EPFvOIWKm1b0c
	jKL3oZ2ZN6OEb5Trs0QIDls9yk4qlYIqDhBIGDScMDGkvYDVYrXFQfSxAM8qIwxn1t++tkQFxGJ
	X+Zr0fulLhS2d/oQf46j+3unpiGaToC2J9zF0p2cshFU9yKczTR5ggIHaVzIMyKjgSaqF1Qh1so
	3AvprPkXWYdvWwaSY/iT1yfqPuMuERcrvce8p2CE9B7W29+brKmGeXWTsAI8AFPZn1Q==
X-Received: by 2002:a05:620a:199a:b0:949:aceb:b77f with SMTP id
 af79cd13be357-949b36034edmr2558799785a.30.1795518851115; Tue, 24 Nov 2026
 03:14:11 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123095455.88622-1-liwang@kylinos.cn>
In-Reply-To: <20261123095455.88622-1-liwang@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Nov 2026 12:13:59 +0100
X-Gm-Features: Aa3M54pbj8-6gfE1d-Xj-d2hBGWMonaIctmbDSe8aODDQN2gLU60G5Esc5wLwmc
Message-ID: <CAJfpeguSMMaBuELCVtUpEvCZZCRZK-xvs_TMMD8r_KuuzzQoaQ@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: fix potential unmount or device removal hang
 due to stuck FORGETs
To: Li Wang <liwang@kylinos.cn>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, fuse-devel@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, virtio-fs@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 10:55, Li Wang <liwang@kylinos.cn> wrote:

> After the FORGET is dropped, return 0 so this same worker invocation
> continues with the rest of queued_reqs.  A full queue still returns 1.

Applied, thanks.

Miklos
