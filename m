Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058930;
	b=eQ8E93oRo0WskA477Zb/8XKaxbex0Hr9bAhDBoOGQFTvfqBFiCuMA9U2FfowPRt5xLzE
	 uBxCvckfVxL7FcukTyDjgw+dQWzdI9OfwIfXxQfgrIYcnSB3idAsB9LOUDvcogyKpmCwh
	 rMBBXm5+74y5T2eNEBGu3ZvxND9NdixoLn9aW5YszR5S4PkGtIRCGtYdmi7PZokks8IHN
	 NlSOC7onBd7YM5uZ0syn7xOXGqLWwnbmC5XqLTyLUag7NoAdqd3hJOttjJEhslV9tjCEW
	 GPWfJu+iBq6AgDQfRI6iiGtY0XyKSJHiZEGcHYxKvCXUt/rzQ5nxEaXhBTtgjMf8oLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CYlgoWlQjoEhGqZTHu9yMtGAoHutdZN/vbViahm757M=;
	b=gMEh1fOuCD1KL7YPyozE6VM4zi04Go5qSp4YWcnvWPBiN1Pcx7hy5GINUbNQMdmMYN7+
	 Ya7rLt2/rWzn7KHXOnzaNjjj+8IoXEjMV623UtZBmyG9v1ClKlM66jpLoYl7My2KB3k7B
	 GaI/MtvYn0NaqjELALAMXpJ7yQih39nfjYDcL3yVkGXMsfq5h4KrhB6QdOHEZBLm4y/rY
	 Lr8gHMD1v1a+7nIx/UX4rQUJQdS5id5aCu/E58pfLylBRed8zi4JZUD5w8vqJCIJDjxT3
	 u6uGiP7hR7PIntz87AalkH9lVrNP0JzsUYIbychMrnvMqRElnrar9T/NNdsjaSSR36Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pXfCUbWL;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EDE606A325
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 03:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67EDE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pXfCUbWL
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cde4b4e936fso244528a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 19:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795058930; x=1795663730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CYlgoWlQjoEhGqZTHu9yMtGAoHutdZN/vbViahm757M=;
        b=pXfCUbWLnxs76b/MfQ8RKnylzDz7BaKSoLAaNcVZVMp953cz1o5DWBgqMUqrMA5yIe
         F0UIBUgtJhZnSrfhRc18S6FvTkI3jq+cwTs98vwytkqQiKzFMdic4cKdjXY9PkmjqT6P
         /isOEoBUk6GSkGLO2jwxL3fumT6AWaEYB2yFtH+9VmokuBRVJw9wK6gfSQA95Y6YyEi2
         lt3Mpo/45zTNEnR6QccgMGVVZi34CU9IlSiBO6PmjuWmgr77sGAaGcwS1hIkR3XqXelH
         ANFDsSg6Tl6F6ORfTI4Vv6h4ZjSYGXGR8jxrw7KEjOSI6EW6enHkwxFiEeuuTZ1oUoeC
         sLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795058930; x=1795663730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CYlgoWlQjoEhGqZTHu9yMtGAoHutdZN/vbViahm757M=;
        b=0UDkyHRch9f3RKCp6pwiC39Y/weRyY5vy7W0xApv51gtjiAOXUtnvFTfN55uXqV5kZ
         YGj4Hqfr+dgNI8//FBivDqOPN6ZVb1d0x2DyT14g2Yn6a1mfgns5NB5B8Decrb86mFWx
         oVnKiYzKx19O6GaPeU4I2jzAbd/J22DJc5BKLRBAS/qS3mZfOO6juhxRs3gEtPuyrVGY
         YQ4lA3s/OZ+a/EsuBeqeSB5218p9Y2o+BeEm1zivm8kZWITBO2q6Gzrkj6LOVBB6zVx1
         4ldb2k8zsfpKJ0e9df/E19MyEBbA2AhwbJvQIbzguRDf4klCvxJeYkxad6kIikP3s/af
         WUXw==
X-Forwarded-Encrypted: i=1; AL+hErEZfScfXUCOzSRzOWxhFBLFlkGDUBbfHbajQDh9/2x2HNer/dF5PnCUO5cCQR524CrSthfAdj6KZ8ncUT1p@vger.kernel.org
X-Gm-Message-State: APuU4Z/6yEZtdPaK84z6OFGUxFYMQLWIOtuR5ek9owIiCxGYXuWl1pkQ
	yH2XmdObiavvaO0qJqtyl6zwd5Tz1T3TEajwJIJqoB1OAcf0hWstUzmh
X-Gm-Gg: AZFdTZctif/aUx/CgExxjA0xqk4XoK4j0qFbRrS25rCZJhT1idUMamgv2PMsOVIYt5N
	cvdncolwDcuDc+ja4mN0j6I2b5wK16oift//92fZzsOl9N7HfqaBj/zfPgoXQSGBPUzqO0b8AZD
	s4pO2GGWNfGPZPKfcRm9epcLf3tf0s9LusvCQk6/wJIb0Ftmd0/vy2Uun43oAJMWcM5RX2NusbV
	1eJg6lzL3maaNNcxyoEdP6fOOy14yNia5XseUkNoK/qQj8Tb4JqNHYb/Q1a4fADwmn+rWWxtLhE
	ZV4MBWTgkoBvI+VFDwsANUxLdLmR5ccLL2q3w/nrqVXnQ/704LMrAe3Bt4PRZVKuTMH0oIDRbKA
	U3XKWAa0GJ99sMsG5m89qLcd/qdGraqsjzVNFbLtuU1fo63L+lgHcZPx2nhOwsmEPyHXc6ZOng3
	IxmuiEDT2GAsYELMKHgxOplscBKJPjWLqX9MMqQZgVM1hELMWVMb2y5cws9LpEMj3kKP0u35wO8
	tW3Spvm9zsP7XrIA2SIfGK0z0gHsmGopFngueNhu7TKFhNJfeebAUtfYXOUvJYc51AnCcnGbw5I
	SqildVx4M5aEh09sjNiv3411BFHQuZ8x8DIopVtFZnj5/Jup/A==
X-Received: by 2002:a17:90b:2487:b0:3b1:6e2:3693 with SMTP id 98e67ed59e1d1-3b3ffa1d30fmr268271a91.17.1795058929793;
        Wed, 18 Nov 2026 19:28:49 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b402aa8555sm319488a91.3.2026.11.18.19.28.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 19:28:49 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs: ignore RLIMIT_FSIZE above LLONG_MAX in generic_write_check_limits()
Date: Thu, 19 Nov 2026 11:28:42 +0800
Message-ID: <20261119032842.34297-1-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119031026.7985-2-dingf3ng@gmail.com>
References: <20261119031026.7985-2-dingf3ng@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan reviewed v1 of this patch after I had prepared v2:

https://lore.kernel.org/linux-fsdevel/hwwtflqzbga65oxvo7bw44xuhpbqseyfww62kyzko5az4gdnxy@4wxsl465nvp5/

The only change in v2 is the type of the limit (u64 instead of
unsigned long).

Thanks,
Ding Feng
