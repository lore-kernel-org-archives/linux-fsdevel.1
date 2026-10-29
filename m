Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274290;
	b=ptO5cEaCcKrTvYUHtnha6TjbrfUgKTbJZ/9AqPb1zHp4CQFIXYXiOCuUMeAdPVnfbVq+
	 nhsnl+huE7UiRKMtX2TbH3jcJyvkatD1ThJWboYZ3725ESnx7R8F6lNM9Pfp6R06hDx6P
	 odWlgAQ7KM4uJntqJj+V5yRS2zZnLy/8T7XxVLgaAIawJDdy3KKIXGs6F9htH+N1RFdn8
	 0+J1inQfdkBe3ZrKRY2OEuXQbw/nyOvTTinyG7odmMjkI/vn6tWI21nXdTT1xmYa+8Vol
	 kTb5X3XHczhXPJH5GLz8esHbpOJ3CYBQsHuA0w4NSY2HHLmzOe+5oqByDyV/98gKACQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:From:To:Cc:Subject:Date:
	 Message-ID;
	bh=Jd2UFCxkcxCtfD/oLW8VbcTJ/FVOrbooQK6exqmS0mc=;
	b=n9AIPsG2mRjYk+Yx0/vbcEczMB9wywGWP9a06xYFGW4r59tZgboRvlD1gooaTpJpmKyd
	 /beb07D79lO5iXnpj8r+BjuqRP4WdstdO4SQwEcU0UR6Pn7id6cmMszcDZT4kU2BIf3Hf
	 9P4PRuFFzLk9/pCWc3IFwW2DJoHiqhEDQGt+FG5UJKcm4ON7iC5dXxM1CY2/ogWHHmHMj
	 +PKnRqDasYf0FjtCpSi+MM3bMkQJHLiGUuDV1lx7N22RnDNrn8z5ThH37HFlfQ+oEeRxw
	 ArLbRaWnl32bG+43l683sPXP3qFsPjZekZDDGwuo78tmhuzWcPmdtLcz/q9T4kauNXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sp0hYAsK;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D2606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC7D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sp0hYAsK
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8b20a899fso14134575ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793274289; x=1793879089; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jd2UFCxkcxCtfD/oLW8VbcTJ/FVOrbooQK6exqmS0mc=;
        b=sp0hYAsKsusSZkG6p3IwcI1DsN+Wr+/4elieWPKYr2NgaEaxHfPGSHsWiL2gUwo15r
         Nrx1vMgSLgdbXPw+xPoFSRyIzqPtDRZ6EoQt1jLjKO9Yoh8K15LfUz+gnKJlnc9lhMDy
         K5iJN4Tj9NJV0cAhk/P7mva8b9g9/VoRQaLfESUVebsOzsmKv4cN6vdfQaqc0r+iM8jF
         OFZKIfC5ItyxcKkXScWfvCwEKU7hJrWmlNuhX78IPrc009JD+SNYgrTiFejA6rpawSu3
         y83+S2fC+wTO0D7+kdkWiCKcUyU7FYYhTIvR6Xct6y2uaw3nZ2uCkoekm9LtO7Ero9Vs
         MXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793274289; x=1793879089;
        h=message-id:date:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jd2UFCxkcxCtfD/oLW8VbcTJ/FVOrbooQK6exqmS0mc=;
        b=yMXt/q2n4QN2p0rGxp+VTHeWLTZB4ixsd83ZzywHDbX/OuwUlyepfexOhFRF3/YKTo
         lNQhGQPdP6QoZIHC+ysTM1KVy54xuqqvR7dzKS80DILQ+YqMxrHZlPcj2x1A18yOtXkB
         1OaTNT3PizqB2/IlmpeTt3/9kkRnqC17xapYkDHHKidsGUZACoVcWQUqarK0gCRPckIZ
         Q1zlY1PW4ep6sqVkOdM/f1elSowIbg9SbHH/nVkT7DtmXUjy7hMe9j7J2cdAgrnETatF
         vy2imSzBA8lkinXFBKjMNUKPg5GFzMY5goPZwsOfdzWTFGBXStlxK7OgwDXvQ7J65Flf
         BdCQ==
X-Gm-Message-State: AFq9FYJwjyP8Spqnpnb6vMQ0RiTpEjDrer4QtFOa14PQTT/yUckKMmW/
	G7vVLfql4z952CyIkAYqzJLr2GdSwJgYDXli0JZ26MzJC1cZpoicDsv6BI8NSTEm
X-Gm-Gg: AYBFou2Mr3UwWWPZbAQI9Ky1bh3g47wsLDLPHk5PEaMUpeM9iDvZyVSHlWYaFK4qzYd
	A5kR2OVzvEWP4QwUQ4bT2vyHD0kx5bflCi/ak4kLKteF5GFdHNayQVv22/AochSHU0lnzILbKeU
	ySBmFoOeYgK8SgQak9gEz2Uw6begemXHg6Ptj8SzRSz/yQSby5gnFeKeH+ZjI59cswkt8qLLP2w
	/OcsR20Drj+D1gbpGRrTsipaltG5mA1xtzi+q8HAjprqQPViaedhVgSPZtTd5gygC7SecyfDaHA
	74vekpnMPGV/TEm84Yr2P5ddN1glqFF9fMad4xzMnax7my9CTRfQ4Fxg5JbIX1njQmiFJ1+621o
	G6siLOERMwLa/68uzQu8nAR0a9URuidORS0bCXQIvGrAAZrjj2spBN6XrH83XNul73UygFp843f
	ouXb+qvi8n4kI2lYJNgp3xbeeZLW8XgVshz7gM/+3icPKTT5t0dfmk34CQs6lPjmxkHO8zBLID6
	b67VuTzklgzrm0qmBM6PRSQ1y0pl37WQFTQivMigfyyhWpoPLk9jUMWcI2tujAb3rSycLt/H3Sq
	6b9LpZ7WlRzvhRDws8gz8H7SN9Eshs4CyV5PcGgPOkVZ/2jIcI1CIrQ84uN+1xmHrM34r0hMPxb
	JL2NYyD/mDF7vbQbYaBi8JH6Uyguu1wB8U6I92xTwnVI2K28mLmb8OD8+n8EQ0wUuMWXUp8nv4D
	5fn/4qAuTcKDYEllbwf/k=
X-Received: by 2002:a17:902:d50c:b0:2e8:3d48:4d88 with SMTP id d9443c01a7336-2eb00242781mr49421205ad.7.1793274288940;
        Thu, 29 Oct 2026 04:44:48 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([198.13.63.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b7cdebsm32653235ad.12.2026.10.29.04.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:44:48 -0700 (PDT)
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
From: Sakura Rain <tokenaissance@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: mszeredi@redhat.com, mengmengmengqiang@gmail.com, yifanxu1999@gmail.com
Subject: FUSE: umount2 detach does not wake blocked readers while another
 mount namespace holds the superblock
Date: Thu, 29 Oct 2026 19:44:42 +0800
Message-ID: <179327428247.5614.10808778141810242006@gmail.com>

SGVsbG8sCgpXZSBhcmUgd3JpdGluZyB3aXRoIGEgRlVTRSBiZWhhdmlvciBxdWVzdGlvbiBhbmQg
dXNlcnNwYWNlIGV2aWRlbmNlLiBXZSBhcmUgbm90CmNsYWltaW5nIGEga2VybmVsIGJ1ZyBvciBw
cm9wb3NpbmcgYSBwYXRjaDsgd2Ugd291bGQgbGlrZSB0byBrbm93IHdoZXRoZXIgdGhlCmJlaGF2
aW9yIGlzIGludGVuZGVkIGFuZCB3aGV0aGVyIHRoZXJlIGlzIGEgc3VwcG9ydGVkIHdheSBmb3Ig
dXNlcnNwYWNlIHRvCmRldGVjdCB0aGUgc3RhdGUuCgpTZXR1cC4gQSB1c2Vyc3BhY2UgRlVTRSBk
YWVtb24gcnVucyBpbnNpZGUgYSBEb2NrZXIgY29udGFpbmVyIChMYXllckZTLCBhbgphZ2VudCBX
b3Jrc3BhY2UgZmlsZXN5c3RlbSkuIFRoZSBkYWVtb24gbW91bnRzIG9uZSBGVVNFIGZpbGVzeXN0
ZW0gYW5kIHNlcnZlcwppdCB3aXRoIHR3byB3b3JrZXJzIGJsb2NrZWQgaW4gcmVhZCgvZGV2L2Z1
c2UpLiBPbiBhIG5vcm1hbCBzdG9wIGl0IGNhbGxzIGEKcGxhaW4gdW1vdW50Mihtb3VudHBvaW50
LCAwKSwgdGhlbiBqb2lucyB0aGUgd29ya2VycywgZHJhaW5zIHJlcXVlc3RzLCByZXZva2VzCmFu
ZCBjbG9zZXMgdGhlIGNvbm5lY3Rpb24uCgpPYnNlcnZlZCBvbiBtYWNPUyAyNi41LjEgLyBPcmJT
dGFjayA3LjIuOSAvIERvY2tlciAyOS44LjIgKEFQSSAxLjU0KSwga2VybmVsCjcuMi45LW9yYnN0
YWNrLTAwMzkxLWcyYjI5OGQwNWZiZDQ6CgotIHVtb3VudDIgcmVtb3ZlcyB0aGUgbW91bnQgZnJv
bSB0aGUgY29udGFpbmVyJ3MgbW91bnQgbmFtZXNwYWNlIGFuZCByZXR1cm5zCiAgc3VjY2Vzczsg
dGhlIG1vdW50IHJvdyBpcyBnb25lIGZyb20gdGhlIG5hbWVzcGFjZSdzIG1vdW50aW5mby4KLSBU
aGUgdHdvIHJlYWQoKSB3b3JrZXJzIHJlbWFpbiBibG9ja2VkIGFuZCBkbyBub3QgcmV0dXJuLiBU
aGUgY29ubmVjdGlvbgogIHN0YXlzIGFsaXZlIGFmdGVyIHRoZSBkZXRhY2guIE91ciB1bm1vdW50
IHBhdGggZ2l2ZXMgdXAgYXQgaXRzIDUgcyBkZWFkbGluZQogIHdpdGggYm90aCByZWFkZXJzIHN0
aWxsIG5vdCBqb2luZWQuCi0gV3JpdGluZyAiMSIgdG8gL3N5cy9mcy9mdXNlL2Nvbm5lY3Rpb25z
LzxuPi9hYm9ydCB3YWtlcyB0aGUgcmVhZGVycwogIGltbWVkaWF0ZWx5LiBEcmFpbiArIHJldm9r
ZSArIGNsb3NlIHRoZW4gY29tcGxldGVzIGluIHA1MCA3NSBtcyAobWF4IDU1OCBtcwogIG92ZXIg
dGhlIG1lYXN1cmVkIHRhaWwpLiBXaXRoIGEgMSBzIGpvaW4gZ3JhY2UgaW4gdGhlIGRhZW1vbiwg
dGhlIHN0YWxsIGVuZHMKICBhdCBhYm91dCAxLjA4IHMgaW5zdGVhZCBvZiBhYm91dCA1LjEgcy4K
LSBJdCBpcyBkZXRlcm1pbmlzdGljIGZvciB0aGlzIHNoYXBlIG9mIHJ1bjogNi82IGF0IG9uZSBM
YXllckZTIGNvbW1pdAogICg1ODJiYzc4NikgYW5kIDEvMSBhdCB0aGUgdjEuMS4wIHJlbGVhc2Us
IHdoZW4gdGhlIG1vdW50IGlzIGNyZWF0ZWQKICBpbW1lZGlhdGVseSBhZnRlciB0aGUgY29udGFp
bmVyIHN0YXJ0cyBhbmQgbGl2ZXMgYWJvdXQgMS41IHMuCgpUaW1pbmcuIERlbGF5IGJlZm9yZSBt
b3VudCAvIGRlbGF5IGJlZm9yZSB1bm1vdW50LCB0d28gcnVucyBlYWNoLCB1bm1vdW50IHdhbGwK
dGltZToKCiAgYmVmb3JlIG1vdW50ICAgYmVmb3JlIHVubW91bnQgICB1bm1vdW50CiAgMCBtcyAg
ICAgICAgICAgMzAwIG1zICAgICAgICAgICAyMiAvIDE5IG1zCiAgMjUwMCBtcyAgICAgICAgMTUw
MCBtcyAgICAgICAgICA0MyAvIDE1IG1zCiAgMCBtcyAgICAgICAgICAgMTUwMCBtcyAgICAgICAg
ICA1MDY2IC8gNTAyOSBtcyAgICA8LSBzdGFsbAogIDI1MDAgbXMgICAgICAgIDMwMCBtcyAgICAg
ICAgICAgMTIgLyA5IG1zCgpTbyB0aGUgc3RhbGwgaXMgYSB3aW5kb3c6IHRoZSBtb3VudCBtdXN0
IGJlIGNyZWF0ZWQgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlCmNvbnRhaW5lciBzdGFydHMgYW5kIGxp
dmUgYWJvdXQgMS41IHMuIEEgMi41IHMgZGVsYXkgYmVmb3JlIG1vdW50aW5nLCBvciBhCjMwMCBt
cyBsaWZldGltZSwgYXZvaWRzIGl0LgoKQ29udHJvbC4gSWYgdGhlIGRhZW1vbiBjYWxscyB1bnNo
YXJlKENMT05FX05FV05TKSBhbmQgbWFrZXMgLyBwcml2YXRlIGJlZm9yZQptb3VudGluZywgc28g
dGhlIG1vdW50IGlzIGNyZWF0ZWQgb25seSBpbiB0aGUgZGFlbW9uJ3Mgb3duIG1vdW50IG5hbWVz
cGFjZSBhbmQKbmV2ZXIgYXBwZWFycyBpbiB0aGUgY29udGFpbmVyJ3MgaW5pdGlhbCBtb3VudCBu
YW1lc3BhY2UsIHRoZSBzdGFsbCBkb2VzIG5vdApvY2N1cjogZWFybHktbW91bnQgdW5tb3VudCBw
NTAgMTUgbXMgKG49MTAsIHJhbmdlIDcuMi0zNS4wIG1zKS4gVGhlIHNhbWUgbW91bnQKd2l0aCB0
aGUgZmxhZyBvZmYgc3RhbGxzIGFib3V0IDUuMCBzLgoKV2hhdCB3ZSBjb3VsZCBub3QgZGV0ZXJt
aW5lLiBBdCAyNTAgbXMgaW50byBhIHN0YWxsZWQgdW5tb3VudCB0aGUgbW91bnQgcm93IGlzCmFs
cmVhZHkgZ29uZSBmcm9tIHRoZSBjb250YWluZXIncyBuYW1lc3BhY2UsIHlldCB0aGUgcmVhZGVy
cyBhcmUgc3RpbGwgYmxvY2tlZC4KU2VwYXJhdGVseSwgYSBwcml2aWxlZ2VkIC0tcGlkPWhvc3Qg
c2NhbiBvZiBhbGwgbW91bnQgbmFtZXNwYWNlcyBmb3VuZCB0aGUgRlVTRQptb3VudCBvbmx5IGlu
IHRoZSBjb250YWluZXIncyBQSUQtMS9kYWVtb24gbW91bnQgbmFtZXNwYWNlLCBub3QgaW4gYW4K
YWRkaXRpb25hbCBob2xkZXIsIGFuZCBubyBwcm9jZXNzIGZkIG9yIGN3ZCBwb2ludGVkIGludG8g
dGhlIG1vdW50LiBXZSBjYW5ub3QKaWRlbnRpZnkgd2hhdCBrZWVwcyB0aGUgc3VwZXJibG9jayBy
ZWZlcmVuY2VkLgoKRnJvbSB0aGUgc291cmNlIHdlIGNhbiByZWFkLCBmdXNlX3NiX2Rlc3Ryb3ko
KSBjYWxscyBmdXNlX2Nvbm5fZGVzdHJveSgpICh3aGljaAphYm9ydHMgdGhlIGNvbm5lY3Rpb24g
YW5kIHdha2VzIHJlYWRlcnMpIG9ubHkgd2hlbiBmdXNlX21vdW50X3JlbW92ZSgpIHJlcG9ydHMK
dGhlIGxhc3QgbW91bnQgZm9yIHRoYXQgY29ubmVjdGlvbi4gQSBwbGFpbiB1bW91bnQyIHRoYXQg
aXMgbm90IHRoZSBsYXN0CnJlZmVyZW5jZSB0aGVyZWZvcmUgbGVhdmVzIHRoZSBjb25uZWN0aW9u
IGFuZCBpdHMgcmVhZGVycyBhbG9uZS4KClF1ZXN0aW9uczoKCjEuIElzIHRoYXQgaW50ZW5kZWQg
d2hlbiB0aGUgY2FsbGVyJ3MgbmFtZXNwYWNlIG5vIGxvbmdlciBoYXMgdGhlIG1vdW50IGF0IGFs
bD8KICAgU2hvdWxkIGEgZGV0YWNoIHRoYXQgbGVhdmVzIHRoZSBzdXBlcmJsb2NrIHJlZmVyZW5j
ZWQgb25seSBlbHNld2hlcmUgd2FrZSBvcgogICBhYm9ydCB0aGUgYmxvY2tlZCByZWFkZXJzLCBv
ciBtdXN0IHRoZSBsYXN0IHJlZmVyZW5jZSBkcm9wIGZpcnN0PwoKMi4gSXMgdGhlcmUgYSBzdXBw
b3J0ZWQsIHJhY2UtZnJlZSB3YXkgZm9yIHVzZXJzcGFjZSB0byBsZWFybiB0aGF0IG5vIG1vdW50
IG9yCiAgIHVzZXIgcmVtYWlucyAtLSBmb3IgZXhhbXBsZSBhIHBlci1jb25uZWN0aW9uIG1vdW50
IHJlZmVyZW5jZSBjb3VudCBvciBhCiAgICJkZXRhY2hlZCIgc3RhdGUgLS0gc28gdGhhdCBpdCBj
YW4gYWJvcnQgZGV0ZXJtaW5pc3RpY2FsbHkgaW5zdGVhZCBvZiB1c2luZwogICBhIHRpbWVvdXQ/
IFdlIGNvdWxkIG5vdCBmaW5kIG9uZSBpbiBmdXNlY3RsIG9yIGVsc2V3aGVyZS4KCjMuIERvZXMg
bWFpbmxpbmUgZnMvZnVzZSBiZWhhdmUgdGhlIHNhbWUgYXMgNy4yLjktb3Jic3RhY2stMDAzOTE/
IFdlIGNhbm5vdAogICB0ZXN0IG1haW5saW5lIG9uIHRoaXMgaG9zdC4gV2UgaGF2ZSBhbHNvIGFz
a2VkIE9yYlN0YWNrIHdoZXRoZXIgdGhlaXIga2VybmVsCiAgIGNhcnJpZXMgYSBjaGFuZ2UgaW4g
dGhpcyBhcmVhLgoKV2UgY2FuIHByb3ZpZGUgYSBzdGFuZGFsb25lIHVzZXJzcGFjZSBGVVNFIHJl
cHJvZHVjZXIgKHR3byByZWFkZXJzIG9uIG9uZQovZGV2L2Z1c2UgZmQsIHBsYWluIHVtb3VudDIs
IGpvaW4gdGltZW91dCkgYW5kIHRocmVhZC9tb3VudCB0cmFjZXMgb24gcmVxdWVzdC4KVGhlIExh
eWVyRlMgcmVwcm9kdWNlciBpcyBkZXRlcm1pbmlzdGljIDYvNiBvbiB0aGUgYWZmZWN0ZWQga2Vy
bmVsLiBUaGUgZnVsbApldmlkZW5jZSBhbmQgdGhlIG9wZW4gcXVlc3Rpb25zIGFyZSBhbHNvIGF0
Cmh0dHBzOi8vZ2l0aHViLmNvbS9FcGhlbWVyYWwtQUktTGFiL2xheWVyZnMvaXNzdWVzLzQ2MAoK
VGhhbmsgeW91LApUaGUgTGF5ZXJGUyB0ZWFtCmh0dHBzOi8vZ2l0aHViLmNvbS9FcGhlbWVyYWwt
QUktTGFiL2xheWVyZnMK
