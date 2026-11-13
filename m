Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540724;
	b=plTiUYPtCJUW3r0x+cXNhlzqv/jNcEqFaGCZ3G+8ixAhqMUxEupE7/2eqmMl5Q1b47bf
	 eJfBUDK66/jplnNCNifE8Xw+Hp5eCJLjNPhYA/9JAjYda1b1Rcdz+sTvaLTvfMqFFR5I6
	 D8O5dejunpQTeNWh5SGAcaeZYiMjXj+UFnDT1YuCKgHfvYecbP1NTiriqtRwWBOoPJXAS
	 f7YzGsQ8Zp9TUUGOR1cfyKGODRRbVWgD1qK9zat6LWgVRJ1D2n6xkovzwSGgbRa1dBKWg
	 1VTSgQlI3UDMrg5VtSJVXQETLFwjCkeqjKXdt8B3qByNCo7b3wbKAyO0WdHyVhHAmXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540724;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:X-NTES-SC:Content-Transfer-Encoding:Content-Type:
	 MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=aD4ZZT8V9BMEpEpjteO0aAWzTPsp1nwTppO6+HHX6/g=;
	b=WWD+Z/5VcxgFyhkcHKlunZLtV9zF7dQeK3Cv9G+XrkkX51CaMjZlYlDfJGnXuI/XR/z3
	 KRsSFb0ItQ71QvpHfM6j56vm3QNasBXLn/8q2Kh0xdeH/yR1pg5ARYGPG7gIQUtbK9bzY
	 hTBjPxoMBdFWWT1eNSghlp3BMI2KOsS46mOcGGpqBjLfjHBW2ICiH7txQYkFFWq1Teie4
	 ea1Wxh2oL+J+HU0yKSjsAjQEw9Y9n7t3q15TDyTXhNMKx6AjMvRHcEjQuayZcN1hMTjNa
	 /6OOfhM2CX+7TY0yesd2/FIBauQ7xmHgg3L8HYzzt917C/B5iCSeh8ZCBhxikXFx5Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pxE1P6zo;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB0606A31C;
	Fri, 13 Nov 2026 03:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDBB0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pxE1P6zo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=aD4ZZT8V9BMEpEpjteO0aAWzTPsp1nwTppO6+HHX6/g=; b=p
	xE1P6zo4D2dCRVO7hkrXOAeongr+VKpqx0GfrEhELjTIM4PtAJZ3EEtigzK4MSFP
	3aDTRBHO4gN/9RySV+1IEvVoHopBCYtdSCV75svMgyuqgwlnSIbqJUm0MOcLmsMV
	hJGHU3LPrcA7S2KI9HN6cTycW88Ips0xU8JoCEgawI=
Date: Fri, 13 Nov 2026 11:31:55 +0800 (CST)
From: CJ <firefly0158@163.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: INFO: task hung in evict on v7.3-rc2
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2SBvmfv08q4yaQY+kdmEsTju82UcS4ufQl245Xc98Fnj/m0QAgUkVjHWLvy8SkMRGyrhS9cglw1fpzYbBylhgr8HL6+LPCOJ3BvpnopQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <40539074.308b.1a1d2f63eb0.Coremail.firefly0158@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgD3H7qrhPZqlVg2AA--.1614W
X-CM-SenderInfo: piluvw1o1qikqy6rljoofrz/xtbC+QujVWr2hKsJLwAA3R
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLAoKCnN5emJvdCByZXBvcnRlZCAiSU5GTzogdGFzayBodW5nIGluIGV2aWN0IiBvbiBsaW51
eC02LjEuIFRoZSBzYW1lCmZhaWx1cmUgaXMgc3RpbGwgcmVwcm9kdWNpYmxlIG9uIHY3LjMtcmMy
IHdpdGggdGhlIHJlcHJvZHVjZXIgYmVsb3cuCgoKVGVzdGVkIGtlcm5lbDoKwqAgTGludXggdjcu
My1yYzIKwqAgSEVBRCBkZjI5MDgwOTBjZGEzNjhiMDFmZjQzNzA5ZjUxODkwMDc2YzU2MTU3CgoK
T2JzZXJ2ZWQgZmFpbHVyZToKX19maWxlbWFwX2dldF9mb2xpb19tcG9sKzB4NzFjLzB4MTE2MAp0
cnVuY2F0ZV9pbm9kZV9wYWdlc19yYW5nZSsweDMzMy8weGRmMApldmljdCsweDdiNi8weDk3MApk
aXNwb3NlX2xpc3QrMHgxMjQvMHgyMTAKZXZpY3RfaW5vZGVzKzB4NWI3LzB4NjkwCmdlbmVyaWNf
c2h1dGRvd25fc3VwZXIrMHhjNC8weDQwMApraWxsX2Jsb2NrX3N1cGVyKzB4MzgvMHhhMApkZWFj
dGl2YXRlX2xvY2tlZF9zdXBlcisweGI3LzB4MTMwCmRlYWN0aXZhdGVfc3VwZXIrMHhiMC8weGQw
CmNsZWFudXBfbW50KzB4Mzc4LzB4NTEwCnRhc2tfd29ya19ydW4rMHgxNmUvMHgyNzAKZXhpdF90
b191c2VyX21vZGVfbG9vcCsweDFmZC8weDY2MApkb19zeXNjYWxsXzY0KzB4NGY3LzB4NzAwCmVu
dHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UKUklQOiAwMDMzOjB4N2Y5NzI3
OWFmZWJiCjwvVEFTSz4KCgpUaGUgY29uc29sZSBkb2VzIG5vdCBpZGVudGlmeSB0aGUgbG9jayBv
ciBwYWdlIG93bmVyLCBzbyB0aGlzIGlzIGEgcmVwb3J0IG9mIGEgc3RpbGwtcmVwcm9kdWNpYmxl
IGhhbmcgcmF0aGVyIHRoYW4gYSBiaXNlY3RlZCByb290IGNhdXNlLgoKClRoaXMgaXMgYSByZXBv
cnQgb2YgYSBzdGlsbC1yZXByb2R1Y2libGUgZmFpbHVyZSwgbm90IGEgYmlzZWN0ZWQgcm9vdCBj
YXVzZS4KCgpSZXByb2R1Y2VyOgrCoCBTWVogcmVwcm9kdWNlcjogaHR0cHM6Ly9wYXN0ZWJpbi5j
b20vcmF3L0hYWExLRWFHCgoKQXJ0aWZhY3RzOgrCoCBjb25zb2xlOiBodHRwczovL3Bhc3RlYmlu
LmNvbS9yYXcvTUU4bUdoUHkKwqAga2VybmVsIGNvbmZpZzogaHR0cHM6Ly9zeXprYWxsZXIuYXBw
c3BvdC5jb20vdGV4dD90YWc9S2VybmVsQ29uZmlnJng9NmE1Y2JkMjY4NDA2YmY0MwoKClRoYW5r
cy4KCg==
