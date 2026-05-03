Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C12D7BF;
	Sun,  3 May 2026 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777788029; cv=none; b=WF/CX/OViPaaj4lVIRm+nRV2iI0jHQh7LMHJeqDSNOhCoq/CNdGiUXx7S5bP75mORpPwbtcl0ICv2A42kluWA1F91pPR/evytnK6dziIxWvAoNSukj5vUoyyfLsojDwHAZ7W9oG+Uux3aK50+4B12cCo1sgeBdk6ynNAD9jMRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777788029; c=relaxed/simple;
	bh=wO8rjCYdIBcW/Y7koahzQo+OytF/YnJYooGQ+ycDZ4w=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=HsyJ5KV5OGQ6tPBlngTIAOxE4vbfAianCqurK7qDYNTJeTcwayJ+Pc2q//0hdSBSD39NEFzUKzedBOcSHjLUlmGkL10INxNe8Cptc/FQUzDMqE4hGVolEHMPcDIpfyo12KbXiA05G5dhO/w6Cz9oSb+4cAhOqoqIJbKzbT3il2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id B5BC91D490;
	Sun,  3 May 2026 06:00:18 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id 1TKCGXLk9mlxkwAA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sun, 03 May 2026 06:00:18 +0000
Content-Type: multipart/mixed; boundary="------------GQoHdbbTEYRjJyiNyC5SxWyd"
Message-ID: <4b30ba28-6f75-43a1-a108-5c0288ab021a@dev.snart.me>
Date: Sun, 3 May 2026 15:00:14 +0900
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
--------------GQoHdbbTEYRjJyiNyC5SxWyd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test
--------------GQoHdbbTEYRjJyiNyC5SxWyd
Content-Type: text/x-patch; charset=UTF-8;
 name="syz-cae7809e9dc1459e4e63.patch"
Content-Disposition: attachment; filename="syz-cae7809e9dc1459e4e63.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L3N1cGVyLmMgYi9mcy9leGZhdC9zdXBlci5jCmluZGV4
IDk1ZDg3ZTJkNzcxNy4uZGYxMGQ5YTc5YTI5IDEwMDY0NAotLS0gYS9mcy9leGZhdC9zdXBl
ci5jCisrKyBiL2ZzL2V4ZmF0L3N1cGVyLmMKQEAgLTY1Niw2ICs2NTYsNyBAQCBzdGF0aWMg
aW50IF9fZXhmYXRfZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLAogZnJlZV9h
bGxvY19iaXRtYXA6CiAJZXhmYXRfZnJlZV9iaXRtYXAoc2JpKTsKIGZyZWVfYmg6CisJZXhm
YXRfZnJlZV91cGNhc2VfdGFibGUoc2JpKTsKIAlicmVsc2Uoc2JpLT5ib290X2JoKTsKIAly
ZXR1cm4gcmV0OwogfQpAQCAtNzUyLDYgKzc1Myw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfZ2V0
X3RyZWUoc3RydWN0IGZzX2NvbnRleHQgKmZjKQogCiBzdGF0aWMgdm9pZCBleGZhdF9mcmVl
X3NiaShzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpKQogeworCWV4ZmF0X2ZyZWVfdXBjYXNl
X3RhYmxlKHNiaSk7CiAJZXhmYXRfZnJlZV9pb2NoYXJzZXQoc2JpKTsKIAlrZnJlZShzYmkp
OwogfQo=
--------------GQoHdbbTEYRjJyiNyC5SxWyd
Content-Type: text/x-patch; charset=UTF-8;
 name="syz-cae7809e9dc1459e4e63.f2fs-crippled.patch"
Content-Disposition: attachment;
 filename="syz-cae7809e9dc1459e4e63.f2fs-crippled.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2YyZnMvc3VwZXIuYyBiL2ZzL2YyZnMvc3VwZXIuYwppbmRleCBj
NGMyMjVlMDlkYzQuLmZkMjQ5OWZlMTU2YiAxMDA2NDQKLS0tIGEvZnMvZjJmcy9zdXBlci5j
CisrKyBiL2ZzL2YyZnMvc3VwZXIuYwpAQCAtNTM4OCw3ICs1Mzg4LDEwIEBAIHN0YXRpYyBp
bnQgZjJmc19maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBmc19j
b250ZXh0ICpmYykKIAogc3RhdGljIGludCBmMmZzX2dldF90cmVlKHN0cnVjdCBmc19jb250
ZXh0ICpmYykKIHsKLQlyZXR1cm4gZ2V0X3RyZWVfYmRldihmYywgZjJmc19maWxsX3N1cGVy
KTsKKwlpZiAodHJ1ZSkKKwkJcmV0dXJuIC1FTk9NRU07CisJZWxzZQorCQlyZXR1cm4gZ2V0
X3RyZWVfYmRldihmYywgZjJmc19maWxsX3N1cGVyKTsKIH0KIAogc3RhdGljIGludCBmMmZz
X3JlY29uZmlndXJlKHN0cnVjdCBmc19jb250ZXh0ICpmYykK

--------------GQoHdbbTEYRjJyiNyC5SxWyd--
