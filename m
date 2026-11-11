Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.238.7.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383530;
	b=l8sxV8X9TIRwpEv6L7xlOFi2mLUBX1A/6gsbCuatVlGmnDKjorHmxpitBbHCj78Yu2xA
	 q2ZWGxQSxNZ6RIq2FEsK8Z7/31Ec/QCsIuEED8dPph5xD2h+2cAnspMku1vXVGu4ONug5
	 HnkzHaBdpv3pBItboFp6dIxwrZF9e0TGK/BQtoQSB5zFhbCsAggcTSxMPev0cQ1qlStAM
	 L6GkRkKrM/Kdia8g+6nT33qMbBocS1ZQ96XoQN4fHvsoTzRDGl/gQ4JsWYbkFVba5xjCL
	 /+PT+xSG8zq8RhIFdMV9l7Na95dgW9iSuiZxWSw6c66v67/Kvrv/2E1X+lzQWGd0OfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383530;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-Halon-ID:
	 Received:Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:x-uu-exchange-origin:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lAdLzm0lC6RteZTIgPAPr9QVhABezDfRESoAcyYKOqc=;
	b=FuJZiRRmJUPpreTIeZd1QOxdJSqNy4IsdnFwJ9JWvHO9wZfPdTMFDECNN2fWSa48FzaU
	 yKh4mcnxK3Rw8mNq1wSH9AXF8FnGN28XZAxCVDgi7c2zF28ZUO7m6WoT+l7CJLpStPd2N
	 v2IiIIEbR3v8cb10ALNmRsvwBsTEaMivSOrh2ZVULFBK17+lp+wsUL5OOnqT6mgdetZ2w
	 S/dU+MMSoOzZcNNxOdJ6j4DHBm3cUC8iMkLXfVvnqhLy3aJC2waW+GtTRFBuJ1g4sLDPh
	 74d8sQC8HUvZJVMueWRnIcbjDHntHFoOwwPywRi32iAq1H9qxIQPz0At5p+sDwJmQSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=it.uu.se;
	spf=pass smtp.mailfrom=it.uu.se;
	dkim=pass header.d=uu.se header.i=@uu.se header.a=rsa-sha256 header.s=centralsmtp2 header.b=X0fzAzJB;
	dkim=pass header.d=it.uu.se header.i=@it.uu.se header.a=rsa-sha256 header.s=halon header.b=Qq5BqxLJ;
	arc=none smtp.remote-ip=130.238.7.173
Received: from smtp-out2.uu.se (smtp-out2.uu.se [130.238.7.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26C606A326
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 07:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B26C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=it.uu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it.uu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uu.se header.i=@uu.se header.a=rsa-sha256 header.s=centralsmtp2 header.b=X0fzAzJB;
	dkim=pass (2048-bit key, unprotected) header.d=it.uu.se header.i=@it.uu.se header.a=rsa-sha256 header.s=halon header.b=Qq5BqxLJ
Received: from mailfilter-ng-3.sunet.se (mailfilter-ng-3.sunet.se [192.36.171.200])
	by cursor.its.uu.se (Postfix) with ESMTP id 29739680356
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 08:43:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uu.se;
	s=centralsmtp2; t=1794383038;
	bh=lAdLzm0lC6RteZTIgPAPr9QVhABezDfRESoAcyYKOqc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=X0fzAzJBxqmCcUWUW107VD4jNm2DEjgqwA/gfIoTMmfIb0Ig9bP4C65WSTohrXzRZ
	 GrdJPf5Bkh0ojEp18Nf8ytBBpx4hCNrisLz+Hx8v/BxIJvD/TyXHksHCY79GYA15fU
	 34nhygh0wRqDzx2SQcry5O2a4QHK34qgzoSYNhHz8zzwtCfo6kQrtaHy5f/PX/BQGK
	 AUE/qcr7thBH0JIfkT/MUZzCLEpVi1qnvLCiLASjdmEKMotjLrQObTz2Rjrv4FVDaQ
	 iKQW9FmFMenowBFQU0rAr6nHR+T6Oi0ZjnVYkILNuf8R0CYcnLhe/KGcFeyeEOCrm2
	 eKo+tyM53aQzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=it.uu.se; s=halon;
	h=mime-version:content-transfer-encoding:content-id:content-type:in-reply-to:
	 references:message-id:date:subject:cc:to:from:from;
	bh=lAdLzm0lC6RteZTIgPAPr9QVhABezDfRESoAcyYKOqc=;
	b=Qq5BqxLJ4oAo00iMNlrHTOpc9HvjRubpjClAEe5L3t+l2IozLY455YfG9pN9eHB5WO2RSNeUZ927l
	 ODci0EOU9b3Nd/DbKkSRhAhErAihDZxMg3Lhq+AdjG0MU9Hbp8r7I0GBYk9LeAdTOWIYuImLeLcluL
	 37j/LfZd1I8HaOXVQIXN1N2Xjj9LpFOrIMzJRcXHz226+VHP2fvZMJJ5IKwdMZ2jJMTlwYMsCyPkRi
	 re0nJPjknrXj5GpwEWyfSZiCQLgosSuMOsD3V510XmS06H++eryZDC4QyhuL24WRYi5N7F0jYgXVGa
	 0oxoLONhHEkhuwGJvT5DjsLbvZU4CIg==
X-Halon-ID: a67b696e-dda3-11f1-95df-0050569a1168
Received: from lyra.its.uu.se (lyra.its.uu.se [130.238.7.73])
	by mailfilter-ng-3.sunet.se (Halon) with ESMTPS
	id a67b696e-dda3-11f1-95df-0050569a1168;
	Wed, 11 Nov 2026 07:43:56 +0000 (UTC)
Received: from smtp.user.uu.se (uuc-epost016.user.uu.se [130.238.3.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lyra.its.uu.se (Postfix) with ESMTPS id B1301600088;
	Wed, 11 Nov 2026 08:43:54 +0100 (CET)
Received: from UUC-EPOST014.user.uu.se (130.238.3.24) by
 UUC-EPOST016.user.uu.se (130.238.3.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 08:43:54 +0100
Received: from UUC-EPOST014.user.uu.se ([130.238.3.24]) by
 UUC-EPOST014.user.uu.se ([130.238.3.24]) with mapi id 15.02.2562.056; Wed, 11
 Nov 2026 08:43:54 +0100
From: Alireza Haddadi <alireza.haddadi@it.uu.se>
To: Gopal Malaviya <gopalmalaviya53@gmail.com>
CC: "jack@suse.cz" <jack@suse.cz>, "willy@infradead.org"
	<willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "vishal.moola@gmail.com"
	<vishal.moola@gmail.com>, "fujunjie1@qq.com" <fujunjie1@qq.com>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "tracekotae@gmail.com" <tracekotae@gmail.com>
Subject: Re: [PATCH] mm/filemap: let sequential faults restart mmap readahead
Thread-Topic: [PATCH] mm/filemap: let sequential faults restart mmap readahead
Thread-Index: AQHdcFXobp3vto+/eEuuawUN31FcZrcoN0gAgAA4CQA=
Date: Wed, 11 Nov 2026 07:43:54 +0000
Message-ID: <26E03EC6-F37C-4350-B2A9-1F354217F469@it.uu.se>
References: <20261109-mmap-miss-v1-1-8b44b33f3358@it.uu.se>
 <20261111042310.191979-1-gopalmalaviya53@gmail.com>
In-Reply-To: <20261111042310.191979-1-gopalmalaviya53@gmail.com>
Accept-Language: en-GB, sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-uu-exchange-origin: Internal
Content-Type: text/plain; charset="utf-8"
Content-ID: <00E735D1736E5D4697FA838A52C10B56@user.uu.se>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

DQoNCj4gT24gMTEgTm92IDIwMjYsIGF0IDA1OjIzLCBHb3BhbCBNYWxhdml5YSA8Z29wYWxtYWxh
dml5YTUzQGdtYWlsLmNvbT4gd3JvdGU6DQo+DQpIaSBHb3BhbCwNCg0KVGhhbmtzIGZvciB0ZXN0
aW5nIHRoaXMgc28gdGhvcm91Z2hseSwNCmFuZCBmb3IgcG9pbnRpbmcgbWUgdG8gVHJhY2XigJlz
IHJlcG9ydC4NCg0KPiBIaSBBbGlyZXphLA0KPg0KPiBJIGhhZCBzZW50IGEgZGlmZmVyZW50IGZp
eCBmb3IgdGhlIHNhbWUgcmVncmVzc2lvbiBbMV0sIHJlcG9ydGVkIGJ5DQo+IFRyYWNlIGluIFsy
XS4gSmFuIHByZWZlcnMgeW91cnMsIHNvIEkgaGF2ZSBkcm9wcGVkIG1pbmUuIEkgcmFuIHlvdXIN
Cj4gcGF0Y2gsIGFsc28gd2l0aCB0aGUgdjIgY2hhbmdlIHlvdSBkZXNjcmliZSB0byBKYW4sIHRo
cm91Z2ggdGhlIHRlc3RzDQo+IEkgaGFkOiBhIEtWTSBndWVzdCAoeDg2XzY0LCAyIHZDUFVzLCAz
IEdpQiksIG1tLWhvdGZpeGVzLXVuc3RhYmxlIGFzDQo+IG9mIDIwMjYtMTEtMDgsIGV4dDQgYW5k
IFhGUyB3aXRoIDE2IEtpQiBibG9ja3Mgb24gdmlydGlvLWJsaywNCj4gcmVhZF9haGVhZF9rYiAx
MjggdW5sZXNzIG5vdGVkLg0KPg0KPiBUaGUgcmVwcm9kdWNlciBmcm9tIFsyXSAoMjAwMCBzaW5n
bGUtcGFnZSBmYXVsdHMgMSBNaUIgYXBhcnQsIHRoZW4gYQ0KPiA2NCBNaUIgc2VxdWVudGlhbCBy
ZWFkKSwgbWFqb3IgZmF1bHRzIGluIHRoZSBzZXF1ZW50aWFsIHBhcnQ6DQo+DQo+ICAgICAgICAg
ICAgICAgICAgICAgICBiYXNlICAgYXMgcG9zdGVkICAgd2l0aCB2MiBjaGFuZ2UNCj4gIGV4dDQg
ICAgICAgICAgICAgICAgMTYzODQgICAgICAgICAgIDIgICAgICAgICAgICAgICAgMg0KPiAgWEZT
LCAxNiBLaUIgYmxvY2tzICAgNDA5NiAgICAgICAgNDA5NiAgICAgICAgICAgICAgICAyDQo+DQpU
aGF0IG1hdGNoZXMgd2hhdCBJIHNlZSBoZXJlOiBvbiBtbS1uZXcgd2l0aG91dCB0aGUgcGF0Y2gs
IFhGUyB3aXRoDQoxNmsgYmxvY2tzIHRha2Ugb25lIGZhdWx0IHBlciAxNiBLaUIgZm9saW8gaW4g
dGhlIGluLW9yZGVyIHJlYWQuDQo+IFRvdWNoaW5nIDElIG9mIHRoZSBwYWdlcyBvZiBhIGNvbGQg
MjAgR2lCIGZpbGUsIGxhcmdlciB0aGFuIG1lbW9yeSwgaW4NCj4gcmFuZG9tIHJ1bnMgb2YgMSwg
MiBvciA0IGFkamFjZW50IHBhZ2VzLCBNaUIgcmVhZCBmcm9tIGRpc2sgd2l0aCB0aGUNCj4gdjIg
Y2hhbmdlIChmaXJzdCBvZiB0d28gcnVuczsgdGhlIHNlY29uZCB3YXMgd2l0aGluIDEwJSk6DQo+
DQo+ICAgICAgICAgICAgICAgICAgICAgICByZWFkX2FoZWFkX2tiIDEyOCAgICAgcmVhZF9haGVh
ZF9rYiA4MTkyDQo+ICAgICAgICAgICAgICAgICAgICAgICAgYmFzZSAgIHdpdGggdjIgICAgICAg
IGJhc2UgICB3aXRoIHYyDQo+ICByYW5kb20gNC1wYWdlIHJ1bnMgICAgIDI0MCAgICAgIDExNDYg
ICAgICAgIDEyMDAgICAgIDU3NzQ4DQo+DQoNCj4gVGhlIDQtcGFnZSBydW5zIGF0IHJlYWRfYWhl
YWRfa2IgODE5Miwgd2hpY2ggaXMgd2hhdCB0aGlzIGd1ZXN0J3MNCj4gdmlydGlvLWJsayBkaXNr
IGdldHMgYnkgZGVmYXVsdCwgcmVhZCBhYm91dCA0OCB0aW1lcyBtb3JlLiBBcyBmYXIgYXMgSQ0K
PiBjYW4gdGVsbCwgZWFjaCBydW4gbm93IGhhcyB0d28gbWlzc2VzIGFuZCB1cCB0byB0d28gaGl0
cyBvbiB0aGUgbmV3DQo+IHdpbmRvdywgc28gbW1hcF9taXNzIHN0YXlzIGFyb3VuZCBNTUFQX0xP
VFNBTUlTUywgYW5kIGVhY2ggdGltZSBpdCBpcw0KPiBiYWNrIGF0IHRoZSBsaW1pdCB0aGUgbmV4
dCByYW5kb20gbWlzcyBnZXRzIHRoZSBmdWxsIDggTWlCDQo+IHJlYWQtYXJvdW5kLiBNeSBwYXRj
aCByYW4gaW50byB0aGUgc2FtZSBhbmQga2VwdCBtbWFwX21pc3MgYXQgaXRzIGNhcA0KPiBvbiB0
aGF0IHBhdGg7IHNvbWV0aGluZyBsaWtlIHRoYXQgbWF5IGhlbHAgaGVyZSwgYnV0IHlvdSBhbmQg
SmFuIGtub3cNCj4gdGhpcyBiZXR0ZXIuDQoNClRoaXMgaXMgYSByZWFsIHByb2JsZW0sIHRoYW5r
cyBmb3IgY2F0Y2hpbmcgaXQuIE5vbmUgb2YgbXkgdGVzdHMgaGFkDQpzaG9ydCBzZXF1ZW50aWFs
IHJ1bnMgYXQgcmFuZG9tIHBsYWNlcywgc28gSSBtaXNzZWQgaXQuIEnigJlsbCByZXByb2R1Y2UN
Cml0IGhlcmUgYW5kIHJld29yayB0aGUgcGF0Y2ggYmVmb3JlIHNlbmRpbmcgdjIuIEkgd2FudCB0
byBjb21wYXJlDQprZWVwaW5nIG1tYXBfbWlzcyBoaWdoIG9uIHRoYXQgcGF0aCwgYXMgeW91IGRp
ZCwgd2l0aCBvbmx5IHJlc3RhcnRpbmcNCnJlYWRhaGVhZCBvbmNlIHRoZSBmYXVsdCBjb250aW51
ZXMgYSBsb25nZXIgcnVuIG9mIGNhY2hlZCBwYWdlcy4NCg0KSmFuIHRoYW5rcyBmb3IgYmVpbmcg
T0sgd2l0aCB0aGUgbWluLW9yZGVyIGNoYW5nZS4gR2l2ZW4gdGhpcywgdjINCndpbGwgY2hhbmdl
IG1vcmUgdGhhbiwgc28gSSB3b27igJl0IGNhcnJ5IHlvdXIgUmV2aWV3ZWQtYnkgb3Zlci4NCkni
gJlkIGJlIGdsYWQgaWYgeW91IGNvdWxkIHRha2UgYW5vdGhlciBsb29rIGF0IHYyLg0KPg0KPiBP
biB0aGUgRml4ZXMgdGFnOiB3aXRoIHRoZSBjb21taXRzIG9mIHRoZSBzZXJpZXMgYnVpbHQgb25l
IGJ5IG9uZSwNCj4gY29tbWl0IDBiOWMwYWViYTkzOCAoIm1tL2ZpbGVtYXA6IGNvdW50IG9ubHkg
dGhlIGZhdWx0aW5nIGFkZHJlc3MgYXMNCj4gYSBtbWFwIGhpdCIpIGFsb25lIGRvZXMgbm90IHNo
b3cgdGhlIHByb2JsZW0gKDEgbWFqb3IgZmF1bHQgd2l0aCB0aGUNCj4gcmVwcm9kdWNlciksIGFu
ZCBjb21taXQgOWIwZmNhYzNjZmU3ICgibW0vZmlsZW1hcDogZG8gbm90IGNvdW50DQo+IEZBVUxU
X0ZMQUdfVFJJRUQgcmV0cmllcyBhcyBtbWFwIGhpdHMiKSBkb2VzICgxNjM4NCkuIFsyXSBpcyB0
aGUgc2FtZQ0KPiByZWdyZXNzaW9uLCBpbiBjYXNlIHlvdSB3YW50IHRvIGFkZCBSZXBvcnRlZC1i
eSBhbmQgQ2xvc2VzIHRhZ3MgZm9yDQo+IHJlZ3pib3QuDQo+DQpJIG9ubHkgdGVzdGVkIHJldmVy
dGluZyBib3RoIGNvbW1pdHMgdG9nZXRoZXIsIHNvIEnigJlsbCBjaGVjayB0aGlzIGFuZCBmaXgg
dGhlDQp0YWcgaW4gdjIsIGFuZCBhZGQgUmVwb3J0ZWQtYnkgYW5kIENsb3NlcyBmb3IgVHJhY2Xi
gJlzIHJlcG9ydC4NCg0KPiBJIGFtIGhhcHB5IHRvIHJ1biB0aGVzZSBhZ2FpbiBvbiB5b3VyIHYy
LiBUaGUgdGVzdHMgd2VyZSBzZXQgdXAgd2l0aA0KPiB0aGUgaGVscCBvZiBhbiBBSSBhc3Npc3Rh
bnQuDQoNClRoYXQgd291bGQgYmUgZ3JlYXQsIHRoYW5rIHlvdS4gQ291bGQgeW91IHNoYXJlIHRo
ZSBzaG9ydC1ydW4gdGVzdCwNClNvIEkgY2FuIHJ1biB0aGUgc2FtZSBoZXJlIHdoaWxlIHdvcmtp
bmcgb24gaXQ/DQoNCkJlc3QgUmVnYXJkcywNCkFsaXJlemENCg0KDQoNCg0KDQoNCg0KDQoNCk7D
pHIgZHUgaGFyIGtvbnRha3QgbWVkIG9zcyBww6UgVXBwc2FsYSB1bml2ZXJzaXRldCBtZWQgZS1w
b3N0IHPDpSBpbm5lYsOkciBkZXQgYXR0IHZpIGJlaGFuZGxhciBkaW5hIHBlcnNvbnVwcGdpZnRl
ci4gRsO2ciBhdHQgbMOkc2EgbWVyIG9tIGh1ciB2aSBnw7ZyIGRldCBrYW4gZHUgbMOkc2EgaMOk
cjogaHR0cDovL3d3dy51dS5zZS9vbS11dS9kYXRhc2t5ZGQtcGVyc29udXBwZ2lmdGVyLw0KDQpF
LW1haWxpbmcgVXBwc2FsYSBVbml2ZXJzaXR5IG1lYW5zIHRoYXQgd2Ugd2lsbCBwcm9jZXNzIHlv
dXIgcGVyc29uYWwgZGF0YS4gRm9yIG1vcmUgaW5mb3JtYXRpb24gb24gaG93IHRoaXMgaXMgcGVy
Zm9ybWVkLCBwbGVhc2UgcmVhZCBoZXJlOiBodHRwOi8vd3d3LnV1LnNlL2VuL2Fib3V0LXV1L2Rh
dGEtcHJvdGVjdGlvbi1wb2xpY3kNCg==
