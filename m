Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC521507F
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773098723; cv=none; b=Z/Ia/fWRIt5jDSeTNg5/H1mBsv3eXyPtdt/3qObbQyPtmY1rV+HhecZPQWTksZ5Lvy6Zrck1rCjUcgjpapzN4QxTwDFlEXahKuoebMksvC3Ck83X2CA+KJXGyunqzmnQgU2oPBJsxWFfIFJ2Eu11l7+ZrxQFRR817cW1ufOROEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773098723; c=relaxed/simple;
	bh=kYRhnI5zOl0eL4LaPPUZrdcsw0J3vVgADR93bgDflY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I69jwEDGTsZnjTzcVd9T7eW6/7yF95CzBzERu3FmHrE/sWggb+YDqe9f6KRVsYocQsKihjqS5pDXFZYyrj0U7+Tbc9rf5x/oJo9RaZWjwNiPmgvHTA5EMmxwOCKf9zqfGfhoJyru6gqGNbw2jSkXCbn3MjmIIcgO4l8uymRslDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJTKHIT6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJTKHIT6"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35691a231a7so7589803a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 16:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773098722; x=1773703522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Rul9euUSY1VXyT4m6rmdkDbgLWpRqcvC7DTDH9ZQ14=;
        b=aJTKHIT6nSJNfJz+FllF30gwFvFYbNe/WBmhicod+sBVVnoWkZPtaOpDyZZZHCqRT8
         WFfz0m11TwbmdmqSg6Q1UL8ACslKkXP9t2FnIvgJn1W7QPx5gRRHuuyVWdg/77FrvI5m
         lYDH3b5p7nYEUPYRbYd5z5PZzAUkK1/GC571b8h8/F8O34hHN5GPNwAbAqzTQM/lHjG0
         AixasdIEG90+rH7ATKPbC7CLGItjAA4tTamTHFnJgdXoiij7rCSdfjJgrrH+jcfekgvo
         0pysYoDqu/efdojMzudgIruHNYtVkNR4Es9e3LuMZiO9Hy+GtVwZ7da+KoOjnLug/4Mw
         Od1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773098722; x=1773703522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Rul9euUSY1VXyT4m6rmdkDbgLWpRqcvC7DTDH9ZQ14=;
        b=lVw1VdN6meZW1fmecOPUXmscdbzjHk9JX7Zabl+4tgY/+TW+ScqqSiVDzxOKHk+nb5
         E6YtAk9FTKazPsN8P2sPQIRl3OCS22/rhBBXllA55uXPcZDFXujCvJV00z9ctQMHms09
         aHSs+uUVKrxusRz4/F7C2OTkvqvudvQYzi1p7Crf+pMH1zWrYXv5kCpY8Dhx3pIGo/zS
         7iYR4FKiqBA9w3dOlqHcnBJlTrehUEP8yD8FaBzu/7mcraXzYbgfPyiCXFgVZP2LUZTe
         DAzG+VQfwBBPPAyiCJWul1++rdf/DQQ9m7Wv0l2vX9adRVcEYFNzzAX9NkciuRVGEwHa
         gPRA==
X-Forwarded-Encrypted: i=1; AJvYcCXljN6hRhi7w5FXcCwPwiJ0CW16JJtVCWmdDkiT3NxAlBWD1PbCgVDFXef5UP8J/JtneLdaEI7nW05c126B@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+/DNJY2mtasBzT+J7dwcYH/5mWnGtvsGUrXDvP+XXZniXY5i
	t0dwq4XvQEY4Q2jdnDyVSVV9QKBbLLrlRjgzVq3bWL27UA5x1Xju732D
X-Gm-Gg: ATEYQzygJSfgTBQvboMDzKqVfrCQcvHZ4yRuCS+dAyErLYOUT0zeiJhzYNYSfDsnBVd
	VVSmAYm6FH5ljqhQ241df92I1aXI4CzFRvVPY0HdFNBk3/g5IejESJpdC/bvNIm5SbeQWDkHkXR
	0SkY3S9NYoP+oFOYm3CRriwTxosEHBoYM+J/LhdWP89fapCPdLbLFlMiMrsJT/YnEJb+mfR4ytT
	izo1M8jtgt18aGkkFFvFKFS9H0Q6YarBp5qF4lLnCwOmqpVVz3fW2157OYss63w7+/K9fEekyD6
	BD2XmLKPTaWNdhDhvgwbnJYmS9BzJfU9liUK7/HA2qf3MAbNK4GkGjanWAKXtrZw8AORnKjxCca
	owVOLsb3azFFvh+FK1kRRxQ71z5j4/F6Sj5kK71pAtTHXgCrXiHSG1Jlb74xl84xZSLQd4EPYZy
	CxgvER3O/HUotbEL7lxce1TSJa
X-Received: by 2002:a17:90b:1848:b0:359:974a:b73d with SMTP id 98e67ed59e1d1-359be34aaa9mr11232807a91.35.1773098722147;
        Mon, 09 Mar 2026 16:25:22 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f110991esm592991a91.13.2026.03.09.16.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:25:21 -0700 (PDT)
Date: Tue, 10 Mar 2026 08:25:19 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"cheol.lee@lge.com" <cheol.lee@lge.com>
Subject: Re: [PATCH] hfsplus: limit sb_maxbytes to partition size
Message-ID: <aa9W33RcQDDalfNF@hyunchul-PC02>
References: <aajObSSRGVXG3sI_@hyunchul-PC02>
 <532c5cdf12ced8eee5e5a93efe592937b63b889d.camel@ibm.com>
 <CANFS6bZm3G9HA3X5Bi2_KGZDNGuguQzG44-cMcQHto2+qe_05g@mail.gmail.com>
 <e979abaf61fa6d7fab444eac293fcbc2993c78ee.camel@ibm.com>
 <aaomj9LgbfSem-aF@hyunchul-PC02>
 <f174f7f928c9ee29f1c138d9ca1b23abfbc77d0c.camel@ibm.com>
 <aao2Ua94b16am-BE@hyunchul-PC02>
 <cecaebb4c333439ea6e10808908f69cd3f3dbf95.camel@ibm.com>
 <aa4ZxJ1Lkk_9-f-C@hyunchul-PC02>
 <32997ac487b258aa219c66d870eb3fad71bb9de9.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32997ac487b258aa219c66d870eb3fad71bb9de9.camel@ibm.com>

On Mon, Mar 09, 2026 at 07:47:53PM +0000, Viacheslav Dubeyko wrote:
> On Mon, 2026-03-09 at 09:52 +0900, Hyunchul Lee wrote:
> > 
> <skipped>
> 
> > 
> > The email is getting lengty, so I will try to summarize the
> > discussion. :)
> > 
> 
> I think I would like to see the second version of the patch. It will be easier
> to review and discuss your solution in the form of patch. Otherwise, our
> discussion goes nowhere now. :)
> 

Okay, I will prepare the patch and send it out. 

> Thanks,
> Slava.

-- 
Thanks,
Hyunchul
