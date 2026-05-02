Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13F31353B;
	Sat,  2 May 2026 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777716571; cv=none; b=fuzf6wrgqLYw7KrgcT0+8jiQbaRd64pN9VbnpQGGhMBsgUT5HimeGezFLZAdOBJACZJIqKMhWC+G5xo5PQGj6tWDooVvJJ9awBchYhRa7TGLHV9c4sFlPZN1Aqqc2mWE0R3R6gY2jnRAofavmPsKQYVMmZOxeI76zc8QouG+GhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777716571; c=relaxed/simple;
	bh=tvhU2FPOdnW18DAKkmSWm6VtPzZONYyLIxcRcchGJ2Y=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:Cc:In-Reply-To; b=uFOUHRkqgic2t+3rU82jEsnj7aUWC+3TdWmplS5W0U6IEy2xzwUF0TV10Bb/mLR3dC0ZdKvm+SaoShQtBBqKIIuEKywrcpEPblx0AFaugBns+2XepM7DuLbdZ8n5ZUPaiLFXGFOFx4FV/5WCfgU0Ghf+NLJKP+QlGyOtpKZNxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 114B21D490;
	Sat,  2 May 2026 10:09:26 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id RUJcLVbN9WlfTQAA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sat, 02 May 2026 10:09:26 +0000
Content-Type: multipart/mixed; boundary="------------OqT5KjLsi2Nj00j2V0JIyF7M"
Message-ID: <41ec0e37-ce27-4daf-972e-580ce0ed445b@dev.snart.me>
Date: Sat, 2 May 2026 19:09:25 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
To: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
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
--------------OqT5KjLsi2Nj00j2V0JIyF7M
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

|#syz test|
--------------OqT5KjLsi2Nj00j2V0JIyF7M
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

--------------OqT5KjLsi2Nj00j2V0JIyF7M--
