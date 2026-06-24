Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534AD38A70B
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284307; cv=none; b=EkAjvZmt8QsLmH/Pa5ucfnRypiMn4lYvy5V6iv6EAKcjSOgCyAyxZUIb36VDX/FqVP41fdICrTy5XEGuwpif/QDQOIrdIaW6WTFOK+gDoFeqctn57JUcCqx5RO7pCaaUf0dYVRlA5Kgcyh8Lnghvpo4K2cHqAKby0roI//yiFbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284307; c=relaxed/simple;
	bh=c3/hAAsUkpGUpzNzk6RCbkGXgVL4bAM4gpI7T7r7OVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ud0PKupihfHUe8NOM8ccOQMYNNBDqQkAyJVQFORYiMNLP3xUGuPWqnVs0UVcSCARTKMRnPoEAAI6eWlqROH3+PNyBSDibKWFgOVYGTIjBEMpacZEvhQpXvJZHrYoMEJMIWOkapYbJUgpQdpAZdjsHyuCaxjeW17rdHnUzLbwwcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpAtg9eA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpAtg9eA"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b9d265355so417608a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782284305; x=1782889105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0Um4hH99oeJ48BWDhTuqgCjMj39PG5+rvU6cG4OaeI=;
        b=VpAtg9eAKhgR9DfcZVtsUKpUAUVCQiTDVVOWrx8mGfG1D7VUUBQvdKdcV6QFK7P6/h
         1KtNMqfV1dW2XCb9TzV8nzFwIn9rT99yWOU+zHfVxMevV4de+86fRXP6NiS7eZeZH252
         PBrH0puLE79E/Hpv+dlVm68YpQ3lRTPwHrNgBZeczInEEZdaFqNrBkPe46VsNzR0gls3
         60cNZXZ6c4heRFJ3pUf1LWWYwPzt4IR+11LEm6weq0rds5nv6hAQiAyoSgkiWWMsvU/f
         vahG5dPJc/1onvNsnxA+TGVU1BKP8mzZPWeqz011ZvPfF617ECxyYFMgaqorzd7JNXti
         6BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782284305; x=1782889105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0Um4hH99oeJ48BWDhTuqgCjMj39PG5+rvU6cG4OaeI=;
        b=ifrUa3C1GA1jCkyKl7gD2851LxuBsac3BxBy8qmRgSoKc6Gc/513IdSE+G/hp3RQDN
         aShDLfEaKgKtz5DyeAQ99TbOvn3npp/oOCnZc8md1/wPYW2NegmWLpF68rTBYIiPrKCY
         g9LRkqY/5ENRMujGiisowu/pffVT/kUh1z0nLkPtndaV9JoPvCs+2sCGNn0E2yG+s2xN
         yD7+nMjUE7Bta/pIs96q4qtSYGVnBgPggsgOWwxThHa7b16Zoaokn7b94fVAp3XtPJQS
         ySwTT9phbDA6Q9WQlMvmhQprozAO4lantFQPuUIR+XLT/5arQlL7y8D9O7QgGWnXRqH8
         oNkg==
X-Forwarded-Encrypted: i=1; AHgh+RoRPy9sLZPEDj6+X6KGe41i/0sMWO1L89hSvzPLO7FKgPbEIEYf2/VQtKI9uvVEXyxVmEVE336u8q1Ve5GI@vger.kernel.org
X-Gm-Message-State: AOJu0YyvwjMhrgd54TRLAexJF1/1rywGM7pq4t/ScjfYLUq+yPEBYVPe
	1Y0UeXSL5wk6oxj/02MAn3e+imiNMwLBurIVBU+rt/8J+DtxFKVEMx2n9Qw0kg==
X-Gm-Gg: AfdE7cnXuHVtmGsnIfqk/FBTdnLXacEzruIX2dOGc/V5x7bsgXud+VpozRrf/pjWj1d
	QvCPkeRLrUsN/+ackCX8+k8tBSXDhRz8ph06CZGTSpGIIfkiIaWPv+e7f2yB4YIdkhBhFL9YbFm
	61PDkK+093hcgCbRQ/ObkViSlinAQ+deOOgZOP6jnSWUVGgCoPmMby/wYqm/x88r9H4aWRBK7+/
	vuIQxbkbZY2cfoG47bKhmWo4YyX8aTFMACJYZha0Dxf5USM2DducfhmaIuhQHv3+iWy8piNeZq8
	30tLyJp70Gda6Ama1cIK2PER56DwM2VESDuP0sQ+6IWrsUmgvuPM4JUrcTqA0B3GUchxKFgb+lW
	ZNmlMesa0JsyAwSqSUbqcOv0B390nKfEoDB9gflqSVpmVZOwb9HGbpHYMCW7TvzOltru/FU2ZZE
	YTW7WcfPQj3ZiVSWVDK8iNVVrIoHq9H6OCa0MjNMMQYvJRBlpF0E4hx3ve7IQ9sg==
X-Received: by 2002:a17:90b:4ac1:b0:369:7421:b36f with SMTP id 98e67ed59e1d1-37de462d411mr2084324a91.21.1782284305284;
        Tue, 23 Jun 2026 23:58:25 -0700 (PDT)
Received: from localhost.localdomain ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3a8441dsm1488142a91.4.2026.06.23.23.58.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jun 2026 23:58:24 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: willy@infradead.org
Cc: josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] filemap: Remove file pinning during fault handling
Date: Wed, 24 Jun 2026 14:58:18 +0800
Message-Id: <20260624065818.49975-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260622192114.1147198-1-willy@infradead.org>
References: <20260622192114.1147198-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Now that faults are protected by a per-VMA lock instead of a process-wide
> mmap lock, it is far less important to avoid holding the fault lock while

We could have fallen back to the mmap_lock from the very beginning in
do_page_fault(). And for GUP fault-in, we have always used the
mmap_lock so far.

> performing file reads.  The per-VMA lock does not prevent operations
> on other VMAs, nor does it prevent iterating through /proc (see commits
> 6b4c9f446981 and a75d4c333772 for the original motivations behind dropping
> the fault lock).
> 
> We will now submit I/O and wait for I/O to complete while holding the
> fault lock.  This removes the need to return VM_FAULT_RETRY which means
> we won't fall back to the mmap_lock from the VMA lock just because we
> had to wait for I/O.
> 
> This should result in improved lock contention, although it is possible
> that some workloads will find themselves contending on the VMA locks
> due to them being held for longer.

Hongru reported that 82 of the top 200 Android applications in the
China market call fork() in heavily multi-threaded processes[1]. It
would be good to take existing applications into account, please.

[1] https://lore.kernel.org/linux-mm/20260623075805.466317-1-zhanghongru@xiaomi.com/

[...]
> -static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
> -				     struct file **fpin)
> -{
> -	if (folio_trylock(folio))
> -		return 1;
> -
> -	/*
> -	 * NOTE! This will make us return with VM_FAULT_RETRY, but with
> -	 * the fault lock still held. That's how FAULT_FLAG_RETRY_NOWAIT
> -	 * is supposed to work. We have way too many special cases..
> -	 */
> -	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> -		return 0;
> -

Does this break FOLL_NOWAIT users? They are KVM on x86 and s390.

Best Regards
Barry
