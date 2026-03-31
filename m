Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7643E9D6
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979426; cv=pass; b=WDVfwjFg5KMPjjUOq4tltH0VlOMB8z10Sh5OWxkhjLGMj40Nx6dLTg6Sil0F8THmn7FJAcBhTGdWVrYGKcfv3Y5ZR4rvo/ZueRz3ZQadI600mV2bC5rxRUZzpB1+q9b0zZa7aLA4GDCA56/tgGnVhiLRqBztbcKepFswgrWXcag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979426; c=relaxed/simple;
	bh=vowOFXfj1KQIdKnk1KHHCR1AWDIPX+2hhHcMYLTonco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfixFJTq+xM+q4G+R7Jx0jnxwB9lkZhS6m9teW81qA8kjPZErmJ38G8lnkU3vxXRpie/Z8rs1tA82qL1zlIeA/c/W0g6YLJQJaKiz2rDk2NcOBFirjR9P1apNxf+tsEs2yBpZjcv4qkvfICNC+X8A0bqKiKq0SA39LPHoo28LeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwJoybUT; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwJoybUT"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65005a8840dso6973167d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 10:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774979424; cv=none;
        d=google.com; s=arc-20240605;
        b=TBdMSa36jm652ernsLR92kl3sEMh6YyQM6BrbNRlb6CtwanaOoboTdy/kETvYWyRiv
         G2t8j0PeprMXLM/iqo4qIzEx9GIQm+XisbUiYE1o9m6vFwsXD42n9ts/1dXIB97VRpZJ
         m7ar1/BAnEXqpjHp9cvFmSKwyxApPHBUBUNDdruwRU+lCSK/kXtm8ffj09WMalEd9Ty9
         Es5QG2rn2w8ivrkAH1VyqME8j8xdPlXEOFzD3xONi6vOGDCTZJvpTHiN+KAPgXDIRWSO
         wRa9SXsgVEX+6/LuDNZS2yrH6S+lCWXt/pORdVNlYTyJwTXo5Sos7DwvhCVftNQlh/8v
         xAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lWv5aQqtVP3yHvapSEezFCdVTMYfWG7NdlcvpRIxSq0=;
        fh=5bhRuxoJIja/h/zhORh8+sVmYAcCsLmYLlcU4h7JaJw=;
        b=fXohG9cbHUhjV1Vbofn3RpNq9bHRA5jHj2LA/snd8CAutft8xvZKUFOrUByi6yHtlB
         5/UhsOeOqtCjToWbQHu2imShBXv1bllVtmQRrvy53+kGZPJ8i67lkCtUwUosB2zy6n85
         ygSGVrcCmvU052xnFF1vidU1SdbxSU11q4DeD2VuG3ZtG4SmBJzP+uBKHYE1kkENp70Z
         hyBnu8xekkXbmZZ2V4UmdU7Zz9drNBMfhsGGxrzgpytiSqTNzwFsEH47SN6ovTkaB1oF
         f73T8jokxzgZ+l1Oxpw16ior2G59o7GwsCANJBNVXAOlr5mjah/pR6s9jgTKszZUDwJj
         93ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774979424; x=1775584224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lWv5aQqtVP3yHvapSEezFCdVTMYfWG7NdlcvpRIxSq0=;
        b=bwJoybUT+989Q/lVjmbZLxajrydQB6CRb5ZHoCh9ff6ebJ+rhY+lhBP1WpgiQWnpmW
         6JjYL7om50MKdwIwrSPg/DwQGqgUZe6uXx2l2UJ/T/1GGw1W/lHDfmYa98StoyV/Z+Im
         cPFCLxXPxs+1SBZ1F8nnazXeGG1x3ihStPtUxW1QE4eYUhzHjhdQXvddlWeTvbZJy9NB
         jdTXrcoiCcTgQetLxZJON4PlOMl2Hi4gMcGl7yl6c++mhKkBS1qpoXqmY5nFlYwypPf6
         /92kR+L6vB36TfMwK2tJFm+qRgQdVEkmJxmVH2Pdowvd/prWEktgaBL6ncxMHPMsop77
         xWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979424; x=1775584224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWv5aQqtVP3yHvapSEezFCdVTMYfWG7NdlcvpRIxSq0=;
        b=Hh+GPIBKu75BIXx+y3BZidUxqpcohc6Qw8mAbnl6FkMOQKPxQ6c8cjC74mWN9TH5ta
         rA5d05xc93Uea4MnOWLv4c8h6lPDsQ67M7Z6e96PV+TbCOUF/4ZM6MJofWjovNnvr6nf
         Dc8RE/46Ws5vC5z0pUGIBxq0/dkS11chShBLitiZFVANdv5fArpKVhsbh1R7Uan0dNF0
         sU0ysXs4tu+0UWlRdDsouDjvRhMOfSxetzjow3mawixdb5/5UHAnUmqWMI/bnrecgrDe
         HE6MfSAzCLWN5xJc62KICb9vd9aCu6tdPDx2TvH/XoDn23O9Pe4J9P7kNaGBXX7hR7HH
         9Axg==
X-Forwarded-Encrypted: i=1; AJvYcCUomGsiTPqeHOVZj7vadc/XkhIjHqGUT+KEiTC7dHz2iKQJGKiLF4egX1xIX4DLD0/4dffilLDqcCwshs/f@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOFxzNlj3M3sIjacehOIPFIhaJ4j9sn+s6+Vs+0w4c54ZVuCP
	uKiC0yFHVyvrTti9BRn4uKni6WK5UK3zSSv/EL9iSJIFWYa3ljciCeneYUgpkgkWskViG3yi78G
	FKqQL/0XjWjS8nGhVYtcaa8QWw7aFWVM=
X-Gm-Gg: ATEYQzzk0tO5UJP7TzsI/R47qzqCnGPCewZHSHAP6uGf3ZNrBa7lfwCaWF/pG3Fmk73
	QESvH6FS0jroT6zvu1qwBRwskPVwVRCwSXW4P9CvPlfIFqTu6SrpYabZ+jJSOySBqP3TlxjLZn0
	c3/DtHqBQINcbj2bGVjeoHUipURn1igEX6/0YwaRXT7l9gpjIMoxOqbepdJQcvKm6COO+knsHuN
	SnHWDdN087rZBo7lC0WGuu0y588z6FO/c112O8FjFyIUCXI0Rcr+Kx8FqEWj6i/h4dUMdBu1YIX
	KjeKhR4Yf3vL3H0vBJRK1O8rb9YNnmjUnmNMAT/dAw==
X-Received: by 2002:a05:690e:4395:b0:64e:a765:ef82 with SMTP id
 956f58d0204a3-6502fdfacf2mr135696d50.24.1774979423761; Tue, 31 Mar 2026
 10:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401-dynamic-dname-name_max-v1-1-8ca20ab2642e@amutable.com>
In-Reply-To: <20260401-dynamic-dname-name_max-v1-1-8ca20ab2642e@amutable.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 31 Mar 2026 18:50:12 +0100
X-Gm-Features: AQROBzDeFYey_YKrvSEEPOQ6YayGDF6J80JR5XQ1X3Amq49nNLRdJHtcx0YdCDM
Message-ID: <CAMw=ZnR6iUW334c0yEwmawBmFKoFD4smOC7G3s+m06MUdyu=qg@mail.gmail.com>
Subject: Re: [PATCH RFC] dcache: permit dynamic_dname()s up to NAME_MAX
To: Aleksa Sarai <aleksa@amutable.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 15:46, Aleksa Sarai <aleksa@amutable.com> wrote:
>
> dynamic_dname() has had an implicit limit of 64 characters since it was
> introduced in commit c23fbb6bcb3e ("VFS: delay the dentry name
> generation on sockets and pipes"), however it seems that this was a
> fairly arbitrary number (suspiciously it was double the previously
> hardcoded buffer size).
>
> NAME_MAX seems like a more reasonable and consistent limit for d_name
> lengths. While we're at it, we can also remove the unnecessary
> stack-allocated array and just memmove() the formatted string to the end
> of the buffer.
>
> It should also be noted that at least one driver (in particular,
> liveupdate's usage of anon_inode for session files) already exceeded
> this limit without noticing that readlink(/proc/self/fd/$n) always
> returns -ENAMETOOLONG, so this fixes those drivers as well.
>
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> Fixes: c23fbb6bcb3e ("VFS: delay the dentry name generation on sockets and pipes")
> Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
> ---
>  fs/d_path.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Tested-by: Luca Boccassi <luca.boccassi@gmail.com>

Thanks, works nicely, tested on top of 7.0-rc5
