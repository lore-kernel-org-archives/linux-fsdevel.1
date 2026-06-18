Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 56BC23AA182;
	Thu, 18 Jun 2026 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772244; cv=none; b=ejb/gwJ2CBD9Vc3VT2voKHvYlRGvFqalQXyYvfr4bOWlZl3sU0piMXGBxmaao6MR5FmfNnz2fct5Rhuuexi7QNJEOa8tOS0ajA1EZ1v2yTfmj4lUuGjpoFQpBu/rkTez3bmhHpfCGuDMWddZL9xNF970QPeFv646Y97GQb66Fuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772244; c=relaxed/simple;
	bh=Yy2Om45W5FEFgPOAqKj9h16i/OpLgkVAXO6bnSqJsyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XFdJQUJnsJQ8U5/qMWy9ay+VCfxQXDqEl9tb154Qh91AgB7cy0lhF/ksS1E+dVFyYaZYPPi/7qAPKYSXgbfaACeh9ww+U+N9e7HP6Ki5t4dRtPItTB7NTGeS09pV2olE291WAaPI0KAMB6de69hyiFnn2dG3GGPhX9N3D3rbZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=mReXtYuk; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="mReXtYuk"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.48
From: "Li,Rongqing" <lirongqing@baidu.com>
To: David Howells <dhowells@redhat.com>, Christian Brauner
	<christian@brauner.io>
CC: Marc Dionne <marc.dionne@auristor.com>, "linux-afs@lists.infradead.org"
	<linux-afs@lists.infradead.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFtQQVRDSCB2MiAxNC8xN10gYWZzOiBSZW1vdmUgZXJy?=
 =?gb2312?Q?oneous_seq_|=3D_1_in_volume_lookup_loop?=
Thread-Topic: [????] [PATCH v2 14/17] afs: Remove erroneous seq |= 1 in volume
 lookup loop
Thread-Index: AQHc/vcc7WY4cV0CAkmAdgSfMtjLErZD+urA
Date: Thu, 18 Jun 2026 08:43:40 +0000
Message-ID: <2e4b689b91fa4d28a00c5aba058b964b@baidu.com>
References: <20260618074903.2374756-1-dhowells@redhat.com>
 <20260618074903.2374756-15-dhowells@redhat.com>
In-Reply-To: <20260618074903.2374756-15-dhowells@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1781772226;
	bh=Yy2Om45W5FEFgPOAqKj9h16i/OpLgkVAXO6bnSqJsyg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=mReXtYukPubpPUjqXmprCrsjAgfO27KygzH+KD78INtT8apjkp89Pqqt0xftdYUv6
	 JZwDXxTXHw7h9RHPIhFYdJYrmkVvTNEZKAo98opBFmWVgBkxX8rbUsXKW0w+iZAxCw
	 gpgqjGUIyNNan210YRBbKKSTe7QUJFsv79tg0ORUw3nA+UZWxHzIpbHVsY/7qFBbRn
	 42D4JPYeWd/IwZPMINgcI9FO0QvA8LhNkjo0yHn4KVUyHmOf0/nPX1T1DUEfATuA38
	 LGfhAJt7e4wxbZ2BqEi+Yi8tsoMwCPk9Bvx2u+aPuBWttXIpQqvBX6YX3AAP3EpdF7
	 0fIlzUqn3/t9w==

DQoNCj4g1vfM4jogWz8/Pz9dIFtQQVRDSCB2MiAxNC8xN10gYWZzOiBSZW1vdmUgZXJyb25lb3Vz
IHNlcSB8PSAxIGluIHZvbHVtZSBsb29rdXANCj4gbG9vcA0KDQpJIHRoaW5rIHRoaXMgdGl0bGUg
aXMgaW5hY2N1cmF0ZQ0KDQo+IA0KPiBUaGlzIGlzIGFuIGFkZGVuZHVtIHRvIHRoZSBwYXRjaCB0
byByZW1vdmUgdGhlIGVycm9uZW91cyBzZXEgfD0gMSBpbiB2b2x1bWUNCj4gbG9va3VwIGxvb3Au
DQo+IA0KPiBTd2l0Y2ggdG8gdXNpbmcgc2NvcGVkX3NlcWxvY2tfcmVhZCgpIGFzIHN1Z2dlc3Rl
ZCBieSBPbGVnIE5lc3Rlcm92WzFdLg0KPiANCj4gRml4ZXM6IDMyMjIyZjA5NzgyZiAoImFmczog
QXBwbHkgc2VydmVyIGJyZWFrcyB0byBtbWFwJ2QgZmlsZXMgaW4gdGhlIGNhbGwNCj4gcHJvY2Vz
c29yIikNCg0KQW5kIHRoaXMgRml4ZXMgaXMgbm90IG5lZWRlZCBkdWUgdG8gdGhlIHNpeHRoIHBh
dGNoDQoNCltMaSxSb25ncWluZ10gDQoNCg0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIb3dlbGxz
IDxkaG93ZWxsc0ByZWRoYXQuY29tPg0KPiBjYzogTWFyYyBEaW9ubmUgPG1hcmMuZGlvbm5lQGF1
cmlzdG9yLmNvbT4NCj4gY2M6IE9sZWcgTmVzdGVyb3YgPG9sZWdAcmVkaGF0LmNvbT4NCj4gY2M6
IExpIFJvbmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gY2M6IGxpbnV4LWFmc0BsaXN0
cy5pbmZyYWRlYWQub3JnDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvYWlmYWVL
dnozS2VtZnphU0ByZWRoYXQuY29tLyBbMV0NCj4gLS0tDQo+ICBmcy9hZnMvY2FsbGJhY2suYyB8
IDkgKy0tLS0tLS0tDQo+ICBmcy9hZnMvaW50ZXJuYWwuaCB8IDIgLS0NCj4gIDIgZmlsZXMgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2ZzL2Fmcy9jYWxsYmFjay5jIGIvZnMvYWZzL2NhbGxiYWNrLmMgaW5kZXgNCj4gODMzYWMzMTc4
ZGRjLi5kZDdhNDA3ZWEzNjggMTAwNjQ0DQo+IC0tLSBhL2ZzL2Fmcy9jYWxsYmFjay5jDQo+ICsr
KyBiL2ZzL2Fmcy9jYWxsYmFjay5jDQo+IEBAIC0xMTMsMTYgKzExMywxMiBAQCBzdGF0aWMgc3Ry
dWN0IGFmc192b2x1bWUNCj4gKmFmc19sb29rdXBfdm9sdW1lX3JjdShzdHJ1Y3QgYWZzX2NlbGwg
KmNlbGwsICB7DQo+ICAJc3RydWN0IGFmc192b2x1bWUgKnZvbHVtZSA9IE5VTEw7DQo+ICAJc3Ry
dWN0IHJiX25vZGUgKnA7DQo+IC0JaW50IHNlcSA9IDE7DQo+IA0KPiAtCWZvciAoOzspIHsNCj4g
KwlzY29wZWRfc2VxbG9ja19yZWFkKCZjZWxsLT52b2x1bWVfbG9jaywgc3NfbG9jaykgew0KPiAg
CQkvKiBVbmZvcnR1bmF0ZWx5LCByYnRyZWUgd2Fsa2luZyBkb2Vzbid0IGdpdmUgcmVsaWFibGUg
cmVzdWx0cw0KPiAgCQkgKiB1bmRlciBqdXN0IHRoZSBSQ1UgcmVhZCBsb2NrLCBzbyB3ZSBoYXZl
IHRvIGNoZWNrIGZvcg0KPiAgCQkgKiBjaGFuZ2VzLg0KPiAgCQkgKi8NCj4gLQkJc2VxKys7IC8q
IDIgb24gdGhlIDFzdC9sb2NrbGVzcyBwYXRoLCBvdGhlcndpc2Ugb2RkICovDQo+IC0JCXJlYWRf
c2VxYmVnaW5fb3JfbG9jaygmY2VsbC0+dm9sdW1lX2xvY2ssICZzZXEpOw0KPiAtDQo+ICAJCXAg
PSByY3VfZGVyZWZlcmVuY2VfcmF3KGNlbGwtPnZvbHVtZXMucmJfbm9kZSk7DQo+ICAJCXdoaWxl
IChwKSB7DQo+ICAJCQl2b2x1bWUgPSByYl9lbnRyeShwLCBzdHJ1Y3QgYWZzX3ZvbHVtZSwgY2Vs
bF9ub2RlKTsgQEAgLTEzOCwxMQ0KPiArMTM0LDggQEAgc3RhdGljIHN0cnVjdCBhZnNfdm9sdW1l
ICphZnNfbG9va3VwX3ZvbHVtZV9yY3Uoc3RydWN0IGFmc19jZWxsDQo+ICpjZWxsLA0KPiANCj4g
IAkJaWYgKHZvbHVtZSAmJiBhZnNfdHJ5X2dldF92b2x1bWUodm9sdW1lLA0KPiBhZnNfdm9sdW1l
X3RyYWNlX2dldF9jYWxsYmFjaykpDQo+ICAJCQlicmVhazsNCj4gLQkJaWYgKCFuZWVkX3NlcXJl
dHJ5KCZjZWxsLT52b2x1bWVfbG9jaywgc2VxKSkNCj4gLQkJCWJyZWFrOw0KPiAgCX0NCj4gDQo+
IC0JZG9uZV9zZXFyZXRyeSgmY2VsbC0+dm9sdW1lX2xvY2ssIHNlcSk7DQo+ICAJcmV0dXJuIHZv
bHVtZTsNCj4gIH0NCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9hZnMvaW50ZXJuYWwuaCBiL2ZzL2Fm
cy9pbnRlcm5hbC5oIGluZGV4DQo+IDBiNzJhODU2NjI5OS4uNzg1YzY0Njg1NmQ3IDEwMDY0NA0K
PiAtLS0gYS9mcy9hZnMvaW50ZXJuYWwuaA0KPiArKysgYi9mcy9hZnMvaW50ZXJuYWwuaA0KPiBA
QCAtNzUwLDggKzc1MCw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhZnNfdm5vZGVfc2V0X2NhY2hl
KHN0cnVjdCBhZnNfdm5vZGUNCj4gKnZub2RlLCAgeyAgI2lmZGVmIENPTkZJR19BRlNfRlNDQUNI
RQ0KPiAgCXZub2RlLT5uZXRmcy5jYWNoZSA9IGNvb2tpZTsNCj4gLQlpZiAoY29va2llKQ0KPiAt
CQltYXBwaW5nX3NldF9yZWxlYXNlX2Fsd2F5cyh2bm9kZS0+bmV0ZnMuaW5vZGUuaV9tYXBwaW5n
KTsNCj4gICNlbmRpZg0KPiAgfQ0KPiANCg0K
