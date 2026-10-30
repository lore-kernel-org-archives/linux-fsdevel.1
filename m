Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333155;
	b=Nr5YIIhcVpkUJdHTJTy2ZADHNEmjJ57vm5DaoFFLR8c2ysv4A3I+egftquuQ+YsDFe4v
	 aKvn4uCKHTGXTtuuVVr9zVvfYJFSw4qDRLO3U0PfQAYALo5XFbctfnEC75+uK588dXa24
	 YwjcqTgDVMEH3jwmxdwo6XoVhCGs7g2L5yGdUYG56kcA4mv6UkU1BafxJciYuee2ejyPQ
	 jRd772tBfhJj0NAKlcObDYVcWYpwqSTEyJM/fnb/vZLQV1VWyTZeLjdAO0PPAIxgT1jkn
	 VqT7U5m9pmVAS9QArGaKAO8xmQFsR7YNNgmi0bqhLLaEVtoqOa/aoT+Ha7vTkN90ffw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
	b=zdFPoTNjAsV2cv0L0PTGIMetTtbMN3qyjb7L67/mdNlO0D/9aFbiLhm0S9OszxMxLVVu
	 rdfC/kgncoka6qHcxS+juj1ZjovF8wiVIInZ0L8eiuwjXYtoVpefMTB8+iwVXTHH5psf5
	 P1MIxW8k1zx9oEmDV8I2dyL60yB8cnKGqmuNg3vg9PwbGsZPUP3wRVSnt5IP8gbLSEYki
	 swuTzBGJdZOChbBwptPwO2dAx8arXNwJHVwm2fcfelwJwjZaktU7LRx5y3F0nrOLjUbTo
	 FgDEEhQpDb9ZQVT3LshEXb/E6Hn9w8iaJJTWV2WbZUVCJKSaCuyCEvPcl6hH/6/mdOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="cZUI88/L";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4A606A31F
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 04:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE4A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cZUI88/L
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so519838eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793333154; x=1793937954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=cZUI88/L9F1F6vaHkoJiPubaFvpBx9ZOZoFIH4WzYEl9uT8+1501kBXRQ+iQnW1rG/
         4Fw7u6pK2bhGr83aiABmILWeko3myUezgpD4yxFu1q8ofu7DAw3nd3xwaeMW+dOR7WjW
         fF2I6XSi4uBYslctXHDwkVQCwzAYXH2+VEB4ld4ijUFXCUVYiKPoDWGSOArpmY2b6MgQ
         9ZvnqUJjjMcJdZxPtAbFTkDp6O48lwLVb7JSCvyQcehPpzJbJ6jeHUnZCR3iOiOfxhs1
         cwBXgsfbLoMorO9ZFOLAr33BI+k9rnycgZilL+r2ECnd+fRbSczk3whlomOJkp24wZFS
         GQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333154; x=1793937954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=hNqAV0C5xm/VLAfwwRAxDWPf8Gp+PKHJhyDuduU++QtRNbofwKjnIqBPCxzGUW47DF
         qqeGE5XTfWHZTwucBqgdr3QsS+fl/IGhcTMUV/PHV7z/i0QPW5V4yjHkBw96JoRSklsr
         l+CwFigjfFogdTaZAcifGjaWshydRj8igaiss6tsQug3XAbAIegUWoIownUQS1VBInQ5
         BOdkIPxnnVsNzdE0IglQeNyU9Lgu6LqLGP4VYYI9DFhbdNduuC45nWjgMaJt82hcIDyN
         Kj1weE1WFrPTwoQd8/ly7mkCq+OYhRhxrk12SMlhZabZfO9ANmCZOAfvJE/cLWDZwi6C
         /ElA==
X-Forwarded-Encrypted: i=1; AKwUvByRxY4OhfJc1ydzUf0meWx/NwaLtFRDRagqTAST1d/WHlxhBWfnmCbElFj6wTC5FLJR/b2U5V5jjzHV80gX@vger.kernel.org
X-Gm-Message-State: AFq9FYL9ft4tpPsbkiDlzwG4V9J8id3+lbBqX7i5WcBrk+k4yGIonB3j
	6OwEC8sjgK9Q9Mw4Wdl3XqTohEgmIBsybNwXbvDbvDhugOilN8ce+oSD0lZ/WrZv2qU=
X-Gm-Gg: AYBFou2OlpAj1Dx1qA0B1RR9TqKwzFZ9SZ9NyEZ7GJBdgPcOgpIrH+1Lrchf6vSaNmJ
	V2fdDYD8jjayYSL47QrWf4vwRn4n3DNnItBaxuJRYWDjhOzaWk01Y4iHFh1TG3DY0FAYL8l+yLg
	t4XDbQXoIw7ZyH50seqgq9e+DcMlHb2jcEgutwgBOn1yOJ/JZHObxUyFgQuwQON+F+l+9O5o5Ji
	3iemV7Vu7q6JKZ3r4qh+j+j/aix73Iu7PxmiAhAR3klEJEQXIuTh2vFRM+wNT6sXQnEPifHeS1d
	6PdWypxjU8vOOwYEvIwpVua+jIFo/OcdMK5A9WuWc81H6vRPYLDYE7MjN2RCJdlCUA847Pq+yoB
	8hyCR/OPNLuDDUdKkle+9XgA8IEieD3yOt3AROOXpAMrCxkKBuv2xb46jgqkfVcFzqcTrivgQ1/
	5mzXOVY6t9XGFDKC27SyRGSc+PpQtGSnAYxc4dqx5NOxhpjvP+nM9YdKox16WLghA7Q4wwAbVaX
	ZNZCfg8vOD+O4M7JPgN2NKZlJMOUDiPBwaUL1TScRLb8mOQfWCiZbxhd3X/LzWE90bUSNUDj7DZ
	+vFZTH9iRl6gAauiGTJNnf2GxTcgGWk=
X-Received: by 2002:a05:7301:53cb:b0:35c:e696:2d4a with SMTP id 5a478bee46e88-36a423ea99dmr1772736eec.24.1793333153319;
        Thu, 29 Oct 2026 21:05:53 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm3512579eec.15.2026.10.29.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:05:52 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:35:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Message-ID: <auQXnep2xKpuNJOF@vireshk-B250M-D3H>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
 <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
 <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>

On 28-10-26, 16:39, Rafael J. Wysocki (Intel) wrote:
> I'd expect the driver core to pick up the series as a whole then, so
> please feel free to add
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
