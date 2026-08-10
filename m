Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB7145B3F
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786321329; cv=none; b=A+3PrY5nH7BNX64NXGb5bjrvj81BwECqFhrS8d+dMNEaZ7VNqXp5OCqb2UpNSSie208KeBIORKH1NriaAgn1kTSV4299S8nCFcIK1gy5lqN4FuZGArxXsP6pRqtsXT9qqfQKa4C0MX/S1LUkvInATmVn22fGCq8erl04Zt9Cy9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786321329; c=relaxed/simple;
	bh=GIwUV2G5B82ttz4RR5yrvVeCGMbentO5f3paTcE0lv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=huuhPBUHkATkCaJzVfjVfpEekVeGe7AgvCsXLUx4nTsgUJxSlZJeIoCL8BKsmEofnBWs95gOlccr+XxVsmSsp+e0TcYGPH3sb4SoF00WnpjPYjaI0oDmSX7Jf7oeWaFxM7cdyBWxMHpC3AmIGQZ+a1CGfOTse2l+L0OKU0fn4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=UP9GI7tJ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="UP9GI7tJ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ecf499af9so17610437b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Aug 2026 17:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1786321327; x=1786926127; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GIwUV2G5B82ttz4RR5yrvVeCGMbentO5f3paTcE0lv8=;
        b=UP9GI7tJEOAl3XLjjFpCjESaqDqBYAZ/C+yE4hpTtPcGNBGfVi3t3110EFUt23RuJH
         cfg98eSpct4rYYYezRqQich6v0Vh9g4FdYqpWkHSXTA8BwV/uwxK1sBZtbS1q/LUsylx
         Xswtzztvl9WTaeVyknXegEKjaXR60wkUyI69Ovtm7vaYJ50n1Z80lG8GyyPtad9WWG9V
         Wg5YIgejeNMkVXWNkuqpOsvmf8EvahCYSv5u3cSdxcUqDbkg8IGF7p6+G6Gob8nVEzAT
         QSfjDxw8a7CfyHPLWRhLGcoC9zCXhMtNs/jYQLwIcr7duIqOVbScPyEZsyYOK8HbbzeG
         dasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786321327; x=1786926127;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GIwUV2G5B82ttz4RR5yrvVeCGMbentO5f3paTcE0lv8=;
        b=p/oA5N6DluS7QxLqsTybZqHQY1vkRflvvq3CxzC6AG6Q1mazixqbvxTyHM9BUEBGRh
         4ip5r6AD9hvv+I6AeNNdFWG0MsgXwbWsEn76hvWg8RHG18+5fK8GyTWSVZJL1JQQ6vDi
         uEwWUEpZdkw7CXNBeAojQ/rpdmH4HSkdlXFDQ0wnXFHzYqOiXp1D1qJmh21rhJZ8fNFq
         dYtW4pQD+QOSbJzZWAaNjhY13N1SMoTkXughEFR5htsdVfd0hKM9MZpgo0442pdyKf+Q
         ZGsdIlgaIS3HFu2yNg6t0A8d2W06Bz8cKgE10k57gNwBIH2X4fK8BecbCK4C+Pb10rmu
         TJNg==
X-Forwarded-Encrypted: i=1; AHgh+Rry4wmBnj8XKHb9XNtZYd5qaH6yfRi6Qh58zjDaOrXvuijvK8DoC3opKN/xwZ6Y6nbbPGsi0bAunr07jALU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3wT0OwonOI2F8IA0EnrQJVRbuuN47bE4qDZ7GCpXZW3Xso/p
	cghZ41q8GlAxG33nemISz8wk6beUuogSmo73G3hg2HfDtvxFu/Bd+Kciv7DDdZ6wu+o=
X-Gm-Gg: AR+sD12noVS4jB7MCAOax59fR6hb0YICFyTVrq0cC3ArUtY1v/DORf//8qTbO9wFQly
	uW36WC0qxhA4IG56K5ttXL5GFrhci8ikwbk5QMwmKGBAF/wBZ+5oJkJ7GEOYEmOGGttpyfUrmkl
	peKBJ7muBMIr0+ws5kMP3xcBNRQhkDjDcZnSjisbhc8KKUaKL3tCojczpvYEbpwTQk/1nrNgCmT
	0d00G1BXonjswy2hbT7zlJAMwfkem3vHDOX/wDXNgdrY7x89TF++JDHg940uIjr44eE8Zk9HM0C
	DEYYkPsozjk1+sw+pIAGDAytgKQx3rN+7bRFsflvfb1eAi63vuA05b+nd16oEFKiEP+iH/Eh+P0
	HUQs4oyhtbPmj9uglfc5ZcqD0rVlFhslw9p6QalV3p+f15LaWVg3PcRL2ZVHuXNi/CdCxvSQ5iG
	cy/HjpRLXCo0YY4xC0A5z8+sg7IOtXHBObQVplv3pnr5bCqW3+k3wB7FyOq8JkxVdCRpOAxNOrP
	vm6UdTKfReR/r+HGDGL0n5cK4LFUg/Bb8TirPyShfX0YMHYXtgG3eUtfTuaYDtNtWXRyOnye55E
	mY0pk5x9HSP4zhBB
X-Received: by 2002:a05:690c:b85:b0:81e:6cd1:5329 with SMTP id 00721157ae682-8202275ac60mr231650537b3.34.1786321327387;
        Sun, 09 Aug 2026 17:22:07 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:c24:25ad:39a6:33c1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f098ec15sm47191317b3.15.2026.08.09.17.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 17:22:05 -0700 (PDT)
Message-ID: <0720c3ba6399c11a0a328e8d8eef99a19e6999c8.camel@dubeyko.com>
Subject: Re: [PATCH v6] hfsplus: validate B-tree record offset table
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, vdubeyko@coreweave.com
Date: Sun, 09 Aug 2026 17:22:03 -0700
In-Reply-To: <CANypQFZ-kejru9P3D7rvCzDp5hP-xqM9okq7LpiHEobbU=oQpw@mail.gmail.com>
References: <ee23d8f65b44586d6b630bec295fd581a6be1160.camel@dubeyko.com>
	 <20260806073358.1184938-1-r772577952@gmail.com>
	 <cbd7003314c530d4f910eacf019ff80adad6687e.camel@dubeyko.com>
	 <CANypQFZ-kejru9P3D7rvCzDp5hP-xqM9okq7LpiHEobbU=oQpw@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU2F0LCAyMDI2LTA4LTA4IGF0IDIyOjUwICswODAwLCBKaWFtaW5nIFpoYW5nIHdyb3RlOgo+
ID4gCgo8c2tpcHBlZD4KCj4gPiBJJ3ZlIHJlYWxpemVkIHRoYXQgd2UgaGF2ZSBhZGRpdGlvbmFs
IGlzc3VlIGluIEhGUysgbG9naWMuCj4gPiBQb3RlbnRpYWxseSwKPiA+IGtleWxlbiBhbmQgbGVu
IGNvdWxkIGJlIG5vdCBpbnZhbGlkIGJ1dCB3ZSBjb3VsZCBoYXZlIG5lZ2F0aXZlCj4gPiB2YWx1
ZQo+ID4gbGF0ZXIgaW4gdGhlIGxvZ2ljOgo+ID4gCj4gPiBkb25lOgo+ID4gwqDCoMKgwqDCoMKg
wqAgZmQtPnJlY29yZCA9IGU7Cj4gPiDCoMKgwqDCoMKgwqDCoCBmZC0+a2V5b2Zmc2V0ID0gb2Zm
Owo+ID4gwqDCoMKgwqDCoMKgwqAgZmQtPmtleWxlbmd0aCA9IGtleWxlbjsKPiA+IMKgwqDCoMKg
wqDCoMKgIGZkLT5lbnRyeW9mZnNldCA9IG9mZiArIGtleWxlbjsKPiA+IMKgwqDCoMKgwqDCoMKg
IGZkLT5lbnRyeWxlbmd0aCA9IGxlbiAtIGtleWxlbjsgPC0tIG5lZ2F0aXZlIHZhbHVlIGhlcmUu
Cj4gPiAKPiA+IFRoZSBuZWdhdGl2ZSB2YWx1ZSBvZiBmZC0+ZW50cnlsZW5ndGggaXMgY2hlY2tl
ZCBpbiBtdWx0aXBsZQo+ID4gcGxhY2VzLgo+ID4gSG93ZXZlciwgdGhlcmUgaXMgZXh0ZW50cyB0
cmVlIGxvZ2ljIHRoYXQgaGFzIG5vIHN1Y2ggY2hlY2sgWzFdOgo+ID4gCj4gPiBzdGF0aWMgaW50
IF9faGZzcGx1c19leHRfd3JpdGVfZXh0ZW50KHN0cnVjdCBpbm9kZSAqaW5vZGUsCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGhmc19maW5kX2RhdGEgKmZkKQo+ID4g
ewo+ID4gPHNraXBwZWQ+Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJlcykKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJlczsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBoZnNfYm5vZGVfd3JpdGUoZmQtPmJub2RlLCBoaXAtPmNhY2hl
ZF9leHRlbnRzLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZmQtPmVudHJ5b2Zmc2V0LCBmZC0+ZW50cnlsZW5ndGgpOwo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhpcC0+ZXh0ZW50X3N0YXRlICY9IH5I
RlNQTFVTX0VYVF9ESVJUWTsKPiA+IMKgwqDCoMKgwqDCoMKgIH0KPiA+IAo+ID4gPHNraXBwZWQ+
Cj4gPiB9Cj4gPiAKPiA+IENvdWxkIHlvdSBwbGVhc2UgZG91YmxlIGNoZWNrIG15IGNvbmNsdXNp
b24/IFdlIGNhbiBmaXggdGhlIGlzc3VlCj4gPiBpbgo+ID4gYW5vdGhlciBwYXRjaC4gQ291bGQg
eW91IHBsZWFzZSBmaXggdGhlIGlzc3VlPwo+ID4gCj4gCj4gSSBhZ3JlZSB3aXRoIHlvdXIgY29u
Y2x1c2lvbi4gQSBjcmFmdGVkIGltYWdlIGNhbiBrZWVwIGJvdGggbGVuIGFuZAo+IGtleWxlbiB2
YWxpZCBidXQgbWFrZSBmZC0+ZW50cnlsZW5ndGggbmVnYXRpdmUgKGkuZS4ga2V5bGVuID4gbGVu
KSwKPiB3aGljaCBtYXkgbGVhZCB0byBvdXQtb2YtYm91bmQgcmVhZCBhbmQga2VybmVsIG1lbW9y
eSBsZWFraW5nLgo+IAo+IFRvIGZpeCB0aGlzIGlzc3VlLCB3ZSBjYW4gY2hlY2sgdmFsaWRpdHkg
b2YgZmQtPmVudHJ5bGVuZ3RoIGluCj4gX19oZnNwbHVzX2V4dF93cml0ZV9leHRlbnQoKSBsaWtl
IHRoZSBjaGVjayBpbgo+IF9faGZzcGx1c19leHRfcmVhZF9leHRlbnQoKS4gRm9yIGV4YW1wbGU6
Cj4gCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvZXh0ZW50cy5jIGIvZnMvaGZzcGx1cy9leHRl
bnRzLmMKPiBpbmRleCA4MTNlNjhiOGVjZDYuLmViN2MxMTUyNGQxOCAxMDA2NDQKPiAtLS0gYS9m
cy9oZnNwbHVzL2V4dGVudHMuYwo+ICsrKyBiL2ZzL2hmc3BsdXMvZXh0ZW50cy5jCj4gQEAgLTEx
MCw2ICsxMTAsOCBAQCBzdGF0aWMgaW50IF9faGZzcGx1c19leHRfd3JpdGVfZXh0ZW50KHN0cnVj
dAo+IGlub2RlICppbm9kZSwKPiDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmVzKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJlczsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoZmQtPmVudHJ5bGVuZ3RoICE9IHNpemVvZihoZnNwbHVzX2V4dGVudF9yZWMp
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
LUVJTzsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaGZzX2Jub2RlX3dyaXRlKGZk
LT5ibm9kZSwgaGlwLT5jYWNoZWRfZXh0ZW50cywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmZC0+ZW50cnlvZmZzZXQsIGZk
LT5lbnRyeWxlbmd0aCk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhpcC0+ZXh0
ZW50X3N0YXRlICY9IH5IRlNQTFVTX0VYVF9ESVJUWTsKPiAKPiBEbyB5b3UgdGhpbmsgdGhpcyBm
aXggaXMgYWNjZXB0YWJsZT8gSWYgc28sIEknbSBoYXBweSB0byBzZW5kIGFub3RoZXIKPiBwYXRj
aC4KPiAKCkFzIGZhciBhcyBJIGNhbiBzZWUsIHRoZSBmaXggbWFrZXMgc2Vuc2UuCgpUaGFua3Ms
ClNsYXZhLgo=

