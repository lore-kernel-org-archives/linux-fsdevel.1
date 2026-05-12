Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCCA357D01
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617941; cv=none; b=RR4c4LLZDMsSiz6m13uNVHIFDz/fwG+feNSEwztuSQ377K0/O9olbfbQtGl11x+/t6F9YHz+niPuTdXlypH9QEbxKJ+FVQH8s2VhiHe184+dTmZGUMy7ec0waT/cUiCVlA47q/+qi8x/ojIrtpYaQHPB7qgCsFq4OeeZ5/p5spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617941; c=relaxed/simple;
	bh=cbmkt9pZZr54kIHHjaESeO29ZT3m2Envrn5GyloGMiQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=HBrGC2YETZ4VIVTW6/pARBAqeL1U1xyV5+emFGzhbuIYF+3NNdZHDI7LHCZb7js01bRl8/k14ZdIoMAAIRX4x8en4vvLI0iS2NfSSddZnQV1o6Q3sArYrd0qRDS3lazB72v3A91WvFUtvvMRTNszzjHNOQl85G08Ycbvz4/LSv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oUG1ePpW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oUG1ePpW"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36865d109dcso2800986a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778617938; x=1779222738; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZFtakTJB5Vs+VUIE17YL6aA+lS3I+iyXqjPjtCVuM/s=;
        b=oUG1ePpWZyIoxkUSjIElarYfWQTx/zHjVt7wv2XsuBaMTQo5lWAlU6oPh7+Xg7yNiS
         eDSoNLcp2FxZZCzN5I/LewRGVYY1jz4LzysMFM4ZDQsijA8VkLFVQX/Sl7TmT3XfXZYU
         lqzkSDPmy9ZeU/fI4OKAlz70CLkOQs4pIyNu+RdYxuiK6MaJuE6nbQhQPkVmMs8wdD/7
         4mz30zXN6Rq8Fv7HZ6YidmMnaAlGqveiqa5bTtoY4BwLLzcmKA2gd4sY45DncAC8Bw07
         GSthe8dpkkrB/P8gu+L/lG7cNiM5CSnLWACq8No84jPkYixeyu7vIHFo9RfC/qjcEDff
         ytTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617938; x=1779222738;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFtakTJB5Vs+VUIE17YL6aA+lS3I+iyXqjPjtCVuM/s=;
        b=Xm2xfE1K9FiwV39jVCDjMChmwSsRPwiGSE5QPlzWoSWihSvm4qdYuUVWtHJPC2Nq1m
         mvzqHeYc2byPtT13Lq3TBVJfvVePNM7Bj1Z+5WSg9PxXBdO/+1h+G0LfSewTTbsBNEcS
         PZBqN9LROTgakd0AdUsb2IwJ9xs6d5NGspQSn7twxS/iYCvNVYtqRnZFYwb67UeDpCVZ
         OsXAVOzaBC19vEPH8CpqYiHf3RdIsrskw4NbPxPXJ69iXTBP83JRHKoTQ7LcxXuTSuf+
         Uee/bRjrscgd5nshjxVJIEjVWAnkMHMrt9ijb0ekONa6Yci/BAUqmPJoZjWFIxPaa+sc
         WjFw==
X-Forwarded-Encrypted: i=1; AFNElJ/hbt4pwtSYV/dNG3bTOZYHZILpyTHRhHZTJvqKydb/OPwrvwFhnWniuDp7Z/QQ/kzzKGRJn7fFBmyOiHAi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb2+MwM7y54Usa2DAmZq4Vrt/N8TVCC+a3Pjd5RWmIeqPCcAkI
	eA1XSxhKqh5WLeA9HCp2yShtGK5EDdETTt4M4KUtEp+N0TnJ6dH3O+i7klSujxouA4LLDL+n/R3
	D2/KHpA==
X-Received: from pjxx6.prod.google.com ([2002:a17:90b:58c6:b0:366:191:7105])
 (user=fmayle job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c02:b0:35d:a38a:a117
 with SMTP id 98e67ed59e1d1-368f3e6ffabmr627464a91.15.1778617938317; Tue, 12
 May 2026 13:32:18 -0700 (PDT)
Date: Tue, 12 May 2026 13:31:34 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512203154.754075-1-fmayle@google.com>
Subject: [PATCH 0/2] mm: document read_pages and simplify usage
From: Frederick Mayle <fmayle@google.com>
Cc: android-mm@google.com, kernel-team@android.com, 
	Frederick Mayle <fmayle@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a kerneldoc for read_pages() to formalize an invariant and then use
it to simplify the callers in page_cache_ra_unbounded().

Frederick Mayle (2):
  mm/readahead: add kerneldoc for read_pages
  mm/readahead: simplify page_cache_ra_unbounded loop counter reset

 mm/readahead.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)


base-commit: 972c53e0ec3abfc6f5fe2cb503640710fb23cf95
-- 
2.54.0.563.g4f69b47b94-goog

