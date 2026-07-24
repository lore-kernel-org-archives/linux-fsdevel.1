Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9502230569B
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906199; cv=none; b=fr7i820SMzqSDDPxGuSuv2e2VaZFv2qRcilwHrhbH90IAD+N87u14D+ETKOAu4fNcv5I7PgSdbfoD801tDiuLb8aYZf2exR+ca+ZXo+PcVzujjVYgN29muw+a2ENXfeNvSPFmWvQEyxStTLuvZjZZ4UckLL1iSGSrDkE6PdD7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906199; c=relaxed/simple;
	bh=2bpP1ibW5dJmvFrzzhBS0AQ365XuAs8E3axf34t/Dlw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CQgIq96HwRhFRSwD4VUpgyt894XYF4FTRKFmLtr7f0teVw1V0/D4wXZdv9//mx8bwdbB5O+zmDTa50j/EUw9AQIaYZhzump3dgDYqHIH6hCk9hKXHEfBbn+s0NG+/0ecO7ZOOUyjQRBuqGyPrZHohNR41IZF+Hj/tT55EPtFg9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nR3fsmQ7; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nR3fsmQ7"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so556597a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784906198; x=1785510998; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZ8f+6ih5KROSa3iYv5xsmVxcdcq3+d3PqbnwpAR2WQ=;
        b=nR3fsmQ7N2HcC205WKRTn3ANgIHKpjC7ExmRF3aacxKdqH00XYTJVblHa11RWR6FCB
         8ZdSRmZUyle9IlTE7QDAqKUFVqub766g2WuTtS3F81zqo5KUF/KNzQu/lpyd8lwNPKpY
         UOw4lvEvqLqA8HGqaZQOH4b7E3dzBx/4Z+4xXa4jFx9EFU7gRkmF6brWb81sPqOpHFmQ
         pdA5CCXfBPTcLUkjxdKccwhT9b0juwMB6Tz2jd945ZGK2yl9g8e0FSFVViZtLEqqH26F
         yEWUXIgXZA9E9+FzUVlnKzURYrp3itrn2VpL1PepEn8Tbb2MqXeIBK8NLW5pR8kaYfPj
         jIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906198; x=1785510998;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DZ8f+6ih5KROSa3iYv5xsmVxcdcq3+d3PqbnwpAR2WQ=;
        b=j0ygFedskU9hLrzT8FfQ++lsY1az1LwNB+1msSr4D8y+Y/PZW6MBAnain7DV4EUyqD
         x69PpLfIBw4obKTTvRYOA4KSWr3rQ+FGuaGrr5c6KIuX57oIhV4Z746qNNQvR4h11OZz
         LOPFRFK/r+Ls415+M04trpbBCov1YLNU89ipfyXmzhpb5tkSIuNANhIzoH7yL9iOqPqH
         V8iCq8poy49FtsB2N60MgB6ulKc5T1Bi7jhuSJxihk4nZYT+LKZ87Cuzqu5KAJ1+Q8dh
         GWxIOyMT4l8S7EAjjiFJtUycjU2qU3RmRKNFaQJ3hzdN0BgyxdsSlmBkdceLawPN6fE5
         txow==
X-Forwarded-Encrypted: i=1; AHgh+RqGjGL8xPcC32Lj25iWjG6ZtfCw8qsQ0fVLM15pV860QrP8LVjJicysOt/Q3EiF03ISIEr1A6YsONMoKX14@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXqImCC6B9bvLp6SXPmqI7Vza+DiCVK4FAprvkSOxVDSqKbnO
	o8jSmECg43bQh73NonHoYx/rXBAYzDp8wiRi0xqD0XjhDwNwKypp9qjYUaTWrcbL0utCMBJMBga
	MhBEe9Q==
X-Received: from pgbdp1.prod.google.com ([2002:a05:6a02:f01:b0:c92:11a5:bbce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1d98:b0:3c3:a490:9674
 with SMTP id adf61e73a8af0-3c44b250f8dmr8630341637.64.1784906197213; Fri, 24
 Jul 2026 08:16:37 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:16:36 -0700
In-Reply-To: <20260723143034.175661-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723143034.175661-1-willy@infradead.org> <20260723143034.175661-6-willy@infradead.org>
Message-ID: <amOB1ATJGo71QMkE@google.com>
Subject: Re: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page()
From: Sean Christopherson <seanjc@google.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 23, 2026, Matthew Wilcox (Oracle) wrote:
> folio_test_hwpoison() only works on hugetlb folios today and will give
> the wrong answer for other large folios.  folio_has_hwpoisoned_page()
> works on both.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
