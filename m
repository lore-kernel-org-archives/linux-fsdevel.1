Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6D3ACEE3
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286482; cv=none; b=VOvY4UGPnaFg6/v7cRgPMg3HxmfGKpu9BNwz4DRzgC8e2GPFm2ekzF4FXVgd6XKBfDwkdiWGIBY3yZBjlkL46/I4hFfEABbhAtZRVgIUs7i0SJYndYuQGis8tl/axRg7VQ+cCKltTjFfAkVch+zL7zVip9xRqYNK9M2umVVB7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286482; c=relaxed/simple;
	bh=yH1yt0CoI6J8X7bpRyZZ2pRSe3RY9ifAqT9OyjlZIEE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=OJHsZR6LySFZXnqriZf4Ojj8zdR8TyHeuUEf0DwbvmYULeIklq4DCb6XtcuX/zj0VHhM5fNhvBSpJZbXdxLxnk7x5DW1lS2H5YRac9F9xVJGoC3zu6nTlU8sMTNiSUV4hCO++vG7EHUs33ZZU7E1eKDaDcfJjdMkzWLXDFrXYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Js+TMjj8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Js+TMjj8"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g40V54Zb5z9tkN
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 12:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777286477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=yH1yt0CoI6J8X7bpRyZZ2pRSe3RY9ifAqT9OyjlZIEE=;
	b=Js+TMjj8OScIyEO1cjpuQbPwQ61uXemVKOH81nq9v0uHwj+zh6Huiq/EZjZ4s21BlRZmOR
	3QJMGxZJJ4ki/CCW5sw0z/FTr1q6gT6NrJnybuKCPAUXiDaC7vF7RKgFOk6IHeS5NQR06j
	wdcDW+aVVYPohhznvAXkBH7nsGsyRGchXPjZtALskFGLUczR9DB6fePMHABwMJJWvogFS0
	mHwUZUMn5EjInyhxq1bfZT9edQO1ksvdSkM0cdoUsDLM5bT6aDq/1LVEVCPrikELUpf08i
	DQ3aq1LK5nNBwgk/SA2LB/lQh/lU/WGhMKiT5z/UsWndNQeGxFitruGJZhTwhA==
Message-ID: <9a7ffc95-077c-473d-9462-a7d4ac58e9ed@mailbox.org>
Date: Mon, 27 Apr 2026 12:41:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
From: Zeno Endemann <zeno.endemann@mailbox.org>
Subject: Meaning of struct statx->stx_blksize field
Autocrypt: addr=zeno.endemann@mailbox.org; keydata=
 xjMEaQTnsRYJKwYBBAHaRw8BAQdAaM0iP7BM4cim48CUrxLA/GL1pYCCEzcWwMWZpif6rNXN
 M1plbm8gU2ViYXN0aWFuIEVuZGVtYW5uIDx6ZW5vLmVuZGVtYW5uQG1haWxib3gub3JnPsKW
 BBMWCgA+FiEEmC5dRIssSc8usW9ctw5fyLMNvKkFAmkE57ECGwMFCQWjmoAFCwkIBwIGFQoJ
 CAsCBBYCAwECHgECF4AACgkQtw5fyLMNvKlmYgD+LcbsvEZxyegeAcyvZXvpZBEjHXqkdM90
 C9QVC1CsW3IA/jqxTNUPJZ26XR3/d7XcWMFg5JRZyJdL7dP+7crJeMkGzjgEaQTnsRIKKwYB
 BAGXVQEFAQEHQHFzaxdORLfIxXTm1tjSnTbboFXL9tw5GgcNA4Nz0AQiAwEIB8J+BBgWCgAm
 FiEEmC5dRIssSc8usW9ctw5fyLMNvKkFAmkE57ECGwwFCQWjmoAACgkQtw5fyLMNvKmYmgEA
 xY2IpTWenWoXXSyhGUWu/ZfdRUsUBtYM5wSj7XeayCUA/0/dEWSKHsuxuFgvaetZE92+qjb8
 HkxusIwKIh1rafYI
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: i7yxywojr7qcokbdjsih5ic6eecjbtwn
X-MBO-RS-ID: 8794de77527b5d71ec8

Hi,

The man page of statx(2) describes the stx_blksize like so:

 > The "preferred" block size for efficient filesystem I/O.
 > (Writing to a file in smaller chunks may cause an
 > inefficient read-modify-rewrite.)


However, from observation it rather looks like that field
is set to the "block size" (meaning the allocation unit) of
the file system the given file resides on - at least for
ext4 and vfat.

To my understanding that value is fairly unrelated to a good
IO transfer size and for the most part not really relevant
for userspace apps. For avoiding inefficient read-modify
rewrite the actual relevant thing is writing in multiples of
the page size (unless the page cache is bypassed, in which
case I guess stx_dio_offset_align is the value to use).

Can someone confirm my interpretation, so the man page can be
corrected? Or do I misunderstand or overlook something?

Thanks,

Zeno Endemann
