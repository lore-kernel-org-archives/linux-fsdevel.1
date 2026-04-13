Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55035B62F
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114662; cv=none; b=SISnApeel32axGe/EOleb7bSCvvwfCUJOCMeIOXN1Yib8QxVy3ElMsUW/D5Of0yRBkoEl1wxiWN5n7Koo6KtM4WWRBV2l9i0AlTAKxZWPMgc28tSTvnW1OkhRpFfCJDG4d88iwcCAq0gf3vjrPnszJMcIFA1nMr8/jiUhHUeQFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114662; c=relaxed/simple;
	bh=Zu9Y1OZSUXOJVh0Hxwr7m8iJ5/WvQjpvGRGhPTQgKwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvbKNTb5wengqvenuPlYUsm2xdZW5wVZcWUFEmvD6CCQZRN1rIvt3yQtubttyz9TFcY+JqkCY5HmCYdwzjPjnEr41belLOOT0PtTILlcnYkVSFwVbbQwVO57K4XiR4Zh6S4IyLkRr3M/or5zkIxbwdY6Ood8JcJSIaP/ZoZag/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MbSLvqig; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MbSLvqig"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a7bbe9d0so39136701cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776114660; x=1776719460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvjBPb9V/1uUcVtqtPM38pzbO+uRaYxM6ZJ3cCtV8PQ=;
        b=MbSLvqigJ3bwIdRcTvME9dcJRW99krvA6yRRyRi0EhKWdt6B9ce3Sla9ei2lyQRGmq
         YleW6Yzz25tnpmLw26w4CUuIvhZfktAIWmBO2z8F3hBBC5StQxPvnp6r829i9YbbyF8v
         MHb/FdOlWFq2XxhR8A3NXXmG6iK6WRvCAUYKNuKLdqVQAls+Nb2IJeNMM17ASTZNorCd
         wrETQOml65bE0RJcdn6BhVtc4idL9VHka8iQcKyrUHSGswzl3zOJ2c28hN6QP+pzlxL9
         ot67zwJRyituSWFiNlPUzvrzYcvxfx2faJYVF6eTrRB7xaWF7JBWBwU/kFe3jXcZHxjo
         aw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114660; x=1776719460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvjBPb9V/1uUcVtqtPM38pzbO+uRaYxM6ZJ3cCtV8PQ=;
        b=rSji/mOBtL2UqchIJPz/ZHMHw0fc0IS+PJLwlUDbbncAIPWPqpTzR0pTYlkym2aOfy
         Fdrv5DxWklVPCWSLlnjJt9yrxrvFwhvIp5MULd+/ZyQLd14qIcsagc/tpr4+3EzLRGfj
         qgr8NUUqk7dbM46Ii/gM2x9bjcek7uGWvwjck2bbjmzo4hIznZN0B/D13NH4rx2JX1c7
         dPDuKXNcs6Wwf2PazIISZjZCCJUULhiKDbpYEx03Kfl1+ixGvDdIjlSF1pnk1uNGElXZ
         emA4mF1f8M3kMXYLr1GxJXzVq/1wy1nRUhvmTbvz/7cUeFlCRUAoVrkdpEn6gmFPT7wG
         47zg==
X-Forwarded-Encrypted: i=1; AFNElJ8BaAPOJ4ezwnYOHxKHcAnC4K1klEaasGyueFayvqXTnIaL/WQruXRg9gAxQgFOTe78dMggWZFnmCTcGHtC@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXyyVGteLBhqLimxH93gWThXAp9Jud0+QH2BPyvgbnb4zYRjp
	oxe4irdAHWJzXG2yeXwM0/KNqcAPI+8EOwUkboRxjwm9x4wetbahwm2J3VFYZ2nPeYY=
X-Gm-Gg: AeBDievmRZKJfauss9xw03QtBMdVavTdP6kj8pu3VC0YBq/LeY54D24t4KaP9YoQhrP
	skkg8fW0t3hiIVdlhfjqG5M3kHQ3pOJUyXvjNmyEuu9eIiJHtGbk2bb+ATHftIK1MbIIL6+4eGN
	rLrAPQYrmaoe1lOuleOOlqlVh+Igrgx5AAzZzFkGNHSauFIx1X3cLfzbWbyzTQbtO55sIn3BoCT
	KFU02/W+6KT5HfguUeYEB443xm96y/OIpHDcXuGKsH29iqidZkcBDg1M4QcVlbybCYfJcnlty4m
	c3zQzZPCMdxlM5kWbh8QUo75spmXZGX78FfEuElHMP/8WKaOwX0Fsv7yletN2AEEspjR6GDZZ04
	q6lmhnE9aNmQsbnirQuGw3+dVWP47FNkeLtbfsOIcLMEbYBJM5FaL8Y5TjYAyDj77fpk4knry9n
	ZAq2qThVEgB0VrR/GHnJd6Au1CZ8tN6PV+h6GDWX/4LyiCbL0kXJLWsDGdpAVWU5ed5vcMdkZyt
	Td02MlKzAf7BUh3vRnQseA=
X-Received: by 2002:a05:622a:8a04:b0:50d:855a:8909 with SMTP id d75a77b69052e-50dd5b7cca7mr167929061cf.32.1776114659953;
        Mon, 13 Apr 2026 14:10:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd54ff026sm94173381cf.22.2026.04.13.14.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:10:59 -0700 (PDT)
Date: Mon, 13 Apr 2026 17:10:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Hannes Reinecke <hare@suse.de>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Strategies for memory deallocation/movement
 for Dynamic Capacity Pooling
Message-ID: <ad1b4dVCgG27A5AK@gourry-fedora-PF4VCD3F>
References: <e06deabf-44ad-4f3f-b817-78506c5e3203@suse.de>
 <20260413164359.00001c86@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413164359.00001c86@huawei.com>

On Mon, Apr 13, 2026 at 04:43:59PM +0100, Jonathan Cameron wrote:
> > 
> > So quite some things to discuss; however, not sure if this isn't too
> > much of an arcane topic which should rather be directed at places like
> > LPC. But I'll let the PC decide.
> 
> Superficially feels a bit arcane, particularly as we are currently
> kicking untagged memory into the long grass as there are too many
> open questions on how to present it at all (e.g. related to Gregory's
> recent work on private nodes).  On recent CXL sync calls the proposal
> has been to do tagged memory first and only support allocation of
> all memory with a given tag in one go and full release.
>

General consensus after last few months seems to be:

"While technically possible, untagged memory a bad idea for $REASONS"

I do not thing the private node case changes this, if anything it only
changes where the capacity ends up.

~Gregory
