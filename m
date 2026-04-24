Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D03F660E
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056605; cv=none; b=L1qO2sW8MNZIB8eKOn7U3j7clEvZkYg2rVb80au7kTOXt+ET3XII6LWfZ4mfFulolyeUfRGwH+GlV7ee5beUYTL1Vy6XEKd/hdD70QBSyT8FjX5c1yHoN2M7AdyA1fkWAz/Fv3ZXMn1LJ8fs9PRRLCu92UCdG4N/gfleW4JONCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056605; c=relaxed/simple;
	bh=F0gcFbyNIeCxJf1KL1Z7gVb3Ii/er9bI52qbI3HrFB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHvA15XUBeBGW8fCXBCtKaZzJl+RxhtP/LIqvfJBWQLjqpVJdZyklY7KnSEYJ1ABSvenk8Hh9PhE+8LhQjFsBOCMgBho6QUDBYW/otJgZcScjRd+VpajgX1rjfgmDOr2Noh8POqh3jI1AOoNFeKVcpSUTCPcdCgiS/SfSnbym3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpozKon0; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpozKon0"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e4a04f059so9807595e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777056602; x=1777661402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2hSohRjeGx5XTtLIeUKSBFxVdH32z1XvsX6sIeIBOk=;
        b=BpozKon0wrOVs3b13BMsRR0rJqOEHsm/QtNf2yZCrjYcH2j3QMplhu9+KdGB2kbbkb
         JVrDtzsHJlXiDMvVqehHNO667f4qx678bBAsebcrQioFMqhT0f/FbMOY7GwIspiEWElF
         hDJ0XSPUKs9t5G8Evs7OjYuK8KMPGQ72yknpSDcK6SFsq3fk9fva3bhEMnWyQaHtW3g/
         O2dzZsYymvfG+N+LS1xhqE4dt72VGKcIr9DCx99Nzl5nlZi1gQlnB/abczsaeLDJEzih
         f0AOI0qAWi15bBguUJDWk4ZiEUKAqyYZ/CqUCCoHmiwHAtRn8vXhjogSEOPtIY6dUzOv
         YwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777056602; x=1777661402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2hSohRjeGx5XTtLIeUKSBFxVdH32z1XvsX6sIeIBOk=;
        b=gFm6hmKZT+xaeNko/1e4DAMAfzhZxHDB872jqBd6oD0mBeTq8n7D8SHN6b+dFvCJbj
         TkGUcR34Y9KcI54hviIwZ59PynEuZSg/ulT2VE6IAYWxxO0QQAmsQSgBqYlHeaCEHqe7
         ff2ZVLfig1clFXXq//bn2CreeZv6ZCwFywY8yqIGOq/MeyYiDEc5d/OPjOly5PZq499B
         nMUD49lyQkSC1x/ElXqsiOtlPE+3Lk3EGFrR5+x4EKKpY3ioEnk8Pphkgpq6KHFZhhID
         hj4871roDhRTUf0k7VewcS7X28TdWcKLHodYLzqgicKnJA3cKezYx4cXcrAOby2j+8ml
         +b/w==
X-Forwarded-Encrypted: i=1; AFNElJ+1i/lxU7zNoKKC90cy/BZD9+R8WXzb25TcrmVDVsgXHa0QBH7cGkc5ylMBqq13nMtuFeX6BGQEFX029om0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7HBqsAoxjE2ssPTWnbtjUnkPxLog00fzwI/sK7O6DMfMZzQZ+
	WbWKfqcqMbGiCaeaLLtnJYQP/AJpJ01HnH9Dg523XlYMjAlx6j8TTApT9MBY
X-Gm-Gg: AeBDietRTS7UuoNhzUGoGkwwjRTH1WS7eQo5s0JahvZgg45L2XJywvM153BxJO5/h81
	vSucnF/RYBVM/AsoNZZ3YrjZRlqeglMtj89PzqnN2Y8GwT3htjkFTTU7cZZi36g3xSS21fVYAUT
	bQc+OxCsA4ONJ+oAcMkUeE/LP5eMr6qPzifH/lyht4msALuHNeRtrGYGpqoFOoyLFdxQJOUtJDI
	RiWSSSs/r0zcM+1m4jIIXkbjSTFPr33Y1/vxTZW/EWg9NptkW2zKNlEsl+URbRRJM09aRBDXMIP
	4iGSZriazFByOvA4nmTTmXcWpW/DEXmbIsdb0scvAv0qMk0unf6gJgd8t7IczIjXQkHFC74YuFT
	SMFSOLoDy508Wih4nzfP6duuFE+YqLP0oOxbRaSzxurR+457nQeZitXJ/YeU6YqnGynSg/enLzY
	/KwUdb+gXd9yWb9qLiHvX2iM0=
X-Received: by 2002:a05:6512:33c1:b0:5a2:b219:3ecb with SMTP id 2adb3069b0e04-5a4172ebf9emr9629778e87.42.1777056602322;
        Fri, 24 Apr 2026 11:50:02 -0700 (PDT)
Received: from p183 ([178.172.147.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc672sm6365408e87.34.2026.04.24.11.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 11:50:01 -0700 (PDT)
Date: Fri, 24 Apr 2026 21:52:12 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	John Stultz <johnstul@us.ibm.com>, Yao Zi <me@ziyao.cc>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: fix comm_write return value when truncated or error
Message-ID: <5587b10e-91a4-458b-a95b-025be31e1a84@p183>
References: <20260424-fix_proc_write_return-v1-1-7a793c2aad32@cherr.cc>
 <20260424035028.a811dd6bc8248b640a9fd7c2@linux-foundation.org>
 <3f91ed95-b38e-4049-b69c-13335b13ae44@p183>
 <aeuwfe6xy74R2qm4@pve.cherr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeuwfe6xy74R2qm4@pve.cherr>

On Sat, Apr 25, 2026 at 02:03:41AM +0800, Shengzhuo Wei wrote:
> On 2026-04-24 16:28, Alexey Dobriyan wrote:
> > > > Fixes: 4614a696bd1c ("procfs: allow threads to rename siblings via /proc/pid/tasks/tid/comm")
> > > 
> > > December 2009.
> > > 
> > > Hopefully no userspace is depending on the broken return value of a
> > > write to /proc/pid/comm.
> > > 
> > > Arguably we should leave the code as-is and add an apologetic comment
> > > explaining the situation.
> > 
> 
> First, there's a plain bug regardless: assigning -EINVAL to a size_t count and
> returning it as ssize_t produces a bogus positive value on the error path.

There is no bug, write() will return -EINVAL as it should.

> Introducing a dedicated ssize_t ret fixes this without changing any
> success-path behavior, the change is on a permission failure path, so it's hard 
> to imagine anyone depending on the broken behavior, but worth mentioning
