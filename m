Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794923732;
	b=05ho93Cn00W3AmPlqjrVfIlkMW256Z7aRAf5qSerWKK0keyjPrWn51SAJyF8HGxWNHSs
	 +wF8GtlzIcMYI99UjHIgxMn5FUGvSkqvCw6wZbHUyjZCXTJeOuT4b6frue4VtXEkw0F+K
	 DamUxbP8KMjbUpx80aVaCyZF8obOY057syZpsmCMxPNrzTlPGEuop9pTHoay7NuNvOfoH
	 SmEltEKiDeVQ4j0VBFfVOMWJHy5SQ56aS9aMJ/Ow6N8koE0mzfPOUOYA7J0S0liVjqtjH
	 ZgpcOytESZE+tqhdExBQiNnbbNdccC1dlBJco/mZuo+775qrnUxHBYKWF15jjwxTU3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PCMFhWYNetgcqgqSD3/UH0RoHtSUqDu9dzIGNxeEMr4=;
	b=uKbfUEh7YTu4hMwM/9buLQoZBAHRoNubOfK5czTzawR1RYbh8Zkv1Y8sP75zl+O1eHci
	 yZrXPKBkXA37QD+3BOU4oWDTmOlVQfrFQz+We3bS2Eqx4q9kfiXcKB2xznSi6Xh/10eH2
	 tpMtVtfyS0o33ywHfICYhqGx0h5kkaRXoFfF3lacH09r1jZ8nbcwmjun5wT0PAr7zH7gJ
	 6ciJCjZD/E85gAL89XMNBYno6n9J0vLeo/I2jBFGqXdAnU4tLEUbivU1I0ybCbOnB77go
	 X8SxtoDImsyxYNmBmzYmYXe6d+TI6F1kupU/YkEBiFvaj4e5PWPw4MrUMMVgLxTCc5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=SH7KLr12;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E1606A32C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 13:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 515E1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=SH7KLr12
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53644ab1f7bso45631801cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 05:55:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794923730; cv=none;
        d=google.com; s=arc-20260327;
        b=hrahKW4AoehX/IeB3zsAe+BPKoI7CBvxfYI+fXxizhjG+o3UGE9SD7IZu4Bw06qaYn
         OeC6lQEr+wqNY/RN0HsuZ6hW4TiMJy4mfbWZxhKc3A0P5vf+eDD70kfsCW09L/bridGA
         Vyr4e/iBAVpRlPzCCcLHQawJ0mGyM7++1i2li2HLu6DdncgIl042KTVmYdWA5vgSL5sw
         e10/3qJCOW/BVHftZJwQfX/NY8kbi8UwkN23XHyP6DMndYrfDB2qlfEIKCFiYBluvp5X
         borLgk1KF2vF4n6CZVriEk6o1j3QIx28jJB9Nj8HcMReA6HX5DY08vg6MHuUdWTyKXN9
         I6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PCMFhWYNetgcqgqSD3/UH0RoHtSUqDu9dzIGNxeEMr4=;
        fh=Ou3to2OJyEltHLn79ldNGhomzbY9Vk/rqO2Eqclu2q8=;
        b=FHwHpPlnmwaUfgevCcdUcV/Vw9fJR21JEZ01NRmkZ+I/gCZmwtt+1SM71gKoyi5kjS
         HUz4OgLuNUA/65VoeOc0mY3/FK+E70fFBgZQEYlO6x2vvGFGUPFZKFyiHG3JE0VfNO5t
         8je1MqRQDN+4gyXI4efXpmX1NNTILgWZ7cVm5lvnXIFAkJ5YFaC9yheuO3+IGDLcYea1
         Ce5Jc42X6xbyzdv1jiRr6ru6YCgMX4qitMcwdoFzYh7Tdt/w+UXT4F7Nxb53GXqkhZ5w
         6EsLIYuUOc14dHr5oENU1XLWRH3+vd76JVylxJOsQ7w7qhsG9m6f00FXmWx+9ZIyUKW8
         RcTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1794923730; x=1795528530; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PCMFhWYNetgcqgqSD3/UH0RoHtSUqDu9dzIGNxeEMr4=;
        b=SH7KLr12oFVQlGQu23gMnVbVU965VwERVkakgZt9pLWsAylpgYXB/mGouBKpUsgfOD
         Oi6VrUvTVvnr5h9x98HM+b7x+RuLo6N7E5W+WYGtMJKnY22ljV3ehYyNxJeOyzpzyEYt
         dQ1tKCwK3fIt7khNRP7wsWfQMc+9tMtznrE9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923730; x=1795528530;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PCMFhWYNetgcqgqSD3/UH0RoHtSUqDu9dzIGNxeEMr4=;
        b=CcPhY2ZIbSAPymmmdTHaWrSlh963l5wgbmAIWfvaPqxTRmGjXyDRlJuisfuZiCZx+e
         /d24fLQV78ry5fV0c7FJ/CuUce6iXxtdDmFIM6LTaFfV2QRauuT837F9OyBpLkJu/rzg
         n6AIplhnA8Cuwj9JbD9WOXZQbn84YbJmPRtAgRXD/hy6mNCJ9TQBa9O/VjHTMYsDVbx5
         fTk5LVkWpsQi0FNaKDwiqRPZ1op3ome1CJdGegRtJUTq32WWmC6GRA2SQXTBDUzooIVl
         fjjSQK3EUkrtXcO83oP2wy3mW9IUvxNPXG12Mx9KYEfufKEkgel4BwTqg3EcKGoWXRhE
         Fk+g==
X-Forwarded-Encrypted: i=1; AL+hErFobUMwdNSI2RuR5MrEgJ86V1wAh2C8HeKfEl12LMQ+EkfZufmIPYvU/i8CrLM1yK6qwRCRBVEbwcX+RbgB@vger.kernel.org
X-Gm-Message-State: APuU4Z/R2HdprzUZBYDwaA7jKyxcsuxvoHQW8T/Yo1dt+5N6RfO0cb1L
	8J5VNkZ4n0u7jCUbXO/n1TGhh/RuxYronffNsSGA+J3yY4TmtkEFOjQ44tYXt+Orvff/u/t37Fg
	4xd94rGMhjv9NgQx0pbBWUUSO/JuUWE4sKGavhx55HA==
X-Gm-Gg: AYBFou32RFy1ndnqieOPzuvRSjN3CJv5tbLG8c8BIGUMRt6L4RSPUJcT6PqqvclFoF4
	SOrwl+RzPMXSgMFLol5xyfwBUcIlGrjZTGNCcZNrbiAv3l8jQIZinTh+eYcs0hm/7UXuwba2OJj
	NwqZ9QFf+eLayiwzZ1a8yp0N/6YgFAAQrHQfhKeSaSMHAmuhl7ahdN+KONE17usU0FrxmW5JrSg
	G7Gdjei8XOKLVZUatFZmiY1Y2SpRbPFv4ebuC59gYSwuZmgkuMa3ZmwasumcxoeVGegWgCoRWzX
	yvi24p0hE+VdTAK32j5kcQEp+CYn9795OqePKmtUBwp+BN4zdgNvJ/dRnm+CH2axCod+LDx9iK9
	r1qiHAHw+a8IIEiiePQf6r4j+oNmGb2heOiPmBlPlOhGfI1tIz3a3QlyogCTJ6tKXgA==
X-Received: by 2002:a05:622a:1649:b0:535:8509:3138 with SMTP id
 d75a77b69052e-55ac366a4a7mr228951361cf.11.1794923730002; Tue, 17 Nov 2026
 05:55:30 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029033700.273707-1-leonming@meta.com>
In-Reply-To: <20261029033700.273707-1-leonming@meta.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Nov 2026 14:55:18 +0100
X-Gm-Features: AclHuK864qzqHSTrfZsL886LInnKNh2XiAhmdPhsQx2jCLEfINY9UG0itbitE0I
Message-ID: <CAJfpegsKJCzdBGmQmbHt-Hxhe-b9cs4z5s-uDBMHDx3ZsnHQFQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: set dentry epoch before making the dentry visible
To: Leon Ming <leonming@meta.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Joanne Koong <joannelkoong@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Oct 2026 at 04:37, Leon Ming <leonming@meta.com> wrote:

> Set the epoch before the dentry is published, and keep setting it on
> any alias that d_splice_alias() returns; the dentry that loses to an
> alias is dropped without ever being visible, so setting it too is
> harmless.

Applied, thanks.

Miklos
