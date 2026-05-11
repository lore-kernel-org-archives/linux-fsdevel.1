Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F63A1682
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503463; cv=none; b=YbhyXG8iQco5/MpqUVs4YiIN2X1ZvFizasn6IN+o8OdEwQaRlfGNdHAY9yMjGIQHrnhlPFk8zX68vZwJ1IRQ5y1uoh5fN+JDjJkiR4Ffh6zdUeDmqDISXlSrtT57D65QF1RqsHSE/E0evdGbuFP09cDkQZwHzE4GmVqknx5vg7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503463; c=relaxed/simple;
	bh=TQYRPqIuRJ9SBiARipZkoDO1NSpzuzn031P9qW8s+s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp87+jH9aDa0RdEqX4tNI7GMMwQnKe7PYzcLQ/q4zPauKooUdTm50UkEbGSLGbhJ4bwhwejrh3uTacePq6uOzGqg6xvPtFhjhXLWLSh1qzwTFyz67ZxSlk0Yf5QCbk8Ajc/uqKchrnp3pFzQoeeFnw3QkvEPdiuY0UonqyO/ZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJRLNy0h; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJRLNy0h"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ba840146so37949035e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778503460; x=1779108260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHitmBP8USNGMLAXOmkdJpRqduMwp3sFGN+yTzeTwUQ=;
        b=hJRLNy0hBaxFCD4No9t+y/tW2i9OPHQhf3lAU+DOutMQRT2W3mYGNkAWKky69b2CMs
         tq0oHUjHKeOrxHTC3EWAtikrZgMwVYbnzsAGLdkrL8BkzeJ0LSCmK43jR+UZx9yNfw4+
         BV73GvLRsYKeSz0zcEf8p+XnJl9FDL0tyiBjuEi/9O3jPyYrMAjCNe2QN8lYblVI4JUO
         gOy3NFpOi+LlkrJKPOqWrnLoZDjWsc2tg3HN2aEL8rn1QpZBdbd+9d7a2+EulxiIiyYP
         +Yedbbc2SPBeAIHIxJyziA75GwygqDx7/q6WymlwBjDEXc8LO1EFDdSCJvoKXX19UO40
         3I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778503460; x=1779108260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHitmBP8USNGMLAXOmkdJpRqduMwp3sFGN+yTzeTwUQ=;
        b=EnTpjakQmArDlL64D4uRRXTxWcMN0+Gd+Y1j1nnnxese85XlJBR6q3hfBD9NgbnhOJ
         F+rL4lPf7JwjwCKb3efBCnElKOmEyHN1E7CBMETxw80oHS2Zph47ir/NdYukXKDdBt1c
         vfIgti79GrbeGe44LkChkRG7zQ37hHg6lrZFwdXd6o/5eLowIpAw6eLfi2VJ6iRRAMRE
         jROgH2cL+Cnat2bD2hyq6bNLGsyh65STEm9C3cKOMZWooq2IElBF8rtvVDHavrSuNQFA
         /9HneNlONyN/qBxqD1Sz5UugFGte+CgUiCiIGLqfD88Zvvydi5O2qQytJ+ccBWDd/63/
         aw5g==
X-Forwarded-Encrypted: i=1; AFNElJ8vXqNMERu+ttAzFkN/c+D1wBLueivtl51/tltbfzM3YYN13Yg/IbS/dQIiUPCxiCuws0Bj9SPwV34t21iu@vger.kernel.org
X-Gm-Message-State: AOJu0YxiafbqI/tk/YHXnutPqFRVKYiUh71GID9gx0XhWBtNb5zszylW
	TF4oiGr15UlXASK5nfXtpGPLYlCZ7sTyLYBnAIzNSq1lZaqRNWfWpPrr
X-Gm-Gg: Acq92OGsDuRso3EHrzyZKJyA2dlc0WwlWlpOE/yRyTGridknhvwNgw0vlI8I24jENeE
	i4WAT/6gaa7HvagtgEPLX9t+lGurmTcfItagkiU0mzhDgLP/IbbO9DbzSZpHyQ3tP+zOuqkRswm
	JlJKrRKovq6M2/u/7/JhlrmLuo/oEthGpz+ouzHIcFm5ekOyrH0QsgNigdlaExE46U/BQCw3KXB
	a9omSiKufzU7HH/RK1+mQodw+uFa1xI7Dpj5uQG2u6wa3WbUKk/GHvtoSpsKp3dxeAWvT7JnVtX
	eP1bB/BxOERNgCYEAkLIfLn8p4qL15tMQHDEeb/9NEMC2iPP8wmdSao+VA6ZSypxEb+0QI78xgp
	7GEUGJ9lZcSRU17PJg6RBXI8YXrLzJjsPP4W/BFSDgxS4O8peJTUFg5iUnqMhX3hbYn9KBeZ8cr
	TcjQKiTAQt9wq6yOpk9MrlbhZXrF0wZiPP3Vo7MKMuTU1+GqteVJvIOI7qrfRMdgC9x70zw4eKj
	/1/nXjMBbLq
X-Received: by 2002:a05:600c:3548:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48e51e0a6a2mr360497845e9.4.1778503459729;
        Mon, 11 May 2026 05:44:19 -0700 (PDT)
Received: from fedora ([185.193.234.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e6d41sm234731455e9.7.2026.05.11.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:44:19 -0700 (PDT)
Date: Mon, 11 May 2026 13:44:17 +0100
From: Vishal Moola <vishal.moola@gmail.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: fix page_cache_prev_miss() when no hole is
 found
Message-ID: <agHPIcZHHyzBjcGN@fedora>
References: <20260510-prev_miss_fix-v1-1-755bb123145a@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510-prev_miss_fix-v1-1-755bb123145a@columbia.edu>

On Sun, May 10, 2026 at 05:54:17PM -0400, Tal Zussman wrote:
> page_cache_prev_miss() is documented to return a value outside the
> searched range when no gap is found. However, the no-gap-found path
> returns xas.xa_index, which after a successful loop is the first index
> in the range. As such, that index is misreported as a gap.
> 
> The sole caller, page_cache_sync_ra(), uses the return value to estimate
> the cached run preceding a sequential read. In some cases, the buggy
> return value can undercount the contiguous range by one, shrinking the
> readahead window or pushing borderline requests into the
> small-random-read branch.
> 
> Mirror the fix in commit bbcaee20e03e ("readahead: fix return value of
> page_cache_next_miss() when no hole is found"): preserve max_scan in a
> separate variable across the loop and return `index - max_scan` from the
> no-gap-found path.

IMO, this way of fixing it hurts the readability. I'd prefer something
similar to the fix in the original commit. Or...

> -	while (max_scan--) {
> +	while (nr--) {
>  		void *entry = xas_prev(&xas);
>  		if (!entry || xa_is_value(entry))
> -			break;
> +			return xas.xa_index;
>  		if (xas.xa_index == ULONG_MAX)
> -			break;
> +			return ULONG_MAX;
>  	}

If I understand this correctly, couldn't we just do something like:
if (!max_scan)
	return xas.xa_index - 1;

> -	return xas.xa_index;
> +	return index - max_scan;
>  }
>  EXPORT_SYMBOL(page_cache_prev_miss);
>  
> 
> ---
> base-commit: e9dd96806dbc2d50a66770b6a86962bd5d601153
> change-id: 20260510-prev_miss_fix-fcb308472131
> 
> Best regards,
> -- 
> Tal Zussman <tz2294@columbia.edu>
> 
