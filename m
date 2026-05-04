Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032533E866D;
	Mon,  4 May 2026 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926369; cv=none; b=EUvZm1S8oKKoHih2b91HwB9N6WY0YLsByAWy8iszk4QZWbMpd60uJND4wyfuYmlyDkRFwm3XO49GEI9SUe/bQ1gpZOacInYAly69G9F1KtHXIJ9hcvYTNYRwUIHnSyELANrQeLGmIxLBRmJurcY313DJ3a75Ppz3rMweRcd5ICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926369; c=relaxed/simple;
	bh=5wLVemXqI5XtogvSMfyxXKUc5BMAPV85CSbBsm7nmCU=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=WkXRSXGuHpbivoTykSDG+IrBavTRe1PYSwpWpoD/mDOe8HIxcY70rRlnAZotc6oEsCBjMnSWqR++HrDUmmDdWr0V38OoR+ho3kGVKZd/xwgna2mMW3xpv3glFwOA5QN/d0MPqvg1LAl69lHoPs+Bx5kbF3CNEkgK/08se0uFHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 683EC1D490;
	Mon,  4 May 2026 20:26:04 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id lSeiCNwA+WnyJwEA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 04 May 2026 20:26:04 +0000
Content-Type: multipart/mixed; boundary="------------SgzrhKw02r9lKy3Uyqq9E2Ky"
Message-ID: <13bb1c13-98b6-4a4a-b03d-ba0f88680f1e@dev.snart.me>
Date: Tue, 5 May 2026 05:26:03 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Timber <dxdt@dev.snart.me>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
To: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <698a26d3.050a0220.3b3015.007e.GAE@google.com>

This is a multi-part message in MIME format.
--------------SgzrhKw02r9lKy3Uyqq9E2Ky
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test
--------------SgzrhKw02r9lKy3Uyqq9E2Ky
Content-Type: text/x-patch; charset=UTF-8;
 name="syz-cae7809e9dc1459e4e63.f2fs-dont-use-after-free.patch"
Content-Disposition: attachment;
 filename="syz-cae7809e9dc1459e4e63.f2fs-dont-use-after-free.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2YyZnMvc3VwZXIuYyBiL2ZzL2YyZnMvc3VwZXIuYwppbmRleCBj
NGMyMjVlMDlkYzQuLjdhYmE5OWUxZjkzZiAxMDA2NDQKLS0tIGEvZnMvZjJmcy9zdXBlci5j
CisrKyBiL2ZzL2YyZnMvc3VwZXIuYwpAQCAtNDU5NSw2ICs0NTk1LDEyIEBAIHZvaWQgZjJm
c19oYW5kbGVfZXJyb3Ioc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCB1bnNpZ25lZCBjaGFy
IGVycm9yKQogCQlyZXR1cm47CiAJaWYgKCF0ZXN0X2JpdChlcnJvciwgKHVuc2lnbmVkIGxv
bmcgKilzYmktPmVycm9ycykpCiAJCXJldHVybjsKKworCWlmICh1bmxpa2VseShpc19zYmlf
ZmxhZ19zZXQoc2JpLCBTQklfSVNfQ0xPU0UpKSkgeworCQlmMmZzX3dhcm4oc2JpLCAiZjJm
c19oYW5kbGVfZXJyb3IoKSBjYWxsZWQgdXBvbiBzYl9wdXQiKTsKKwkJcmV0dXJuOworCX0K
KwogCXNjaGVkdWxlX3dvcmsoJnNiaS0+c19lcnJvcl93b3JrKTsKIH0KIApAQCAtNDYyMSw3
ICs0NjI3LDEwIEBAIHZvaWQgZjJmc19oYW5kbGVfY3JpdGljYWxfZXJyb3Ioc3RydWN0IGYy
ZnNfc2JfaW5mbyAqc2JpLCB1bnNpZ25lZCBjaGFyIHJlYXNvbikKIAkJICogaW4gb3JkZXIg
dG8gYXZvaWQgcG90ZW50aWFsIGRlYWRsb2NrIHdoZW4gcnVubmluZyBpbnRvCiAJCSAqIGYy
ZnNfcmVjb3JkX3N0b3BfcmVhc29uKCkgc3luY2hyb25vdXNseS4KIAkJICovCi0JCXNjaGVk
dWxlX3dvcmsoJnNiaS0+c19lcnJvcl93b3JrKTsKKwkJaWYgKHVubGlrZWx5KGlzX3NiaV9m
bGFnX3NldChzYmksIFNCSV9JU19DTE9TRSkpKQorCQkJZjJmc193YXJuKHNiaSwgImYyZnNf
aGFuZGxlX2NyaXRpY2FsX2Vycm9yKCkgY2FsbGVkIHVwb24gc2JfcHV0Iik7CisJCWVsc2UK
KwkJCXNjaGVkdWxlX3dvcmsoJnNiaS0+c19lcnJvcl93b3JrKTsKIAl9CiAKIAkvKgo=

--------------SgzrhKw02r9lKy3Uyqq9E2Ky--
