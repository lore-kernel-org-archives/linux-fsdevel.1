Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B881E511;
	Fri, 24 Apr 2026 01:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776992951; cv=none; b=GZ0qhlIWQ2KLpP/lsey8aABw9RvP03CK9gRf8pD0s24MMmE48Cg7BcQ7CjhZ5igcuzK0PykwVS2hiskLB9ip0UqGAcHlqMfjUKDIMYNSql0t/30/f7xlwy2+bmFfgEvHXx2+OAMAaqhbwzZOi/ZnUZmueG/BrjPQR7bZdoJ+9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776992951; c=relaxed/simple;
	bh=rnq4RWnsTy4lXDa/rQB6twwAVqU3G0R+DkIdM741GHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WfWeAAkmJvX1POVUvA9LDOpGRTzIjdRjivnK8TRs97dcd7qYvZND4A1O37wAvO6eT04XhMp0eveLwxHXqHsq1Ms67O0OU0J16S1HKirOj8qhq46ekZ+RwShQZBlIlMCFLvGdZgwx9Pb9kNiZjavDgJ0cqg/6bN/vfi1BMdelcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4g1vwq6lpCz4r78b;
	Fri, 24 Apr 2026 09:08:43 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4g1vwq243jz4r78b;
	Fri, 24 Apr 2026 09:08:43 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 03A6D3006724;
	Fri, 24 Apr 2026 09:08:37 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 24 Apr
 2026 09:08:35 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Fri, 24 Apr 2026 09:08:35 +0800
From: Yibin Liu <liuyibin@hygon.cn>
To: Lorenzo Stoakes <ljs@kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>, Jianyong Wu <wujianyong@hygon.cn>,
	Huangsj <huangsj@hygon.cn>, Yuan Zhong <zhongyuan@hygon.cn>, "jack@suse.cz"
	<jack@suse.cz>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "alex.aring@gmail.com"
	<alex.aring@gmail.com>, "vbabka@kernel.org" <vbabka@kernel.org>,
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gbW06IEFkZCBSV0hfUk1BUF9FWENM?=
 =?utf-8?Q?UDE_flag_to_exclude_files_from_rmap_sharing?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG1tOiBBZGQgUldIX1JNQVBfRVhDTFVERSBmbGFn?=
 =?utf-8?Q?_to_exclude_files_from_rmap_sharing?=
Thread-Index: AQHc0kWjdlrDL8nbPE+Fpw0BQ/z5wrXrBF9Q//+3pQCAAqdBAA==
Date: Fri, 24 Apr 2026 01:08:35 +0000
Message-ID: <a96c20b74b874248bc0cdc2b926a43fe@hygon.cn>
References: <20260421020932.3212532-1-liuyibin@hygon.cn>
 <aeikm2e5Gh5reJ30@lucifer> <bc514883d6154420b3cfde4ab25a20c7@hygon.cn>
 <aejzSsiXZBK1emv7@lucifer>
In-Reply-To: <aejzSsiXZBK1emv7@lucifer>
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

PiBPbiBXZWQsIEFwciAyMiwgMjAyNiBhdCAxMjo1MTowNlBNICswMDAwLCBZaWJpbiBMaXUgd3Jv
dGU6DQo+ID4gRmlyc3Qgb2YgYWxsLCBJIGFtIHRydWx5IHNvcnJ5IGZvciBub3QgdXNpbmcgUkZD
Lg0KPiA+IFNlY29uZGx5LCBJIG9taXR0ZWQgbWFueSBtYWludGFpbmVycyBiZWNhdXNlIEkgd2Fu
dGVkIHRvIOKAnG5vdCBkaXN0dXJiIHRvbw0KPiBtYW55IHBlb3BsZeKAnSwNCj4gPiBhbmQgSSBh
cG9sb2dpemUgZGVlcGx5IGZvciB0aGF0LiBJIHdpbGwgZnVsbHkgZm9sbG93IHRoZXNlIHR3byBy
dWxlcyBmcm9tIG5vdyBvbi4NCj4gPg0KPiA+IEFzIGZvciB0aGlzIHBhdGNoLCBpbmRlZWQsIGFz
IE1hdHRoZXcgc2FpZCwgdGhlIHRydW5jYXRlIHBhcnQgaXMgbm90IGZlYXNpYmxlLg0KPiA+IE15
IG9yaWdpbmFsIGludGVudGlvbiB3YXMgdG8gYXBwbHkgdGhpcyB0byBmcmVxdWVudGx5IHVzZWQg
bGlicmFyeSBmaWxlcyBsaWtlIGxpYmMNCj4gYW5kIGxkLg0KPiA+IENvbnRlbnRpb24gb24gdGhl
IGlfbW1hcF9yd3NlbSBsb2NrICh3aGljaCBldmVudHVhbGx5IHR1cm5zIGludG8gb3NxX2xvY2sp
DQo+IGNhdXNlZCBieQ0KPiA+IHRoZXNlIHR3byBmaWxlcyBhbG9uZSByZWFjaGVzIHVwIHRvIDcw
JSBpbiB0aGUg4oCcMjU2LWNvcmUgZXhlY2zigJ0gY2FzZSwgYXMNCj4gb2JzZXJ2ZWQgZnJvbQ0K
PiA+IGZsYW1lIGdyYXBocy4gQmVzaWRlcywgbm8gb25lIHBlcmZvcm1zIHRydW5jYXRlIG9wZXJh
dGlvbnMgb24gbGliYyBhbmQgbGQNCj4gYW55d2F5Lg0KPiANCj4gSW50ZXJlc3RpbmcsIHdvdWxk
IGJlIGdvb2QgdG8gc2VlIHRoZXNlPyBBbmQgbW9yZSBkZXRhaWxzIG9uIHRoZSBzY2VuYXJpbz8N
Cj4gDQo+IFdoYXQgd29ya2xvYWRzIGFyZSBjb250ZW5kaW5nIHRoYXQgZXhhY3RseT8NCj4gDQoN
Ckl0IGlzIGdvb2QgdG8gc2VlLg0KT24gYW4gSW50ZWwgRW1lcmFsZCBSYXBpZHMgc2VydmVyICgx
MTIgY29yZXMpLCBydW4gdGhlIGV4ZWNsIGJlbmNobWFyayBmcm9tDQpVbml4QmVuY2ggd2l0aCB0
aGUgY29tbWFuZDogLi9SdW4gLWMgMjIwIGV4ZWNsDQpUaGVuIHBlcmYgdG9wIHNob3dzOg0KDQog
IDkxLjUzJSAgW2tlcm5lbF0gICAgICAgICAgICAgICAgICAgIFtrXSBvc3FfbG9jaw0KICAgMC41
MCUgIFtrZXJuZWxdICAgICAgICAgICAgICAgICAgICBba10gcndzZW1fc3Bpbl9vbl9vd25lcg0K
ICAgMC40NSUgIHBlcmYgICAgICAgICAgICAgICAgICAgICAgICBbLl0gcXVldWVfZXZlbnQNCiAg
IDAuNDIlICBba2VybmVsXSAgICAgICAgICAgICAgICAgICAgW2tdIHZtYV9pbnRlcnZhbF90cmVl
X2luc2VydA0KICAgMC4zNiUgIFtrZXJuZWxdICAgICAgICAgICAgICAgICAgICBba10gbmV4dF91
cHRvZGF0ZV9mb2xpbw0KICAgMC4yNSUgIFtrZXJuZWxdICAgICAgICAgICAgICAgICAgICBba10g
X196YXBfdm1hX3JhbmdlDQoNCkFsbCB0aGUgb3NxX2xvY2sgb3ZlcmhlYWQgaGVyZSBjb21lcyBm
cm9tIHJ3c2VtX29wdGltaXN0aWNfc3BpbiwgYW5kDQpyd3NlbV9vcHRpbWlzdGljX3NwaW4gaGFz
IG1hbnkgY2FsbCBzb3VyY2VzLg0KVGhlIGJyZWFrZG93biBpcyByb3VnaGx5IGFzIGZvbGxvd3M6
DQoNCjYuMTMlICBfZGxfbWFpbi0tPm1wcm90ZWN0LS0+Li4uLS0+X19zcGxpdF92bWEtLT52bWFf
cHJlcGFyZS0tPmRvd25fd3JpdGUoJm1hcHBpbmctPmlfbW1hcF9yd3NlbSkNCjYuMTUlICBicHJt
X2V4ZWN2ZS0tPi4uLi0tPmV4aXRfbW1hcC0tPi4uLi0tPnVubGlua19maWxlX3ZtYV9iYXRjaF9w
cm9jZXNzLS0+ZG93bl93cml0ZSgmbWFwcGluZy0+aV9tbWFwX3J3c2VtKQ0KMjQuNzElIHZtYV9s
aW5rX2ZpbGUtLT4uLi4tLT5kb3duX3dyaXRlKCZtYXBwaW5nLT5pX21tYXBfcndzZW0pDQoyNC44
MiUgbW1hcF9yZWdpb24tLT4uLi4tLT5mcmVlX3BndGFsYmVzLS0+dW5saW5rX2ZpbGVfdm1hX2Jh
dGNoX3Byb2Nlc3MtLT5kb3duX3dyaXRlKCZtYXBwaW5nLT5pX21tYXBfcndzZW0pDQoxOC41JSAg
bW1hcF9yZWdpb24tLT4uLi4tLT5fX3NwbGl0X3ZtYS0+dm1hX3ByZWFwcmUtLT5kb3duX3dyaXRl
KCZtYXBwaW5nLT5pX21tYXBfcndzZW0pDQoxMi40NCUgX2RsX21hcF9wcm9qZWN0LS0+bXByb3Rl
Y3QtLT4uLi4tLT5fX3NwbGl0X3ZtYS0tPnZtYV9wcmVwYXJlLS0+ZG93bl93cml0ZSgmbWFwcGlu
Zy0+aV9tbWFwX3J3c2VtKQ0KDQpBbmQgQU1EIFplbjUoOTc1NSkgcGVyZm9ybXMgcHJldHR5IG11
Y2ggdGhlIHNhbWUgd2F5ICh0ZXN0ZWQgd2l0aCAuL1J1biAtYyAyNTAgZXhlY2wpLg0KDQo+ID4N
Cj4gPiBTbyBJIHdhbnRlZCB0byB0cnkgc2tpcHBpbmcgcm1hcCBmb3IgdGhlbS4gU2luY2UgdGhl
eSBhcmUgc21hbGwsIGV2ZW4gaWYgdGhleQ0KPiBjYW5ub3QNCj4gPiBiZSByZWNsYWltZWQgb3Ig
bWlncmF0ZWQsIEkgYXNzdW1lZCBpdCB3b3VsZCBub3QgY2F1c2UgbXVjaCB0cm91YmxlLiBPZg0K
PiBjb3Vyc2UsDQo+ID4gdGhpcyBpZGVhIHdhcyB0b3RhbGx5IHdyb25nLCBhbmQgSSB3aWxsIGRl
ZmluaXRlbHkgbWFyayBzdWNoIGluc2FuZSBwcm9wb3NhbHMNCj4gd2l0aCBSRkMgaW4gdGhlIGZ1
dHVyZS4NCj4gPg0KPiA+IFRoZXNlIGlkZWFzIGFyZSBpbnNwaXJlZCBieSBNYXRldXN64oCZcyB3
b3JrIGFuZCB0aG91Z2h0cw0KPiA+DQo+IChodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1t
bS9DQUd1ZG9IRWZpT1BKMlZHRVYzZkRUOWNEc3VvSEItd2s4amctaw0KPiAtRUs2SmhXZ2lIa1d3
QG1haWwuZ21haWwuY29tLyksDQo+ID4gc28gSSBzcGVjaWZpY2FsbHkgQ0PigJlkIGhpbSB0byBz
ZWVrIG1vcmUgb3BpbmlvbnMgYW5kIGluc2lnaHRzLg0KPiANCj4gSSB0aGluayB0aGUgYmVzdCB0
aGluZyBpbiBnZW5lcmFsIGdvaW5nIGZvcndhcmRzIGlzIHRvIGJyaW5nIHVwIHRoaXMgaXNzdWVz
IGluDQo+IGFkdmFuY2UsIHdlJ3JlIG1vcmUgdGhhbiBoYXBweSB0byBsb29rIGludG8gdGhpbmdz
IGFuZCB2ZXJ5IGludGVyZXN0ZWQgaW4gaXNzdWVzDQo+IHdpdGggbG9jayBjb250ZW50aW9uLCBs
YXRlbmN5LCBldGMuDQo+IA0KPiBBbmQgdGhhdCB3YXkgeW91IGNhbiBkaXNjdXNzIGlkZWFzIHlv
dSBtaWdodCBoYXZlIHRvIHRhY2tsZSB1cCBmcm9udCBhbmQgd2UgY2FuDQo+IGdpdmUgeW91IGVh
cmx5IGZlZWRiYWNrLCB3aGljaCBzaG91bGQgc2F2ZSB0aW1lIGFsbCByb3VuZCBhbmQgaGVscCBn
ZXQgdXMgdG8gYQ0KPiBnb29kIHNvbHV0aW9uIDopDQo+IA0KPiBKdXN0IHNlbmQgd2l0aCBhIFtE
SVNDVVNTSU9OXSBwcmVmYWNlIGFuZCBjYy0gcGVvcGxlIHlvdSBmZWVsIGFyZSByZWxldmFudCAo
dXNlDQo+IE1BSU5UQUlORVJTIHRvIGZpZ3VyZSBvdXQgZS5nLiBtYWludGFpbmVycyBvZiByZWxl
dmFudCB0aGluZ3MsIGxpa2Ugcm1hcCwNCj4gbW1hcCwNCj4gZXRjLikNCj4gDQo+ID4NCj4gPiBM
YXN0bHksIEkgc2luY2VyZWx5IGFwb2xvZ2l6ZSBmb3IgdGhlIHRyb3VibGUgSSBoYXZlIGNhdXNl
ZCB0aGUgY29tbXVuaXR5Lg0KPiA+IEkgd2lsbCBzdHJpY3RseSBmb2xsb3cgY29tbXVuaXR5IGNv
bnZlbnRpb25zIHdoZW4gc2VuZGluZyBwYXRjaGVzIGluIHRoZQ0KPiBmdXR1cmUuDQo+IA0KPiBJ
dCdzIG5vIHByb2JsZW0sIGJldHRlciB0byBiZSBkaXJlY3QgYWJvdXQgdGhpcyAtIGl0J3MgbW9y
ZSB1c2VmdWwgdG8gZGlzY3Vzcw0KPiByYXRoZXIgdGhhbiB0byBqdW1wIHRvIGEgc29sdXRpb24g
d2l0aG91dCBjb21tdW5pdHkgaW52b2x2ZW1lbnQsIHdoaWNoIG1pZ2h0DQo+IG5vdA0KPiB3b3Jr
IG91dC9jb25mbGljdCB3aXRoIG90aGVyIHN0dWZmIGV0Yy4NCj4gDQo+IFRoYW5rcywgTG9yZW56
bw0KDQpUaGFua3MgZm9yIHRoZSBraW5kIGFkdmljZS4NCg0KSSB3aWxsIHN0YXJ0IGEgZGlzY3Vz
c2lvbiBmaXJzdCB3aXRoIGEgW0RJU0NVU1NJT05dIHRhZyBhbmQgaW52b2x2ZSByZWxldmFudA0K
bWFpbnRhaW5lcnMgZm9yIHNpbWlsYXIgaWRlYXMgaW4gdGhlIGZ1dHVyZS4NCg0KVGhhbmtzLCBZ
aWJpbg0K

