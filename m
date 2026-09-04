Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FF472088;
	Fri,  4 Sep 2026 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519247; cv=none; b=rYt3nqLjZ4h9igaNDthfc0NsZ8VwRBTuHS/WbrF9jiP5z7B8qgnFO4Nfg7+DCZ9NEw9YNgwwNyEbkFW9Oj9NuZ608mSikCiwehiU5RM5ZyPTQFr0Bz4epnR/wkAlV6XpcU9t4+IwA1RI1Rv6AHWuMi5GhZ3Vv1O3x6Xl8VRL2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519247; c=relaxed/simple;
	bh=AuQmDI80L6Qo8i15LU1LctjI9xB8T8iXJn6A+skiQWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pqIrJr0NAxnhMThWUCA17F114MqcBanLgMkjM5fKvpfngJuc8PcJfF/nS9udCruEbABJcR3R4eXkt1EiFzI32xKv6CCwKM5344SnW1hkvQ94Uj/t8B/7FMDYeX3ErawMGzam82BWtr3oSfSrMXhrngswbrbQueavAtIz7FnKFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=vRZFRV+x; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="vRZFRV+x"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id ABC3632C;
	Fri,  4 Sep 2026 10:55:02 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=vRZFRV+x;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8DB382206;
	Fri,  4 Sep 2026 10:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1788519244;
	bh=7qstcDk7tqVfdFyRK5jQ1nNUCM/E/gzwRPi1HUBSq4w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vRZFRV+xb3Xy6QhCeD/Ww+9cs2iw/Kel8Emx2xxqR4YMabpZuLtcGlIYOFBHYBbVV
	 3YuSqbJkoGiwc7hPRDdy75xKj6NqG3w27lXJZhLjkSvO2mDqA0quMtZ7iK5Wyql+bb
	 X2LqhoAE/jktMa8jQtbr3fTOaQLsiGv9aw67MXR4=
Received: from [192.168.95.128] (172.30.20.203) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 4 Sep 2026 13:54:03 +0300
Message-ID: <65b90e7c-d3b1-41f9-b4fd-6a1d51b88e4c@paragon-software.com>
Date: Fri, 4 Sep 2026 12:54:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: fix out-of-bounds write in
 ni_create_attr_list()
To: hewei-gikaku <skyexpoc@gmail.com>, Weiming Shi <bestswngs@gmail.com>
CC: Xiang Mei <xmei5@asu.edu>, <ntfs3@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260624053008.4885-2-xmei5@asu.edu>
 <20260626131122.1341-1-skyexpoc@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260626131122.1341-1-skyexpoc@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 6/26/26 15:11, hewei-gikaku wrote:

> Hi Weiming, Xiang,
>
> I posted a fix for this exact ni_create_attr_list() out-of-bounds write
> two weeks before this patch, to the same list and CC'ing the same
> maintainer:
>
>    v1 (2026-06-10): https://lore.kernel.org/all/20260610002929.51765-1-skyexpoc@gmail.com/
>    v2 (2026-06-25): https://lore.kernel.org/all/20260625031932.9412-1-skyexpoc@gmail.com/
>
> Same root cause, same Fixes: tag.  The two patches differ in how they fix
> it, and the difference matters:
>
>    - This patch keeps the fixed al_aligned(record_size) buffer and returns
>      -EINVAL as soon as an entry would cross the buffer end.  Because each
>      ATTR_LIST_ENTRY (le_size(0) = 0x20) is larger than the minimum resident
>      attribute it represents (SIZEOF_RESIDENT = 0x18), the list can grow past
>      a single record_size for a sufficiently full base record, so this can
>      fail a normal setxattr/file operation with -EINVAL instead of handling
>      it.
>
>    - My v2 computes the exact list size from the attributes first and
>      allocates accordingly, closing the overflow without introducing that
>      regression.
>
> Given the earlier posting and that v2 fixes the bug without rejecting
> otherwise-valid records, I'd suggest taking v2.  I'm happy to rebase it or
> adjust to whatever Konstantin prefers.
>
> Thanks,
> HE WEI

Hello,

Sorry for the delay.
I'll stick to the He Wei patch for this fix.

Regards,
Konstantin

