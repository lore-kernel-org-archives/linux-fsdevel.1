Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.231.201
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793394143;
	b=YKlMgh0MUrfVm35HBE04Qp+Sr9A/1LwLGXgycQbT21Awvewgw9rg0qxCRYnKsF0p0cDh
	 TR4af6UlHna60N6jBTq9zg0tJv8vCrneHSEkIAI9+umfKyBmpoiklN6es/1qcjPUDNu3x
	 cZ6yjn1ScuHaqYH8nIpmoo6/0WTeLD0av6jFxTMcjcWdZmla1R8WMSmiVcwQy+TrOeNEq
	 0ZF5E3CqC9s5IiqtI2o1kI9SlgFkY6912Abjds2ma6YyAbu30ffP/vL+68V2XJ4nV3AGU
	 5by6lje0mECcZxgt/8KW0RyOomVe750lW1DPhJeIWmlqslL5HsUNM8iKnUryrEzz/0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=8B4N1ZSUOdoChEztnUklzFSy/6ZgDKWdxgrzNXlkcbs=;
	b=Vms1Ed80WriyedXSuGASRbiH+oXo5breBYwYXQfz+vouJjKc8goEZfv/f6zdfuSFy2W1
	 S9scNgEeQzrMBMFDllITjXLzUDOVSGY0j3DrWGKxYbK23SCsjSKJGtrOn0NsgBQ37Wt7y
	 fFdLO8Km1sn82sNgwoGQnRRnZv1cP+QIFoXnAQjnKVAHKPKWzbb/chy1z+yO3+1nr54/C
	 IWLWEaesUtnD5mPC19f9X2TfGhlOptdHtDZfV6oQdlP80Rm6MaY0mSg62mOiGCsaWp6kD
	 YeX19IIPJVvUfWwf+LUCCgAiECYNS1umgtNb2g3lY+1J+wLgoSLMr8lroFxB/FL0iEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0TTYO4pr;
	arc=fail smtp.remote-ip=74.125.231.201
Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A96160A2620
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 21:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A96160A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0TTYO4pr
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f61e12e8e0so205722b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 14:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793394141; cv=none;
        d=google.com; s=arc-20260327;
        b=p82D76VBy+zLKwUZaSsGfmlll40naItuV6OywP6SsUHoOHy6GNoPHp2GgHYnjA7J92
         8CYBKk9UzcYo1Rp2P4ElqJkCuSSwSxykbhs4wR79Ck4amNQFXfAUJBh4ZB7axJ1zwoKe
         a8d56n2Gj2apezWf3tkJK4nwX3eeX2TR83bUXf1PnBeRn7CZxby6AcsMGaO25Rtfjdxw
         HjU2Z4pKXJ9ju5Rr5JM0egvgj6fWWwdv8wjjcKuRXHtpihIvLph6TqiJaQQDdk/zF2t8
         36Zj/OonnmZhaee4Lt+X7drL6udEjNyPRlwev2IozFvjMQupfnjIQdfuPHvAGRyUH/A1
         YnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8B4N1ZSUOdoChEztnUklzFSy/6ZgDKWdxgrzNXlkcbs=;
        fh=NJ7zg7UDhHbJCPRmUlw3aUWQRDAVNe3Kie80LTCoOOg=;
        b=Da9a7zNPA+cU5B7kRLCz6K1SHx33aZ6bFPeiNTDRahyKW9QmAIWRrGY6Sr8bOZB8QX
         pBd1OGW66LPuR2FjkWPNnJCb3S4/5qBqeWKHbPR0OCz7nmxmM7rM0dAR+nj9yVRGvDsL
         kuKG8W8CGOhxKmquEsGAPbufdT6/muvsiL+OWl6h6b9bRVvU4mp/HJzS8m6Y4kuu5jC2
         +ece4kbhxhN639uvms6uH73tw9I8vZWTEtDPLH2i26CJYHQOGBWRIYrMO4oYniQ495Lr
         9ZxgXcoCdnfz4N3xC1gr3InLQKFpbw1aPDpPGddipQgSpyD1xgfIqNLKY+V5WoyP2mCz
         8+Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793394141; x=1793998941; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8B4N1ZSUOdoChEztnUklzFSy/6ZgDKWdxgrzNXlkcbs=;
        b=0TTYO4pr7tSRMFpmh9cL/3wpnEVZg5Cm3u4NQqizAdplSORi+UixOYKBq+CZM4+7GV
         8RzDdeon2JvI73M41/8Cfe1pX0b4uI1256BnBNNG8IsvyPThYPwUePQEmiS7PKZn9EcT
         WtSqeyAKd1kxL2OFow9YbwTn+EMVzgMC/jgReQjXfRJrYSGSqHDXaqBAVvOr5mEFX+/+
         uNGvFG5m3dapQO5gyJpscZGzNRNthVlMBVC+TXkyVvhdWnQYM/fuKjhwbhjGaWm0Dwfs
         NANgQdPDcGdSgK467pxUgbhSAxbGW1s0v6TxgOXXqxOVAPwrqm9s+QK7n++O4YsZkEbv
         ka3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394141; x=1793998941;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8B4N1ZSUOdoChEztnUklzFSy/6ZgDKWdxgrzNXlkcbs=;
        b=R9F6DNAugRL3z1wQ3dlw7ymtmVUbKbsmVhu26T1SZqlQBLMJLuo+nxs4tK/b+hN6Ba
         LXUEeUu9beJWODmjCV8yeQYrUiisWPy6S7w1wEzRYWbktO1N0WWbyPEg/AwtRPx4cIuS
         xy7GQIHy2MIchN+Co5wZ29yZ/VLVbuqQa/2g/qvqTjnBR4PDjBwumrqYP5Dk7+c9RcBx
         9Bqz+khQ3X+itECZN3TT7vrgiWPhAPR1RKDoMb0jsbwDH7HJuTUSOshSDxt5ExAmPfob
         /R4qY/AvocNJpJ8pPIHAwWGyuAJaq/U/GLGn1Ew1f/qes13DWUVoyplSd2bKBCRB92V8
         lk2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZp1xI/vu3xeVPVxM7UfV0AfzKycchSJIvmq7Ng1zTT+1234Ibe+ELawiIjm4jsgL391MmXUY4Xfwzdfmo@vger.kernel.org
X-Gm-Message-State: AFq9FYLFPYXyNmxao9nVcoS7H1Y14eYonHnBo44KeoD+Vq/nijI11t5G
	HDXpkrIqIn/suJyPR3530Ibvg5LJVShwdCcTkyObzFYfG8OPabeFBMeXf309rqUV9H/KLuj90ID
	8+N6XE/u4ohOTWVrAxsGHRwpeQgxa+1A=
X-Gm-Gg: AYBFou0EvhAZw0OvPQzuCtSm0eLVZyYKTV6+ATLSI8y/bOrbD/8hdDx7Op6/w46q69C
	Rh41DCcC7JVb0txp5UQMDajxUinuAz6zEeNdcNHyEBIARnj5ZIN83me6EHD6oGq0dKSGzn4TiZV
	G+cRWILtTuMjFKK0lWQwePJS4F79CFmaVD8wahLDyt5vxbJfairr0iY16QIcQzYy2eY6NvkzB4N
	H2cu+Xc4R0NlLKY7YS4b8c+kBUSyqniIpJYYFlXMInJ1mWdvt2goa2FhijP9Mm2QhK/MecjRBel
	MqTepKFjRKuAgM/4FiihcbFUYRCBvalcWwLmtqJ2yAxtiG7LeUXaN6C0+2UCtkAuqhT7aUn1ItS
	IWH8uEUFJPm7gZO6Rc8SY+id1jxuiE6FXPaElV/g9BuyNth/RspJrhWEy7A/pmgN8WFqK+g==
X-Received: by 2002:a05:6808:c1d3:b0:552:950f:3ce9 with SMTP id
 5614622812f47-5640de0fcc0mr2520783b6e.44.1793394141572; Fri, 30 Oct 2026
 14:02:21 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030113201.2921633-1-amir73il@gmail.com>
In-Reply-To: <20261030113201.2921633-1-amir73il@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Fri, 30 Oct 2026 14:02:10 -0700
X-Gm-Features: AclHuK8s0Wwz9brUstaJ5S65vD0XppIg-j-1wwQ7MLH45BRDf9xJZWXuVCCjOq8
Message-ID: <CAGEkeHekpqv5ncd8tFP2v-OAy-ujTf9_RBbed3dgmTTAQrsPzA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Overlayfs casefold fixes
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Please see fstest generic/783 and see if a similar test could be
> added to add test coverage.

I'll review and test the series, and work on functional fstests
coverage following generic/783.

Thanks,
Hungyu
