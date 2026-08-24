Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D53806C6
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594302; cv=none; b=UZAXxfxGTyX1k1tP8V7gdEO1p227/P/cxSXlwLz6OcQKHkz2LOYL2X/jvVc8Ms8DUl9+KynN+RaE/6z3zKZu0U+tasBZ/Mv4dUE5oDB/T0u43NVBV67cHjHr0Qi3+Uirbjq7Jx2Ay4pyw27ZCrMIsEdDDS9PnvGNdPHk+s8r5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594302; c=relaxed/simple;
	bh=jcX1BOXw1evMbb68xwYAb+KhNzXpTeM+avGPItf84U0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NsHAzoKiCMLjxiyaa6gA8/fIqrepKMv+rUxrE/Rk1rtfD8ylyZUnlDFmqgxWmzXM6hrw8oEHcthdnlurxarL3PVXbYu+8FZj/if+aA3SIFayUiSzlBDr2cz4y2GJefTqlWe7zQjYcUynmorvNVUcLxKc1IyZIZ7fkLq5i7h2044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--psalian.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VeC8rjY0; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--psalian.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VeC8rjY0"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cacd6d37edso50072815ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787594298; x=1788199098; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jcX1BOXw1evMbb68xwYAb+KhNzXpTeM+avGPItf84U0=;
        b=VeC8rjY05fEyqLffND8yzHrU6r5LKuRXLTmxy5ifNKNqXo0o8Z0ditwmwX5ZwTiQGx
         q0F+5CiE5Ht9cfhD/GxIjAk6jtXtbklzuqH0StYs98CQtsJSS4wIAHq3FaCLaX2p7zyu
         bElGaEbj48DrCJNfyYyt2/d2vwxf6zfvN24oY3Req6be1Pbd9yAHZYshM8AxxvKrJyg1
         IzYduSZcDeTuhmGKSQ6SgGGj2mQn5vPpLTUtS4KpljxlTA2iWZDGRgwKH8Ex9kXOlHvb
         mxdhwTDH8gUSE6mbzl5n/k43FvpcJ9coMXid8XmjZZhSvgNU4M+st3J9Vfex5IRdDSML
         AlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787594298; x=1788199098;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcX1BOXw1evMbb68xwYAb+KhNzXpTeM+avGPItf84U0=;
        b=EdLB8C3jHmv+0L+XKtMGpUmElWX7vNHj7dFrIPBcGx6dJdzyBzFMmHr15J5eAYj4dT
         MCEhZKGBJb3b6ka7BVzz+8+NVnVRw8ftcwZ5pn7AADgOggVhQ+H8vhN8WVtv5OqiY/eq
         r4XEJPWIk2EKzqB4w2kmzBOv1MBIEnfXdhVw4aCSkdsbMnkojAj9kiiElDYdXf+bLfc5
         8/6Rdpt05ZrTt6m0nuKIx5ZdUEZc8rK0AMnS290dQC+hqd/Zh9ChvDcluf4DeMDSXJZU
         345X4Pzneb1IfNmRoNtz1KGz+VMGCAngdZhmSNRRJX0JG/ledgL6y615h8ZswVuPVXG1
         xazg==
X-Forwarded-Encrypted: i=1; AHgh+RqZiKjZqAyzRgS0+xgiO2dYhcb9CUKKONv098Xa7fuSRRFZRhkAN3Wwt4JefOi46FOouSI07L9S3XNYVMbi@vger.kernel.org
X-Gm-Message-State: AFuF++kHD4SYy1GNT536Mf2McddW3m61CYMmI0Uqga/FebgExCEWfH+k
	GLKKG93eAMZwJ6vGoLQwAYJDnfdENJ+/HEmfOHk/BrA2eflrHDPVMltW7NJoe2/p9knpEVbRx6Z
	JY+z5Oumf5w==
X-Received: from plbiw24.prod.google.com ([2002:a17:903:458:b0:2ca:97d5:9cac])
 (user=psalian job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c07:b0:2d5:c099:16e2
 with SMTP id d9443c01a7336-2d670d5d4bfmr364320495ad.13.1787594298184; Mon, 24
 Aug 2026 10:58:18 -0700 (PDT)
Date: Mon, 24 Aug 2026 17:58:17 +0000
In-Reply-To: <51a316c1-4654-4f6f-92ff-84c310cd604d@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <51a316c1-4654-4f6f-92ff-84c310cd604d@amd.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260824175817.483800-1-psalian@google.com>
Subject: Re: [PATCH] fuse: mark DAX VMA page protections as decrypted
From: Punit Salian <psalian@google.com>
To: pankaj.gupta@amd.com
Cc: michael.roth@amd.com, thomas.lendacky@amd.com, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stefanha@redhat.com, vgoyal@redhat.com, linux-coco@lists.linux.dev, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Pankaj,

Just following up to see if you had a chance to test this patch on your working SEV-SNP setup. If everything looks good on your end, could you please share your Tested-by tag so we can get this queued up with Miklos?

Thanks,
Punit
