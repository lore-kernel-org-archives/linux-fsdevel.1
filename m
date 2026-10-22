Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653301;
	b=HAu4dQiQDWhOEq3J1TqVdJrrgkiDSHnfy9pxHdn2RK8CaPOExgeyT0qErlrmRMZrjwhA
	 qlNpt4kdoYBGcUR9Ca3MPrmoemzv594P1n+YR1wwSyX1QjoniOdGRIteuBl40awmLP5VJ
	 P6OTEmCEURPg91yD60I/X9N0zYIkVtbcrgLvqp61sxiYGtaihwZ1kFTYqfB27RhlIwU28
	 wsxxZ9DOk5pQsTiKEZGxER7LUAW+nNt4Jl1idn7cihF+E8p+Qj49pm0pjM5Ky/QHBhht4
	 A7ysKHKJFCG68RA9MQTh1339V6N2C0mqDMfGZmZGaQRRV/0SNBLaRbxuHr/JVTEpGKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653301;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Reply-To:Message-ID:Subject:X-Mailer:MIME-Version:
	 x-aliyun-im-through:x-aliyun-mail-creator:x-aliyun-mailtrack:
	 Content-Type:Content-Transfer-Encoding;
	bh=IXslyo3svzvvM0WBQuHyfy17WFzlnrNdUcm/DdWmIwA=;
	b=WS7H2djkJSBi/mYVSfrzfOpnkbJb3pmRzmxBnOC5HmUoeBwbjRu9e+tx2R6vRnos4n2Q
	 rUWmzuU5sA7szsofXZrebG5yxTk1AXsfMAK7f1x1n0Xt5Gy2JQiMOTlaOd0p7sZTosAUV
	 WIwAWx9O4ERIzfV0DouIKTV+DHP5V1Wz4qhFHVIa6tIKdr3fj1wDEGxC6moCdV/RyO6se
	 YDPtgWE7SmLlRr2uUrqm9d7xQ4fpIa2EQWcUCjZGGk9yi62EnOPu74OPN+RHgTYT+xvl8
	 +hCCY1Vne1AC6+fbwxBlEu1FBc3cVBsZryuDd0I3c/FLuIKTP++ZAtys8NRa4/JuDfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=antgroup.com;
	spf=pass smtp.mailfrom=antgroup.com;
	dkim=pass header.d=antgroup.com header.i=@antgroup.com header.a=rsa-sha256 header.s=default header.b="Cfp/iAJR";
	arc=none smtp.remote-ip=115.124.28.122
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BEB606A319;
	Thu, 22 Oct 2026 07:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05BEB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antgroup.com header.i=@antgroup.com header.a=rsa-sha256 header.s=default header.b=Cfp/iAJR
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1792653288; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=IXslyo3svzvvM0WBQuHyfy17WFzlnrNdUcm/DdWmIwA=;
	b=Cfp/iAJRihbtSkH45+kPnaKJemgXowgyyQUkzokXQ8GUfSQR5TZuauwE46ieek6k6s6tDOLFjj0hqm1PevLAlfmjivbqjGTbK3nr7pCr8Gc9dnJY4UBX4AZmO7j8Dq9c0+pz7bfXXwSkVi/eshez5gmP+NGsl0x7mT1LQWmeaRg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=luojunrui.ljr@antgroup.com;NM=1;PH=DW;RN=5;SR=0;TI=W4_0.2.3_v5ForWebDing_21252944_1792652413528_o7001c73p;
Received: from WS-web (luojunrui.ljr@antgroup.com[W4_0.2.3_v5ForWebDing_21252944_1792652413528_o7001c73p] cluster:ay29) at Thu, 22 Oct 2026 15:14:43 +0800
Date: Thu, 22 Oct 2026 15:14:43 +0800
From: "=?UTF-8?B?SnVucnVpIEx1byAoQU5UIEFJIFNlY3VyaXR5IExhYik=?=" <luojunrui.ljr@antgroup.com>
To: "Ali Ahmet Memis" <ali@iusegentoo.com>
Cc: "Jan Kara" <jack@suse.cz>,
  "Christian Brauner" <brauner@kernel.org>,
  "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
  "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "=?UTF-8?B?SnVucnVpIEx1byAoQU5UIEFJIFNlY3VyaXR5IExhYik=?=" <luojunrui.ljr@antgroup.com>
Message-ID: <adb0ff6b-7f0d-42db-8cdb-6f75810b59d1.luojunrui.ljr@antgroup.com>
Subject: =?UTF-8?B?W1BBVENIXSB1ZnM6IHZhbGlkYXRlIHRoZSBpbm9kZSBiaXRtYXAgcmFuZ2U=?=
X-Mailer: [Alimail-Mailagent revision 74][W4_0.2.3][v5ForWebDing][Chrome]
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzE0OS4wLjAuMCBTYWZhcmkvNTM3LjM2La
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

dWZzX3JlYWRfY3lsaW5kZXIoKSBjYWNoZXMgY2dfaXVzZWRvZmYgd2l0aG91dCBjaGVja2luZyB0
aGF0IHRoZSBpbm9kZQpiaXRtYXAgZml0cyBpbiB0aGUgbG9hZGVkIGN5bGluZGVyLWdyb3VwIGJ1
ZmZlcnMuIEEgbWFsZm9ybWVkIG9mZnNldApvciBiaXRtYXAgbGVuZ3RoIGNhbiBjYXVzZSBvdXQt
b2YtYm91bmRzIGFjY2Vzc2VzIGR1cmluZyBpbm9kZQphbGxvY2F0aW9uIGFuZCBmcmVlaW5nLgoK
UmVqZWN0IGN5bGluZGVyIGdyb3VwcyB3aG9zZSBpbm9kZSBiaXRtYXAgZXhjZWVkcyB0aGUgbG9h
ZGVkIGJ1ZmZlcnMuCgpGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGludXgtMi42LjEyLXJjMiIpCkNj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEp1bnJ1aSBMdW8gKEFOVCBB
SSBTZWN1cml0eSBMYWIpIDxsdW9qdW5ydWkubGpyQGFudGdyb3VwLmNvbT4KLS0tCiBmcy91ZnMv
Y3lsaW5kZXIuYyB8IDggKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvdWZzL2N5bGluZGVyLmMgYi9mcy91ZnMv
Y3lsaW5kZXIuYwppbmRleCBiOTMwZWUxY2Y4NTMuLjJiMzczNTlkNzQ2NCAxMDA2NDQKLS0tIGEv
ZnMvdWZzL2N5bGluZGVyLmMKKysrIGIvZnMvdWZzL2N5bGluZGVyLmMKQEAgLTMzLDcgKzMzLDcg
QEAgc3RhdGljIGJvb2wgdWZzX3JlYWRfY3lsaW5kZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwK
IAlzdHJ1Y3QgdWZzX3NiX3ByaXZhdGVfaW5mbyAqIHVzcGk7CiAJc3RydWN0IHVmc19jZ19wcml2
YXRlX2luZm8gKiB1Y3BpOwogCXN0cnVjdCB1ZnNfY3lsaW5kZXJfZ3JvdXAgKiB1Y2c7Ci0JdW5z
aWduZWQgaSwgajsKKwl1bnNpZ25lZCBpLCBqLCBjZ3NpemU7CiAKIAlVRlNEKCJFTlRFUiwgY2du
byAldSwgYml0bWFwX25yICV1XG4iLCBjZ25vLCBiaXRtYXBfbnIpOwogCXVzcGkgPSBzYmktPnNf
dXNwaTsKQEAgLTY5LDExICs2OSwxNSBAQCBzdGF0aWMgYm9vbCB1ZnNfcmVhZF9jeWxpbmRlcihz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLAogCXVjcGktPmNfY2x1c3Rlcm9mZiA9IGZzMzJfdG9fY3B1
KHNiLCB1Y2ctPmNnX3UuY2dfNDQuY2dfY2x1c3Rlcm9mZik7CiAJdWNwaS0+Y19uY2x1c3RlcmJs
a3MgPSBmczMyX3RvX2NwdShzYiwgdWNnLT5jZ191LmNnXzQ0LmNnX25jbHVzdGVyYmxrcyk7CiAK
KwljZ3NpemUgPSBVQ1BJX1VCSCh1Y3BpKS0+Y291bnQgPDwgc2ItPnNfYmxvY2tzaXplX2JpdHM7
CisKIAkvKiB0aGVzZSBvbi1kaXNrIHZhbHVlcyBiZWNvbWUgYXJyYXkgYW5kIGJpdG1hcCBpbmRp
Y2VzICovCiAJaWYgKHVjcGktPmNfY2d4ICE9IGNnbm8gfHwKIAkgICAgdWNwaS0+Y19yb3RvciA+
PSB1c3BpLT5zX2ZwZyB8fAogCSAgICB1Y3BpLT5jX2Zyb3RvciA+PSB1c3BpLT5zX2ZwZyB8fAot
CSAgICB1Y3BpLT5jX2lyb3RvciA+PSB1c3BpLT5zX2lwZykgeworCSAgICB1Y3BpLT5jX2lyb3Rv
ciA+PSB1c3BpLT5zX2lwZyB8fAorCSAgICB1Y3BpLT5jX2l1c2Vkb2ZmID49IGNnc2l6ZSB8fAor
CSAgICBESVZfUk9VTkRfVVBfVUxMKHVzcGktPnNfaXBnLCA4KSA+IGNnc2l6ZSAtIHVjcGktPmNf
aXVzZWRvZmYpIHsKIAkJdWZzX2Vycm9yKHNiLCBfX2Z1bmNfXywKIAkJCSAgImluY29uc2lzdGVu
dCBtZXRhZGF0YSBpbiBjeWxpbmRlciBncm91cCAldVxuIiwgY2dubyk7CiAJCWdvdG8gZmFpbGVk
OwotLSAKMi4yNS4xCgoK
