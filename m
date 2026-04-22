Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55D212554;
	Wed, 22 Apr 2026 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863036; cv=none; b=YmYbIfqMFjC+uwn2m4QXj4V9ozv90i4HLesYL84Eq2i2O1P4h+vFg1Hjq3uMaIH+pCj2skNEzstkC76gYQUbmWsvfb87CAvpu7K02SV44iIW5GvOWUVhZavsY7iFYryiFt30XGUNl3df3ehxMM0w4vis/Yxh1dBmVeyPwYqWlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863036; c=relaxed/simple;
	bh=UCVUeGdlFfGlA93XmYUteXT3qdaKxKb/nR4f2YXDczw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wk5vMYP39VtRm7XoVFD4GRsM9lf0O+G9iW2pLi48H+YZznTmUjrCrFSbyHi6Mj+pVHmc0ocyWsAPpbCR+0DBa1v8GnGRElqTqixM4Uubx657aBMhOhcYqjg4YlsV9W2fiIJvEjzvbRGRXDvwlT+LY24eCjtvrXGgWn9O4Jun8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4g0ztT6lWXz1YQpmJ;
	Wed, 22 Apr 2026 21:03:29 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4g0ztS3Mx8z1YQpmJ;
	Wed, 22 Apr 2026 21:03:28 +0800 (CST)
Received: from cncheex05.Hygon.cn (unknown [172.23.18.115])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id E658932B354C;
	Wed, 22 Apr 2026 21:03:24 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex05.Hygon.cn
 (172.23.18.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 22 Apr
 2026 21:03:19 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Wed, 22 Apr 2026 21:03:19 +0800
From: Yibin Liu <liuyibin@hygon.cn>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>,
	Jianyong Wu <wujianyong@hygon.cn>, Huangsj <huangsj@hygon.cn>, Yuan Zhong
	<zhongyuan@hygon.cn>, "jack@suse.cz" <jack@suse.cz>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>, "vbabka@kernel.org"
	<vbabka@kernel.org>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Lorenzo Stoakes <ljs@kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG1tOiBBZGQgUldIX1JNQVBfRVhDTFVERSBmbGFn?=
 =?utf-8?Q?_to_exclude_files_from_rmap_sharing?=
Thread-Topic: [PATCH] mm: Add RWH_RMAP_EXCLUDE flag to exclude files from rmap
 sharing
Thread-Index: AQHc0ceWdlrDL8nbPE+Fpw0BQ/z5wrXrCmTg
Date: Wed, 22 Apr 2026 13:03:19 +0000
Message-ID: <67a71b489eb3413ab0907351d3c56d31@hygon.cn>
References: <20260421020932.3212532-1-liuyibin@hygon.cn>
 <CAGudoHHki3gv-HXXMALePDoC+tmao4oWcYgCo9kXNDkEhW4E4g@mail.gmail.com>
In-Reply-To: <CAGudoHHki3gv-HXXMALePDoC+tmao4oWcYgCo9kXNDkEhW4E4g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBPbiBUdWUsIEFwciAyMSwgMjAyNiBhdCA0OjEx4oCvQU0gWWliaW4gTGl1IDxsaXV5aWJpbkBo
eWdvbi5jbj4gd3JvdGU6DQo+ID4NCj4gPiBVbml4QmVuY2ggZXhlY2wvc2hlbGxzY3JpcHQgKGR5
bmFtaWNhbGx5IGxpbmtlZCBiaW5hcmllcykgYXQgNjQrIGNvcmVzIGFyZQ0KPiA+IGJvdHRsZW5l
Y2tlZCBvbiB0aGUgaV9tbWFwX3J3c2VtIHNlbWFwaG9yZSBkdWUgdG8gaGVhdnkgdm1hDQo+IGlu
c2VydC9yZW1vdmUNCj4gPiBvcGVyYXRpb25zIG9uIHRoZSBpX21tYXAgdHJlZSwgd2hlcmUgbGli
Yy5zby42IGlzIHRoZSBtb3N0IGZyZXF1ZW50LA0KPiA+IGZvbGxvd2VkIGJ5IGxkLWxpbnV4LXg4
Ni02NC5zby4yIGFuZCB0aGUgdGVzdCBleGVjdXRhYmxlIGl0c2VsZi4NCj4gPg0KPiA+IFRoaXMg
cGF0Y2ggbWFya3Mgc3VjaCBmaWxlcyB0byBza2lwIHJtYXAgb3BlcmF0aW9ucywgYXZvaWRpbmcg
ZnJlcXVlbnQNCj4gPiBpbnRlcnZhbCB0cmVlIGluc2VydC9yZW1vdmUgdGhhdCBjYXVzZSBpX21t
YXBfcndzZW0gbG9jayBjb250ZW50aW9uLg0KPiA+IFRoZSBkb3duc2lkZSBpcyB0aGVzZSBmaWxl
cyBjYW4gbm8gbG9uZ2VyIGJlIHJlY2xhaW1lZCAoYWxvbmcgd2l0aCBjb21wYWN0DQo+ID4gYW5k
IGtzbSksIGJ1dCBzaW5jZSB0aGV5IGFyZSBzbWFsbCBhbmQgcmVzaWRlbnQgYW55d2F5LCBpdCdz
IGFjY2VwdGFibGUuDQo+ID4gV2hlbiBhbGwgbWFwcGluZyBwcm9jZXNzZXMgZXhpdCwgZmlsZXMg
Y2FuIHN0aWxsIGJlIHJlY2xhaW1lZCBub3JtYWxseS4NCj4gPg0KPiA+IFBlcmZvcm1hbmNlIHRl
c3Rpbmcgc2hvd3MgfjgwJSBpbXByb3ZlbWVudCBpbiBVbml4QmVuY2ggZXhlY2wvc2hlbGxzY3Jp
cHQNCj4gPiBzY29yZXMgb24gSHlnb24gNzQ5MCwgQU1EIHplbjQgOTc1NCBhbmQgSW50ZWwgZW1l
cmFsZCByYXBpZHMgcGxhdGZvcm0uDQo+ID4NCj4gDQo+IFRoZSBvdGhlciByZXNwb25kZXJzIGhh
dmUgYmVlbiBhIGxpdHRsZSBoYXJzaCBhbmQgZGVzcGl0ZSByYWlzaW5nDQo+IHZhbGlkIHBvaW50
cyBJIGRvbid0IHRoaW5rIHRoZXkgZ2F2ZSBhIHByb3BlciByZXZpZXcuDQo+IA0KPiBUaGUgYmln
Z2VyIHBpY3R1cmUgaXMgdGhhdCB0aGUgcHJvYmxlbWF0aWMgcndzZW0gaXMgdGFrZW4gc2V2ZXJh
bA0KPiB0aW1lcyBkdXJpbmcgZm9yayArIGV4ZWMgKyBleGl0IGN5Y2xlLiBOb3JtYWxseSB5b3Ug
ZW5kIHVwIHdpdGggNQ0KPiBkaXN0aW5jdCBtYXBwaW5ncyBwZXIgYmluYXJ5L3NvLCBlYWNoIGNy
ZWF0ZWQgd2l0aCBhIHNlcGFyYXRlIGxvY2sNCj4gYWNxdWlyZS4NCj4gDQo+IFNvbWUgdGltZSBh
Z28gSSBwYXRjaGVkIGV4aXQgdG8gYmF0Y2ggcHJvY2Vzc2luZywgbGVhdmluZyAxIGFjcXVpcmUg
aW4NCj4gdGhhdCBjb2RlcGF0aC4gZm9yayBjYW4gYW5kIHNob3VsZCBiZSBwYXRjaGVkIGluIGEg
c2ltaWxhciB2ZWluLCBidXQgSQ0KPiBkb24ndCBrbm93IGlmIHVuaXhiZW5jaCBydW5zIGl0IGlu
IHRoaXMgYmVuY2htYXJrIChpLmUuLCByZWFsDQo+IHdvcmtsb2FkcyBjZXJ0YWlubHkgc3VmZmVy
IGZyb20gaXQsIEkgZG9uJ3Qga25vdyBpZiB0aGlzIHBhcnRpY3VsYXINCj4gYmVuY2ggaW5jbHVk
ZXMgdGhhdCBhc3BlY3QpLiBUaGlzIGlzIG9uIHRvcCBvZiBmb3JraW5nIGl0c2VsZiBiZWluZw0K
PiBhdm9pZGFibGUgc2hvdWxkIHRoZSBrZXJuZWwgZ3JvdyBhIGJldHRlciBpbnRlcmZhY2UgZm9y
IGV4ZWN1dGluZw0KPiBiaW5hcmllcy4NCj4gDQpUaGFuayB5b3UgZm9yIHlvdXIgb3BuaW9ucyBh
bmQgYWR2aWNlcywgSSdsbCB0cnkgdGhpcyB3YXkNCj4gVGhpcyBsZWF2ZXMgdXMgd2l0aCBtYXBw
aW5nIGNyZWF0aW9uIG9uIGV4ZWMuIFRoaXMgcHJvYmxlbSBpcw0KPiB1bmZpeGFibGUgd2l0aG91
dCBpbnRyb2R1Y3Rpb24gb2YgYmV0dGVyIEFQSXMgZm9yIHVzZXJzcGFjZSwgd2hpY2gNCj4gY29u
c3RpdHV0ZXMgcXVpdGUgYSBjaGFsbGVuZ2UuDQo+IA0KPiBUaGUgZW5kIHJlc3VsdCBpcyB0aGUg
YWJzb2x1dGVseSBob3JyaWJsZSBjYXNlIG9mIG11bHRpcGxlIGFjcXVpcmVzIG9mDQo+IHRoZSBz
YW1lIGxvY2sgcGVyIGl0ZXJhdGlvbi4NCj4gDQo+IE9uZSBjb21tb24gaWRlYSBob3cgdG8gcmVk
dWNlIGNvbnRlbnRpb24gYm9pbHMgZG93biB0byBzaG9ydGVuaW5nIGxvY2sNCj4gaG9sZCB0aW1l
LiBUaGlzIGhhcyB2ZXJ5IGxpbWl0ZWQgZWZmZWN0IGluIGZhY2Ugb2YgdGhlIGFmb3JlbWVudGlv
bmVkDQo+IG11bHRpcGxlIGFjcXVpcmVzIGFuZCBpcyBhdCBiZXN0IGEgc3RvcCBnYXAgLS0gbm8g
bWF0dGVyIHdoYXQsIHRoZQ0KPiBjZWlsaW5nIGlzIGRpY3RhdGVkIGJ5IHRoZSBleHRyYSBhY3F1
aXJlcyBhbmQgaXQgaXMgaW5jcmVkaWJseSBsb3cuDQo+IA0KPiBZb3VyIHBhdGNoIGtlZXBzIHRo
ZSBwcm9ibGVtYXRpYyBhY3F1aXJlIHBhdHRlcm4gaW50YWN0IGFuZCB3aGlsZSB0aGUNCj4gODAl
IHdpbiBtaWdodCBzb3VuZCBlbmNvdXJhZ2luZywgdGhlIGVuZCByZXN1bHQgaXMgc3RpbGwgc2V2
ZXJlbHkNCj4gdW5kZXJwZXJmb3JtaW5nIGV2ZW4gYSBzdGF0ZSB3aGVyZSB0aGUgbG9jayBpcyB0
YWtlbiBvbmNlIGluIHRvdGFsDQo+IGR1cmluZyBleGVjLg0KPiANCj4gQmVzaWRlcyB0aGF0LCB0
aGUgaW50ZXJuYWxseS12aXNpYmxlIHNpZGUgZWZmZWN0IG9mIG5vbi1mdW5jdGlvbmFsDQo+IHJt
YXAgaXMgcHJldHR5IGJhZCAoYW5kIHRodXMgZS5nLiwgdHJ1bmNhdGUpIGlzIHByZXR0eSBiYWQg
aW4gaXRzIG93bg0KPiByaWdodCwgYnV0IGxldCdzIGlnbm9yZSBpdC4gVGhlIHByaW1hcnkgcHJv
YmxlbSBoZXJlIGlzIHRoYXQgdGhlIHBhdGNoDQo+IGV4cG9zZXMgYSBtZWNoYW5pc20gZm9yIHVz
ZXJzcGFjZSB0byBkaWN0YXRlIHRoaXMgaW4gdGhlIGZpcnN0IHBsYWNlLg0KPiBFdmVuIGlnbm9y
aW5nIHRoZSBxdWVzdGlvbiBvZiB3aG8gc2hvdWxkIGJlIHVzaW5nIGl0IGFuZCB3aGVuLCB0aGUN
Cj4gcmVhbCBzb2x1dGlvbiB0byB0aGUgcHJvYmxlbSB3b3VsZCBiZSBjb25maW5lZCB0byB0aGUg
a2VybmVsLiBTdXBwb3NlDQo+IHRoaXMgcGF0Y2ggbGFuZHMgYW5kIHN1Y2ggYSBzb2x1dGlvbiBp
cyBpbXBsZW1lbnRlZCBsYXRlciAtLSBub3cgdGhlDQo+IGtlcm5lbCBpcyBzdHVjayBoYXZpbmcg
dG8gc3VwcG9ydCBhIG5vdy11c2VsZXNzIChpZiBub3Qgb3V0cmlnaHQNCj4gaGFybWZ1bCkgZmVh
dHVyZS4NCk9LLiBJIHVuZGVyc3RhbmQgaXQgbm93Lg0KPiANCj4gV2hhdCB3aWxsIGZpeCB0aGUg
cHJvYmxlbSBpcyBzaGFyZGluZyB0aGUgc3RhdGUgaW4gc29tZSBjYXBhY2l0eSwNCj4gcHJvdmlk
ZWQgbm8gdW5maXhhYmxlIHN0b3BnYXAgc2hvd3MgdXAuDQo+IA0KPiBBbnkgb3RoZXIgYXBwcm9h
Y2ggaXMgcHV0dGluZyBzbWFsbCBiYW5kYWlkcyBvbiBpdCBhbmQgY2FuIGJlIGENCj4gY29uc2lk
ZXJhdGlvbiBvbmx5IGlmIHRoZSBkZWNlbnRyYWxpemluZyBsb2NraW5nIGlzIHByb3ZlbiB0b28N
Cj4gcHJvYmxlbWF0aWMuDQo+IA0KPiBQZWRybyBhcHBhcmVudGx5IHZvbHVudGVlcmVkIHRvIGRv
IHRoZSB3b3JrLCBzbyBJIHRoaW5rIHdlIGNhbiB3YWl0IHRvDQo+IHNlZSB3aGF0IGhlIGlzIGdv
aW5nIHRvIGVuZCB1cCBjb29raW5nLg0KPiANCj4gSSBob3BlIHRoaXMgaGVscHMuDQo+IA0KDQo=

