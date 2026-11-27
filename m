Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.252.183.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795757536;
	b=1iXZayQ96v/gn1xjGrcIQERwnERWWE4tsaRttNWUSiOm/EOC+OymAePQVUm3z/eEPZ+J
	 UJddcPsi+gmBXJsD4326mnc43fq/Ps0aBvAnUhKI9paiGDdddfhKqOqVtqwy/QlyCdeaM
	 Pqc7Id00D9wedf7n5/Gj6Z90cafIpQhj22gsRGOJM1zVC0LtUD9UBa8OgYdOacDrynzy3
	 onSMXGVA0f9D880kByhdU+z9U70RwxniOd47FA0H+hBL7kCXG9iH3+XIDb8rcHmKlWpz5
	 Slh69ULm/oI8vUfLSMD58sm8MQIVa27p1e7EjvF8LASWPNz/8j2AvdnxGjrS8Q06+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795757536;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QhqXKwYF+Wm18X/XF60rxhw3X7mSPLKbsz/HwLEwmb4=;
	b=rtUDz81dNEoCLr5yLUytKkc8OZn20CxExmEFqRLubBigIXgWBG5YFUttfRFwmoLZ3Vql
	 QCgQr6eTR4rYg8sWJ56+qPni10B3dXKkW7NjKFStdqaT7wu1TqKh/NKZZiZjrQnaFhDiR
	 XVDMOSdtcVMeMQALytC2n05i9Nvb2dVf5clbb1+JimZhJhc5Ht4/0FX9KPetXv3NRRuDt
	 eQRJhsPLAPV6SVih+1mzCG/Zms4QxGru3WEJLotivnItbtbPYooIx57uwrd43aUggQoPs
	 jOqi7kFiUjt3DUs3SfcnTvRC1Qqe3VKfgJWP5aM55w0oa9YzI7p6iiCGOjTZKEYV3Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.snart.me;
	spf=pass smtp.mailfrom=dev.snart.me;
	dkim=pass header.d=dev.snart.me header.i=@dev.snart.me header.a=rsa-sha256 header.s=00 header.b=ZwMvYDoq;
	arc=none smtp.remote-ip=54.252.183.203
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF6606A31C;
	Fri, 27 Nov 2026 05:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99AF6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=dev.snart.me header.i=@dev.snart.me header.a=rsa-sha256 header.s=00 header.b=ZwMvYDoq
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 0F3BA1D4A2;
	Fri, 27 Nov 2026 05:32:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 0F3BA1D4A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1795757534; bh=hbnMvSCxGDklwNSiO8sJ6F/iW5gauXVIXSNa2acbZVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZwMvYDoqS6nGBejVcFqanTVSE4mf5ktoFFJCm6FVfQka17jJn/xS48GtnFxYhVEaT
	 Qt0dOgIi2GiNbudRS/b2eDa7z6b6nPA+BUtjlLwiVeG9aEVDMcwPU1z1t8JK5qC0KN
	 dm0EORwzFcnpBLb3djfu9JnzwtKFKgLt0sgHZQJU=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id jgSII9sVCWu7IAMA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Fri, 27 Nov 2026 05:32:11 +0000
Message-ID: <059a0b05-2993-4e98-a640-c7c8364c7c69@dev.snart.me>
Date: Fri, 27 Nov 2026 05:32:07 +0000
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
To: Shaopei Zhu <shaopei_1012@163.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 exfat@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20261124230746.850528-1-shaopei_1012@163.com>
 <CAKYAXd_ap120uprmarov-GuO0fb1eXEgw-U8G08L1xRJ9bv18A@mail.gmail.com>
 <20261126075247.850895-1-shaopei_1012@163.com>
 <dcd27d38-60a2-4c1a-81ff-4a82e99520ab@dev.snart.me>
 <20261126190704.935716-1-shaopei_1012@163.com>
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
In-Reply-To: <20261126190704.935716-1-shaopei_1012@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 19:07, Shaopei Zhu wrote:
> On implementations in the wild: a similar implementation, though not
> this version, is already used in mature camera products.  I would
> rather not name the vendor for now, as that involves other matters, but
> the use is real.  The open source user is exfatcombine in the
> exfatprogs pull request.
See, this is a typical defensive LLM response.

You lost me when you replied with 80% of generated text. There are
actual people taking their time. I suggest you respect that.

