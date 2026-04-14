Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9693E0C66
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168720; cv=none; b=OMl31cUClGkYoz8rQtbfdzx/EN5+9P785AAFi036VlA2QNWAwd6TQ7ZhKVejj2qFn7pyWyKrDh4ecn+2usWf05yd/1wqOQkGh8Gdkq2HWSmHYtV4D4k1yiU+Z8ybaY6TfYrN/uJ9bjCxaAAMgUOob2LW3b6DHHWYdTM/WFkFWPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168720; c=relaxed/simple;
	bh=RbTGYcK6509LY81XJH8m1Pc4f+w2K7u1mTemWvMy5AY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s7ofVpCfnomxZj6NL87ah860l1Uw5tWzkpLLY0ofI4duF8STDR8unyugHy/1Nj2gEOlTLI7oUC/wtWmN19+EaG3bVXLM7A+6Dwmf7k2P5muwmrnDEhvvyn98lz8bOZ0B9REs4dMqjzfYoWJl5uch46euldSSBxUprMUzsP86Vzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a8f97f6bso10209905e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 05:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168717; x=1776773517;
        h=message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbTGYcK6509LY81XJH8m1Pc4f+w2K7u1mTemWvMy5AY=;
        b=bwSGZmAMwOAawVMb8SyGDBEmraXtlmquJfubF6vPOpwIfwj7IsRv4RU1T4XFraankS
         p6o8tmYuVwt50g5eshy2x4O/15zvsoHJaBErOrwN5dM6dK0naQVObuPQJoHNaH6SjBir
         5QWYUsSxXDeZQ410YEuqLpH6SutuSrToUs+X4m0MZDiTDqFl5J42tZfV4ESKQgMPFKM4
         antYdnVDAMG5+LxlrLq8g5iYSbDKMwJEoW6aze25y0h/4kcFeO3C3u01pGeguQMYi/Ej
         IS7fWfCJAQj5xOYLWIWKRwj+zkfLDksI359+cFbnKDY8+8No/A3r7Zbes0Irvgwhsb1i
         NHqA==
X-Forwarded-Encrypted: i=1; AFNElJ/qLDg3OZ4WAbAwaiO1TvxMSmnw80WKmPQQalV3xaflV011+q2D3T2kNW64C7HEWESdgv647P/9OEgia3Av@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnCXumag15Ie3IicUVxkaG2Jj1Q95MTXLtyfcar0vOZIMCt41
	8/TBhUutn0mFUXMGNARzkANmxVavA1tjx/1kYj/HDfYwM0ByUb5kWe5nuLbwm3l4
X-Gm-Gg: AeBDieu4gYXeRGQaO+Yzh33Xj6UwIM2nj+bN29kYJM+rg4vbzLeOKuhKwtYvx8cVHHk
	UP9zuA0SCx3v3F6PUCzi1vKrZa9SPe9GCNdOHpX2PfSr8YxDqnWgqAVyUpW/SALEhAWUTQngOWv
	nT5ThL6pz6NBs2nj0fpLONL2j8eYitQd7QTLkxjPtlgob441QYjgsnL3mHM0Wf74HGEF4yzNIgH
	0RzxGCu00iLL7A5DKjyJvceoLu/wf49cAVvtiQkZounvPkT4RLoP8HNYFJOCYMbutt2LUvpVL01
	ii7iSd0BFdAo0auxmFazyHkerpEKr2+iC1VNyJMQ/xWsKjokH7ipj9n7MsUCitIoxQ8MD7PmQhC
	4ox5tDvtC6SugpyTNZqjCzJwE1g5wvXshzwY9w6GM1Fc5ssBLSP2HCNONNpZxu5aTyZaIF1mtoD
	NXLej1+biPABORTHthC7B0DnPwHO++BgtmVaO3myqig89uvG0/tg68kKwISuVTOLbNSw21nWk=
X-Received: by 2002:a05:600c:45cf:b0:488:af08:73c5 with SMTP id 5b1f17b1804b1-488d683337bmr108457505e9.4.1776168717391;
        Tue, 14 Apr 2026 05:11:57 -0700 (PDT)
Received: from hackers.camp ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee03898bsm45605905e9.11.2026.04.14.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:11:56 -0700 (PDT)
Received: (nullmailer pid 12727 invoked by uid 1000);
	Tue, 14 Apr 2026 14:11:31 -0000
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: Darrick J. Wong <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [RFC PATCH 0/10] ftrfs: Fault-Tolerant Radiation-Robust Filesystem
In-Reply-To: <20260413181156.GY6202@frogsfrogsfrogs>
References: <20260413142357.515792-1-aurelien@hackers.camp>
 <ad0GX6gVgHxD9-ym@casper.infradead.org>
 <20260413181156.GY6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 16:11:31 +0200
Message-Id: <1776175891.855383.12726.nullmailer@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Mon, Apr 13, 2026 at 11:11:56AM -0700, Darrick J. Wong wrote:
> Why not add FEC to btrfs instead? Then you can concentrate on getting
> the IO paths correct, instead of burning time on ensuring that you've
> implemented all the other posix filesystemisms correctly.

Adding FEC to btrfs would produce a filesystem that cannot be certified
under DO-178C, ECSS-E-ST-40C, or IEC 61508. btrfs at ~200k lines is
not auditable under these frameworks regardless of what features are
added or removed.

The certification constraint is a hard requirement for the target
environment (space, avionics, nuclear/industrial). It is not a
preference. A smaller, purpose-built filesystem with RS FEC as a
first-class design constraint is the only viable path to certification.

btrfs also carries significant complexity in its COW B-tree allocator,
extent maps, and RAID layer that would need to be analyzed and
certified alongside the FEC addition. The audit surface would be
orders of magnitude larger than a dedicated implementation.

That said, the IO path concern is valid. v3 addresses this by
migrating the data IO path to iomap as you and Matthew Wilcox
requested. buffer_head is retained only for metadata IO (inode
table, directory blocks) pending further review.

Aurelien DESBRIERES <aurelien@hackers.camp>
