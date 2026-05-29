Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD736F427;
	Fri, 29 May 2026 04:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780027703; cv=none; b=WrPc6Pg0C6rkX0EbuJqSlUTryYEer89c1ugyTwIcmF3erahz1N6wM1NWSID4a9AucY3PfoKvUFjuJW8anDG3pHHMdwFv/1QCQkhbpzqP8bkmAquaH0Sm0GEP7RtYtHeWgy9695XaPvbZhgTCwNKlYplbxWTFIvQ923YO4OCnNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780027703; c=relaxed/simple;
	bh=oygsdnR7CqvrVE1HWq5mt8THW9fcl34Bickxczx8U9M=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=sneHLQAFAPNqlWRikFwgOHk4Ba+gtHSwygWkJN+jaak3m7ve1v1gcfJ+ukfSgyzxERLLr0cASlr4NpY3861dyzn9t/NqvPT/lbummhnWHPgqWjkH786XobJUr0LA6T56kL6xHH5O1Yuv3N8iNnXddeBGgQasQ3LcO7S0W/0i6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 037e46265b1411f1aa26b74ffac11d73-20260529
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:badf1323-f148-47b1-b337-e32fcd2618b6,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:f97461e035bfbeb51c00cb44343375fb,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102|865|898,TC:0,Content:0|14|51,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: 2483C66CED848B1E200EEE4EE5FC8E08
X-UUID: 037e46265b1411f1aa26b74ffac11d73-20260529
Received: from node4 [(10.44.17.112)] by mailgw.kylinos.cn
	(envelope-from <fuqingshuang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1501025117; Fri, 29 May 2026 12:08:14 +0800
Received: from node4 (localhost [127.0.0.1])
	by node4 (NSMail) with SMTP id 0A9611200BD91;
	Fri, 29 May 2026 12:08:14 +0800 (CST)
Received: by node4 (NSMail, from userid 10001)
	id 03D331200BD8A; Fri, 29 May 2026 12:08:13 +0800 (CST)
From: =?UTF-8?B?5YKF5riF54i9?= <fuqingshuang@kylinos.cn>
Subject: =?UTF-8?B?UmU6IFJlOiBbUEFUQ0ggdjFdIGZzOiBmaXggdHdvIHNwZWxsaW5nIG1pc3Rha2VzIGluIGNvbW1lbnRz?=
To: =?UTF-8?B?ZmZmc3FpYW4=?= <fffsqian@163.com>,
	=?UTF-8?B?SmFuIEthcmE=?= <jack@suse.cz>
Cc: =?UTF-8?B?dmlybw==?= <viro@zeniv.linux.org.uk>,
	=?UTF-8?B?YnJhdW5lcg==?= <brauner@kernel.org>,
	=?UTF-8?B?amFjaw==?= <jack@suse.cz>,
	=?UTF-8?B?bGludXgtZnNkZXZlbA==?= <linux-fsdevel@vger.kernel.org>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>
Date: Fri, 29 May 2026 12:08:13 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <74eveufks5oj-74f1sjio1akk@nsmail8.2--kylin--1>
References: iqp6gjxl7qohnxn7rle62zovyiedmw7nnfhjk5mpmq4azx7v5m@llgoenjgzgbf
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Fri, 29 May 2026 12:08:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-774ajja99sxy-774hzijv2gnb
X-ns-mid: webmail-6a19112d-75aa6879
X-ope-from: <fuqingshuang@kylinos.cn>
X-receipt: 0

This message is in MIME format.

--nsmail-774ajja99sxy-774hzijv2gnb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3ITwvcD4KPHA+QWRk
ZWQgeW91ciBSZXZpZXdlZC1ieSB0YWcuPC9wPgo8cD4mbmJzcDs8L3A+Cjxk
aXYgaWQ9InNpZ25hdHVyZVRvcCI+PC9kaXY+CjxkaXYgaWQ9ImNzMmNfcmUi
IHN0eWxlPSJtYXJnaW4tbGVmdDogMC41ZW07IHBhZGRpbmctbGVmdDogMC41
ZW07IGJvcmRlci1sZWZ0OiAxcHggc29saWQgI2NhY2FjYTsgLXdlYmtpdC11
c2VyLW1vZGlmeTogcmVhZC1vbmx5OyAtbW96LXVzZXItbW9kaWZ5OiByZWFk
LW9ubHk7IC1tcy11c2VyLW1vZGlmeTogcmVhZC1vbmx5OyAtby11c2VyLW1v
ZGlmeTogcmVhZC1vbmx5OyI+PGJyPjxicj48YnI+CjxkaXYgc3R5bGU9ImJh
Y2tncm91bmQtY29sb3I6ICNmOGY4Zjg7IHBhZGRpbmc6IDhweCAxMHB4OyBm
b250LWZhbWlseTogTWljcm9zb2Z0IFlhSGVpOyBmb250LXNpemU6IDE0cHg7
IGNvbG9yOiAjMDAwOyI+PHN0cm9uZz7kuLsmbmJzcDsmbmJzcDsmbmJzcDvp
opjvvJo8L3N0cm9uZz48c3BhbiBpZD0iY3MyY19zdWJqZWN0Ij5SZTogW1BB
VENIIHYxXSBmczogZml4IHR3byBzcGVsbGluZyBtaXN0YWtlcyBpbiBjb21t
ZW50czwvc3Bhbj4gPGJyPjxzdHJvbmc+5pelJm5ic3A7Jm5ic3A7Jm5ic3A7
5pyf77yaPC9zdHJvbmc+PHNwYW4gaWQ9ImNzMmNfZGF0ZSI+MjAyNuW5tDA1
5pyIMjjml6UxOTo1Mjwvc3Bhbj4gPGJyPjxzdHJvbmc+5Y+R5Lu25Lq677ya
PC9zdHJvbmc+PHNwYW4gaWQ9ImNzMmNfZnJvbSI+SmFuIEthcmE8L3NwYW4+
IDxicj48c3Ryb25nPuaUtuS7tuS6uu+8mjwvc3Ryb25nPjxzcGFuIGlkPSJj
czJjX3RvIiBzdHlsZT0id29yZC1icmVhazogYnJlYWstYWxsOyI+ZmZmc3Fp
YW4sSmFuIEthcmE8L3NwYW4+IDxicj48c3Ryb25nPuaKhOmAgeS6uu+8mjwv
c3Ryb25nPjxzcGFuIGlkPSJjczJjX3RvIiBzdHlsZT0id29yZC1icmVhazog
YnJlYWstYWxsOyI+dmlybyxicmF1bmVyLGphY2ssbGludXgtZnNkZXZlbCxs
aW51eC1rZXJuZWw8L3NwYW4+PC9kaXY+Cjxicj4KPGRpdiBpZD0iY3MyY19j
b250ZW50Ij5PbiBXZWQgMjctMDUtMjYgMTE6MzE6MDIsIGZmZnNxaWFuQDE2
My5jb20gd3JvdGU6ICZndDsgRnJvbTogUWluZ3NodWFuZyBGdSAmbHQ7ZnVx
aW5nc2h1YW5nQGt5bGlub3MuY24mZ3Q7ICZndDsgJmd0OyBGaXggdHdvIHNw
ZWxsaW5nIGVycm9ycyBpbiBmcy86ICZndDsgLSBjaGlsZGVuIOKGkiBjaGls
ZHJlbiAmZ3Q7IC0gcG9zdGlvbiDihpIgcG9zaXRpb24gJmd0OyAmZ3Q7IFNp
Z25lZC1vZmYtYnk6IFFpbmdzaHVhbmcgRnUgJmx0O2Z1cWluZ3NodWFuZ0Br
eWxpbm9zLmNuJmd0OyBMb29rcyBnb29kLiBGZWVsIGZyZWUgdG8gYWRkOiBS
ZXZpZXdlZC1ieTogSmFuIEthcmEgJmx0O2phY2tAc3VzZS5jeiZndDsgSG9u
emEgJmd0OyAtLS0gJmd0OyBmcy9jb3JlZHVtcC5jIHwgNCArKy0tICZndDsg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkgJmd0OyAmZ3Q7IGRpZmYgLS1naXQgYS9mcy9jb3JlZHVtcC5jIGIvZnMv
Y29yZWR1bXAuYyAmZ3Q7IGluZGV4IGJiNmZkYjFmNDU4ZS4uZjgyZjZkYzRm
NzczIDEwMDY0NCAmZ3Q7IC0tLSBhL2ZzL2NvcmVkdW1wLmMgJmd0OyArKysg
Yi9mcy9jb3JlZHVtcC5jICZndDsgQEAgLTYzNyw3ICs2MzcsNyBAQCBzdGF0
aWMgaW50IHVtaF9jb3JlZHVtcF9zZXR1cChzdHJ1Y3Qgc3VicHJvY2Vzc19p
bmZvICppbmZvLCBzdHJ1Y3QgY3JlZCAqbmV3KSAmZ3Q7IHBpZGZzX2NvcmVk
dW1wKGNwKTsgJmd0OyAmZ3Q7IC8qICZndDsgLSAqIFVzZXJtb2RlIGhlbHBl
cnMgYXJlIGNoaWxkZW4gb2YgZWl0aGVyICZndDsgKyAqIFVzZXJtb2RlIGhl
bHBlcnMgYXJlIGNoaWxkcmVuIG9mIGVpdGhlciAmZ3Q7ICogc3lzdGVtX2Rm
bF93cSBvciBvZiBrdGhyZWFkZC4gU28gd2Uga25vdyB0aGF0ICZndDsgKiB3
ZSdyZSBzdGFydGluZyBvZmYgd2l0aCBhIGNsZWFuIGZpbGUgZGVzY3JpcHRv
ciAmZ3Q7ICogdGFibGUuIFNvIHdlIHNob3VsZCBhbHdheXMgYmUgYWJsZSB0
byB1c2UgJmd0OyBAQCAtMTA1Myw3ICsxMDUzLDcgQEAgc3RhdGljIGJvb2wg
Y29yZWR1bXBfd3JpdGUoc3RydWN0IGNvcmVfbmFtZSAqY24sICZndDsgY24t
Jmd0O2NvcmVfZHVtcGVkID0gYmluZm10LSZndDtjb3JlX2R1bXAoY3BybSk7
ICZndDsgLyogJmd0OyAqIEVuc3VyZXMgdGhhdCBmaWxlIHNpemUgaXMgYmln
IGVub3VnaCB0byBjb250YWluIHRoZSBjdXJyZW50ICZndDsgLSAqIGZpbGUg
cG9zdGlvbi4gVGhpcyBwcmV2ZW50cyBnZGIgZnJvbSBjb21wbGFpbmluZyBh
Ym91dCAmZ3Q7ICsgKiBmaWxlIHBvc2l0aW9uLiBUaGlzIHByZXZlbnRzIGdk
YiBmcm9tIGNvbXBsYWluaW5nIGFib3V0ICZndDsgKiBhIHRydW5jYXRlZCBm
aWxlIGlmIHRoZSBsYXN0ICJ3cml0ZSIgdG8gdGhlIGZpbGUgd2FzICZndDsg
KiBkdW1wX3NraXAuICZndDsgKi8gJmd0OyAmZ3Q7IGJhc2UtY29tbWl0OiBl
YjNmNGI3NDI2Y2ZkMmI3OWQ2NWI3ZDM3MTU1NDgwYjMyMjU5YTExICZndDsg
LS0gJmd0OyAyLjI1LjEgJmd0OyAtLSBKYW4gS2FyYSAmbHQ7amFja0BzdXNl
LmNvbSZndDsgU1VTRSBMYWJzLCBDUiAmbHQ7L2phY2tAc3VzZS5jb20mZ3Q7
Jmx0Oy9qYWNrQHN1c2UuY3omZ3Q7Jmx0Oy9mdXFpbmdzaHVhbmdAa3lsaW5v
cy5jbiZndDsmbHQ7L2Z1cWluZ3NodWFuZ0BreWxpbm9zLmNuJmd0OzwvZGl2
Pgo8L2Rpdj4KPHA+Jm5ic3A7PC9wPgo8cD4mbmJzcDs8L3A+CjxkaXYgaWQ9
InNpZ25hdHVyZUJvbSI+CjxkaXY+CjxwPiZuYnNwOzwvcD4KPGJyPgo8cCBz
dHlsZT0iY29sb3I6ICMwMDA7IGZvbnQtc2l6ZTogMTZweDsiPi0tLTwvcD4K
PGRpdiBpZD0iY3MyY19tYWlsX3NpZ2F0dXJlIiBzdHlsZT0iY29sb3I6ICMw
MDA7IGZvbnQtc2l6ZTogMTZweDsgZm9udC1mYW1pbHk6IE1pY3Jvc29mdCBZ
YUhlaTsiPjwvZGl2Pgo8cD4mbmJzcDs8L3A+CjwvZGl2Pgo8L2Rpdj48L2Rp
dj4=

--nsmail-774ajja99sxy-774hzijv2gnb--
