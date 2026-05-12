Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95823AF646
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618279; cv=pass; b=gmaRhpmMJiE09UeVNiA9W5jWgBf9cB4bGoGg2AMwSHgNzprEINRk2tpMer9CScrMSwlkOu+wmpz7LKB6ATpCYlj5wxnghY6LrHa2QSgKaHG6S/cB74W+FJ/n4WIgQOzRBmwm3WUaP/GSCBChHm6Hq3dCTZYLFe0bsffKb7iukB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618279; c=relaxed/simple;
	bh=AL45aLj0FrY71o7xvV4NidJyS8nGRh53kGCcVO6QHP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=AUVchTLtGP2jSryuZxVJHSFtO7jPHYTknm2HvwPaFoNJaB5f2v4aJUat3Gk0TvhoMbc4WqmVWMA3DlFYlKui0HQIAJjbO1RFvsj2gVt4HAcre7yQEcM1Ugo2wb2gyspdhh4QHAcfqU6mj/uAJ+2q/G2q3+lASKry1oK7UkIEcRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtDKzFsZ; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtDKzFsZ"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c8d0945b3so219c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778618278; cv=none;
        d=google.com; s=arc-20240605;
        b=Qz9Sdc02/z4FcyupsX759o8TC6HvKsHljHRX40WVbVde+2ERjiw+j5s1uOjMl4wg2S
         IrSFzBCQzxGrVtuoX/vPPgS2RgMzQ7zY0n+HW27hi2P9A9xbMZ8A8HXz4RqF/N8VFPXP
         Iy+R3CEAQRCwKNNy6eKjSYrf5EXSXrUSVIO+8fzvgl7QQx6Uz0UfhYJKs2mWJvyUSUQE
         8nbbLR06Favjmrakc0NeQzKcEKmsY3wyoY2NpeWNyEOm4KqE6Y8WYAqMWCf6EzcIpB0w
         LzR0wCzWZtsreNpTE7R4Si6fSPez18xhit32qtDN5AVqJeNWgvSf/vGF68ZHEzUnu1ct
         6SZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OrYDI2P3+uGuMoKwTVd3FJswaOrTXSNDbhUawVFFcyM=;
        fh=MBoLIQWvsfl++Md0SIFMGIblswyAn99//K2QPYG1y3A=;
        b=Bgj2ZtvL6myj3+CiLjECDXDc06OnRVoG531pflw+sM2TnZPV0kPpFjNvjzaRlzePjw
         co4gqlOsrM2YDr4+hRUq+EVFI7HRbo+cUfR6aYCZAreIp5qyGmaQa9E/6AfbNTm54w3z
         RcKnuWpNlk11fAgSctqRcnrl1fSTFK6NFGSpsT/GctGoZVEBUVk7jo3Sglg7e34r/3r5
         nVUkn8Z78ys0/JQsBDdVXTT+rmGgRZfHcB5C833mchA4BJLmeBalZCZYY67VFY2rBibu
         6ikKY0dPg/tRe06G0kcUFXJGWSxxHX/1O4iK+gZx8jjNZG7Yz5atBaU9EB2o0S6uwdCD
         vzpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778618278; x=1779223078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrYDI2P3+uGuMoKwTVd3FJswaOrTXSNDbhUawVFFcyM=;
        b=XtDKzFsZJIjDq1USKlHJUPh0LPA1SXJ2KpDAxVyVeXuQkpYKxk+JuUFLemmU6YqjwU
         AH2mq8/OkvT8m6zq1vEsDKqCpXngZB/ZEliAm4Vazia+XlTRPsSt2sPnUScu6rWZUN9j
         PGAhQJMI1n3jAGhQzj5i/Nh83heXByYHPhKYju9+Oi+NpewH62YxHZzKRUiAzTkx89vx
         w/vnxiSFMObLx4kwTWtJ55WJIDi3hv8EMsQR97zmqI3YjHUwe397YReSYpZkfu6j4fVh
         l90QjxpPxytEqgE0Y8iqhY6t29E7Q0SA8f+YRGNT+xWWZIr56jCJvTD7MTdoVuzGi8n5
         mSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618278; x=1779223078;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OrYDI2P3+uGuMoKwTVd3FJswaOrTXSNDbhUawVFFcyM=;
        b=Pjw91eYPdPMq9UJBZOzXm+DTOo6SinOwqD54HgIbD7as1t8DMBzlBM089TqZbK7q/K
         jkMtkXKnQ7mR1sfBax3gscL3c+BQ2jI9+ebZ+d6noXpNczh2ccYs1/u64jSqMUei/ahR
         qqQRkGcFdCZuEDbqG/wC9o+CofL1k2XIpRQIQ3l6aX4pCwP+UhoGpPg7FsVWFVCYttwr
         EH48uxIT9lk0nlAjnX8ttMFAyl+vULo38sH/YSmSQ23Dc7gKlwjuvgnOqHv9Ao8xKimS
         vAYohKzWD7vwSFMJHDqb9jRquIybDodGJwEJTu+lL1LGWdMaKS2rf4t4MK19K3+MqO/Q
         +UUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3Pfu2llQcKnO4h5dl/vCjPqMulh9Z1tIUxtaX5cyeXrcd9nY2COyxGb/UD7u1g8wDgVOey5KbNlkqwv3z@vger.kernel.org
X-Gm-Message-State: AOJu0Yyam0udSe9ny1GwTe/bZ8HLO8LXmsixcFHG2ZImtZGJOxepnvyo
	BNsSTqQueV7PJYelgD2Cg6jh4pwg9OAW0WHBAtOoEzJSk65uyjdzDfIGHbilbHBOYS8uGkLmWjD
	ACoHSweWfNjjhdsmqkhmO8AKmLFV6/R2+/icyJ2oC
X-Gm-Gg: Acq92OERnkYUckVKrijVTSBC6lBfT4GmbMqULBi/mKUe4jehjE0XFYPKjc+LjedK6eD
	mizyUeW5GKfBHau4yfNwLqVQuWWXichjneb6I8Oh5b76dcNbIGIeOeb0v18ZHtjJ/Znq6LAPu8F
	pKZm6cU5jRLXWn3yBlj9w7EbqZmxHoTDu8F235XbLsN3n9aL+jxhdGcr/xqFhT0Lu8JEn9wZP7m
	X7ysxvT04quiCT4JeW8xDTlrxGZvXKDxon4tJLSaeniIg6+ICNeIMOemN3cP1rm14KR8R8Egg+J
	vZX6JqzUtq0sl71nji1yCiJckX/jqUeGzdl+0Ku8lI9lwjU=
X-Received: by 2002:a05:7022:f9e:b0:133:12f0:c144 with SMTP id
 a92af1059eb24-133fb2d63d2mt154906c88.0.1778618277002; Tue, 12 May 2026
 13:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512203154.754075-1-fmayle@google.com>
In-Reply-To: <20260512203154.754075-1-fmayle@google.com>
From: Frederick Mayle <fmayle@google.com>
Date: Tue, 12 May 2026 13:37:45 -0700
X-Gm-Features: AVHnY4LUH4csHNJ57nbLZc63OyezIngjmZ0PpZ-8t1Biar5aP4v5cPbOd5gslHg
Message-ID: <CAHCxdc4Bk2DvXB3SE09ge-xyBFQDcA0AdSN38dYUUiiqUd0b4g@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: document read_pages and simplify usage
Cc: android-mm@google.com, kernel-team@android.com, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a combined v2 of the following patches. Sorry that I didn't send it=
 as
such.


https://lore.kernel.org/r/20260508015402.735441-1-fmayle@google.com/
https://lore.kernel.org/r/20260501011908.3630802-1-fmayle@google.com/



On Tue, May 12, 2026 at 1:32=E2=80=AFPM Frederick Mayle <fmayle@google.com>=
 wrote:
>
> Add a kerneldoc for read_pages() to formalize an invariant and then use
> it to simplify the callers in page_cache_ra_unbounded().
>
> Frederick Mayle (2):
>   mm/readahead: add kerneldoc for read_pages
>   mm/readahead: simplify page_cache_ra_unbounded loop counter reset
>
>  mm/readahead.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
>
> base-commit: 972c53e0ec3abfc6f5fe2cb503640710fb23cf95
> --
> 2.54.0.563.g4f69b47b94-goog
>
