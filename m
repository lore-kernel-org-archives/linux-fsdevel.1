Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335653A6F0B
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412947; cv=none; b=DtrA0N+4ShRP7OlRlo26z/iINHQWuljnbBICrvoO9VGjSezd+bMbnsWz+0bzZ9B9atWNk+gWCeQs4Fk+2Yjyq/4lkV/c8jVoDCn18wQ6GTvIss+E8t62BICeFwF41lZmNCh0DK9n+1v7CV4KfNdsbfvN6HTgLkRwX00itfpnKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412947; c=relaxed/simple;
	bh=8114Na+BbK3Hw2QjXAtIsz6NBPw0bOuncf0+0DbDwwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+yaVVsblYhEmh/uj/CevH2dxerO7XTUzsU5HH7CPzCFBSYuEeHNggzDzxtAFsKddTRQXHieNojhIhSyh/W6eiH6+IJG/dn6YMj3DTNFPl9ZkCEl6dWCzFPUdr108UZndEgQ4lWMlbRXbvKBrKrBrnCYrpcKBps0OEBWmCPjxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=ZeXrEtqF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="ZeXrEtqF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae4e538abdso25434455ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773412945; x=1774017745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6Y/n2o5yEo+tuZB5cloL22Tzkf84YmlhIt4ugqI5/U=;
        b=ZeXrEtqF23XHjjA/FPOvWuD0XkqFkA+OUitPv6ljhH/01S1+8V0EatbZrG/lB9VlT8
         kDVYqreJzUX77yXF15I3tI6zt/bBdMDLDCenmzJ0i3idG9W3y/hchs1mFBpgumAxjgrB
         FlsqSjCmBYJjPEMtGFnNHfy1Z6F8q6/auTKvJyTnPMv8OOmJcx8FpX9x2yr7zjmt2K9M
         UOJl86WTawdmSklfi96fF2WybFVovGDDVYI+cmV6YIKHxy43S8QSkLkyKmURGBPi+2xx
         azJVhjciAcaMKak2NYxJv9QbxAdZk5Hcxix9s7ijZD4w0Wrtc2M1scXR7OKk2XYqpkZU
         pilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773412945; x=1774017745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6Y/n2o5yEo+tuZB5cloL22Tzkf84YmlhIt4ugqI5/U=;
        b=VtU+HtZPqX1tISYUdnJ5iy9l8QgZXXDabRUAbviksY9cJQUe+lOdEcLf/yeMCJU+cO
         ZKhQKT9Zwu7M9wj+pZG9QdLzKVsrOdQwuoFgX/WwBtf04dlFwsnEdTD4F73QPYpJAbpB
         SHLUmYpOmgO84DXIG4fo8WJl9vKddGq6DmP1dMs26iFmvdpRY+qjngWbayRJti96145h
         cW9E/UKu688s/eNjPL9mmgvBVstO9Uv7fKxUcykfPMgaWLooJ0MbdT7BoSioh869uITZ
         dwW5fDGNSyIpumEgFieujaIUxb6WJXxASOeBPqTF034GCqomGnQoancZfi64rBpBGLtj
         IhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZdIjjvAPB6OdyrGpFP/1gjnMJ4P6j/Pm+S3t3U+5pzSMIN3t4BOp95OZyHP+vALwqtHrvBYZwlepu2fKe@vger.kernel.org
X-Gm-Message-State: AOJu0YxtzE+hLkzrytQqd8if/uHoB3BMmYeckOPgRZzo9g+AVXvCQRRJ
	nF1JlJ7RmsWRi5qsEu4XYYPC6sC0EHlfNkXiCdJsqTnZVg+yaoSt6pSjoftECEC7JBM=
X-Gm-Gg: ATEYQzzqk8VGuOp99eET+lhN3Yz8dZcKL5+bT9NFd1cVuUOzlStN+4Vci4YTNYGuSUz
	9KRp2drxWPAnKXwQ6dhwtptYrrAhMpwsqwG9Ab3JVsRmdSN6Wm5gLKSAR5rSwiptBcH3RmH6x9z
	mmtB0stFi8Q8BQ/Ni5KBEJRequuNi/+mZZWms40EZRMD8E7yDrczWngyoj3FcW0WJXn7PuQvaX2
	qUJuUSMevO6rwVGv+0vDzLeuLWXGCJyflpOrSyOPzM6P4X4ilbw3/8S2rwkctdOnloifHZszUCk
	80vH/YAoEw7zep1fNzvlqPOtBAfOtepB5gG48YycYNAxm7e+TiLfBb+ojTWUHwi0guCUsjadM5F
	4kvl4vwU3qKgfeYib0wV3pm0O0JuqX6PNkQiZDA9qvRHVhi7VSuejeuhq7IiCcxd1b/7iWrdUYX
	4ia7lm3Q0Y1Vs=
X-Received: by 2002:a17:902:cf12:b0:2a0:c1ed:d0d9 with SMTP id d9443c01a7336-2aecab32ec3mr35478735ad.46.1773412945451;
        Fri, 13 Mar 2026 07:42:25 -0700 (PDT)
Received: from gpc ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ed9cdsm25651935ad.60.2026.03.13.07.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:42:24 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: usama.arif@linux.dev
Cc: Liam.Howlett@oracle.com,
	ajd@linux.ibm.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	david@kernel.org,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	jack@suse.cz,
	kas@kernel.org,
	kees@kernel.org,
	kernel-team@meta.com,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	npache@redhat.com,
	rmclure@linux.ibm.com,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	viro@zeniv.linux.org.uk,
	will@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	WANG Rui <r@hev.cc>
Subject: [PATCH 3/4] elf: align ET_DYN base to exec folio order for contpte mapping
Date: Fri, 13 Mar 2026 22:42:13 +0800
Message-ID: <20260313144213.95686-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310145406.3073394-4-usama.arif@linux.dev>
References: <20260310145406.3073394-4-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Usama,

Glad to see you're pushing on this, I'm also following it. I first noticed this when rustc's perf regressed after a binutils upgrade. I'm trying to make ld.so to aware THP and adjust PT_LOAD alignment to increase the chances of shared libraries being mapped by THP [1]. As you're probably seen, I'm doing something similar in the kernel to improve it for executables [2].

> +			if (exec_folio_order())
> +				alignment = max(alignment,
> +					(unsigned long)PAGE_SIZE << exec_folio_order());

I’m curious, does it make sense to add some constraints here, like only increasing p_align when the segment length, virtual address, and file offset are all huge-aligned, as I did in my patch? This has come up several times in the glibc review, where increasing alignment was noted to reduce ASLR entropy.

[1] https://sourceware.org/pipermail/libc-alpha/2026-March/175776.html
[2] https://lore.kernel.org/linux-fsdevel/20260313005211.882831-1-r@hev.cc

Thanks,
Rui
