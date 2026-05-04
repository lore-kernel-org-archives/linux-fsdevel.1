Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BAF2E5B2A;
	Mon,  4 May 2026 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777925878; cv=none; b=HvE5BWIqLj3DeewtX1OToGaZ5UEuW46Y0AUNObPtk+PDhawiT6CCLiO6JqZhlwtD3rSKaxPgHpCQYrqOHmtGVOFyWa3uQpypIeVAPJQ/uy9R9XOKy1dtGkhfOs0yohkfyW8QB94kg+nlPlWj/AZcmswnFy96Xde4KvGJaxYg6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777925878; c=relaxed/simple;
	bh=XBCWx0m8bb3GJusI0mviL4YlaAPRihO9FHtlhisSfT8=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=aX0s0uOSwIm7yG/YeHbExZPGk/QoYFhSkyffHXx1IbvIb8lj1CQGsq5xbTYL0gIzpNK2ZgpS9yaozU9EM4MKYOfgN/ngLANHWUmxHEqy+0tcixCxx9JWEfh9jOONNusXWWPJMQeMec5N5R1AvCWvhZMCh96kWbC+/DGbH58xhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id CF49C1D490;
	Mon,  4 May 2026 20:17:48 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id kpfYIez++GlJJwEA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 04 May 2026 20:17:48 +0000
Content-Type: multipart/mixed; boundary="------------k0h9QtSMARiwiU4a30pozDMq"
Message-ID: <2956b248-c79f-4eae-8bfc-81178b5899af@dev.snart.me>
Date: Tue, 5 May 2026 05:17:44 +0900
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
--------------k0h9QtSMARiwiU4a30pozDMq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test
--------------k0h9QtSMARiwiU4a30pozDMq
Content-Type: text/x-patch; charset=UTF-8;
 name="syz-cae7809e9dc1459e4e63.f2fs-use-after-free.patch"
Content-Disposition: attachment;
 filename="syz-cae7809e9dc1459e4e63.f2fs-use-after-free.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2YyZnMvc3VwZXIuYyBiL2ZzL2YyZnMvc3VwZXIuYwppbmRleCBj
NGMyMjVlMDlkYzQuLjVhMzhiNzQ3NTdjYSAxMDA2NDQKLS0tIGEvZnMvZjJmcy9zdXBlci5j
CisrKyBiL2ZzL2YyZnMvc3VwZXIuYwpAQCAtNDU5NSw2ICs0NTk1LDggQEAgdm9pZCBmMmZz
X2hhbmRsZV9lcnJvcihzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksIHVuc2lnbmVkIGNoYXIg
ZXJyb3IpCiAJCXJldHVybjsKIAlpZiAoIXRlc3RfYml0KGVycm9yLCAodW5zaWduZWQgbG9u
ZyAqKXNiaS0+ZXJyb3JzKSkKIAkJcmV0dXJuOworCisJZjJmc19ub3RpY2Uoc2JpLCAic19l
cnJvcl93b3JrIHNjaGVkdWxlZCBpbiBmMmZzX2hhbmRsZV9lcnJvcigpIGJ5IHNiaSBhdCAl
cCIsIHNiaSk7CiAJc2NoZWR1bGVfd29yaygmc2JpLT5zX2Vycm9yX3dvcmspOwogfQogCkBA
IC00NjIxLDYgKzQ2MjMsNyBAQCB2b2lkIGYyZnNfaGFuZGxlX2NyaXRpY2FsX2Vycm9yKHN0
cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgdW5zaWduZWQgY2hhciByZWFzb24pCiAJCSAqIGlu
IG9yZGVyIHRvIGF2b2lkIHBvdGVudGlhbCBkZWFkbG9jayB3aGVuIHJ1bm5pbmcgaW50bwog
CQkgKiBmMmZzX3JlY29yZF9zdG9wX3JlYXNvbigpIHN5bmNocm9ub3VzbHkuCiAJCSAqLwor
CQlmMmZzX25vdGljZShzYmksICJzX2Vycm9yX3dvcmsgc2NoZWR1bGVkIGluIGYyZnNfaGFu
ZGxlX2NyaXRpY2FsX2Vycm9yKCkgYnkgc2JpIGF0ICVwIiwgc2JpKTsKIAkJc2NoZWR1bGVf
d29yaygmc2JpLT5zX2Vycm9yX3dvcmspOwogCX0KIApAQCAtNDY2Niw2ICs0NjY5LDEwIEBA
IHN0YXRpYyB2b2lkIGYyZnNfcmVjb3JkX2Vycm9yX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0
ICp3b3JrKQogCXN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSA9IGNvbnRhaW5lcl9vZih3b3Jr
LAogCQkJCQlzdHJ1Y3QgZjJmc19zYl9pbmZvLCBzX2Vycm9yX3dvcmspOwogCisJZjJmc19u
b3RpY2Uoc2JpLCAiZjJmc19yZWNvcmRfZXJyb3Jfd29yaygpIik7CisJaWYgKHVubGlrZWx5
KGlzX3NiaV9mbGFnX3NldChzYmksIFNCSV9JU19DTE9TRSkpKQorCQlwYW5pYygiISEhIHNi
aSBhdCAlcCB1c2VkIGFmdGVyIGZyZWVpbmcgISEhIiwgc2JpKTsKKwogCWYyZnNfcmVjb3Jk
X3N0b3BfcmVhc29uKHNiaSk7CiB9CiAKQEAgLTU0NTQsNiArNTQ2MSw3IEBAIHN0YXRpYyB2
b2lkIGtpbGxfZjJmc19zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQogCWtpbGxfYmxv
Y2tfc3VwZXIoc2IpOwogCS8qIFJlbGVhc2UgYmxvY2sgZGV2aWNlcyBsYXN0LCBhZnRlciBm
c2NyeXB0X2Rlc3Ryb3lfa2V5cmluZygpLiAqLwogCWlmIChzYmkpIHsKKwkJZjJmc19ub3Rp
Y2Uoc2JpLCAiZnJlZWluZyBzYmkgYXQgJXB4IGluIGtpbGxfZjJmc19zdXBlcigpIiwgc2Jp
KTsKIAkJZGVzdHJveV9kZXZpY2VfbGlzdChzYmkpOwogCQlrZnJlZShzYmkpOwogCQlzYi0+
c19mc19pbmZvID0gTlVMTDsK

--------------k0h9QtSMARiwiU4a30pozDMq--
