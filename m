Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F4364951
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017490; cv=none; b=Ip83iHoujcQPQzxzQakgmPegPayJLn1ewB6pFDj3HmwcD70qoAGZfhHlHlVEFGTgl+0dsDwQwqKIcZtRvOfTAhw6t9wmmAaclc9kKt5GzBk37RRFfuJ64wBf5sCUqPRlTxsrCVCYN/VGPN4OUNTukcoqxWhwx8qWmKVvty5u7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017490; c=relaxed/simple;
	bh=bLydxsjElY72N1viQaJTMiveNAFO1Y+mPy295sog+wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urhKOau6sPu1yyJ6BdjpioHiY3W/ag+2XncE39xg+G9hMYRxtDvfnvXL2N7PKMzBdsa2kme4yA8s4w1ECDZ8UxFhwMJaX1aMR2R7lT+ttBtiZ8SVzEwvmsnIo3PhIbPMDWsBldkNjivPuAjJ+5/bgJaZ4r4LiRH712skZQW+Qnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=HI24HYO+; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="HI24HYO+"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb3bae8d3eso176603085a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1774017486; x=1774622286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IrYGBaCqeFK6sS78naoBvFlPLrxLzAYh6LesIJsA+lQ=;
        b=HI24HYO+c1vB3dvA8XpMKsoCuwhrk0AxVVAnOr63xvWVSx4xcSapzAQkIqWmppUPE2
         4WOmPk0wFSzLPoCWTJke0HST05lcGSvuE+cBIlZGoEaucQQcWODprCQRGJzKimB7Vg9L
         rTYRFpcECB0nYm1zqu5Kq356mRohW3fVX5ZCC50vXXlOEBQXwVYleTAo1jI2SW1pZnDs
         tLBzrJBMvJuqX8v3KhYiXDqQk2nc0KMRwX5UfoiahXQgJDkQUj3ms428/iEyxkY+98Ez
         kaVNpgT3rKs7WBTH4pwxK0e55YpdRuwOC9Nh0v5gbVkcXv+uBDkVszqrTd97bk7Jswdx
         7FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017486; x=1774622286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrYGBaCqeFK6sS78naoBvFlPLrxLzAYh6LesIJsA+lQ=;
        b=rFHxjn0YJXWB5dWngFDbJdfYVVX5lK+9OIjHyxRaOQKpIqiP7o2We26Eo85breOJvP
         N/4711ZvDXrBRK3GOaeCehwz+C4s0J+ubVfGEZR+izAdNlV6HF9HY6PgLCgVoY7xJE8c
         bVwONCtveibcsIp5dBz0ZOQ9PUkUX1kTGiOdmlPgxJ0XiO5CXQMgrL9bx+tYBr30OK0r
         BelVVqWZsuEonXHkXKL3NVsANiJnf16ubFZlDKHpnMOkC/9Cp5bf163wr57c9fwesRPZ
         +07lf7LC/6LqhG5CdRuZnh0u719JEQotyciFMQzUp67iV1szPVQ4qlnnzJSsYYXZKpDl
         TjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpNVCFeILa4R80Q53V11oNezxyunBui0DIE2jjrC3mg1exzdlVKakaFKYxEJwxbl0d6W6tZz0X3DwsLxxX@vger.kernel.org
X-Gm-Message-State: AOJu0YxMC9+0yPX3tXW0TlzGXnJvRZHHK1mnL0Ki48bjcTYyGYNcclwa
	YRr5/696OoDo7ezVM6vAWrZHgx33KSlq4tck9hEbUpnjYbakl2TNOMCClphTmwlTOc7j4T67vYU
	5RrPa
X-Gm-Gg: ATEYQzwMf0pIvGNfIWEntB3cv0k0uZi73s2rNVy6v9GzFhtVlEK78hIHEow4v9igVaQ
	AphT7EWxNARstm082EnVd4e/R+6kub2MIVRg8t56Pl1L4wANrUxK8tZAkLjWDdGE3aQDugGUkG8
	uo2PuR0ncNAt8ACW1iqrNdbk+OlWZeyagIX22sHfyRm2GBOlweyRHSt8LnNbDA7EGKRtXe3kTYN
	UHoCSmPSY+W9bZ7mLDC1SXy4tGPy5Jyp3OBfzycPqeUzUqVNBbjRuGpvzdk5wkzgUfe3YsCJXcn
	VcBeBIf43M/YNmRN00HXfZZTXHQdZOGKsF/WzBvNr/PQK2u+w0kqOF8hUtOEPnKjWKxsy24+Ant
	+9/P1CSborjsqJGZ0WllQ7fMv92EUcaLpdSu0J9MYmg0RCnK1z3+mOMB6ARMUlw7alWeitRqnAR
	bWeMAPz0n3OVmLcctEoGWhog==
X-Received: by 2002:a05:620a:2547:b0:8cd:c011:dfc1 with SMTP id af79cd13be357-8cfc7b66345mr471071585a.5.1774017486070;
        Fri, 20 Mar 2026 07:38:06 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9089bdfsm176182585a.31.2026.03.20.07.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:38:05 -0700 (PDT)
Date: Fri, 20 Mar 2026 10:38:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Jan Kara <jack@suse.cz>
Cc: Yunzhao Li <yunzhao@cloudflare.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Jesper Brouer <jesper@cloudflare.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: balance_dirty_pages() causes 40% IO PSI (full) with no drain
 benefit on 384 GB machine
Message-ID: <ab1bySbmeidrQfoN@cmpxchg.org>
References: <CAAnvDSwOoEOkMEDgKUcHkx-SdmZ_ar5AbVy4Gp-XT7i04ON5fg@mail.gmail.com>
 <z3quejtbpkiizgmvu2pjhqv6ioyach2wszen5slkau2hossj7p@rk2ftlwbdfw5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z3quejtbpkiizgmvu2pjhqv6ioyach2wszen5slkau2hossj7p@rk2ftlwbdfw5>

Hello,

On Thu, Mar 19, 2026 at 12:58:51PM +0100, Jan Kara wrote:
> On Tue 17-03-26 15:53:51, Yunzhao Li wrote:
> > 3. The freerun ceiling gates entry into the proportional
> >    throttle path. Even moderate sleeping shows up as IO PSI
> >    (io_schedule_timeout is accounted as IO stall). Dirty
> >    never hits the hard limit in our case. It sits in the
> >    proportional zone, but cumulative PSI from many tasks
> >    sleeping short durations is already 26-40% (full). Should
> >    the throttle path be skipped when sleeping cannot help
> >    drain?
> 
> Perhaps bumping PSI when dirty throttling kicks in is not ideal measure
> (because it doesn't necessarily mean the storage itself is maxed out,
> besides flush worker not being able to saturate the storage there can be
> also various block layer controllers arbitrarily throttling background
> writeback) but again I'll let PSI guys to chime in here with their
> opinions.

What PSI is supposed to capture is lost productive time. IOW, it's not
about device utilization, it's about whether tasks are being held
up. That's the information it intends to collect, and it sounds like
it's doing its job.

If you get 40% IO full pressure, that means during 40% of wallclock
time, the only / all runnable task(s) are waiting on the IO resource.

It *is* influenced by suboptimal device utilization, but that's not an
accident. That's a real cost experienced by the workload, after all.
