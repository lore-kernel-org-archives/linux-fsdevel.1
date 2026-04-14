Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4531E106
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198041; cv=none; b=E4j+Cm183+2vanGPeHfoYl9fkj6OapgzKAz0AOHOaGbelo4pcQj/t7VMMsJC7IkKIIQuKQgYYirzkYMSCiV8v+Ru5/lWypSw7ni1R31gZiuvIILxYLStcI+9z9TpLdUv0pIHfH5mMltdRXrUp9OwCIarwphCMAooIZqKbD5ibbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198041; c=relaxed/simple;
	bh=iACz2fy6ESXQj5dkHzxUfxjqWwbR8h3u7ccyjq7MRIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gviQfDHC/mZt57LJOKrRaRY2NcFVcCnBvdOaVcOSyzf2QuA4BEiucQpxQYkCMzueWo+OE8FOH7oDyL5jhkGZ66P24eWd0WsyyIg4zV1vdw4UJA6Y85rNpREX7Pwy2/5KVuOUaqwRPDmFo1at1fAWaTZaku0EQHLAfcjs91wxBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVMzj3IY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVMzj3IY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso62805065e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776198038; x=1776802838; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iACz2fy6ESXQj5dkHzxUfxjqWwbR8h3u7ccyjq7MRIY=;
        b=pVMzj3IYODjdra1EdjNivHXd2KyJ13+EOiiQK3Uf5FqJ2hR4xnq3i/ppiTYXWmtHRi
         kYGpaNMogIhdWw9Gwi8fn9gTVsUxN6NpvFUBkVvhfn2n8pf5v7CjGIoVp6Gd75p/34Rq
         Uk6NS/uiceBy3dn12NZESAWI2GUsp8jPy7pklA/CN53UYJx253lrFHmospRH7wihFZOP
         7cme9nC4voEsT5t1frNcJsGS4b4KDREutQRJf6D1xQRHGqS2FLG9vmJGe57LVtKKd9i/
         GOvqyuNrEPUKB8rk59aUthmu3pbHpRbCJc/UcNWGnW1I/vFDoHApuJU/6QGCdTLFvdDw
         +/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776198038; x=1776802838;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iACz2fy6ESXQj5dkHzxUfxjqWwbR8h3u7ccyjq7MRIY=;
        b=SpAxI4L3X+1Wkxj7br4x457hCYLbfyx091XZAj7AZ2hso4+LTKNd21841Q23oy7wjZ
         bYa0Ya3EDMo/GtGmVaw2EjThvfhqhDb6viqW7219YKIZDO4gSeJXqRaogCHKlI2csK0i
         Nmq0K89NyfBKRXLS+Y1q1kW2Ki4MhCH7szd1CcBAwAQJCOBo0upKOiz29BYkcNNIf2U5
         aK3+7sxmxYy26vpgV5auZA+PekFmK71ie9koiF6M+NWt5DdGgVPakxTeh4Vx+YmObYwK
         viU++C2iHpAAclUufQWdDrcmGIZYiEbJKy6yNIGW+fjDlb5EBIJPw0/w3PmoA167GBlC
         DJWg==
X-Forwarded-Encrypted: i=1; AFNElJ+OLtyoosxehe4t2HXwNG8d/nFNukNhWeK2Iqy6VxqWxoAIca4Ze7Z5DweLKXRAOXxKmCPIojtlmkk1fGeu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8IN2y9XYHCAhzZPJp0y4A8zBbO0mpwbQqDhwgOyiLUVkFf9h+
	kiuF27PPYi0Z4WYRpm2ErwHzSRKkR9Q6ToZmVuY6nAF0PXF2dEMqxGx3SE+U4IQS
X-Gm-Gg: AeBDies5mYsnA+oe2DS7KIxk/+uLmXXthbqF5Y9BTMl8LRbTBCSkBe9GNI8ivKK6NJh
	KvnDInq6ULWa79cYk9FESK+5sVk8tb7iaZ2Wl5GuPnHfVO1PTR1dy54gh3Hn5jYa7hldWll7uIS
	nD9L2RC2gfSrZkqs6iPgOwRu0NzZ5Vn5WJEScSPbNC70iUuMfSaqmw5aOqIvbfZLbBxjskL27ij
	cY8YLrtZPYsqwD4Q/tJroYnNZIYdec9dAKdnLvzRQXl6tUEeCumOFd/CXnbuuL88pdQc+6qiane
	oh6oFEBGt8FlRNmtUhZdUN5UzdQBQVyJ5MuDCSBc9iLbZkDEuY2kDAs94Rd2Xat9GGg2MuwS8Aq
	nLlj60u+w6/EWIQwrCY6o2qmeIhQFKhcUd4n37VEAH0jlAVrYbdPhUYgZPntIFa9sGrr52EwvXN
	Bv2vkQSHzBVhBibeCocET/k8ImgWQ7hsioyTXuu78KhhIUrS/5JwI=
X-Received: by 2002:a05:600c:c0da:b0:488:caed:5cc7 with SMTP id 5b1f17b1804b1-488d68af041mr223612985e9.15.1776198037872;
        Tue, 14 Apr 2026 13:20:37 -0700 (PDT)
Received: from [192.168.1.201] ([87.254.0.141])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d6fc9d525sm27663138f8f.36.2026.04.14.13.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 13:20:35 -0700 (PDT)
Message-ID: <4a6a9ef3-cfa1-46df-bf82-d083ef30041a@gmail.com>
Date: Tue, 14 Apr 2026 21:19:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: remove xattr error message
To: Viacheslav Dubeyko <vdubeyko@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260411125338.165758-1-colin.i.king@gmail.com>
 <b0e9b8218a2daeb65c8481d1f4646f3ca89d713a.camel@redhat.com>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <b0e9b8218a2daeb65c8481d1f4646f3ca89d713a.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5eE77470xSMep7d00RsOjinV"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5eE77470xSMep7d00RsOjinV
Content-Type: multipart/mixed; boundary="------------4IYhQ8y7jIWS0Xs5wN7f9s6i";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Viacheslav Dubeyko <vdubeyko@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <4a6a9ef3-cfa1-46df-bf82-d083ef30041a@gmail.com>
Subject: Re: [PATCH] hfsplus: remove xattr error message
References: <20260411125338.165758-1-colin.i.king@gmail.com>
 <b0e9b8218a2daeb65c8481d1f4646f3ca89d713a.camel@redhat.com>
In-Reply-To: <b0e9b8218a2daeb65c8481d1f4646f3ca89d713a.camel@redhat.com>

--------------4IYhQ8y7jIWS0Xs5wN7f9s6i
Content-Type: multipart/mixed; boundary="------------D66ieKmmla7J80M1SzSLQqn7"

--------------D66ieKmmla7J80M1SzSLQqn7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMvMDQvMjAyNiAxODoxMiwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiBPbiBT
YXQsIDIwMjYtMDQtMTEgYXQgMTM6NTMgKzAxMDAsIENvbGluIElhbiBLaW5nIHdyb3RlOg0K
Pj4gV2hlbiBleGVyY2lzaW5nIGhmc3BsdXMgd2l0aCB0aGUgc3RyZXNzLW5nIHhhdHRyIHN0
cmVzc29yIGEgbGFyZ2UNCj4+IHF1YW50aXR5IG9mIHNvbWV3aGF0IHVuaGVscGZ1bCBlcnJv
ciBtZXNzYWdlcyAiaGZzcGx1czogeGF0dHIgZXhpc3RzDQo+PiB5ZXQiIHNwYW0gdGhlIGtl
cm5lbCBsb2cuIFJlbW92ZSB0aGVzZS4NCj4gDQo+IFdlIGNhbiBjb252ZXJ0IGl0IGludG8g
aGZzX2RiZygpIGFuZCB0byBhZGQgc2hvd2luZyBpbm9kZSBJRCArIG5hbWUuIFdoYXQgZG8g
eW91DQo+IHRoaW5rPw0KDQpZZXMsIHRoYXQncyBhIGdvb2QgaWRlYS4gUGVyaGFwcyB0aGUg
cGhyYXNlICJ4YXR0ciBleGlzdHMgeWV0IiBjYW4gYmUgDQpyZXBocmFzZWQgYXMgdGhlIG1l
c3NhZ2UgaXMgbm90IHJlYWxseSB0aGF0IGNsZWFyLiBBbnkgaWRlYXMgZm9yIGFuIA0KaW1w
cm92ZWQgbWVzc2FnZT8NCg0KQ29saW4NCg0KPiANCj4gQWxzbywgdGhlcmUgYXJlIG90aGVy
IHByX2VycigpIGluIHhhdHRyIGNvZGUgdGhhdCBjYW4gYmUgY29udmVydGVkIGludG8NCj4g
aGZzX2RiZygpLiBDb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29rIGludG8gb3RoZXIgb25l
cyB0b28/DQo+IA0KPiBUaGFua3MsDQo+IFNsYXZhLg0KPiANCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT4NCj4+IC0tLQ0K
Pj4gICBmcy9oZnNwbHVzL3hhdHRyLmMgfCAyIC0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAy
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL3hhdHRyLmMg
Yi9mcy9oZnNwbHVzL3hhdHRyLmMNCj4+IGluZGV4IGM3MGJiNmY0OTRiMi4uZTEwZTFkOGE1
ODYyIDEwMDY0NA0KPj4gLS0tIGEvZnMvaGZzcGx1cy94YXR0ci5jDQo+PiArKysgYi9mcy9o
ZnNwbHVzL3hhdHRyLmMNCj4+IEBAIC0zMDEsNyArMzAxLDYgQEAgaW50IF9faGZzcGx1c19z
ZXR4YXR0cihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCBjaGFyICpuYW1lLA0KPj4gICAN
Cj4+ICAgCWlmICghc3RyY21wX3hhdHRyX2ZpbmRlcl9pbmZvKG5hbWUpKSB7DQo+PiAgIAkJ
aWYgKGZsYWdzICYgWEFUVFJfQ1JFQVRFKSB7DQo+PiAtCQkJcHJfZXJyKCJ4YXR0ciBleGlz
dHMgeWV0XG4iKTsNCj4+ICAgCQkJZXJyID0gLUVPUE5PVFNVUFA7DQo+PiAgIAkJCWdvdG8g
ZW5kX3NldHhhdHRyOw0KPj4gICAJCX0NCj4+IEBAIC0zNDgsNyArMzQ3LDYgQEAgaW50IF9f
aGZzcGx1c19zZXR4YXR0cihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCBjaGFyICpuYW1l
LA0KPj4gICANCj4+ICAgCWlmIChoZnNwbHVzX2F0dHJfZXhpc3RzKGlub2RlLCBuYW1lKSkg
ew0KPj4gICAJCWlmIChmbGFncyAmIFhBVFRSX0NSRUFURSkgew0KPj4gLQkJCXByX2Vycigi
eGF0dHIgZXhpc3RzIHlldFxuIik7DQo+PiAgIAkJCWVyciA9IC1FT1BOT1RTVVBQOw0KPj4g
ICAJCQlnb3RvIGVuZF9zZXR4YXR0cjsNCj4+ICAgCQl9DQo+IA0KDQo=
--------------D66ieKmmla7J80M1SzSLQqn7
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------D66ieKmmla7J80M1SzSLQqn7--

--------------4IYhQ8y7jIWS0Xs5wN7f9s6i--

--------------5eE77470xSMep7d00RsOjinV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmneoTwFAwAAAAAACgkQaMKH38aoAiZ3
2xAAqN3Qeb9FDTOlT6TN7DlMw3eviXRqImm4K+SiI15KGUSkwiPWXaH7L0r9ujhQf4W9tPLur22C
g4XR2zfxKg0NTQxs31L/yA2hoKwOX9UjPsxPZCkdtmPckH7FOln0xlARprQSkH6H3RZ3t+mFyXoS
EiElXrheTUSTf4KVZ98uIGyZrLm4a2dFpqbbdsedYDQQNk8Vs8qZoj1EpVJ/pC77os5GJkOUxiJt
+3zq0urAIspG/GCnSiX+0INOLICB0XbgXn1gJS8pRB2Kr4qAK3O7ts2DgDYIl9n7PXg+NGkb16h9
xL1y4vdT27LzhzIZKNEECpZP/j/mExOImf+a6I62OSMu9XxYZktazIC1/woSaGDt/xPknLpxc+Jh
Cd/bqGUzkqKOE4Wbe0YwWKmufwSu6SVC4FK56wN6tOCVkitg1lgElo2ir799tiBvdS0Kh8qj6+zu
Nk0YVP+HOMK5eUHZLm2MNHYOwDkA05HVw7XzHQc3Fj+k+IbAxwJlQUU0bZuEuQtbw4MS3fN+NR7p
Kq5l+ad5n7iCDirlbUzyDZGs5ldA6vRJPwH0JVth3YxeBwn8Zw65zDcWegBOuPVaohQmy9yKqOkp
9zzc18x9ZxJ97v3CyA4aj89/Wiuq0oHoV9WJnTAlM+sMwqV8T89ppqHSd+Vcwiz933LMai6fIkMD
iaI=
=jJSu
-----END PGP SIGNATURE-----

--------------5eE77470xSMep7d00RsOjinV--
