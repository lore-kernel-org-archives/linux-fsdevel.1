Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024500;
	b=qpkxvvDQ8DcJcQNgB8hW+Y3iSMrANrt0zgLVS3nfKMkwyfEHiG9SOsSczoDrtiuDUZkA
	 eGjOwWWyO2uZb8G/Bpf+lvsRqK+kWCTxkEHbxoOq62zPFpeqvBR6nJDDgNqtov6A+RPcX
	 ok5ho/G5AuWCnsZ2sIIl2kbT+Fi2idLQOq4Im5Xt/YEZ+WOvQCFopTDBM3sDi+1dijRGG
	 rAzlxUJiIsscE3m/LzXXniT+KfklDY85xdgTLoItFWpUGc6cNzbHyStZk7+YsDu5YVacn
	 P9w5hOIrxrMKgnDJC/iqg53nOgMHQOxRskBRQqttOSWA55uDNJ+UJkwFyiYZdEztQ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024500;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YrojJ8RdT+pp1L7jagA79jqZnyIDXllAqHzZGpVUGl4=;
	b=23voLxZQYbbeXq1V5Gq+zfz9njvEoulzMrKkoYElzkZ7mMpE8QsY1EMyc/kfUI3Y3fV3
	 wtGxls4UjM6t9pVtgYw8FSIOsJ+yYsSUVGFe+tnDJQ/ivksm1hyQTt1IqS3fNfk+5qNlf
	 krpOM5WplfFjaK4mServjwf4smcwC+LOgaipNucmfXgZSgD+XtF8LMH1pC0/Kw4K+UqsW
	 Oj8gy3OXTEanSHsJNkwfR98sWU5Zq90paTDZ+6DtBsrnI6oH+m1FlXVqjon+2PYTXvF5i
	 d1Mvx+mfiA6DiQtlN/V384QuP7FqOw0pXlZH+2npfVAoQZ3HQIMcAmMqEKbm9WS2UBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Rr/nV/C5";
	arc=none smtp.remote-ip=95.215.58.204
Received: from mta1.migadu.com (out-204.mta1.migadu.com [95.215.58.204])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF3606A31B
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 14:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDAF3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Rr/nV/C5
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LU38JLPVoNiFrE9ir2aCoN20eLvHfG+XA+FLjWMCf10=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793024492; v=1; x=1793629292;
 b=Rr/nV/C58euHFChJjREzKK2GkRORfr2c6xAhMt3TLMROTR6l7RxwSM69VGF/bswbs2EJG3b0
 41y7XHX064jD38T8XXjJFGMZXf7MQTLWx7Ze+7K+lCeqP0ReRuPYgBShiWdO9TvPhcsByNjeN8R
 sUdbSsvIeD3cUiNSysrO1sNs=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 79436808f9b03e13;
	Mon, 26 Oct 2026 14:21:31 +0000
X-Mizu-Trace-ID: 79436808f9b03e13
X-Migadu-Flow: FLOW_OUT
Date: Mon, 26 Oct 2026 15:21:24 +0100
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iomap: only follow dio alignment requirement if specified
Message-ID: <at9hcoPC5NnKADX3@quentin>
References: <9fae60fcce5ae356deef5e38931124b9634dba3b.1792997261.git.wqu@suse.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fae60fcce5ae356deef5e38931124b9634dba3b.1792997261.git.wqu@suse.com>

Hi Qu,

On Mon, Oct 26, 2026 at 05:18:13PM +1030, Qu Wenruo wrote:
> [BUG]
> After commit 4025185cf953 ("iomap: follow the alignment requirement for
> iomap_dio_hole_iter()"), generic/091 fails on both xfs and ext4:
> 
>  FSTYP         -- ext4
>  PLATFORM      -- Linux/x86_64 btrfs-vm 7.3.0-custom+ #6 SMP PREEMPT_DYNAMIC Mon Oct 26 16:04:56 ACDT 2026
>  MKFS_OPTIONS  -- -F /dev/mapper/test-scratch1
>  MOUNT_OPTIONS -- -o acl,user_xattr /dev/mapper/test-scratch1 /mnt/scratch
> 
>  generic/091  6s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//generic/091.out.bad)
>      --- /home/adam/xfstests/tests/generic/091.out	2022-05-11 11:25:30.766666664 +0930
>      +++ /home/adam/xfstests/results//generic/091.out.bad	2026-10-26 16:43:49.387401669 +1030
>      @@ -1,7 +1,25 @@
>       QA output created by 091
>       fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>      -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>      -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>      -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>      -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>      -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -W
>      ...
>      (Run 'diff -u /home/adam/xfstests/tests/generic/091.out /home/adam/xfstests/results//generic/091.out.bad'  to see the entire diff)
>  Ran: generic/091
>  Failures: generic/091
>  Failed 1 of 1 tests
> 

I am trying to reproduce this error in fs-next with ext4/xfs but I am unable
to.

Do we need some specific disk setup or xfstests config to trigger this?

> [CAUSE]
> The failed command of fsx is COPY_RANGE:
> 
>  copy range: 0x6800 to 0xa200 at 0x3f200

-- 
Pankaj
