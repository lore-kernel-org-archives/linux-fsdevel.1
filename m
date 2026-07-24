Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A5413783
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927439; cv=none; b=kicn8yIn+olZSpQAw0Md+j5b2TpBiZvL+wbTVPZjxjH5+FuMZLh8RotUoyrUxn7RTysW2hEngbfzNwYg0NR5sscPXmqdq9zICzjM1wc4iuKTSZOSeTDM7+lsnfcRdrBrdgnvE1s//pbJnIMmzSyooiQpgsnx6YukuspbBspxFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927439; c=relaxed/simple;
	bh=uJykGS3QzQ4tvxZjLWHg5877iVJ4SfE3tavrwKMgWvY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=teomar2jrlO/OKQjRqJv+2hz5jUVrPO2SWEkgBJ86hDCia+IUWK7CpGi1d54Q/1T/GDi8+38YznIu+TEnHa3i3JdK7M0Sz2oKSdQagLeF7JQoah8Ha8DFLy1ytZKUOOCHHtgV78mVzZ+LNvBqwoRodBeWwqMx1gURU7LSDZkuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XY9F4k4v; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XY9F4k4v"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5cb052edso69322385a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784927437; x=1785532237; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yHq87L9vS3HaE9jFDV8bI4q/vxtGKRIuk5rLrUpJx2M=;
        b=XY9F4k4v1mK16fiOg3tFiRVBKhDyczLVSXM5P8e7GhrLs2Ym3ZYtZIlQlUwVbFOex2
         w/rD4ksL4FdN45QllnvZlpzNw064gQcbIFs8RWCRI+p+W5ofwIde95TStccIOJktC7Bj
         LR1YO4Y8H7Gv8+zQA8mwp5joYwmGupwxOQqdJ8p5GvP1nOUTo1Zn2s75MNsCeUdxUUPo
         t/Y4+Iw1uuU5lJ/lAKV9brLaNi9TFo9v9x6ryXzciiCvscD5uCMeGU93MpDz1vYhqaF4
         KyNhLJIb74wRu+vCXyT8ro6BICX7RVMT32l32nSYtPWdxwQB8IfFYX0ufF62mYWhiAlC
         iYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927437; x=1785532237;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHq87L9vS3HaE9jFDV8bI4q/vxtGKRIuk5rLrUpJx2M=;
        b=aqPb8fDDt6/VN3OWIYhImPF3EETlc2AyXmZLQ1MkFsdx+ASR8p7XShfczzl7QcBLyI
         bJsSacV0g5CdPxwXaWOqQtPqPh6LAq2wCHszm2QWbsxnh3TkvNao6bQ/ajv8KzCPvzEH
         vyA8O72a6lkWlgc80G9+InW3S5el65KICIo6ohijy5vfA4LP7ofOns1LrxGN5jm6trZ6
         +Q+OA/Xj5KeRD4J/5eX58j4eTbc/uCl0tlxBdHIsgi7/PuFmcj/VdawISJhRap0g/iGD
         xGyAFWTRre2QEfsF+vaRRB/KywjXMkuLkQOc6rLZSZl+F1flQ3J3WkaqsMtTpEX32UKD
         QitQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSBk4U/hXuSoX2pNVTjrV8U4MwwDl5m9WALZVmda+LpUGY4kJN6OYi3QTIuxXlddVlo0yq/fsZsXPPHATV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm119KQ4UbJOXgC5odEPjHV3RSMs/P2f07dbliZrGgTzyTT2Fv
	9XlMwvg/0Mi577V+TTqBRmGR0TYEOCOkqUm+3IaSST6PZP5oe6n0FFdpSzDkb6wpAjjhaSyNTwH
	WaIDx9w==
X-Gm-Gg: AR+sD10tpsKdJWkkpXStPrSHjR4CdgTfY2+mBZYI+qSazd1BEXvnXjPHm2jpb/7Uizj
	qNnsSoe+vCSmvVsV9oSeJnwwakz46fFU1qJvt5CZp2MlzEWP7lRq7ze4dQDPh11nquu+XnEoiGe
	sqODTkDnYkM0q8IUAjsOfsIpAeyfiKH/ERBYmFH9WCFYyelebPajrq3ENktcRNw341RKn1az6zD
	V0xeex4vi+JTD7BIkKxdQf+k6sN7k4QYD7cMs+fZdqdoJ0y2hGU+aFV7JF0npsp5WMgOviJtmZz
	eyvD369GeJxL12Hn/e8S8YW5987SXF8weNMWGgEvCYdnyuBhVsm0NG2+yBKCjxk8JZk7qIsTXk0
	lOcEk2T/x3IeTUbnSQHahNO8a/90TzfCsnVXcmBhPAvtDmZVcDGVgwRN7lml6e52qrKs60odJVr
	uFLz0q1j40zRzO0S0z0s/bgz6hYtUybTfHqNzEIhS9kcZJmn3zlKs7DT+CWQ==
X-Received: by 2002:a05:620a:294e:b0:92e:c28c:9dff with SMTP id af79cd13be357-93103806f5fmr933223085a.6.1784927436759;
        Fri, 24 Jul 2026 14:10:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e86d499dsm6519536d6.42.2026.07.24.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:10:35 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:10:34 -0400
Message-ID: <0194430e27db3bcdffcf95b5dbf4891c@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260724_1628/pstg-lib:20260724_1535/pstg-pwork:20260724_1628
From: Paul Moore <paul@paul-moore.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Eric Paris <eparis@redhat.com>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Jori Koolstra <jkoolstra@xs4all.nl>
Subject: Re: [PATCH 1/3] vfs: move create error && negative dentry case in  lookup_open() up
References: <20260710164233.827744-2-jkoolstra@xs4all.nl>
In-Reply-To: <20260710164233.827744-2-jkoolstra@xs4all.nl>

On Jul 10, 2026 Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> 
> O_CREAT is stripped when create_error is set in lookup_open(), so when
> lookup does not return an inode, the case
> 
> 	if (!dentry->d_inode && (open_flag & O_CREAT))
> 
> is always skipped. We can get rid of this cognitive step by handling the
> error case first.
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
