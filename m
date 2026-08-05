Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC049421243
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965665; cv=none; b=btLqucFJbg7XIr5qeqvyGy7NaSsKWSuPUsohFatY/GeDu/A7Au/Sx2kllgBc8DseGRash7JH+szfLOoedzN3WK42rvh7RFPpTD+N+Us0sX1WCqcSv0LRiXhy96r+dhwkjA+mL9hQFn4Fb0wTLrYk/My6W3f0keygtEGln63skes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965665; c=relaxed/simple;
	bh=K9zMd4hk7uM/CFEnTD2X3nBbNPjZ1JaU7ol/O2TGlWk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DtUIO4J47pCLhQhgNi6aYlO8lVWdzR+xtHoonSXsiSd1GZxJHqd0P4Lsok7ohwQv4rF2y/o7UXMdVlFBAfEjdqbUBPWS2Sx830cPkZ2J0kZosP3OiSPVxVp1wyd+U2s/yBAF5bzUq+cKQW6rd6/X/8xI/nWxm34UJdE8uk3NgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPSJolok; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPSJolok"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso14401365e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 14:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785965658; x=1786570458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9zMd4hk7uM/CFEnTD2X3nBbNPjZ1JaU7ol/O2TGlWk=;
        b=WPSJoloky8ezU4S483FiL1KVysPMvXwzastgDckNB7EqE1HlKonEY8o4kEP34wdzqp
         wCTIeZMV4IDrh5/HJRyOQOSySL9c9SOE22vG/nwlLqcHvA9p0wnn+imucc6rkcOTOZIA
         77FEhBVzmDC5/2Whi3XFHF0ws5AKEl0dbER6C7cKPglSW0s3OrvkjAqSpL10u68MZYE1
         0BFl/G6ICkqYWNVXfltJ1hzBUBmRUlPhyZom1bcDTMyPZhnsYzWZPVvyhRJok2rCP03V
         dzeUBbwSkyKEHZJkhaNgpFQ5GzYL7m+5YFS4fOIWINgCmxaz2VXOgnZlao4wxhhRNe1T
         In/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965658; x=1786570458;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9zMd4hk7uM/CFEnTD2X3nBbNPjZ1JaU7ol/O2TGlWk=;
        b=jxg0oyy/2XQY32bI8NIAhj9Gd3yEYj009J6EGGnY3aZt032gFyAhguuoCFbYVeUFkW
         M4bDal6/XsfUdK0O1EqHjmJi6C4ofoksTwZlRPJ5sXjxoRDVR6iFxwMxqujr84FWphW1
         LC1zMCjBdQNpQ6lVn0zPQcPyL2Y5vLVwmiIoFFfIYVANqT/oTI5+Gmq1ZW5MBBiN4Thm
         aKdQtByVfPmpzkMqQUh0qLA0Weyy9j1WHNBPUimuASm2riZykWDaXgQR8wH+fZHnOmj1
         NeU0uAjlrwIOEvq2xGBXEmofnjW4p2g6Xn5c0ehXlAXcKAsyogS82fwY8omvD8Wce+H1
         WPLA==
X-Gm-Message-State: AOJu0YwcTO3acGlH03YM+PKUBcOjm5MLNFpZh/dDqUaEfuztjdGBfZ9T
	D64gsxpYWvJi6nu9qhoM35GT0dKnOJA4qCOBMSs+H9UXGBZGsVhVVmsgOmLMAg2J
X-Gm-Gg: AR+sD13sQ0ShqEEmGM4QJVCAeLVf3QUXpxTT9zoeibias5c64604OsSpeQGg8dOMdld
	p/Yas6XtiRWi85qsmx8GiST6ynvtOz12joxYqIwmR0LNXUjlNV8LWHz4HrWDLn5xM8zfc0ERHLD
	5gtJaoj5W6gdCwTSBAg1kJYswiJOV8eHG1dN8V09EtT9mcweDgmatsUfxFHwbJt4MUTZbWhBXTU
	vxVS2s0ZxcFK1twAIrrGbREWVWp86Y7MxtbFSqSvVRmpdShe5cqF/WpTefqthmR/QECJrjei9I+
	URVmXD1eOq7sjv6rzhde3K7iwz9hvuCisw2Mu6QPvgvtjpG46yNlH904lnA389Sqm+2Nq/GG/Er
	Q6bVb6vkppzjveTKa5kVp3OHZzJFDEbP3TPBIZEB7JrIN9mK3reCgQ6uvM2J4d4x0tUSN/ENMVw
	Z3tlVWpV1nKrb0RMd3hxwYEtB8ILJwjIk/JQDqvzB+4mWAPg6KOCPhNLgTNL5WxkyJf5sy4SqlC
	vK/kaHW0QGge+oEq7+OKVGPpOv2xbDonLFPS9CPRYM=
X-Received: by 2002:a05:600c:4f82:b0:495:4cb8:42b9 with SMTP id 5b1f17b1804b1-4994e7112a3mr116556125e9.4.1785965657638;
        Wed, 05 Aug 2026 14:34:17 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:a000:a300:fc5:1920:8bdd:a336? ([2a02:2f04:a000:a300:fc5:1920:8bdd:a336])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b26809sm430373f8f.25.2026.08.05.14.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 14:34:16 -0700 (PDT)
Message-ID: <6659036b-2f4d-44c0-bd1b-3d76b87a8476@gmail.com>
Date: Thu, 6 Aug 2026 00:34:14 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: contact@lukasldc.fr
Cc: linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev
References: <4_qSHDGTzev3i2hKqtp_9TpB7p5JWTBKwOucZ49wWdoLB9TphDDLl-QsnEjjPLerlfuk-xS9J_qL7TQefUZxd3qW9MttPZT-UgBWJW9B_eE=@lukasldc.fr>
Subject: Re: [BUG] ntfs3: IOMAP_INLINE mapping exceeds its page - BUG_ON in
 iomap
Content-Language: en-US
From: Mihai Brodschi <m.brodschi@gmail.com>
In-Reply-To: <4_qSHDGTzev3i2hKqtp_9TpB7p5JWTBKwOucZ49wWdoLB9TphDDLl-QsnEjjPLerlfuk-xS9J_qL7TQefUZxd3qW9MttPZT-UgBWJW9B_eE=@lukasldc.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Hi,
>
> Up front, so nobody wastes time on a wrong assumption: the analysis and
> the wording of this report were produced by an AI assistant (Assisted-by
> tag at the end). I work in software but not on kernels; I read it through
> and it holds together as far as I can judge, but I cannot independently
> verify the reasoning or the source reading behind it.
>
> What is mine is the data. The machine, the seven crashes, the traces and
> the probe runs are real and reproducible here. Please treat the measured
> output as evidence and the analysis as a hypothesis to check.
>
> Buffered writes to small (resident) files on an ntfs3 volume reliably
> trigger a kernel BUG in the iomap layer: 7 times in 11 days of normal
> desktop use, on both 7.0.0-28 and 7.0.0-29. It points at
> ntfs_iomap_begin() in fs/ntfs3/inode.c building an IOMAP_INLINE mapping
> whose length is not bounded by the page holding iomap->inline_data.

Hi Lukas,

This bug has been reported multiple times.
It was fixed in v7.2-rc1 and recently in stable v7.1.5 as well.
However, there are still other issues which cause fs corruption
with Steam.

Regards,
Mihai Brodschi

