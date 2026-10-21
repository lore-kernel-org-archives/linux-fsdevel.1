Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596487;
	b=w/RGNfycdxzKl1D02JmfTFBQj+ZVNWEOqdQHNpFlK/jZ/ezHbUNu+Nla0XquNHLotZ1j
	 c7Tb8kNtMVSPbuaB9wixH01/ezXTfqbW4aAYcshRHV6xD0gE3yM4gv8Jjdzbjbs/R0llE
	 o8CcwAMl5QN2DXDcjICewcCbEoZAu/1HGVxBsV4Cb7VDKZX/6Emr6ysDtKK2mGexUpYVh
	 LxMMEW1Q4vd5KeClhOb8E1mUEa50MSWBgJRhLZcfNOSjXua1F41w/tWUU+e59eutJZRxk
	 5ZsRMGdcAUF5g3K4f8PQk8AIhjbxJfTCIg/G0WyLEf7GBIh0vX8mgeAtf4+/BYMnQpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=J7iM+yhWKMhlaRTv9Dtyn+iVYrKHxFutAHJMBB4EGzM=;
	b=OGKT56nI9XYs0mrADHW6vkPCGR4y4sqot+hfTxbCoG+LGqEUtpXci2Bozpv8IQjwvjzJ
	 pnkzvbFNzA2BhtOUbpCwiR3Ei8adFIg2s9BWzJAtc1m7RaLrv6fSA2Zzlc5jQT7Gez2vk
	 VjNg2bjuZQZeiNwtIaR3/gWhKUhhP41y0iPSqzcpHXSjMf4NPSDb3bdsuGexUlaZJUxlg
	 8qMb8+JLT8WVqU+jz3QT12+bSZr4PUaC1/eDOKoDtygZt1G4LXX04st2WNJXo9cpcSkjX
	 VrY9oRsSbBVhuXXFpE2ixkk+0qq5jVHBadEQ4aowSJ1hPK9jd0g6TbcJ6qHBBebR15g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NjkSxdlR;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F4606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 15:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F0F4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NjkSxdlR
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c1f548f87so3074756d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792596485; x=1793201285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J7iM+yhWKMhlaRTv9Dtyn+iVYrKHxFutAHJMBB4EGzM=;
        b=NjkSxdlRV0YeVz9c7b6C/ObSO3CV0F/hk+ur2ybp4U3aMmAsWcP+bU7/dNr90v16f4
         lzE1t8ilfOMbXED2Faep7Yp5B95D2uUr/qMIEx5Oyw95DKLXGoh3caabdUt2LHq+Fi0j
         vSya0ZD3VKvWY/eLMka4vEoMzAqmA7visb1VKBind7HuYq2Q86IXrdGSvBvLC4hjJMO4
         aZXCGMpGcQKicHLpdJvPEmLzWgdSH16GK3pwIzAwfObU1r7I4EGPOadc8keV1VdF0i4+
         KqPkYtVuJ9RYGRLHuNTHl+cgUIe3yW4bKzYvltjnytDJ3oAKPykNIzKqUiWhpgU+lh6v
         376w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596485; x=1793201285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7iM+yhWKMhlaRTv9Dtyn+iVYrKHxFutAHJMBB4EGzM=;
        b=K7/1CUOn/3qA9quNeqq5DR0AlHzxu5ZWOTAyMvcx6HZwYClJiGcv7XKbWo2E2ygsYE
         NqJJdTXotOYJqE5Vrb2TT2qF22cqcCsy2I71mn4Fso+UWUY6xXUQuEY34lOf4ugmsQb5
         8YawNSIwhKNbRHpWRv9Rk0kbMnX6q92Af60Ia2qONfMwt2i5UsVeBA1+OLHB+bqTe1RL
         v+sJcwHfABVKyuDS+FuERTgSOXUVGEPOQE4nZ1+C1LVdqMlckwCvIdm+ISrSD8VvuT4d
         462bH3WZ3eN3lk+3Scf6wuG2dgkhXH+3Qpq1/vxCZU25E0VXxqH4M/fd6X0zGrL2Ce01
         tShQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOZDw//yHf/kZ2vmbY3xmCyahqwqQCqiUW3Eg7wk2AtItfpdzFi+fiYJpxY1mSFzqAxjRnOayhoGQedr15@vger.kernel.org
X-Gm-Message-State: AFq9FYJbjjaomY6DTGNaZypQuvyBBl/qfeMGrEbTRrH7QuSeB9As4e5O
	ZyF8Yir9ooFdDwqwCP6qOf/M629PRVboY5Y5lD4Xy7KxQNUcqkXd+LvDyy2b7Atc+Dw=
X-Gm-Gg: AYBFou3Zv868fIK8xWZaTpv1UDzKmi6BTJbTYixBS3NJpYJgoGcKWrzLFvxqMCqBabq
	Lvdtom5inS/AnNqgENf8RDJKRTwEYB9VrORgjEHnxEYNot1skz3CrVliSrYNa9XJ1pK9zh6zQ90
	9TcFEYyHKB4QYlb4vA9hrnzTqE48L3WITJsIbVLLqGqx660lx22ekZfZbKiVG/rsFEOtfR94/Fn
	8WstIdYLNHepx3x2JvitsTFe6u2k4UhnPK1qs2pVWft5sQvyk2KsqxWLMVb00Tkm3QE/Cw3cWKB
	Aauc4HzfEqGA3yXjdhyTt+bA/dtLw8iTi9Hrx+RksJNO8AO7bC59wMDNu3/xl5EA0isBXTHd2sv
	PcHG9xqLFALx1409F1/kGplVExrWrfe1bScIWtK5Fj1MNMgLzuRVxzTbf4IF0YhQXXZl6yQCjQq
	INl22QuWi1vYKR3uINjdFKz1y68UpI3Cm7AsVrEIJGdsGuQlXWBjuIUXiWX2j2k9w3ekFKmmYen
	kgpIvn+AWblWgr34UlZ7I+u+S9VwU9lkWpmUWtTKeZrMl1toi24VqspCtg0lY+1ezfSKwreEE0R
	03oFgleFxH4Zj736dPhhc8E+IdeDBa0Xp8XR
X-Received: by 2002:a05:6214:3a8c:b0:91b:d5d7:8c85 with SMTP id 6a1803df08f44-91c12eff3e3mr44319236d6.33.1792596485317;
        Wed, 21 Oct 2026 08:28:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c3b500sm27151986d6.35.2026.10.21.08.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:28:04 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:28:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz, 
	shr@devkernel.io, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/page-writeback: avoid 32-bit overflow in dirty
 threshold shares
Message-ID: <atjZ6yadzSeqjozA@gourry-fedora-PF4VCD3F>
References: <20261021060654.27855-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261021060654.27855-1-dennylin0707@gmail.com>

On Wed, Oct 21, 2026 at 06:06:54AM +0000, Hungyu Lin wrote:
> The ratios used by __wb_calc_thresh() are scaled to parts per million,
> but the threshold and ratio operands are unsigned long. On 32-bit
> kernels, their multiplication can wrap before the result is assigned
> to u64.
> 
> For example, with a threshold of 25600 pages and the default maximum
> ratio of 1000000, wb_max_thresh becomes 4125 pages instead of 25600.
> The shared threshold and minimum share calculations can overflow in
> the same way, producing incorrect per-writeback dirty limits.
> 
> Use a u64 threshold for the three ratio multiplications and div_u64()
> to retain the existing division order and rounding.
> 
> Fixes: ae82291e9ca4 ("mm: use part per 1000000 for bdi ratios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

