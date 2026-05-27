Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6994374E63;
	Wed, 27 May 2026 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875669; cv=none; b=sRvarCxLGKljA2zPIt/+nUOJbgfM03yLAGqyaWth9+4l9hemAn2DX+VdwfqRFca1RoAnAlc+l3j2dYdqCy5N0p/BdnEW2YgxMiJLjB2Ssq0XB4Fzqwu25L1M7QGynIC41PfhFUYGoywX5y734GEse+zzJnXuZsQ6XsZKTG2NoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875669; c=relaxed/simple;
	bh=gXsUTxXXmfkDvqLeXzBSSFHo3vC59iSRPctTeABE3dU=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=ULNamsBNP4cvOFVEs8M2vOE4wGl4/KvYLqdffP6smRtXFKbjhvP6kpTUvhY0u3Wm5IaoswMZiO63iGomRmUMeIch6H/SOp1aTGnSus9CJbChIDihaFy9SkdsfA0pPka+7C3+0wzJNlwA29fn0+bUQcC05pC5SsnQ0X1P7RDHp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 07ed083659b211f1aa26b74ffac11d73-20260527
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:587eec8f-bcdc-444f-b681-7d0631564a12,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:85362666222f83a2486452bc209f1524,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102|865|898,TC:0,Content:0|14|51,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: DA58FD2E486933146EC61F7BA131E18D
X-UUID: 07ed083659b211f1aa26b74ffac11d73-20260527
Received: from node4 [(10.44.17.112)] by mailgw.kylinos.cn
	(envelope-from <fuqingshuang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 445052260; Wed, 27 May 2026 17:54:19 +0800
Received: from node4 (localhost [127.0.0.1])
	by node4 (NSMail) with SMTP id 98A021200BD91;
	Wed, 27 May 2026 17:54:19 +0800 (CST)
Received: by node4 (NSMail, from userid 10001)
	id 8C3871200BD8A; Wed, 27 May 2026 17:54:19 +0800 (CST)
From: =?UTF-8?B?5YKF5riF54i9?= <fuqingshuang@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIIHYxXSBmczogZml4IHNwZWxsaW5nIG1pc3Rha2VzIGluIGNvbW1lbnQ=?=
To: =?UTF-8?B?TWF0ZXVzeiBHdXppaw==?= <mjguzik@gmail.com>,
	=?UTF-8?B?dmlybw==?= <viro@zeniv.linux.org.uk>,
	=?UTF-8?B?YnJhdW5lcg==?= <brauner@kernel.org>,
	=?UTF-8?B?amFjaw==?= <jack@suse.cz>
Cc: =?UTF-8?B?bGludXgtZnNkZXZlbA==?= <linux-fsdevel@vger.kernel.org>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>
Date: Wed, 27 May 2026 17:54:19 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <3oj5hcb43wtr-3oja38fcgicw@nsmail8.2--kylin--1>
References: 22tr2m4v4b7kc5w7eoclxdcajodtvfl6e2jvgvx4vd7k7atvdt@l4hxanuf5squ
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Wed, 27 May 2026 17:54:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-3qytby1ngkxe-3qywisl735df
X-ns-mid: webmail-6a16bf4b-3p6dbmjy
X-ope-from: <fuqingshuang@kylinos.cn>
X-receipt: 0

This message is in MIME format.

--nsmail-3qytby1ngkxe-3qywisl735df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+VGhhbmtzIGZvciB5b3VyIHJldmlldyE8L3A+CjxwPkluIHYy
IEkgZml4ZWQ6PC9wPgo8dWw+CjxsaT5BZGRlZCBjb21tYSBhZnRlciBlLmcu
PC9saT4KPGxpPkZpeGVkIHdyb25nIHVzZSBvZiAiaW1iYWxhbmNlIjwvbGk+
CjwvdWw+CjxwPktlcHQgdGhlIHBhdGNoIHNpbXBsZS48L3A+CjxwPlBsZWFz
ZSBjaGVjayB2MiwgdGhhbmsgeW91ITwvcD4KPHA+Jm5ic3A7PC9wPgo8ZGl2
IGlkPSJzaWduYXR1cmVUb3AiPjwvZGl2Pgo8ZGl2IGlkPSJjczJjX3JlIiBz
dHlsZT0ibWFyZ2luLWxlZnQ6IDAuNWVtOyBwYWRkaW5nLWxlZnQ6IDAuNWVt
OyBib3JkZXItbGVmdDogMXB4IHNvbGlkICNjYWNhY2E7IC13ZWJraXQtdXNl
ci1tb2RpZnk6IHJlYWQtb25seTsgLW1vei11c2VyLW1vZGlmeTogcmVhZC1v
bmx5OyAtbXMtdXNlci1tb2RpZnk6IHJlYWQtb25seTsgLW8tdXNlci1tb2Rp
Znk6IHJlYWQtb25seTsiPjxicj48YnI+PGJyPgo8ZGl2IHN0eWxlPSJiYWNr
Z3JvdW5kLWNvbG9yOiAjZjhmOGY4OyBwYWRkaW5nOiA4cHggMTBweDsgZm9u
dC1mYW1pbHk6IE1pY3Jvc29mdCBZYUhlaTsgZm9udC1zaXplOiAxNHB4OyBj
b2xvcjogIzAwMDsiPjxzdHJvbmc+5Li7Jm5ic3A7Jm5ic3A7Jm5ic3A76aKY
77yaPC9zdHJvbmc+PHNwYW4gaWQ9ImNzMmNfc3ViamVjdCI+UmU6IFtQQVRD
SCB2MV0gZnM6IGZpeCBzcGVsbGluZyBtaXN0YWtlcyBpbiBjb21tZW50PC9z
cGFuPiA8YnI+PHN0cm9uZz7ml6UmbmJzcDsmbmJzcDsmbmJzcDvmnJ/vvJo8
L3N0cm9uZz48c3BhbiBpZD0iY3MyY19kYXRlIj4yMDI25bm0MDXmnIgyN+aX
pTE3OjE3PC9zcGFuPiA8YnI+PHN0cm9uZz7lj5Hku7bkurrvvJo8L3N0cm9u
Zz48c3BhbiBpZD0iY3MyY19mcm9tIj5NYXRldXN6IEd1emlrPC9zcGFuPiA8
YnI+PHN0cm9uZz7mlLbku7bkurrvvJo8L3N0cm9uZz48c3BhbiBpZD0iY3My
Y190byIgc3R5bGU9IndvcmQtYnJlYWs6IGJyZWFrLWFsbDsiPmZmZnNxaWFu
PC9zcGFuPiA8YnI+PHN0cm9uZz7mioTpgIHkurrvvJo8L3N0cm9uZz48c3Bh
biBpZD0iY3MyY190byIgc3R5bGU9IndvcmQtYnJlYWs6IGJyZWFrLWFsbDsi
PnZpcm8sYnJhdW5lcixqYWNrLGxpbnV4LWZzZGV2ZWwsbGludXgta2VybmVs
LOWChea4heeIvTwvc3Bhbj48L2Rpdj4KPGJyPgo8ZGl2IGlkPSJjczJjX2Nv
bnRlbnQiPk9uIFdlZCwgTWF5IDI3LCAyMDI2IGF0IDExOjE1OjA4QU0gKzA4
MDAsIGZmZnNxaWFuQDE2My5jb20gd3JvdGU6ICZndDsgRnJvbTogUWluZ3No
dWFuZyBGdSAmbHQ7ZnVxaW5nc2h1YW5nQGt5bGlub3MuY24mZ3Q7ICZndDsg
Jmd0OyBGaXggdGhyZWUgc3BlbGxpbmcgZXJyb3JzIGluIHRoZSBjb21tZW50
IGZvciBhbiBpbnRlcm5hbCBmaWxlIHN0cnVjdHVyZSAmZ3Q7IGFsbG9jYXRp
b24gZnVuY3Rpb246ICZndDsgLSBoYXBwZW5kIOKGkiBoYXBwZW5lZCAmZ3Q7
IC0gb3ZlciDihpIgZXhjZWVkIChncmFtbWF0aWNhbCBmaXgpICZndDsgLSBp
bnQg4oaSIGluICZndDsgJmd0OyBTaWduZWQtb2ZmLWJ5OiBRaW5nc2h1YW5n
IEZ1ICZsdDtmdXFpbmdzaHVhbmdAa3lsaW5vcy5jbiZndDsgJmd0OyAtLS0g
Jmd0OyBmcy9maWxlX3RhYmxlLmMgfCA0ICsrLS0gJmd0OyAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKSAmZ3Q7ICZn
dDsgZGlmZiAtLWdpdCBhL2ZzL2ZpbGVfdGFibGUuYyBiL2ZzL2ZpbGVfdGFi
bGUuYyAmZ3Q7IGluZGV4IDE2ZTUyZTdmYzJhYy4uZmEwNmI2NjBmMTE2IDEw
MDY0NCAmZ3Q7IC0tLSBhL2ZzL2ZpbGVfdGFibGUuYyAmZ3Q7ICsrKyBiL2Zz
L2ZpbGVfdGFibGUuYyAmZ3Q7IEBAIC0yMzEsMTMgKzIzMSwxMyBAQCBzdGF0
aWMgaW50IGluaXRfZmlsZShzdHJ1Y3QgZmlsZSAqZiwgaW50IGZsYWdzLCBj
b25zdCBzdHJ1Y3QgY3JlZCAqY3JlZCkgJmd0OyB9ICZndDsgJmd0OyAvKiBG
aW5kIGFuIHVudXNlZCBmaWxlIHN0cnVjdHVyZSBhbmQgcmV0dXJuIGEgcG9p
bnRlciB0byBpdC4gJmd0OyAtICogUmV0dXJucyBhbiBlcnJvciBwb2ludGVy
IGlmIHNvbWUgZXJyb3IgaGFwcGVuZCBlLmcuIHdlIG92ZXIgZmlsZSAmZ3Q7
ICsgKiBSZXR1cm5zIGFuIGVycm9yIHBvaW50ZXIgaWYgc29tZSBlcnJvciBo
YXBwZW5lZCBlLmcuIHdlIGV4Y2VlZCB0aGUgZmlsZSAmZ3Q7ICogc3RydWN0
dXJlcyBsaW1pdCwgcnVuIG91dCBvZiBtZW1vcnkgb3Igb3BlcmF0aW9uIGlz
IG5vdCBwZXJtaXR0ZWQuICZndDsgKiAmZ3Q7ICogQmUgdmVyeSBjYXJlZnVs
IHVzaW5nIHRoaXMuIFlvdSBhcmUgcmVzcG9uc2libGUgZm9yICZndDsgKiBn
ZXR0aW5nIHdyaXRlIGFjY2VzcyB0byBhbnkgbW91bnQgdGhhdCB5b3UgbWln
aHQgYXNzaWduICZndDsgKiB0byB0aGlzIGZpbHAsIGlmIGl0IGlzIG9wZW5l
ZCBmb3Igd3JpdGUuIElmIHRoaXMgaXMgbm90ICZndDsgLSAqIGRvbmUsIHlv
dSB3aWxsIGltYmFsYW5jZSBpbnQgdGhlIG1vdW50J3Mgd3JpdGVyIGNvdW50
ICZndDsgKyAqIGRvbmUsIHlvdSB3aWxsIGltYmFsYW5jZSBpbiB0aGUgbW91
bnQncyB3cml0ZXIgY291bnQgJmd0OyAqIGFuZCBhIHdhcm5pbmcgYXQgX19m
cHV0KCkgdGltZS4gJmd0OyAqLyAmZ3Q7IHN0cnVjdCBmaWxlICphbGxvY19l
bXB0eV9maWxlKGludCBmbGFncywgY29uc3Qgc3RydWN0IGNyZWQgKmNyZWQp
IElmIG9uZSBpcyB0byB0b3VjaCB0aGlzIGNvbW1lbnQgYmxvY2sgaXQgd291
bGQgYmUgYmVzdCB0byBzb3J0IGl0IG91dCBvdmVyYWxsLiBPciBiZXR0ZXIg
eWV0LCBub3QganVzdCB0aGlzIG9uZSBidXQgdGhlIGVudGlyZXR5IG9mIHRo
ZSBmaWxlLiBGb3Igc3RhcnRlcnMgdGhlcmUgaXMgYSBmb3JtYXQgdG8gZm9s
bG93IHRvIGRvY3VtZW50IGFyZ3MgJmFtcDsgcmV0dXJuIHZhbHVlcywgc2Vl
IGZpbGVfaW5pdF9wYXRoIGZvciBhbiBleGFtcGxlLiBUaGF0IGFzaWRlIGV2
ZW4gaWYgeW91ciBjaGFuZ2VzIHRoZSBjb21tZW50IGlzIGRlZmluaXRlbHkg
d3JvbmcgZnJvbSBncmFtbWFyIHN0YW5kcG9pbnQsIGJ1dCBJIGRvbid0IGtu
b3cgRW5nbGlzaCB3ZWxsIGVub3VnaCB0byBiZSBjb25maWRlbnQgSSB3b3Vs
ZCB3cml0ZSBhIGZ1bGx5IGNvcnJlY3QgdmVyc2lvbi4gImUuZy4iIHJlcXVp
cmVzIGEgY29tbWEgKCJlLmcuLCIpIFRoYXQgYXNpZGUgInlvdSB3aWxsIGlt
YmFsYW5jZSBpbiB0aGUgbW91bnQncyB3cml0ZXIgY291bnQiIHJlYWRzIHdh
eSBvZmYgdG8gbWUuIFBlcmhhcHMgdGhpcyBpcyBiZXN0IGxlZnQgdG8gbmF0
aXZlIHNwZWFrZXJzLiAmbHQ7L2Z1cWluZ3NodWFuZ0BreWxpbm9zLmNuJmd0
OyZsdDsvZnVxaW5nc2h1YW5nQGt5bGlub3MuY24mZ3Q7PC9kaXY+CjwvZGl2
Pgo8cD4mbmJzcDs8L3A+CjxwPiZuYnNwOzwvcD4KPGRpdiBpZD0ic2lnbmF0
dXJlQm9tIj4KPGRpdj4KPHA+Jm5ic3A7PC9wPgo8YnI+CjxwIHN0eWxlPSJj
b2xvcjogIzAwMDsgZm9udC1zaXplOiAxNnB4OyI+LS0tPC9wPgo8ZGl2IGlk
PSJjczJjX21haWxfc2lnYXR1cmUiIHN0eWxlPSJjb2xvcjogIzAwMDsgZm9u
dC1zaXplOiAxNnB4OyBmb250LWZhbWlseTogTWljcm9zb2Z0IFlhSGVpOyI+
PC9kaXY+CjxwPiZuYnNwOzwvcD4KPC9kaXY+CjwvZGl2PjwvZGl2Pg==

--nsmail-3qytby1ngkxe-3qywisl735df--
