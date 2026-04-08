Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7A394478
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685375; cv=none; b=p3AUyywsoSkixoLMSXBK06QFHJflkZpq8/808rJq/OMFnRDd+0D94R8fH17gnLQtojGPYUsoLtMfyYgN0kfIWP6waJ+90ukTfkR38vr755S5S0HxkzuobH+yeWqsdIxiJ8BuLVecAZQudr2n5bop8ctkx+pbDjFZVqE0Mi4mSiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685375; c=relaxed/simple;
	bh=m/RIsCZ6L9sAmGDRZI2YbyVGhDO+TzeVpIUyc9KH1Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxwKncmAF7Yl55ZJFRfucOnl0SmvHn7+C6xR+O1nok0xjJ56YYiJqz3GXb1cRQt1KSKqzkyPFqdts9YksF1Yz8eo7HQ+TWFn6++fJgzveQg9FZKwU5suqOEOKWIDfLwff+cvn5hob61dQSagIVwlok98IBpGvFq6rUsyj7YCn0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WbZlpVdA; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WbZlpVdA"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89f1e767f92so2279366d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1775685373; x=1776290173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qndnJttoApFXUO2POEtVDoUfAMGPbRgoP3C1nGgpeNw=;
        b=WbZlpVdAVg4/a8k/okNew88UBd78k8vdw7AVRhZqFjKtpHP6glg9FH8DkicHFEBmmF
         2nYUR1Q73PV4hpYYaPyu9h54xWwfDieHsPxL/R0T1L+6Em4TvpLU6kbf9T+9L3dAURQP
         0eu7WL7hcsvgCIYmUefP/zQ/QokOisRWbeJkVWgICBCNaL8PsB2kFpDnTFcHCLXnUfr+
         byqTf/u0Nl+G09hdRbyXNH3zB8q20LOqdLmMycWdyOBvWiFX2aMR8InXpkEI8Oiwbwc6
         BiipGUfAJGI48xk24nwOgZBkAlREFXVtEqVCXBcrSohYiyzEW7Siqp3qZPTQUnT/mrae
         hCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775685373; x=1776290173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qndnJttoApFXUO2POEtVDoUfAMGPbRgoP3C1nGgpeNw=;
        b=r7JrZUvrIOWl4LXcRxCNOfahIDKVFohI9s8Np4jfRKznhhHUvl2ceU1magurRGg8Ve
         T6Meer3AU1pQiPTIrulm7aiNACdBBYspSmHpGW9IQCHrbpIb6zRXDT4wURJKhpCr6jc6
         7UKmSzwM2L2V2+dfJ761gVNlmqNHQqffdUf5gAQbP3VNpnNEVzXvdzfHTZYtchAPdpnB
         Y5bbdsyxI6xaBBvDTv6+Y3JW5AzGrhHiOETOLMuLrBz9J4tXUMYP9z4MmNDfqPpkKMLM
         PoQk84Q9B1EJIenN9YN0q6elW0ZUrpsP9J21S6Ao8A+5fpkyz1aIgoJx1ude4+TPFZ4w
         CLtg==
X-Forwarded-Encrypted: i=1; AJvYcCWMeKPipTqS8axC2ufU+nBvQ9fZynYe+pOLd9KL3Bs3ylUEhA4NF7JIjiMe23ICa8+JPVzukSc5tfcmNgDZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyB53Ob+c264tGOfTjq3R0YwlKpdSoYVh7maU9Ea3heLXsmKUKy
	YhzZmtXjdNIgvHRnSna0F6KH4G10Ol/puLWWH3Q/Usf5mXRMYb8iPlQoZPrBDxR8FJoeP/PuFKh
	0FMEw
X-Gm-Gg: AeBDieu1Gj6VG86tcSwDKHjxnfqLPW3wwax6F0WJYxToOw92cMwbwqnQVeFf/d/ohfz
	5yKJTwn2ckR8VTRrN8jFZi6PewwyhKs4mKyzpaT01rRMtOV4hwaJKQUh4Qfga3PVqBVMWpS8F/q
	E9y0quRL3YN4sylDc2hxgc2vQ3zzNOjKsy4vpBAkRozQ/OemCAB0n4bLfwRfDBffDPI+YQv8PNa
	K5hLkc91+aO4FI4KizTWtBFuj4EmNhTw/bYt0iBxlChZH8e3LwIZx6x/Hj6ljKd+b5PB+CdfKPU
	gJQh2lP8X/2ZAivJyK28p4SoMDjPNd5b7laNvmmw242nbT0I94uwlRdsQGYtaw77V+xfT5G/4Bj
	yb+sZaI8xWkTPC1rycjEjyfv8dg0iUJdGs3PMilRp4yG9xWezz117TaaexdQJcYkxXieaZvET4R
	nLKGGAhR19/eeaJj9QmQhyeqP7jvpiaVRP4C7J6IqybQnYo6D4kiSAmvAfiijM3E+LteCOLLeKD
	lrzlg5Xx9bF
X-Received: by 2002:a05:620a:1a11:b0:8cf:d565:fca4 with SMTP id af79cd13be357-8d41b8df4ecmr3283687885a.3.1775685373060;
        Wed, 08 Apr 2026 14:56:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5392d35sm1601280185a.10.2026.04.08.14.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 14:56:12 -0700 (PDT)
Date: Wed, 8 Apr 2026 17:56:10 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <djbw@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] What's brewing in CXL?
Message-ID: <adbO-tqwA_MJ1NHW@gourry-fedora-PF4VCD3F>
References: <69d5bf0ab2210_2b3110036@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d5bf0ab2210_2b3110036@djbw-dev.notmuch>

On Tue, Apr 07, 2026 at 07:35:54PM -0700, Dan Williams wrote:
> For the summit I offered to organize a discussion on what has been
> happening in CXL since Plumbers and a summary of the monthly CXL calls
> since. The session goal is present top challenges, address concerns /
> questions from the room, and perhaps introduce the CXL topics that have
> their own session later in the day.
> 
> Please do comment, question, ack/nak, or add to the themes below to
> highlight interest and help focus on the few topics we can cover in the
> limited time.
> 
... snip ...
> 
> "CXL, making MM problems worse since 2021..." -- CXL subsystem tagline

Acked-By: Gregory Price <gourry@gourry.net>

;P

Obviously I have interest in this space, and the private nodes
discussion is semi-orthogonal as I have been applying it to non-cxl use
cases - but i do think the framing of it replacing some DAX patterns is
a decent one.

~Gregory
