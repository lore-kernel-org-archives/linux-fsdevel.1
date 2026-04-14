Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E83E6394
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168461; cv=none; b=CqE4u4+/tXxw4hRGHx4QyFZ0cDPVtje9+rmBg3OczHXwYhjWOjlSqse0cUvC1Ezf+QgY+3v38HIgOSK9uRZJ22UyOblZG+Elqfcoi38vGUrZhVj0tI9zfxord99th7cKrqxAUc7pIOPNd1WacU6S+zcBq292rtN0fenuooWYi6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168461; c=relaxed/simple;
	bh=UaebnlNS68Z+R0VpuogugIfCBIL96+3eUIbIHkfdW5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kRJGFPRaQkged3bLcZ7TcQ+iWcciPHWgBQC+denT0rwCS1MLV4uS0OSFoR5Eoe8YaQn0hmpqf7c3j5Z5/75GweUxXtmgVitWwv1sRu9i6LfZY+AqmJpAIgIioYqkEfG2fs4vQqpnnspreCcWkJAPOK6B1Ou4fyg3Mp6nDlazhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d7146cd1cso92473f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 05:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168459; x=1776773259;
        h=message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaebnlNS68Z+R0VpuogugIfCBIL96+3eUIbIHkfdW5Y=;
        b=iNJHvzpRGGU1dsbjgZ6qfbCVbnCz3vA8o0vQC0VmcMrG282E8drAV7hhR8e7PiPOJq
         Y6ry1Rz5wjdsu/j7H7aZZymCXgtstSN0iZUcW6NbnB/X7YLT/WF1nUllXZBpJdckhlPr
         cuRkOVyhD5OKkhzKIc9ebOPXB524FS3ggeVzJ2OyB061CWmQ3YCFrzlddz8Z0LbsHz98
         0TlvP1a5k9rTtqFCxlydJZkw6hgr+0OOQiRfe1Sp5BabdwdVxHOyevcQemUtGxR1P+Q5
         Z3dLoeY6w6unrg6h6/kyv0LRlOgHKs0bbdf7Lis/eWi7cFxOMRnNAinXqpFTBWJXRCdF
         Zrkg==
X-Gm-Message-State: AOJu0YwPNKl7RIBHrbsREMppeWJB8Ztkn2Cu/V2fIWa6rQ9cg/kfoSgx
	ehE71rcgdTVhUDD/yEOyow3s0ldhw+PM5y9r+P4sPPgB/5W5GfhPll/R
X-Gm-Gg: AeBDieuTzpubI96KNN7/sc7vy6wVpCCs+GilICpgUq+4QdvRIwcFyPs/ip6HQx9cYto
	rdKq2MOgZuw1tyfVh+WhGq2fX7aPAITN6omoOk0luv3MhBkVK0fEDg80z25w9hQF4bamNrw1WSA
	9KFtjKK/M1Jur2lLmUN2rCv330uVYwyTCpSMdNjVWx1gF042hSUbPVP6/nQoyBwwDAQzGI6QOR+
	T27ARHz24bhq6YTy/MfG6+L8jq0ybXV6ijaV/YOodPlaqeS3OId8ZTZTMiSKhTIT7B4g7D/HzNK
	SdHwciXxfod496oWzYbsMWs2WY+MKMmWT0uARgqM4SPktncRQrm3KwI3EgzphEGLiV2GHbRLwjT
	MQ/9373jITiiYkrsDmf7qgBz8OKHQad/XLbqqlhcaRGIFPZypCfcs8mdxaP8aYAauYiKkN/xl2X
	EREGCLvTt1izvEth4sIb2o+myNLUhemb43vJPV0QE/2bOMfoLQDTtb6rhA3EP5e8OHKT5BNqQb1
	s7FmThsKGcHMm9kCiMuL6tysJM=
X-Received: by 2002:a05:600c:46d3:b0:488:78f0:5ba with SMTP id 5b1f17b1804b1-488d6890f22mr141956715e9.7.1776168458623;
        Tue, 14 Apr 2026 05:07:38 -0700 (PDT)
Received: from hackers.camp ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede24eb0sm49753965e9.8.2026.04.14.05.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:07:38 -0700 (PDT)
Received: (nullmailer pid 8855 invoked by uid 1000);
	Tue, 14 Apr 2026 13:31:27 -0000
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [RFC PATCH 0/10] ftrfs: Fault-Tolerant Radiation-Robust Filesystem
In-Reply-To: <ad0GX6gVgHxD9-ym@casper.infradead.org>
References: <20260413142357.515792-1-aurelien@hackers.camp>
 <ad0GX6gVgHxD9-ym@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 15:31:27 +0200
Message-Id: <1776173487.564511.8854.nullmailer@me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Mon, Apr 13, 2026 at 04:06:07PM +0100, Matthew Wilcox wrote:
> Might be nice to link to a non-paywalled copy of that paper, eg:
> https://www.cfuchs.net/chris/publication-list/ARCS2015/FTRFS.pdf

Done in v2 and v3 cover letters.

> Can I ask why? Is the original code not available or too ugly?

The original FTRFS from the ARCS 2015 paper was a research prototype
targeting a custom RTOS (not Linux). There is no upstream Linux
implementation. This series is an independent open-source realization
of the published design for the mainline Linux kernel.

> This is very old-school. That may be appropriate for the intended
> use-case, but it ignores about five decades of filesystem research.

Intentional. The design constraints are auditability (DO-178C,
ECSS-E-ST-40C, IEC 61508) and minimal code size (target < 5000 lines).
Five decades of filesystem research produced ext4 (~100k lines) and
btrfs (~200k lines), neither of which is certifiable under these
frameworks. The old-school approach is a feature, not a limitation.

The iomap IO path was adopted in v3 as you requested, replacing the
buffer_head based read/write. buffer_head is retained for metadata
IO (inode table, directory blocks) pending further review.

Aurelien DESBRIERES <aurelien@hackers.camp>
