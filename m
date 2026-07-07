Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB583876DE;
	Tue,  7 Jul 2026 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407013; cv=none; b=aHypo9sM9r4H00dNnY3t2Ng3bop2r+wVNWKLGQjQDPIVpLuvsEUT8wbFkcVPSXM988xjaks0R44Ak2qMwp4H5LbYpcury3X27aYrRkRzIZGJlMM47LVLqLZLP9PX4iLGjKbTvaWy7TTW9H3SQFikU+1e//Zk8S4Y9Vi1zK7kbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407013; c=relaxed/simple;
	bh=vsxPsF69P5mxW2qFyfvdTU1ZMPuvG2A+BKk4EQd5uX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=g0c9E+Yg9mMSOmxz2gXILHv84yL8B2YCHoB0j633W2dSLquZUFmN9NSGWL0XnRzUJD3ChNzHwNXPYQLYjAUoqgej2wB03vO3lCCqyOc7m33MfD6aDH2rVH9xPpk4UMJjAN19uO/8n5hrD+b/Fkp5BUGksiMmWtKvcCReLgssSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i5pyCbM1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i5pyCbM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=vsxPsF69P5mxW2qFyfvdTU1ZMPuvG2A+BKk4EQd5uX4=; b=i
	5pyCbM1CgGTXmOhHTw8n+VNrVn+Ceo4qvH2xE4DHP8+jyfcgeNut4qslHYqnrOGT
	Hffp5xu6mgJSB12LmWeWu4wfCD+8craolyxyhFFDpHC9XT1gi12gIGWbOJNAOWtU
	KaP+kCWn0rsIdCK8Cg4kGxOdyXFspwdkmkBERxQy7M=
Received: from fuqingshuang$kylinos.cn ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Tue, 7 Jul 2026 14:49:34 +0800 (CST)
Date: Tue, 7 Jul 2026 14:49:34 +0800 (CST)
From: "Qingshuang Fu" <fuqingshuang@kylinos.cn>
To: "Jan Kara" <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v1] fs: fix two spelling mistakes in comments
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
Sender: fffsqian@163.com
In-Reply-To: <iqp6gjxl7qohnxn7rle62zovyiedmw7nnfhjk5mpmq4azx7v5m@llgoenjgzgbf>
References: <20260527033102.824028-1-fffsqian@163.com>
 <iqp6gjxl7qohnxn7rle62zovyiedmw7nnfhjk5mpmq4azx7v5m@llgoenjgzgbf>
X-NTES-SC: AL_Qu2TAfibuUEs4iefYOkckk4Vhu49Xcq2vvQv34Fec/kEsg/Pxj47bHtAL33fwuumBguCmxSrcgRW6spxb4pAJ1140m4p9odSouTRjBRWKg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2fd64e26.5358.19f3b56d73f.Coremail.fuqingshuang@kylinos.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bygvCgDX_69_oUxqxR8ZAA--.1634W
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbC6R81AGpMoX9hRwAA3d
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjYtMDUtMjggMTk6NTI6MTksICJKYW4gS2FyYSIgPGphY2tAc3VzZS5jej4gd3JvdGU6
Cj5PbiBXZWQgMjctMDUtMjYgMTE6MzE6MDIsIGZmZnNxaWFuQDE2My5jb20gd3JvdGU6Cj4+IEZy
b206IFFpbmdzaHVhbmcgRnUgPGZ1cWluZ3NodWFuZ0BreWxpbm9zLmNuPgo+PiAKPj4gRml4IHR3
byBzcGVsbGluZyBlcnJvcnMgaW4gZnMvOgo+PiAtIGNoaWxkZW4gIKH6ICBjaGlsZHJlbgo+PiAt
IHBvc3Rpb24gofogcG9zaXRpb24KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFFpbmdzaHVhbmcgRnUg
PGZ1cWluZ3NodWFuZ0BreWxpbm9zLmNuPgo+Cj5Mb29rcyBnb29kLiBGZWVsIGZyZWUgdG8gYWRk
Ogo+Cj5SZXZpZXdlZC1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KPgo+CQkJCQkJCQlIb256
YQo+Cj4+IC0tLQo+PiAgZnMvY29yZWR1bXAuYyB8IDQgKystLQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9mcy9j
b3JlZHVtcC5jIGIvZnMvY29yZWR1bXAuYwo+PiBpbmRleCBiYjZmZGIxZjQ1OGUuLmY4MmY2ZGM0
Zjc3MyAxMDA2NDQKPj4gLS0tIGEvZnMvY29yZWR1bXAuYwo+PiArKysgYi9mcy9jb3JlZHVtcC5j
Cj4+IEBAIC02MzcsNyArNjM3LDcgQEAgc3RhdGljIGludCB1bWhfY29yZWR1bXBfc2V0dXAoc3Ry
dWN0IHN1YnByb2Nlc3NfaW5mbyAqaW5mbywgc3RydWN0IGNyZWQgKm5ldykKPj4gIAkJcGlkZnNf
Y29yZWR1bXAoY3ApOwo+PiAgCj4+ICAJCS8qCj4+IC0JCSAqIFVzZXJtb2RlIGhlbHBlcnMgYXJl
IGNoaWxkZW4gb2YgZWl0aGVyCj4+ICsJCSAqIFVzZXJtb2RlIGhlbHBlcnMgYXJlIGNoaWxkcmVu
IG9mIGVpdGhlcgo+PiAgCQkgKiBzeXN0ZW1fZGZsX3dxIG9yIG9mIGt0aHJlYWRkLiBTbyB3ZSBr
bm93IHRoYXQKPj4gIAkJICogd2UncmUgc3RhcnRpbmcgb2ZmIHdpdGggYSBjbGVhbiBmaWxlIGRl
c2NyaXB0b3IKPj4gIAkJICogdGFibGUuIFNvIHdlIHNob3VsZCBhbHdheXMgYmUgYWJsZSB0byB1
c2UKPj4gQEAgLTEwNTMsNyArMTA1Myw3IEBAIHN0YXRpYyBib29sIGNvcmVkdW1wX3dyaXRlKHN0
cnVjdCBjb3JlX25hbWUgKmNuLAo+PiAgCWNuLT5jb3JlX2R1bXBlZCA9IGJpbmZtdC0+Y29yZV9k
dW1wKGNwcm0pOwo+PiAgCS8qCj4+ICAJICogRW5zdXJlcyB0aGF0IGZpbGUgc2l6ZSBpcyBiaWcg
ZW5vdWdoIHRvIGNvbnRhaW4gdGhlIGN1cnJlbnQKPj4gLQkgKiBmaWxlIHBvc3Rpb24uIFRoaXMg
cHJldmVudHMgZ2RiIGZyb20gY29tcGxhaW5pbmcgYWJvdXQKPj4gKwkgKiBmaWxlIHBvc2l0aW9u
LiBUaGlzIHByZXZlbnRzIGdkYiBmcm9tIGNvbXBsYWluaW5nIGFib3V0Cj4+ICAJICogYSB0cnVu
Y2F0ZWQgZmlsZSBpZiB0aGUgbGFzdCAid3JpdGUiIHRvIHRoZSBmaWxlIHdhcwo+PiAgCSAqIGR1
bXBfc2tpcC4KPj4gIAkgKi8KPj4gCj4+IGJhc2UtY29tbWl0OiBlYjNmNGI3NDI2Y2ZkMmI3OWQ2
NWI3ZDM3MTU1NDgwYjMyMjU5YTExCj4+IC0tIAo+PiAyLjI1LjEKPj4gCj4tLSAKPkphbiBLYXJh
IDxqYWNrQHN1c2UuY29tPgo+U1VTRSBMYWJzLCBDUgoKCkhpIEphbiwgQWwsIENocmlzdGlhbiwK
ClRoYW5rcyBKYW4gZm9yIHByb3ZpZGluZyB0aGUgUmV2aWV3ZWQtYnkgdGFnIG9uIG15IG9yaWdp
bmFsIHBhdGNoLgpJIHNlbnQgb3V0IHYyIG9uZSBtb250aCBhZ28gd2hpY2ggY2FycmllcyB5b3Vy
IHJldmlld2VkLWJ5IHRhZywgYnV0IHRoZXJlIGhhcyBiZWVuIG5vIGZ1cnRoZXIgZmVlZGJhY2su
CgpUaGlzIHBhdGNoIG9ubHkgZml4ZXMgdHdvIHRyaXZpYWwgc3BlbGxpbmcgdHlwb3MgaW4gY29y
ZWR1bXAgY29tbWVudCwgbm8gZnVuY3Rpb25hbCBsb2dpYyBjaGFuZ2VzLgpDb3VsZCB5b3UgaGVs
cCByZXZpZXcvbWVyZ2UgaXQgd2hlbiB5b3UgaGF2ZSBzcGFyZSB0aW1lPwoKUmVmZXJlbmNlIHYy
IHBhdGNoOgpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA1MjkwNDA3MDEuMTgyNTIz
OC0xLWZmZnNxaWFuQDE2My5jb20vCgpCZXN0IHJlZ2FyZHMsClFpbmdzaHVhbmcgRnUgPGZ1cWlu
Z3NodWFuZ0BreWxpbm9zLmNuPg==
