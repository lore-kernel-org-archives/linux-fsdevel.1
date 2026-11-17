Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794891038;
	b=A3tXgQiF87W3GP8r/k24fHQbyJlxNPSzLcxv6pC4/itdoasmsvHzE3NUGdOXG/Dy8yL0
	 ak3LuLATaitTPrJFCNK1NW17h5FmoltdycVo9E7K3AU1OMVesl5hpxns7yVXW5J0siVDQ
	 A1Z7e0YWaGuGlVjFg/5fuKngtJgrdegJdxGNcs6aWI+9hwTzfOF0ncBesu8yA0T8D7qpv
	 iVKne8MpwuBiVsqfXhpXfOuwR9eq3nGeRDO7LtDBCirzo95eTrOzR84r52u2aW0spkTVE
	 7us7bYmGspPzrV9oKIoha6IDknDbY2emQbwmGnmVCKFO/vYYXbXZ+9OT1EWpJSdcHIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794891038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=9bqqmMB4+kyoRGHHPejEHuADL6UxgHY0xArC5J1XYUg=;
	b=Kiy14Vd5n5ZipWm462Vaf7O1tUdYQy1urrMAXVcHdCf8uFmhXmTewmuuy7OS2FFzQuFb
	 J2SmTb7oq5NktQjC5tNxYM0SUePfv9mDTdZo22OSOHQAvjF1WcAc7UYtnjvEvazBuhE/2
	 jXWJpo+SzsqhtRLdRuHpBLlHSu8MlKwZPWcXDrcc7obAJ2bpuEYdRABtQDlWPHbFNAapV
	 ZsUgrNy+0uPeqT2Q67aeHpdl/Eg/GtRHMyXIoojEOgdH8Qklkg6jlI0mzbt44nY57jBpE
	 67KEJUdKNLu3jkOo6J2JsV/JKXfKjSKlqieh+epj1XQuKhed9ex3Ys95u2Ff/Cp5WOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=JVoEkBuR;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D362606A331
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 04:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D362606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=JVoEkBuR
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-14394530ec6so5373839c88.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794891037; x=1795495837; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9bqqmMB4+kyoRGHHPejEHuADL6UxgHY0xArC5J1XYUg=;
        b=JVoEkBuRB7FQiKYHvBCxvAxh9Oaxf01xN5UIrTjfVi6OU10CeKbp241d27RcBRcSsk
         /Xi/x0gE95b4H/4imd4d7XC7TvMqKuqGtZq30FdKfitiezpDW1A26JSOriDXlFFBwZBZ
         HwMfdVtpba397eVPFTvqZp/IbohPL8IT2620Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794891037; x=1795495837;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9bqqmMB4+kyoRGHHPejEHuADL6UxgHY0xArC5J1XYUg=;
        b=af6rHmeFRwYv2pSFIZhZlSX9wvbU2iptcq7GflUMUIiFDJPWMGTYDxCWxlthJ28IbP
         g6jhcAnBfQEuG8CNEeKZO9EVM7thWgsfv2pYEGV/JqMdtd6rHzRNvDdspxmsavpRtWtJ
         p/60/iGDWpDYTM1henMUobiYmmN2u4vRqN0Wi/JpQum6D8Ovmp9gizfZOv+MnZn4u98n
         xWkXIG+8sdH7qjDaIiWvAcE8O9ZXdVfOm3IZd3RQZySo+6rHvOs18uOFO78Qj8I6tHPR
         LEhViDSdgYhJQXLDy9dR4C7/Uwn0q9wC8Nl/M/JjS5smKMCZxr72IHM2uhCZ+b10rtHq
         rF4A==
X-Forwarded-Encrypted: i=1; AL+hErGLwIHbOd7Dhr3uf0wfD6GJVGaro+mQ0g/hPlo4dF3DCYQZ+JDU6tHjUvzhearpwMjxuy5VaPftiyYD6A3e@vger.kernel.org
X-Gm-Message-State: APuU4Z9Hc4raawYw4G9GrrOJq7zpyJZQOgBTIBiHuqChPmdF7bCP0OEN
	+aAWkt0ovN+VzKy0lVPfnjSJKnOaHyKTMwkL/PvJr0p/cN6gx/ZJRp6q3NEL31mqL8U=
X-Gm-Gg: AYBFou3Ry6qB79e00crLstPDx9CNGthYLKhAJ41de49QZwbrN/TvjFaFfV6B0sxipjM
	j4J303FjaMUz3H5VHO6j2lL3R2Xngx3i/9PikFQOfjhHbEgjINJoRiRlhxuDea+O5L8DeNQxLw2
	djEuq177rF8000JY+r6BRgo/Tlnju58QkBi+J3euIYw27ALnYsVS9n1iICcVjTFDbBLfyD91O12
	Ow/KAjHcOq0RTsk6odZu5D4DiqbAd86DViGAF+hHc2Q4ZYr+ORmA0g5ohS636RaDyH4niC2qj66
	oyW1AomMHxWmcowyo9jRUDPFPzrAF9SYBZQn3aGDvxBeUZ34S4qW9gZJY9blBUwVKnRnKP+HxD8
	vHHmOVh8yu4gEYiGmMeJi4bT7zrQi2x2cyIhwl8XJ9+BT8q/uMl7PFhUrnLZ4i1/zmHU6NW77XQ
	06jel4rkza6cCEAL1E11D7d2bQcL5b4TmpMEKqB9p/8kWuF57+5/PybwIZm1dwhOoO7d8qQnigr
	oKOIeurqPHb9/fN9XxD9p9SVnrJ0MrwnB+X+stD2/dFML05hsHz6z91XVnP1Ajc+g5p4XKVgCam
	HaMnUQ9PPnhfUbmK7WBrDJ9kH4zCujQjfCOSx+As8JUw5OLKIRo0iPdVSRhnKYHDOcM95EhRrSs
	baEhpjTnrPd9OlUVHRj+atuhNRBCRFySdR+tvrH1WHYrWvw/wtUA+jmdCaWZO+1uVet9ARCYjdn
	oAVqlTnPPdJSMYlEy9d+XF8rY/aJ3cd+zE1yogtTr5mWItBROUpl5mCA0xb5GgETXL
X-Received: by 2002:a05:7022:96:b0:1a8:4997:65f6 with SMTP id a92af1059eb24-1b503105175mr11734678c88.20.1794891037361;
        Mon, 16 Nov 2026 20:50:37 -0800 (PST)
Received: from [172.20.0.3] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm53517692c88.9.2026.11.16.20.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 20:50:36 -0800 (PST)
Date: Mon, 16 Nov 2026 20:50:33 -0800
From: Chris Down <chris@chrisdown.name>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: linmiaohe@huawei.com, muchun.song@linux.dev, nao.horiguchi@gmail.com,
	william.roche@oracle.com, ljs@kernel.org, vbabka@kernel.org,
	tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org,
	akpm@linux-foundation.org, osalvador@suse.de, rientjes@google.com,
	duenwen@google.com, jthoughton@google.com, jgg@nvidia.com, ankita@nvidia.com,
	peterx@redhat.com, sidhartha.kumar@oracle.com, ziy@nvidia.com,
	skhan@linuxfoundation.org, corbet@lwn.net, david@kernel.org,
	dave.hansen@linux.intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/3] selftests/mm: test userspace MFR for HugeTLB
	hugepage
In-Reply-To: <20261115160105.2507650-3-jiaqiyan@google.com>
References: <20261115160105.2507650-1-jiaqiyan@google.com>
	<20261115160105.2507650-3-jiaqiyan@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <avvdGec7NCt5oAFr@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Jiaqi,

Jiaqi Yan writes:
>+	map = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, 0);

This isn't right -- a private mapping reserves hugepages of its own, but the
4 hugepages that setup_hugetlb_pages() asked for are all in the page cache
by now, so the seal mode fails with ENOMEM when the test sets up the pool by
itself. I think we either need MAP_NORESERVE here, or to ask for twice
NR_HUGEPAGES in seal mode.

>+CATEGORY="memory-failure" run_test ./hugetlb-mfr

Probably worth adding a 2M line or two as well, since this only runs the 1G
case, which is skipped when 4 free 1G hugepages can't be allocated.

Thanks!

Chris
