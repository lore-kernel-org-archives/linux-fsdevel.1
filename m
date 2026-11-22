Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.182.106.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795308884;
	b=M4FdL5uRvTgzmCRYyML3ZGyYLEPRfA9k5uEVaD2ebNgOMa9daT/A3jA05bKHfPmh0lnY
	 w2CNgeAUA0HIhlV8dCJ55/5XzqalekVfXtuXoUvQAEQSSAokwAy8YAD/mfrgxMLDoAIwm
	 jhryn5i2oiSQK51YRxzvO1PuDNEqSiG24WHvOVHRFLLLlv/O6ZO+zEo8sTSbHTQD1Wv2F
	 9OeO6fgwtC4JhSORAusdrCBsM82VTq6yMEefSKsid9dx3+8y5c4x2qsWIUOzZxzby/5CV
	 UygukTCdSA8csnykoYlD7VEaNEAIT4zyAEaYOsIv0v5x1xGVUpohI+h+AbQo06WwrKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795308884;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:To:Reply-To:Message-ID:
	 List-Unsubscribe;
	bh=m4zOmNtgv2I8z90iDvC5XZMnjpR+BlfgbcOJZmRObtg=;
	b=w4qH6QnIi3LtybCmf3QPlyGw69jvynNR8AwxTRtR+ze6SNIhRzBmOK3w2z9+T+05+Pb/
	 +G/mKqCv58t/h1orVYuel1H1rJE7dvUD1nadJ+fccSoWAemlOxsMpOk8IIxepVRsaQaG5
	 U99ncrt3NmemODW+xvrwVdjINGyfuRcMyjHUKJ5nicbVawMix0gCV80MFf+O3lVoNLHyx
	 K8ciStslAWIXPmr0NxeFt/ZlB1gpq2Sn3nf4INW0vReWenzH4JauqwjlCyJBDq/qcLBmZ
	 E9ckX2N8lmBmkmCH3T/r/K1HMV02Ju/WnJaEgGUims1wC8OlHnp7qQPHbTpmZ+Gprfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=reeldist.com;
	spf=pass smtp.mailfrom=reeldist.com;
	dkim=pass header.d=reeldist.com header.i=@reeldist.com header.a=rsa-sha256 header.s=default header.b=SCkphYp1;
	arc=none smtp.remote-ip=202.182.106.98
Received: from m3.textscene.com (m3.textscene.com [202.182.106.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE3606A334
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 00:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CDE3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reeldist.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reeldist.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=reeldist.com header.i=@reeldist.com header.a=rsa-sha256 header.s=default header.b=SCkphYp1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=reeldist.com;
	s=default; t=1795308881;
	bh=m4zOmNtgv2I8z90iDvC5XZMnjpR+BlfgbcOJZmRObtg=;
	h=Subject:From:To:Reply-To:List-Unsubscribe;
	b=SCkphYp1QxyO/RiEKhXBBn9CEpmlX0dqfHobo2SSNCqjo3IZ8BAzSpZv/JwQ0Jkcf
	 iTF7bV5JE67B51JfE//JAcAaQeggOy195bt+TDifjEC0lTRWc2e+Y4IlAss1LGhKKM
	 KfbxnSxZ/0VizOg74+pSl0iQA23YbfpHepdms526+35nePMp+zJnnyEhRhldBC24qu
	 FHhPZvV2vBfFzz1o9wKpa5xmVTQS04feMYGe5L/K1u2UOAt36V0jOtyPMvTRlhnDE5
	 iQqLuSyrRqrYZZbs2gcBw9Rlh6MNw3/4tqv/ZQBc9Xu5Rfw+HNLaPmRmfyEX/Bxgzb
	 dKHwOiAtmwfVg==
Received: from [172.30.219.47] (unknown [39.105.124.184])
	by mail.textscene.com (Postfix) with ESMTPSA id 650A71269FE
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 00:54:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Subject: =?utf-8?q?How_does_your_team_manage_multiple_model_keys?=
From: =?utf-8?b?ODM0MVRva2Vu5bel5Y6C?= <s20@reeldist.com>
To: linux-fsdevel@vger.kernel.org
Reply-To: wuqiong@token8341.com
Message-ID: <179530887844.2882086.105862704992096115@reeldist.com>

SGksCgpUaGlzIGlzIGEgc2hvcnQgb25lIOKAlCBvbmUgcXVlc3Rpb24sIHRoYXQncyBhbGwuLgoK
QSBzb2xvLW1haW50YWluZWQgcHJvamVjdCBtZWFucyB5b3VyIGVuZXJneSBnb2VzIHRvIHJlYWwg
cHJvYmxlbXMuIFN0aWNraW5nIHdpdGggaXQgdGhpcyBsb25nIGlzIHdvcnRoIHRha2luZyBzZXJp
b3VzbHkuCgpBdCB0aGlzIGxheWVyIHRoZSBmaWRkbHkgcGFydCBpcyB1c3VhbGx5IGtlZXBpbmcg
dGhlIHBsdW1iaW5nIG91dCBvZiB5b3VyIHdheSwgc28geW91ciB0aW1lIGNhbiBnbyB0byB0aGUg
cmVhbCBwcm9ibGVtcyDigJQgaWYgdGhhdCBzb3VuZHMgZmFtaWxpYXIsIHRoaXMgbWF5IHNhdmUg
eW91IHNvbWUgZXZlbmluZ3MuCgpJZiBtb2RlbCBpbnRlZ3JhdGlvbiBpcyBhbnl3aGVyZSBpbiB0
aGUgcGljdHVyZSwgb3VyIEFQSSBjYW4gdGFrZSB0aGF0IGxheWVyIG9mZiB5b3VyIHBsYXRlIOKA
lCBubyBrZXlzLCBxdW90YXMgb3IgZmFsbGJhY2tzIHRvIG1haW50YWluIHlvdXJzZWxmLgoKODM0
MVRva2VuRmFjdG9yeSAodG9rZW44MzQxLmNvbSkgcHV0cyBEZWVwU2VlaywgS2ltaSwgWmhpcHUg
R0xNLCBRd2VuIGFuZCBNaW5pTWF4IGJlaGluZCBhIHNpbmdsZSBPcGVuQUktY29tcGF0aWJsZSBl
bmRwb2ludCwgcmVhY2hhYmxlIGZyb20gQ2hpbmEgd2l0aG91dCBwcm94eSBnYW1lcy4KClR3byBv
dGhlciB0aGluZ3MsIGluIGNhc2UgdGhleSdyZSB1c2VmdWwuCgpGaXJzdCwgQVBJIGFnZ3JlZ2F0
aW9uOiBvbmUgT3BlbkFJLWNvbXBhdGlibGUga2V5IGFjcm9zcyBEZWVwU2VlaywgS2ltaSwgWmhp
cHUgR0xNLCBRd2VuIGFuZCBNaW5pTWF4IOKAlCBzYW1lIGVuZHBvaW50LCBkaXJlY3QgZnJvbSBD
aGluYS4KClRoZSBzYW1lIGVuZHBvaW50IGFsc28gY2FycmllcyB2aWRlbyBtb2RlbHMgKEgzLCBX
YW4gMi4yIOKAlCB0ZXh0L2ltYWdlL2ZpcnN0LWxhc3QtZnJhbWUsIGJpbGxlZCBwZXIgc2Vjb25k
KS4KClNlY29uZCwgdmlkZW8gYWdlbnRzOiBzaG9ydCBkcmFtYS4gT25lIHNlbnRlbmNlIGluLCBh
IGZpbmlzaGVkIGVwaXNvZGUgb3V0IOKAlCBzY3JpcHQsIHN0b3J5Ym9hcmQsIHZpc3VhbHMgYW5k
IHZvaWNlIGFsbCBhdXRvbWF0aWMuCgrCpTAuNSB0cmlhbCBjcmVkaXQsIHBsdXMgwqU1IG9uIGEg
Zmlyc3QgdG9wLXVwIG9mIMKlNSBvciBtb3JlLgoKT25lIG1vcmUgdGhpbmcgd2UgYnVpbHQ6IDxz
dHJvbmc+dG9rZW4tbGV2ZWwgc21hcnQgcm91dGluZzwvc3Ryb25nPiAoZGV2ZWxvcGVkIHdpdGgg
YSB0ZWFtIGZyb20gVHNpbmdodWEgVW5pdmVyc2l0eSkg4oCUIG5vdCBldmVyeSByZXF1ZXN0IG5l
ZWRzIGEgZnJvbnRpZXIgbW9kZWwuIFNpbXBsZSBxdWVyaWVzIGdvIHRvIGEgc21hbGwgbW9kZWws
IGhhcmQgb25lcyBnZXQgZXNjYWxhdGVkLiBTYW1lIGFuc3dlciwgbWF0ZXJpYWxseSBmZXdlciB0
b2tlbnMsIGxvd2VyIGJpbGwsIG5vIHF1YWxpdHkgbG9zcy4KClJlcGx5IHRvIHRoaXMgZW1haWwg
YW5kIEknbGwgYW5zd2VyIHByb3Blcmx5LgoKCgo4MzQxVG9rZW5GYWN0b3J5ICh0b2tlbjgzNDEu
Y29tKQoKLS0tCld1IFFpb25nCjgzNDFUb2tlbkZhY3RvcnkKCi0tCkRvbid0IHdhbnQgdGhlc2Ug
ZW1haWxzPyBSZXBseSAidW5zdWJzY3JpYmUiIG9yIHdyaXRlIHRvIGhlbGxvQHRleHRzY2VuZS5j
b20gd2l0aCBzdWJqZWN0IHVuc3Vic2NyaWJlLg==
