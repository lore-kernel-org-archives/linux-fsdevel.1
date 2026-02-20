Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F619C546
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771592448; cv=none; b=n9vRoR032hInzcRiooMhAYgoxYQt++zzWf1TZRjc3EbXoRUgxI6ffO8gWW2QO+940ejvxZAziIapnHWvVyXeksd1wLCsf0KQykErGJKdfTEOODb0Mcvl2Z0j3XwUvWe53BDbtaHsv2LAVjDKZ2LECbYmnosssfoBpmJyan/4Viw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771592448; c=relaxed/simple;
	bh=eNyNBWMj/ENsfrS6EkF+pdHPNQyJ1hISw17QQ5JkOBI=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=dC1ptKthIdvlz9bvGl0ak6vdHV8I482dudOdUxKTIt5XDTHAaY8gUix4BVvoyePnWZz1CgBjlY9m5UrYfZBHOFkTOVPm9iCEhxg4V4ZDhr3IugtO8yc/vBoOaYeog6WCoHtv8jvd8Wt4wrxkJA7vz6yfJY22RFguM7+/NgWXDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nCacj2x5; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nCacj2x5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=eNyNBWMj/ENsfrS6EkF+pdHPNQyJ1hISw17QQ5JkOBI=; b=n
	Cacj2x5p0S8wHvk53+D8cMpDNFayHtQNbosuPP4CZV7l/4NH9mv5uxFf4Y7fRwF+
	aeQi4HdysY+QU8oXyLsA5K/mGFtvdYAzX0HieuhxTpfCCWSh6eeRyw7l6cq/L21J
	Wu6CUzMG7bM/m1DIZLWPWYVUhzRqUbmZsjWpBOnuxY=
Received: from nzzhao$126.com ( [5.34.216.87] ) by ajax-webmail-wmsvr-41-107
 (Coremail) ; Fri, 20 Feb 2026 20:59:38 +0800 (CST)
Date: Fri, 20 Feb 2026 20:59:38 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, "Christoph Hellwig" <hch@infradead.org>,
	willy@infradead.org, yi.zhang@huaweicloud.com, jaegeuk@kernel.org,
	"Chao Yu" <chao@kernel.org>, "Barry Song" <21cnbao@gmail.com>,
	wqu@suse.com
Subject: [LSF/MM/BPF TOPIC] Large folio support: iomap framework changes
 versus filesystem-specific implementations
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 126com
X-NTES-SC: AL_Qu2cA/mSvUss7iibZukWnE8Uj+g9Wsq2vv0m1IYbXe8yki/A9C4+QU9BHlvM6uCeKSqisD6yXgJ20Np7cpG78k3djr9BPZhRTn0yi148
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aykvCgD3_6O7WphpVyhXAA--.38510W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsBtFFWmYWrtoIAAA3j
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

TGFyZ2UgZm9saW9zIGNhbiByZWR1Y2UgcGVyLXBhZ2Ugb3ZlcmhlYWQgYW5kIGltcHJvdmUgdGhy
b3VnaHB1dCBmb3IgbGFyZ2UgYnVmZmVyZWQgSS9PLCBidXQgZW5hYmxpbmcgdGhlbSBpbiBmaWxl
c3lzdGVtcyBpcyBub3QgYSBtZWNoYW5pY2FsIKGwcGFnZSCh+iBmb2xpb6GxIGNvbnZlcnNpb24u
IFRoZSBjb3JlIGRpZmZpY3VsdHkgaXMgcHJlc2VydmluZyBjb3JyZWN0bmVzcyBhbmQgcGVyZm9y
bWFuY2Ugd2hlbiBhIGZvbGlvIG11c3QgbWFpbnRhaW4gc3VicmFuZ2Ugc3RhdGUsIHdoaWxlIGV4
aXN0aW5nIGZpbGVzeXN0ZW0gY29kZSBwYXRocyBhbmQgdGhlIGlvbWFwIGJ1ZmZlcmVkIEkvTyBm
cmFtZXdvcmsgbWFrZSBkaWZmZXJlbnQgYXNzdW1wdGlvbnMgYWJvdXQgc3RhdGUgdHJhY2tpbmcs
IGxvY2tpbmcgbGlmZXRpbWUsIGJsb2NrIG1hcHBpbmcsIGFuZCB3cml0ZWJhY2sgc2VtYW50aWNz
LgoKVGhpcyBzZXNzaW9uIHByb3Bvc2VzIGEgY3Jvc3MtZmlsZXN5c3RlbSBkaXNjdXNzaW9uIGFy
b3VuZCB0d28gZGlyZWN0aW9ucyB0aGF0IGFyZSBhY3RpdmVseSBiZWluZyBleHBsb3JlZDoKCklv
bWFwIGFwcHJvYWNoOiBhZG9wdCBpb21hcCBidWZmZXJlZCBJL08gcGF0aHMgYW5kIGJlbmVmaXQg
ZnJvbSBpb21hcC1zdHlsZSBzdWJyYW5nZSBmb2xpbyBzdGF0ZSBtYWNoaW5lcnkuIEhvd2V2ZXIs
IG11Y2ggb2YgdGhpcyBtYWNoaW5lcnkgbGl2ZXMgYXMgc3RhdGljIGhlbHBlcnMgaW5zaWRlIGlv
bWFwoa9zIGltcGxlbWVudGF0aW9uIChlLmcuLCBpbiBidWZmZXJlZC1pby5jKSBhbmQgaXMgbm90
IGF2YWlsYWJsZSBhcyBhIHJldXNhYmxlIEFQSSwgd2hpY2ggcHVzaGVzIGZpbGVzeXN0ZW1zIHRv
d2FyZCByZS1pbXBsZW1lbnRpbmcgc2ltaWxhciBsb2dpYy4gTW9yZW92ZXIsIGlvbWFwoa9zIHBl
ci1mb2xpbyBzdGF0ZSByZWxpZXMgb24gZm9saW8tcHJpdmF0ZSBtZXRhZGF0YSBzdG9yYWdlLCB3
aGljaCBjYW4gY2xhc2ggd2l0aCBmaWxlc3lzdGVtLXNwZWNpZmljIGZvbGlvLXByaXZhdGUgdXNh
Z2UuCgoKTmF0aXZlIGZzIGFwcHJvYWNoOiBrZWVwIG5hdGl2ZSBidWZmZXJlZCBJL08gcGF0aHMg
YW5kIGltcGxlbWVudCBmaWxlc3lzdGVtLXNwZWNpZmljIGZvbGlvX3N0YXRlIHRyYWNraW5nIGFu
ZCBoZWxwZXJzIHRvIGF2b2lkIHdob2xlLWZvbGlvIGRpcnR5aW5nL3dyaXRlIGFtcGxpZmljYXRp
b24gYW5kIHRvIG1hdGNoIGZpbGVzeXN0ZW0tcHJpdmF0ZSBtZXRhZGF0YSAoZS5nLiwgcHJpdmF0
ZSBmbGFncykuIFRoaXMgYXZvaWRzIHNvbWUgaW9tYXAgaW50ZWdyYXRpb24gY29uc3RyYWludHMg
YW5kIHByZXNlcnZlcyBmaWxlc3lzdGVtLXNwZWNpZmljIG9wdGltaXphdGlvbnMsIGJ1dCBpdCBp
bmNyZWFzZXMgZmlsZXN5c3RlbS1sb2NhbCBjb21wbGV4aXR5IGFuZCBsb25nLXRlcm0gbWFpbnRl
bmFuY2UgY29zdC4KCgpVc2luZyBmMmZzIGFzIGEgY29uY3JldGUgaW5zdGFuY2UgKGxvZy1zdHJ1
Y3R1cmVkLCBpbmRpcmVjdC1wb2ludGVyIG1hcHBpbmcsIHByaXZhdGUgZm9saW8gZmxhZ3MpLCB0
aGlzIHNlc3Npb24gY29uc29saWRhdGVzIHR3byByZWN1cnJpbmcgaXNzdWVzIHJlbGV2YW50IGFj
cm9zcyBmaWxlc3lzdGVtczoKClBlci1mb2xpbyBzdGF0ZSB0cmFja2luZzogaW9tYXAgc3VicmFu
Z2Utc3RhdGUgQVBJIGV4cG9zdXJlIHZzIGZpbGVzeXN0ZW0tbG9jYWwgc29sdXRpb24uCkNPVyB3
cml0ZWJhY2sgc3VwcG9ydDogbWluaW1hbCBpb21hcCBleHRlbnNpb25zIHZzIGZpbGVzeXN0ZW0t
bG9jYWwgd3JpdGViYWNrIGZvciBDT1cgcGF0aHMuCgpUaGUgZ29hbCBpcyB0byBjb252ZXJnZSBv
biByZWNvbW1lbmRlZCBkZXNpZ24gcGF0dGVybnMgYW5kIGFjdGlvbmFibGUgbmV4dCBzdGVwcyBm
b3IgZjJmcy9leHQ0L2J0cmZzL290aGVycyB0byBlbmFibGUgbGFyZ2UgZm9saW9zIHdpdGhvdXQg
Y29ycmVjdG5lc3Mgcmlza3Mgb3IgcGVyZm9ybWFuY2UgcmVncmVzc2lvbnMuCgpCZXN0IHJlZ2Fy
ZHMsCk5hbnpoZSBaaGFvCgpSZWxhdGVkIFBhdGNoZXMgZm9yIExhcmdlIEZvbGlvczoKCmYyZnM6
Ci0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwODEzMDkyMTMxLjQ0NzYyLTEtbnp6
aGFvQDEyNi5jb20vCi0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZjJmcy1kZXZlbC8y
MDI1MTEyMDIzNTQ0Ni4xOTQ3NTMyLTEtamFlZ2V1a0BrZXJuZWwub3JnLwotIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWYyZnMtZGV2ZWwvMjAyNjAyMDMwOTEyNTYuODU0ODQyLTEtbnp6
aGFvQDEyNi5jb20vCgpleHQ0OgotIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDUx
MjA2MzMxOS4zNTM5NDExLTEteWkuemhhbmdAaHVhd2VpY2xvdWQuY29tLwoKYnRyZnM6Ci0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzY3NjE1NGU1NDE1ZDhkMTU0OTlmYjhjMDJiMGVhYmJi
MWM2Y2VmMjYuMTc0NTQwMzg3OC5naXQud3F1QHN1c2UuY29tLw==
