Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1539336493F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628679; cv=none; b=BU+lr17ErdWXIWAssfPmMaYbcLBw6GHW5aujrW8HxfTqjuJfJWx7NRq2nfvyZaYx94ydg8U44SmLtZcAMx5BdcmEeuXLxqOcIwWqupGScuVpEdWJLfybOuYnhoR+hI6IWoGqkBcY+9TeWndk6jNrf5J/mcakl8QIGnLohTvVuek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628679; c=relaxed/simple;
	bh=CGl0Jxk6sjbfaVN4sy5RfIVfIsj1qUheW0ylvgoNoMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsTpL9bzDO2lq1PxrXGlNV/Gg5htrrpnYVydqWZvMPX/CWSvAXNJn/USEGBxOkqAVDPRI1OWKEsedb01LxRYBo0et+fGBckFNj1R2nLY9dNgZXLCa5aryBjpwbF3kGONYWnhrCi50TXarEVSBYsPSWD0SB5yIqW6lPP8cy10Fnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=sL6FSUyR; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="sL6FSUyR"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899eabc5292so23951826d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1774628676; x=1775233476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cso+lo9ayj72K0N3BDCj+IbAGqDP53N9g3WGxbzu7rQ=;
        b=sL6FSUyRN8oFcvovywry82opGGVTKdTq6hDwn/KpFdYZaZd9GD7i0GIJg6zsNwOA4j
         nSffy8/lwBB5GfgLMyYyxVBF/jLrEsi4Eu38eSYApxh9RW1YYKW3B7lif+arWgcfp9ZI
         a5CZNkLPSYCgwpzECu5aIaiN4VTBKe81Ha/YICr6UADJhgThp/nXUkYzsIqfHMD5hxOa
         oTolnl79LV4LVP9yX5usD1xmskOm3CHD044RyBWDboQHluhowqjsra/AVaOn5IXgeV9I
         eLRK7knixbn3n92emhNTk/3YqXVJKu3rNclXrsKLRPvxAJtHvpDybP7PiJeBjYdBJE9o
         KT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774628676; x=1775233476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cso+lo9ayj72K0N3BDCj+IbAGqDP53N9g3WGxbzu7rQ=;
        b=D55YOLBe5bq8h1qwW7+83IGJz9xMYC6FSZ71wRJHHPwR+dUg7BtsmodrK1feEdkJa9
         aEq0DmlQIHshiP0KuCn6K40Q9RFrygxtLlaITc87mMF3Eq91gFrbO8WuCkyte9G5QptZ
         9ZWn4Xmf/iUzfkY03AWksGqJkfcp2PAKD8rPDm1DhuFjB1GQWEAIzcF519LiC2jibj8N
         RfHMamr2WYqXMl0c8Q5eO9gwJz8ITVeWPRnxQSntgX+WaKyDvBI7fP9NrXYVd/1z1xPW
         bKL4qTSudD48RBMocnczgwMRI4F3fO04jKMRy/mXq9GJ5i8QrOQDi1Dtdepi0kK915iI
         1DiA==
X-Forwarded-Encrypted: i=1; AJvYcCUy3EIhldibwQnslVB6rowbvew/fcAFTiTWXvkzyOGLhcJvihAASU18HOR6MWCFxLS+uo1zp8XFbNlrP6lj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5yDLAK6pKWhJ4CK5TYCks3/gPYs0vM0LbKR3g2fYUCwtYQihL
	40+XNlGEWB1H30CvDyjBcBTpNhDprDdPIST545ZOxIpVwBu/DGbnLcrdOjv3L9ksORmecx47ZJ/
	ogQGt
X-Gm-Gg: ATEYQzyTF2Pfjk5pCSd/MyUXDnodTcDJgPXRXYhvOJYiBV+8m5RWYZyfwFSWT27alBm
	rEqFV8eojZjwbjkqGt1bzyARpdtqKkfV2EKisiM10Qr5LYQWbqS2OWQQYBn/7G4IMM/1/7Hr50Y
	XkWpkwXPxwk0Xtqroe+wWTTdOpb/2e1rB3AYf36Ri0w6imAebqtx+5vSdQGDQTcWG105zILWyub
	1SxV5tD/hZ/HlTJ6iIymd+FgFA3SDcRkKeXIceZJRK0Jte9OER3BChISieefSPKNRfR7DiDc7zb
	BoktAV00buGO6PpvH5CEniVZGl9BnVf3LeeHO2op5XxdbAvbV8zQ2L7Z1bSFnQLevbKD9oBWEQi
	Nrvj4nyq8G1wjgpI8g1FQaZrUF8km8dlZR4tQBNwEQJKUGdv1yOamvkDla/dFYSX8bYAHQHeatk
	AC6oebqmGhuLOa7fOGmIfgCH1/D9bsLdXC
X-Received: by 2002:a05:6214:3f90:b0:89c:4ea7:a705 with SMTP id 6a1803df08f44-89ce8d8b0dbmr44536236d6.21.1774628675762;
        Fri, 27 Mar 2026 09:24:35 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd58553dcsm55760946d6.6.2026.03.27.09.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:24:34 -0700 (PDT)
Date: Fri, 27 Mar 2026 12:24:31 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, jack@suse.cz, hch@infradead.org,
	willy@infradead.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: reinstate unconditional writeback start in
 balance_dirty_pages()
Message-ID: <acavP-qpB0c1nNO7@cmpxchg.org>
References: <20260326215127.3857682-1-joannelkoong@gmail.com>
 <20260326215127.3857682-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326215127.3857682-2-joannelkoong@gmail.com>

On Thu, Mar 26, 2026 at 02:51:27PM -0700, Joanne Koong wrote:
> Commit 64dd89ae01f2 ("mm/block/fs: remove laptop_mode") removed this
> unconditional writeback start from balance_dirty_pages():
> 
>        if (unlikely(!writeback_in_progress(wb)))
> 	       wb_start_background_writeback(wb);
> 
> This logic needs to be reinstated to prevent performance regressions for
> strictlimited BDIs and memcg setups. The problem occurs because:
> 
> a) For strictlimited BDIs, throttling is calculated using per-wb
> thresholds. The per-wb threshold can be exceeded even when the global
> dirty threshold was not exceeded (nr_dirty < gdtc->bg_thresh)
> 
> b) For memcg-based throttling, memcg uses its own dirty count /
> thresholds and can trigger throttling even when the global threshold
> isn't exceeded
> 
> Without the unconditional writeback start, IO is throttled as it waits
> for dirty pages to be written back but there is no writeback running.
> This leads to severe stalls. On fuse, buffered write performance
> dropped from 1400 MiB/s to 2000 KiB/s.
> 
> Reinstate the unconditional writeback start so that writeback is
> guaranteed to be running whenever IO needs to be throttled.
> 
> Fixes: 64dd89ae01f2 ("mm/block/fs: remove laptop_mode")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Thanks for the fix. This was a combination of the old comment and my
overly hasty read of the existing dirty > bg_thresh &&
!writeback_in_progress() block. The patch looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
