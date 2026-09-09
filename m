Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99B448B80
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938704; cv=none; b=stmBxqOCuEKmQ+AUB5W2gbH5DvgisW7jYFwfgnxMt8DO6FAS9XsqdYDD1MJTI2/Fpqf4Bbfk+d6Edzcl2LvRbCQNg6U+Ta0gNNmuUJWOEDTzNc4bDs295PENZKuTAEfdj5ExFADMaLtSjHhxOkdexpQMOqdq+7r9ncb62+TJO1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938704; c=relaxed/simple;
	bh=6IpihIKg7y7X2cwXfcmqkmOxJCzJb7Ke/fCjIixrgYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVqIf8/SvxA0G6HiTgrSAVHqjsubt0qXP9eoIV9sVegUBcAtGALzr3jc1EGNPRTuCfXYOorMjJxgf7bImjGKIgtlVykDjSHDzJyHqzv90mWi6Lg3UReiiwzwSaLns/4lItmrtgT+ZT72NHm5OeskEQxrAp4/ovW4wDnA7DqFkzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctdGs+8w; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctdGs+8w"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48436216a98so3792089f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788938700; x=1789543500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6IpihIKg7y7X2cwXfcmqkmOxJCzJb7Ke/fCjIixrgYE=;
        b=ctdGs+8wEAYbTbCeAp8ELG1CwjP3pXcBGVSoduIKr0ldo2r+KDJZGduZCG/BpoY6pg
         yecUBlmUEataUjdPUK3qzadO6JcJ13qjR8ig80joGcxStO7bEP8WDMXCTDJ4pxP8B0Ti
         TyElTkg2UcV1eKHzLQ8BMPfDqtPfWyvim3+uTNGMDn7Uasiq+9IBKRPHJmJc1bbH3t7Z
         vF9xWYAsNTOroKZSDWiW4cKfAkNBiFHbjIebIuRj7OgoSUWtz3pWHYREm/PzUdsceGJL
         nGWbtmKvMCq6C/6uljQNpUVE/J9xvBrQ3hz/5Z2kKgdyIB1nyUXnnTEO3oASsiSzZRqO
         b51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788938700; x=1789543500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6IpihIKg7y7X2cwXfcmqkmOxJCzJb7Ke/fCjIixrgYE=;
        b=Act2f7LmCz8bERMY80ryyxvwsjiVHY8nghhvi+uIs/e9Jhiw6wKq6PYRlCXRdR6GhI
         WHPW4nUVcoNiKDqlhS3IE+z2CvdjkcF4aZnRzEdf2dPXB1CQMI2h3l/bBHrvtcrgyzHT
         dOwzbpMb8TXWV8ryNDPenhLGv5Y6LOIVK4lmmTIjRXR/sInmeJ0v5j4TYw7vqYE6i72W
         FpNMPgZUOuDX9ILcFxc+Xrw1ujOe7uGDhirC1JvpaPvMoq4JE4JoQzSTZMAZ7NdETJm0
         1PW2sawdW+LaJ3oCWgKXyiHMg2bhACnlL3Mkq43ADdbVcrwlvOqKK+U+h7Dli2Oz11Ad
         fhyg==
X-Forwarded-Encrypted: i=1; AKwUvBzt/Yo2YeWY/1/su/RGs/hq9cltkSxVxxUzjJJZwRcreYcy4qrrDJr5hvuYM4bo5kK7OZZAfa/rYsH5C2VZ@vger.kernel.org
X-Gm-Message-State: AFuF++kjLKd0wmvcItfwyGKByEaGCNdvwbXu591K8mgXR1xE8nk0BkmI
	vSGQjQaZqhbPmtHNA5ZEOHbxBfudTnS6ax9WzP0ZQFzKuqAxC/u9j5jz
X-Gm-Gg: AYBFou3SuRWAMOcMNzp6Oz3+GEuYBBqsmOR3l2O0uhg3beC2gTQpiOzZFjrPS1ui9rB
	QGH+gcdlTH5VIdh0u2iI0p5lb0DE0YB9NFSEWElg2sAgHM+S1rtNVKr0W8JipJjoZQfo2ubOR16
	xHE2f4CUQ8NC3eiJiUaePepsFecwMhwQ4sQ62LLUH9ZW99qEgk5vRysQRByrzsgB+2+XVWLAS65
	dJ6kgYbOMPi6StgE2I3iF8aOtWiA58m8UEe/727WSVGrrY4cio4QahlXxWOWWKUp2udLg5RZAcV
	tqGDZCVtTZRuUl3Qey6C556fvte8395lZhmK/6fxGIkzB8VyyuhpS07fPQ4SOK3PSFuuYUEB0bP
	+fb8U7IAJjZ3Y8QIEVWE/jMWYKcSykRUFttaZil036u8tN6JMgpdrITr0/fTa5fXcRHqe5HWxj1
	zFQ2BQT+sEaEShcJ5oYjmbJTmOwEkx5YIhG9mbRqAGWxzs3UPZfYYM2OoAo7SHPDgcw8loODhR2
	o/D1UvNfRZN
X-Received: by 2002:a05:6000:4909:b0:485:8c17:9764 with SMTP id ffacd0b85a97d-4858c179966mr30927449f8f.38.1788938700220;
        Wed, 09 Sep 2026 00:25:00 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883acd33sm41527265f8f.18.2026.09.09.00.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:24:59 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	david@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	martin.lau@kernel.org,
	mason@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v6 3/5] bpf: Add user memory access kfuncs for mm_struct
Date: Wed,  9 Sep 2026 10:24:34 +0300
Message-ID: <20260909072434.66868-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org>
References: <4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Does this drop the address-wrap guard on !CONFIG_MMU builds?

This is fixed in https://lore.kernel.org/bpf/20260909064231.18693-1-tasos.papagiannnis@gmail.com/
