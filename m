Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574EB3FB7CE
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162958; cv=pass; b=tVjv602bQ0c9qXdOAbMSxqj4v6ZNhzDzAKb7W0+3hTpjj0gw6cjSSxXoG8WtgWHH2XgTtM/AN1puiGkjZg94uZGrJ//fwQCLLRH+pytBs4EEfp9vTyh2GwJJ3LZ8fPvcpTa1L9mlB5Qs5QumTZnR/L0deELKSBpR0S/HwJYI9Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162958; c=relaxed/simple;
	bh=zSxhQFpXAgOryDbzOyvsVeE+DpCQx8y4MAT1BfVdwFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpa0Dd9eU11HMEBipmHeoT5ykunZUl8+/VCIxoEHh3ryYanoVMpCfMmpOQophzqp42M2lr1tkx+qyeyMOMv+FVbgtzW+Z/SVE+j3PYic/2DONqnIXCqhM4tIkqhW6wa7p0YoeG4wQWL1kBIDDwXttYC7OKLYxQl02nWfIdzKHx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfMg5WP7; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfMg5WP7"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ca9d0d189so76323d50.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 07:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778162956; cv=none;
        d=google.com; s=arc-20240605;
        b=M0+TDvpa4qo+zzxszhwoJG4jRIVsxCOWMEh+zoH2SqquUT9bAovpHZ8ofEt+2cqffz
         rA/luihDpGZKqaBBiG62A1awY6cxboaKnbG3zc6xexhqsOsaE/t5raf8o9vDP31ovRmc
         yQnpycBxeJOXtlQTA84dhtq6Fb6mvtfLqe7CgeSmC9WWy2rSJ060KXJCg7FxHivR9dH/
         dxpBewg/8aRSsRPydrBn/TXVEFGLXMnnHZBBJ1KwoWRhyijBpYNIXxWcf1NswdIwfJiL
         EUP/gUcFQKK93oDXWrP6WlrIUgSkJnLjHkwx9KplWznAP7jXTAiIkbkPJUKpAY5vLxnA
         AdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V2NCHFY34E8Uq2W4AVeyGy6zGAO7Y4S/QbjN1GEahfo=;
        fh=W/y+vaNOgqtnh9rcrPx7WojKVnQxQuChsOGhFrLVkD0=;
        b=VS/n5r7tcWQ0DbM69gqKovL08Ts6Jov57+YCUM/SIrMg0YDXkHAULGBe3vPnzyD/J6
         FpDfLsL14FfnBQOLHd4cbvoa0YufmLEdx4hToOjpwPaAO3PNcyOtMhOKJa6K8VF7voeg
         M24xEgh7j7zObg3eAhPpOUNQB9YIZV9KdSem7uXgA8S/jhkmaxxoXZF8aptghoJxTVAH
         d/4gCvVb88pqWbl6RZ9t7HQAOCeSZ3WYiRxVfYJ+9hmNssrYiukEM8wGWKR0IkTlY5ak
         OtWG6aALUrChN6W3K7sPub1+djtSCHEMQvHEHPSyjiB3qhW4e5Cvzm1HExzJn7npRdDk
         qqOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778162956; x=1778767756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V2NCHFY34E8Uq2W4AVeyGy6zGAO7Y4S/QbjN1GEahfo=;
        b=FfMg5WP7kx9yvbDh2RVMoUWHjxBudD0KdMQOL3vOOrfEyVRoGraY5och/g1nxPTJt2
         60gW5VA7jozSADovPldJUYEwoeU9DJRxEm847b0do7KJ7L66Y1gqHSv5AIwZDx35V7Ai
         Id8g58Kpa5MHPKE7qzsmWcMwiEcYjT85FHhINJ0c+lPjMa6MGT0vn7IE6Ybk7MB7Yw9b
         j3HPYeA748CVOrYiUVCLeREuYOO9RpTKZ8TdaDUtDDCN3ld0SNpBPzNjg8o74fCvF88r
         AbQMifP4nSE8Cs/bTNEFTkP+wxs7pt70ZPPhOfYkadrkluY1XC5RbLfwzAvMuCi8ZZsL
         8gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778162956; x=1778767756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2NCHFY34E8Uq2W4AVeyGy6zGAO7Y4S/QbjN1GEahfo=;
        b=knx5hOIsMt+pKcGQHXzynQkOTOlh3ZxWF3tzsWh/i29CpuLyCGxasRvDRK7LL5YbX8
         HKKrcsB8g1nK62GrDDxi5U2RSYhT/RBH+5Xw9+S8OvUx3T6L8vw9jmWdVtGA+o3jxCJz
         1Lqq7tCDco21HUYffVcLgpD+fNqGrfLQ23DpXcm1LxvIQmrqHslIAbboI7l2MtoXAz6L
         +qFpeVLSbbPW6RkYUAqy5DuCyhbh4Q5PDeECsSQEunPpCTPaz42z/5xKHXbMOaLMEiJd
         pVrCj51mpkAm0zKgrsqeFXG34sZ11sYwGvkpexg8i1Bft0u65tNhL5lbVo66tcMuKTiW
         8o1w==
X-Forwarded-Encrypted: i=1; AFNElJ+uaf6w9IzjmeEvKzOhe4n+jidheut45E4mAW/leK1cb2mBuFpE5rc26IKzSVsUX5X2y3C2oe3dSszmO7/w@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNSMNe6nRyf4uYHvtG+gzHEurkdx4yFSSKGDC6c23UAK/lMx+
	VwjLX5KJKoaoBMExC22DevlxavExiYsrW5uf74xewYwA085uK4WFZ8jNH6dzdLFg9marafEt+z3
	S48/z9LIcOhEt+GOqZfCDbH2UY9XagMQ=
X-Gm-Gg: Acq92OE6x8HJxQ12fA5OB0Jjl5nOhbX43Oc5YO5NPRo8DCK0RBEpVszskfMbDaZ0aUV
	gqHr21TKFWOG1zmseaejJ3gNt3rS/1T8bR9etzhM7prYZWht3qYvGY24aVHlJfy+wt2gOSylvpO
	tWuhR6RW+7iM9sgTysyeVUDURxUTmTKFLBpNDVQ+pcKYcpn6NXWX2c8mR5iYMrXHVZYREGCBGGc
	XJK/849QOCY8ZO2r0tqTkT5U+GiDMIJ3PfQjFlURLNBMDYnIeZnET8EkxMBfs4hQcPjfOP9hXmu
	l5kokaNdeIE9bgICqttZ
X-Received: by 2002:a05:690e:1697:b0:651:bdff:db07 with SMTP id
 956f58d0204a3-65c7ba535famr4641538d50.7.1778162956342; Thu, 07 May 2026
 07:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-5-linkinjeon@kernel.org>
In-Reply-To: <20260507124238.7313-5-linkinjeon@kernel.org>
From: CharSyam <charsyam@gmail.com>
Date: Thu, 7 May 2026 23:09:05 +0900
X-Gm-Features: AVHnY4J_N6w80n6y1nXCewuy31GBmrMs5YFCAkzy4G16o8YMa17TTvaJh4O1Rcg
Message-ID: <CAMrLSE6tGG0b+zHExAFzdPJOL7Agv25ggg6nvUd6ik5rEN-DUA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] exfat: add support for multi-cluster allocation
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hi, Namjae.

The critical issue is that this hunk drops the hole-care walk in
  exfat_map_cluster():

                  *clu = new_clu.dir;
  +               *count = new_clu.size;

  -               inode->i_blocks +=
  -                       exfat_cluster_to_sectors(sbi,
num_to_be_allocated) >> 9;
  -
  -               /*
  -                * Move *clu pointer along FAT chains (hole care) because the
  -                * caller of this function expect *clu to be the last cluster.
  -                * This only works when num_to_be_allocated >= 2,
  -                * *clu = (the first cluster of the allocated chain) =>
  -                * (the last cluster of ...)
  -                */
  -               if (exfat_cluster_walk(sb, clu, num_to_be_allocated
- 1, ei->flags))
  -                       return -EIO;
  -               *count = 1;
  +               inode->i_blocks += exfat_cluster_to_sectors(sbi,
new_clu.size);

  The removed comment is explicit: the caller expects *clu to be the
  cluster at the requested clu_offset, not necessarily the first cluster
  of the newly allocated chain. The old code walked
  num_to_be_allocated - 1 steps so that *clu ended up at clu_offset.

  With this change, *clu is left as new_clu.dir (the first newly
  allocated cluster) and *count is set to new_clu.size. That is only
  correct for the sequential-extension case where
  clu_offset == num_clusters. For clu_offset > num_clusters, the caller
  will compute the physical sector from the wrong cluster:

        phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;

  This also interacts badly with the new contig=true allocation mode.
  If exfat_alloc_cluster() stops early at a non-contiguous boundary,
  new_clu.size can be smaller than num_to_be_allocated, so the allocated
  run may not even reach clu_offset while exfat_map_cluster() still
  returns success.

  Could you keep the old hole-care behavior and extend it to the
  multi-cluster case? After allocation, the code should advance from
  new_clu.dir to the cluster corresponding to clu_offset, set *count to
  the remaining number of clusters from that point, and handle partial
  contiguous allocation by either continuing allocation or unwinding it
  before returning an error.
