Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19F2FE07D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368163; cv=none; b=WA6DDIv/0uADy7zMdEAKPGSrkEwxb4JYjfkR/fhTbK7/bp9p1QucOLKsqxFLU+56BTV4+6Lt8kjI2BYPzDAZElEFkww5qwLapU46IulVKJlilxErbjgEfrJ7CZ41WIJmAI+7v3/Awqx5QmxP/+w3M5TfUV+dgKvLmDXkENm23Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368163; c=relaxed/simple;
	bh=32hunHUFd6x+kdFoIJVoxgXSKZ06iEJVOLqaYDJWR9A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=sf/uvV1F31KW8ouQiiCyBPE7F8C9/h+xcdyKnQ4WjNtXMDqVsnwIM+ksmoKQ8iXWWljY53Uo6nGTeylyP6ApLujEVS5mufroC1yRWI4Nx7b7TpN3Rah+xlIQZqkUIzVgDBzVrpeIBoD5J98tMFBWjx21GThIHZ4D9o7zdF0Wwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QeSX2qFV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QeSX2qFV"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so18394635e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 19:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773368160; x=1773972960; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVcNCq4krl0cJzX6/a6sN31q6s37ery0DuP+eb4laYc=;
        b=QeSX2qFVe2ZCvuusaZG7iUv+Y87IyXeHaW82ZFRx9rqj/MfmegxKSc89iJvpW14miY
         B3xEqf/tm85TPu5L5kvgGfM5Pgmua8TdGQp+YPEyYXfqPtBNBzKQc5c2HFdYvLPnTcIW
         kazaymRiirM03jX/yMvZc/IjlcP58AOGUs0JtAYlnQwfUXOBkafcn1ILQYuMMtmfxAoK
         PeK/DVjXDYXCMWOE29+Eq/PJ8BN/RTcjgE3si0b22ol7oQKiunTVAPiv0G9ozVBIxKS2
         4WwYEZwsHNSUJj6GOIXxvkrYNB/SWXiQGy7PdFERdo1utO8PnDJK2TAE7qdj+JvAxzjM
         q9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773368160; x=1773972960;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVcNCq4krl0cJzX6/a6sN31q6s37ery0DuP+eb4laYc=;
        b=AdK+sW2Ihk4LM5I8S0H1phyud2ruORjA4OD7lzd0SJvbBnBpdtCaH8wJ3/opkKnkTO
         ttmSIxEu94q4OyH6ZtZ1s6jsqf7dXMJNCCIrh+hDR0gfuAma483Mhq37bJ12qmM8X6lo
         0STPtywcz3FruRyvAStNXQguxNt9OkUo0GrOacy2MY/0aMtCNzPhvb0BrlY1VRYRAK8L
         4PxXHIFU+crwspuAPeP++MJLYreEhACKDYnfqGFoLCz+sQqnzXMx/qI/Mv9Z7h2JYiRz
         Y5mZ1uHZWK8fxv9VZFX7M1Vdgz6zuevKLn+xd7dHpV2u731OIROYsGllLWMJgo5su3lB
         U/eA==
X-Forwarded-Encrypted: i=1; AJvYcCVt8OMfuJzrEamxc4rB+kPBqzT9VebQipxnl8gCG26U3+UxWSJ+IgdxanqOzCQeedATjihV+tXJCiE6upOB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/aZFucO1dwTcCtEjbNTM/GwP+JSmDOahxNtS4K6BnCva8Sus
	jHfKLRZ4/hBmf/gvsEnHMLM2CiPrdUDcAevNEJnxong/S5GrmzBR7Z8X2rEz8bESCDNLyAPVTa/
	SMZOCOxg=
X-Gm-Gg: ATEYQzyH1OWRwi87+HotUUJLahukJfXqNa4I8ylR4lXOZ9FH8wZCx00s343PZOrmGRV
	D/RDGWh9J3FrMwnkxPz3gNEvZ+LgujXNmbE9cc66TXo7Ai9io/bCVdeoy4DhjM3+PAbDgVBZRRn
	NbjrdmVWjzGhPpZvzrDnuplth8CXH9SwYumXAnX81Q4j9BX2F8hNjZjiyNenCqKcPA6xnedCewU
	RqWW6qii769ajZFNhEqj8qFSIx+cLkSnqq9Z2irAz5dKvfrrGS+PPCiTBw1hmYI3AfOzuT6jJEu
	YkmWLFXTPP4JENh7/Oe9MSg7RIFnQrcomm3Sy5TwB5NmT8SEEB0og3lDL9C29bhk5fkRpj0LJLG
	sRp6uBWoiPASyDCfejkP8o+1iUdUEksdJPYcp6RF99ptqSN1Xhy3oHBiJPR8/SFM7QBRILeZE0e
	5D8dlNvxeAwALqUvQzk+mU89FupRo+aRWXb41v+fs71tWrKux2RC8=
X-Received: by 2002:a05:600c:45d5:b0:485:4535:73d with SMTP id 5b1f17b1804b1-485566cfb8amr23453695e9.2.1773368160125;
        Thu, 12 Mar 2026 19:16:00 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07343719sm4359523b3a.38.2026.03.12.19.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 19:15:59 -0700 (PDT)
Message-ID: <4810d3dc-22bf-4a8d-9964-017c2fdf3c3b@suse.com>
Date: Fri, 13 Mar 2026 12:45:54 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From: Qu Wenruo <wqu@suse.com>
Subject: Should bio_add_folio() add the folio even it returned false for @len
 == 0 case?
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Normally no one should call bio_add_folio() with a zero length, but when 
that happened, bio_add_folio() will always return false.

However if the bio has enough free bvec slots, that folio will still be 
added to that folio, breaking that "returning false meaning addition 
failed" assumption.

This can result folio double freeing (well, if you ignore the bigger bug 
of queuing zero length in the first place), as return false normally 
means the add failed, caller normally needs to release that folio manually.

But caller also needs to cleanup that folio, which involves releasing 
each queued folio, resulting double freeing of the last added folio.

Thus I'm wondering if we should add a @len == 0 check (maybe with a 
WARN_ON_ONCE() too) in bio_add_page().

And please don't ask me why/how I hit this, I'm already embarrassed 
enough to hit it in the first place.

Thanks,
Qu
