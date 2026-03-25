Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EFC3B38BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433756; cv=none; b=q3Ih/rLz60Q8gOwQ2Yo3lRUD/oHpTPEczvaN+kfB4NM+rmGhXzCyruC63ISlQFVuGTnF8ZLweVpiGPdbRe9e1teSLUQ6uaItJhlOS2btePpUToLHXV2LZYtpTUIRCK7QGSs8e2VZrMtdRdhM3h1mMduYJGx+vha51j3HJ5YfMkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433756; c=relaxed/simple;
	bh=dTbxFPey7xSpEexAbeZMQA6ed4XE8QfZT3WtybmGSMY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mw5TBMrL842TMz7aOgom/X6Knm8Vd2gihlW2YmqTopVKWPVwg4r3zJgywSWWtnMv7AqGiNkdIvgSUpe5Fp6IuzA3/w0j8y/1kQ9WWtVXtpUxn9oW2V5biFN/KAcxtQIyy4fVgA8/aYTZWlkW7WegG1Kyet/ojeM7lKa5njZsRrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=KZfZlDPw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="KZfZlDPw"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824c9da9928so6779886b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1774433754; x=1775038554; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAbulfAiOEAPrh906GbXLOqJOMJAMSMFlPNota4Sbhc=;
        b=KZfZlDPw0qnVjy/dNdph6mtgtzPAy8k4qrpyhZC4GsDW6UNt6FUjA1O207xSlcZyNU
         2e0TSTM48MDmZ9s53fRvrHXIDnuQHs/mjdegBE1q1CbA6cxfH6KstCVKlLrjMDsdoieC
         XcXcraLctLcPyP9hVOLoXKztjng9dUS5cpa6jVqdRyKyfdWvyI0u41BgVluYvv7FE3kU
         Cafyqb+R/EcmP4eDjhC5FtoifCUexYsbHTwtZmQszYgYYefN2epoMQEDmYPdj9TfCHFr
         0eq5fvdOQM8GNF181Ep1Ttun0pP4O/GnYTJ+EPWf+Is5w6LMggZOnzDx0RvFHlnzj7Ae
         lRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774433754; x=1775038554;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAbulfAiOEAPrh906GbXLOqJOMJAMSMFlPNota4Sbhc=;
        b=WFMqmKjn11qZ6FqR6Jbeovhmj3rKpOc94+UDKC3GYz/in0bTLLSX741FlWa3ONNGRa
         s89oXjWKx/hMfmj8Laty/PaTqYboUyB5i8eFAc99sGWDPIpI/8kb87JM1dCQcr0d+WEk
         NpFk3wVGocrKCKz7VFQX65O7jLAZMqToUHNMmwGRG7c094Ptzu3sHfE2wpDI+wa+3UQV
         Ooh5hyXGgrCiDC8d7FhL3L6L76R+1/Jo8WbQCk0FW3BlP8Zi15aMCNBTCHe+pTBfQTO5
         M20D3a9WmVBdWuzVY72VnHSvCYKxBZd3FHaeFx1wD4wde3+crCt7ru98ihHYQBW/+O8E
         QoWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE/h1ZiMkbXfdAqZwtRxIkcFrryiGHspuYiSpNiQa5dLdU0Qmi38rjvL9Ey+KWt27fFLD0nMdrSiQCleLH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz92ZiMjRZTLqBY5kel/FZ07UogeKeNPmgPb8m9aTPTM51kAJZC
	yMKWImzFTPYbwymndp9+tf7YGk+IEGQmTIy1JDBrXM0mYRvtKSpUxPn7J+Xihm8k97w=
X-Gm-Gg: ATEYQzy2c6Oipq1qCUuDuw/ESw+oNWsouxFp2GIp7PzzvHdd95BLzaIGy+hRVKJAbxI
	a21FZu3Xnk/SaBan3FQwoSbauIGgpCez7rIxSTGJBfAj+ad686vsz8ePUrZP7ZkQXBnanHOucnA
	s5ZOrstZUeCSSGDSigfRUf5XdR+HuIs6deF/oxmpk1LUEIeaDNxmthvYkp4EDtTsJUjmsdv5BHs
	EbL4iD/wCfgofl01rxeQdM41D69J6EJOaLRcMFSHJI3Wn/Qz7MZmnl4j2uvM6ifLB3+sDertyHi
	o4xq+P+2U+LGX14/o5UE72o0uTeudEOjYbeHeCXvltjRdItXsSgsK3Dg5HwxiJOT+vx3itEDxcd
	JnKRbRj4hqRFwQd2VX9q96R0BNk1JgRnz5lhpckx4lZy3sT3S68ok2r3W9YN0mwO/AXdseQZPi7
	sIGeMTIbpww8YuqiQBLd36J03VfTCpff74cQ815tAc/ei6Yh2xzMn7jF9xozAuerkjm1johBWPo
	+AtEA==
X-Received: by 2002:a05:6a00:4398:b0:829:800b:9fe with SMTP id d2e1a72fcca58-82c6dfb397emr2776396b3a.39.1774433754335;
        Wed, 25 Mar 2026 03:15:54 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc1e59sm15996602b3a.13.2026.03.25.03.15.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2026 03:15:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [RFC 1/1] ext4: fail fast on repeated metadata reads after IO
 failure
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260325093349.630193-2-diangangli@gmail.com>
Date: Wed, 25 Mar 2026 04:15:42 -0600
Cc: tytso@mit.edu,
 linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 changfengnan@bytedance.com,
 Diangang Li <lidiangang@bytedance.com>
Content-Transfer-Encoding: 7bit
Message-Id: <B53E253C-F314-4376-BD9D-58867FC8D3F6@dilger.ca>
References: <20260325093349.630193-1-diangangli@gmail.com>
 <20260325093349.630193-2-diangangli@gmail.com>
To: Diangang Li <diangangli@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Mar 25, 2026, at 03:33, Diangang Li <diangangli@gmail.com> wrote:
> 
> From: Diangang Li <lidiangang@bytedance.com>
> 
> ext4 metadata reads serialize on BH_Lock (lock_buffer). If the read fails,
> the buffer remains !Uptodate. With concurrent callers, each waiter can
> retry the same failing read after the previous holder drops BH_Lock. This
> amplifies device retry latency and may trigger hung tasks.
> 
> In the normal read path the block driver already performs its own retries.
> Once the retries keep failing, re-submitting the same metadata read from
> the filesystem just amplifies the latency by serializing waiters on
> BH_Lock.
> 
> Remember read failures on buffer_head and fail fast for ext4 metadata reads
> once a buffer has already failed to read. Clear the flag on successful
> read/write completion so the buffer can recover. ext4 read-ahead uses
> ext4_read_bh_nowait(), so it does not set the failure flag and remains
> best-effort.

Not that the patch is bad, but if the BH_Read_EIO flag is set on a buffer
and it prevents other tasks from reading that block again, how would the
buffer ever become Uptodate to clear the flag?  There isn't enough state
in a 1-bit flag to have any kind of expiry and later retry.

Cheers, Andreas

