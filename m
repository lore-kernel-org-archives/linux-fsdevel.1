Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989D326939
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773126125; cv=none; b=PuTzYwFAt2WzRF1SnOu4ERCtY2LOpviTXbp/Mj9cTl91kUex0obAyO4W1qcntlrcggYEZ4NK/brPrIfziAo3cddby7o6/trW8aLwE+6h2x34ktZU0NSR+QPVuMFeVMepR9kqeNyWtGDXHY1rWrG9rnS+mJt4Cq/rWcTDl8Pcg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773126125; c=relaxed/simple;
	bh=CDFAowXSXney0ksXggC7TJpx9IHCIC0+vaMl9LqLXHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMxZA34BnfX3kyvxx4VmRpvjm+vheJP+ln7RvH7/yLsflofQVdCNCXlYdjh6rHkTGw5in7mnNIpKLoWLiZ5m3LbwbZDN/mGSJUqj4KfAZ1TtpD6dMbN6YBqgr7iCw0OCsKQ2nmNW8Un/3n7Y19l88emNeLiXXzWzqBGRW8zXIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=foJx+wdW; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="foJx+wdW"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 397DD1CBC0;
	Tue, 10 Mar 2026 07:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 397DD1CBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773126114; bh=CDFAowXSXney0ksXggC7TJpx9IHCIC0+vaMl9LqLXHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=foJx+wdWSok2pardEAL39vJuk/W9iE8hiA2+tWd7evih0N405Eaoe9z99nWGn031X
	 YIzo5ZMW0P/uocpKoAtNnQXZKLyCH9FRrxQy1cPxGjHoKoUSi0waMgKJ33oPr7H1Sl
	 pSur7SHNhVSjsX66ZpkiTBPY7bletUVwn4OOdl44=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id mlJzNeDBr2nB+wMA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Tue, 10 Mar 2026 07:01:53 +0000
Message-ID: <cf6c2b08-b7ff-4f70-95f4-cdb12ef5a666@dev.snart.me>
Date: Tue, 10 Mar 2026 16:01:47 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, hyc.lee@gmail.com
References: <CAKYAXd_8vG6V0NRT_kb76n_yo+d9vvcx6JZbMARC5+C1ovboqw@mail.gmail.com>
 <20260304141713.533168-1-dxdt@dev.snart.me>
 <20260304141713.533168-2-dxdt@dev.snart.me>
 <CAKYAXd_RiCKF1nJK_Jg385VeGxeOUo08s0a_SNgtty2508wDmg@mail.gmail.com>
 <72446d20-f3ae-4acc-86cc-bd8fa3d86f41@dev.snart.me>
 <CAKYAXd97EDFy1yeF=MB0Pc5hR3UTF_u9h=58F6pW6c61DGeWuA@mail.gmail.com>
From: David Timber <dxdt@dev.snart.me>
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
In-Reply-To: <CAKYAXd97EDFy1yeF=MB0Pc5hR3UTF_u9h=58F6pW6c61DGeWuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/10/26 08:28, Namjae Jeon wrote:
> Since we can find out the unwritten area through fiemap ioctl(i.e. if
> fiemap ioctl is supported), wouldn't vdl ioctl be unnecessary?
Good point. That's one way to estimate VDL, but not the exact VDL.
FIEMAP is in block unit. The last written cluster does not necessarily
have all the bytes written to it. AFAIK, struct fiemap_extent does not
have the info on the actual bytes in use. Also, the info is already
available through st->st_blocks. Besides, FIEMAP is not that efficient
when the file is huge and heavily fragmented. The userspace would have
to do multiple ioctl calls to get to the unwritten extent.

The whole point of the new ioctl is because the VDL does not fit into
any standard userspace interface. i.e. the case where

    vdl < st->st_size <= st->st_blocks

> Okay, And if we allocate new ioctl number for this, we need to update
> Documentation/userspace-api/ioctl/ioctl-number.rst
Sure. Will report back in a few days.

Regards,
Davo
