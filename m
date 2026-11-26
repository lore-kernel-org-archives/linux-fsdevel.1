Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.252.183.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703211;
	b=dtsHVjXSIJOh7w1K5gRJ5qdwMV1PE8P/xxb9wJ9F0UR1T+EZ9yVA2Uara8GXuZPvqUc/
	 qwsa484kVKe9LVecBOw2hIrq/JIfaj81URkOLcJJP0zYsheoN9daNEZdSat0KZyd2s3he
	 9MYS33NmOPa49e45JOrlt+6dwbg/PbxSJu1+H7kNlVJCpGbv54R4Twjpgtv0HoNpMWddr
	 BFftTZ8oToMclj0BJWV4QQz+HVFoTUDpszJDyIFhH8c5QFD1qKCpZfjbhsXTxCEiy033J
	 3hz4//hgfDN760jrU4lMX+/JvCM1eDTrlm5ufx/iHMisuDwgAg6et/4QkDpQxid4jQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703211;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=u6DOltPP0RVDz7PGdTyvk/45WxVfduZA0K1xLTMF/Qg=;
	b=hzkuzoxwDfPss7GXUQgv/CGNM09mzBUTD4A/M1heTVF+Nof4bNP8Agd+cySEHHTNvPtJ
	 KUWO5AL4lZ2XGQ5TZa101rRTDH5zsEiIHdpjHCwc1x7VLZwhb/A1k4S4NVvypfgW0aqem
	 aYyhgm1R3tjoVR5hVPs0OdQ3HhopnjjYAFB0rT0d4SZFaFEvZWRd/xMGK+60+vo05CMVL
	 sCpvHaofLAVZP/rfZTlXr12hUYJOQSNXE1Y0ImbF09pUpJEr4266RtU3y+VXFvojNR5+i
	 3R6AtM2Ikziwc9+ncd20iDN86/nK3iit1Vi1Ytv/3Rfs3SGiK77G6ETmVLXu/JXOJ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.snart.me;
	spf=pass smtp.mailfrom=dev.snart.me;
	dkim=pass header.d=dev.snart.me header.i=@dev.snart.me header.a=rsa-sha256 header.s=00 header.b=o7VAhE8N;
	arc=none smtp.remote-ip=54.252.183.203
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345DF606A31C;
	Thu, 26 Nov 2026 14:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 345DF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.a=rsa-sha256 header.s=00 header.b=o7VAhE8N
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 3AE001D4A2;
	Thu, 26 Nov 2026 14:26:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 3AE001D4A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1795703204; bh=9uBNsJ22+ox7vUCGd4FMmwz4iA922GLuuEcn/apNnV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o7VAhE8Njs7DGmqLeaWzKEKCZINuK5QmM57azcqdjP91g4GDTDpJj9KZbHEkcazp+
	 V7ZShRFx3BEmlcUK2kOWE+gq9297NhhHCqInbYAnyNQbptA4Vy7ZLnVJNnvk1JxynE
	 sBGQZ3tAZlpI3NYDo2Uz7vZ7cNYxrPXsbpEFE3c4=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id wlgWMKFBCGur7QIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 26 Nov 2026 14:26:42 +0000
Message-ID: <dcd27d38-60a2-4c1a-81ff-4a82e99520ab@dev.snart.me>
Date: Thu, 26 Nov 2026 14:26:38 +0000
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] exfat: add EXFAT_IOC_COMBINE to append a file's
 clusters to another
To: Shaopei Zhu <shaopei_1012@163.com>, Namjae Jeon <linkinjeon@kernel.org>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo
 <yuezhang.mo@sony.com>, exfat@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
References: <20261124230746.850528-1-shaopei_1012@163.com>
 <CAKYAXd_ap120uprmarov-GuO0fb1eXEgw-U8G08L1xRJ9bv18A@mail.gmail.com>
 <20261126075247.850895-1-shaopei_1012@163.com>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <20261126075247.850895-1-shaopei_1012@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

This is Davo coming from exfatprogs. I noticed the PR in GH which
brought me here.

On 11/26/26 07:52, Shaopei Zhu wrote:
[...]
> The workflow: cameras and dashcams keep motion or position data with
> the video, e.g. gyroscope and accelerometer samples for stabilization,
> or GPS.
>
> The products on the market keep that data in one of three ways:
>
> - as a timed metadata track inside the MP4, e.g. GoPro's GPMF, muxed
>   while recording, so that the samples are interleaved with the video
>   in the mdat box and indexed in the moov box;
> - as a separate sidecar file next to the video, e.g. the GPS logs of
>   dashcams;
> - as a trailer appended after the MP4 boxes when recording stops,
>   which players ignore and stabilization tools read.
>
> A sidecar file is lost in practice: users copy, share or import only
> the video file, and matching the two by name breaks once either is
> renamed or moved. 
I think I understand the the problem being addressed here, but adding
something to the kernel to solve that particular user error sounds like
a lot of trouble to go through...

Also, there's issue of block alignment: Windows formats exfat volumes up
to 32MB cluster size(I myself unsure of this MS's decision, but it is
what it is). The release of 4TB SDUC cards are just around the corner.
At most 2MB of space lost just to padding, just to append a few MB of
metadata to a monolithic file to idiotproof the product.

I think most of the products on the market today just use multiple files
for multiple streams at different rate(LRV and WAV - fs/exfat have long
supported preallocation to alleviate the classical fragmentation issue
inherent in linked-list based filesystems). GPX and gyro data is
certainly not that big - most implementations including Gopros just
interleave that in a single MP4 file with audio and video streams. But
sensor data in industrial use may see a huge amount of data, but then
again, not a consumer product. Something you don't really need to
idiotproof. I think, if the metadata stream gets that big, we're no
longer in the realm of consumer products.

I have no share in the in-kernel fs/exfat implementaion so you don't
have to sell it to me. I'm just a dude curious about all this. However,
if you don't mind elaborating, I'd like to see some actual
implementations in the wild that may benefit from the ioctl. I also have
a bunch of ideas I'd share with the kernel devs, but I just keep them
all to myself because the kernel development is hard and the ideas are,
most of the times, not worth the trouble of maintaining it in the long
run. I don't think it's not fair for the maintainers who have to stay
behind for years to maintain things.

And, tbh with you, fs/exfat is not really the coolest part of the Linux
kernel so expect more push backs :) Just speaking from my experience.
Nothing personal. Thank you for reading my unsolicited two cents.

Davo
