Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072A49F139
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373593; cv=none; b=ABxoe57pO0ArUFeDs/gHmOZZMJQQVEDClpoWL7D1x97kvBiKSQE9ZDpYQ5Y6zKFIJToMga6EzZg/ZxwhinuRZHLxeqCMp0a5JjUo7cEmqpH/8ZfQSTKIhsk0byF8FgDDMR0iMm4uFhI5hpARd4yQVCHoUNUGwrZUbz7Lr5inOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373593; c=relaxed/simple;
	bh=70OW5ShH/kqO2yK+u932q94LT0CG487EPQmNfC7PiGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwIJIuK2FXewQeGBrohDhOIm6ZuiOxMfnxjYK7/rqFeFdk6lACOHBzn503JHxg896yep/+pkZvhmsh020MVWbl6x1gmFsFXDtNAQ638ltPRsIGvwwRsN9SjVdqTurJTIwPDMYGmc539jNDpJYUjhG12wTu02mo6lhoRhLzOdIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QI3g4JYq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI3g4JYq"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1193693a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 11:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373587; x=1788978387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x8T9r1V4Fm4dLLkn3wT9Y3iOMgRpVRxafH+zo6DqTKc=;
        b=QI3g4JYqdukT6t5dp7WrJfdLnVcAMQofmXy9zdQE5Bl2YA+zbQHHNVnjyTlZ/wczzh
         F3F91+s9Ab42Q18P7xXNYtcBTBgovSEPlWa7alaOxNSD9umHNIMW/SbygIkTXRko88FH
         ltO1Kew7Ni/8l4gJ6vc8uzWLA6oSA0Nsu8tDiKIuEI6CSi+6HcD22mfOr/Efa9HJCxr6
         O+eS+y0yEvLlQrMJ8TvZymXwae9aOoZCBbL2AvE7/FGPBNil2lrWLPpMIdiU47iTggRv
         PU/2klL+m3W8dDTqks3h4JT8ujmYFyRGZCN+8M7qNQ6rhgwvow04f9henXV8KNoS4oPm
         E37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373587; x=1788978387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8T9r1V4Fm4dLLkn3wT9Y3iOMgRpVRxafH+zo6DqTKc=;
        b=AXmDfCdmX79c/PrqTvyog89HNoTJL0Fwh/shiv8nHEfVInAfC+feHtC3SDoXC8paLx
         GTx+QnKg7SWB4zgfE+mbAiEibSdIz+0BD3zy3LzMIkMqmCY5NlQSP/+MmaweL0aL7z2l
         gAy8hw1Gr28qEf80eB5kHG9K/m72WXMA2dKl32rvxykknF+S/QFPClC2G6YtYDd19FHV
         SrtaRQ140Tx2bVYKQ3U0A7UAZ++Uy3Lki5Yn5SjdJMGwhc7NSOc9m2rOtOsjAhquAqkg
         FE7T4MjMOK+47RkjFrGdC0mboZ7MJgEfXMA7lh029BkrAvIXhULIIRPU0Ncr4+zU4UeU
         3NOg==
X-Forwarded-Encrypted: i=1; AKwUvBxUur4107B0kKL7NQpsLBfiURlXq3Z/JLFrpuYzVa7RLL4t/GHfoFpuGZxsEgyQXs1o77Tdv6MqZZPnVURs@vger.kernel.org
X-Gm-Message-State: AFuF++lerasHb4C2MB5HeeBez0bZ3seog3LzfNjH0jytQfcZB+Pj3MpG
	2mRL4YPCC/O4wpRfeeaSzcnheROIgNqdhiknwqFdKBV6MnTIUchHyes=
X-Gm-Gg: AYBFou1MnZstsJXBV7pVG0oL20YCkGacMl0dPaQUBo+nYJrTzrDOV/j/iac1IWJkVmp
	Lz1xIrCm0GGyN22e807BpmQdZJnqXGflfP1l2fZUJfw4Q3KHUv1xwUgiuf6wfn3vd/nGcWzSl3J
	OSw9+KO6+1uZSzYNalKFKf+sC2mPi2dpoDAekmvc3/DYWbBMLUIsJvqMhVQYKoNWmnxD4ritVEZ
	iHJSo9tpXt8LWIzs6bgG45Qja/2XvhC1dB8Ya/IWjyKnIYLyz/lvBT69POU0kwOhwQ6m8tWqW1p
	oteEtthVWt5Vgl9WJu26p1hj/++ANUR/B8O7P52FUfZKDkRQQ29lOmfuT+993PU3uY1nW4npOIA
	3l3pH0Xin2VI3odzt/HNXNDXd4AQcZdOULccDuqw0HvLVojls0YywN114XxHFhpiBu3JqICkOig
	doLv0s72o8Nu2NM2jK6s5toLJ8F8vz0zQ/w0uxHDMtmWaq+euvdlr3xN9Ct0wsbu9oZNSlgtfWg
	nbMK/wwmsG7pGQ/PwJkXCSW1ok=
X-Received: by 2002:a17:90b:5288:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-39aedfbb2b9mr10243473a91.6.1788373587474;
        Wed, 02 Sep 2026 11:26:27 -0700 (PDT)
Received: from anuj-MacBookPro ([2406:7400:63:f76b:3efb:3463:cad7:ba39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430ea2d3e7sm15195061c88.6.2026.09.02.11.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:26:26 -0700 (PDT)
Date: Wed, 2 Sep 2026 23:56:19 +0530
From: Anuj Gupta <anuj1072538@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/17] xfs: add error injection for lazy bounce buffering
Message-ID: <hvosc4jkifetywtlktfn6wepezuckp4hb3qlctq6xqoq5glh3b@ri7b6u4r5eod>
References: <20260831064010.2574896-1-hch@lst.de>
 <20260831064010.2574896-16-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831064010.2574896-16-hch@lst.de>

On Mon, Aug 31, 2026 at 09:40:03AM +0300, Christoph Hellwig wrote:
> Add an error injection know to exercise the lazy bounce buffering

s/know/knob
 
