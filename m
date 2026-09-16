Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7778136C5B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562825; cv=none; b=UQW8LMfEn8X9EcLQF17FUw990YySMTJdvAj7fiu3Jua65wwVRnt3oiupVlOI7oTsPWa9FZUMS0tH8XH8dyW6tRgUP8Kz3rsZNx2V/5aJNs9VSmIAtdntyhJ1vc1Lv+Ov9MkGGsiTS3+0oAErQ03tYN7Bi/NP836MNMcOMUS/06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562825; c=relaxed/simple;
	bh=mvh0j17bP4ZxH1uTxYP6X2KgmeRwOrDRPqClmWpV2m8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsofCWXQ7QFym7tQjVzL9k31aXLYYO2IeXdVuzvQMdlGORHltMd2gnAsLBogOdMmJBRcIKb86JY210beeFphJkAEgiUO8j24ouS6lf7ooEk4aQszqKucxknPi3933owYP2I/Qebqam/lQdc69LBj0HIofgnk7IHAZPC6c1mrIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwVpWY5Y; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwVpWY5Y"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f62ccdb1so285146f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789562821; x=1790167621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OvBYQo4TN3EsmIXlY2JV4QPHccIJn3dUvY6VvRLAt+8=;
        b=dwVpWY5YdxuH6Tzhg4fl4Mj/rAU6q5/E12tfhP6+rrk0zSalshveTNYk9YaweKegK4
         EVF9IlcrJnpD/LNlxy/GlifMYlRBG1LTDb32xaAYYUQaJ26wVvfcuUPLh5qWVuy9bjOf
         0WVExC3Y8wVFGEWXd881jYgod4NingMLXAc6Hdo1W6KLwwP7SdY67sk6tQMx/G4eHcpJ
         936BPvA2l45aJBt3DHhpH1YrbzMjMB1javN6iY6PqoqouduQX0S4vdBwD1wvD5MJE3Hq
         DbeAslsPuIDFWPitZyWTSkGoe66JQpyUV/aWYMcWv/ouic8g9tsh2vH92+H3S+MjPOGY
         qoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789562821; x=1790167621;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvBYQo4TN3EsmIXlY2JV4QPHccIJn3dUvY6VvRLAt+8=;
        b=VLJ/r9RtwMFFpDrWxbPimPCv5hCruqkVLtmKrZA1SfR/NyQcR7TZV7aSRPYv6wUYBv
         ylV0i9+sNdURQG90Ufg5DDZAhO1f4MyBp07G3FE+4mWi/hdHsNAWBAd6S9fL/cs0kx1b
         oFcftGkUIn/+ZVPd2gxyx4NL721ejidV9PZn/pbVquUVwBqh09ToWmQjUfhAwyl7woeO
         VF31iGYiKlVq61K/6/JrtKOW0zSF7UlMsEXXVtsFc1Cntbv6CbocrKf3iE3enxQi6sP0
         86izun2G45A4yhggHamgaw7awT98Vw33bLZmu19PBQSyoxjqWpE8nB4KymT964nG/mxr
         2o4A==
X-Forwarded-Encrypted: i=1; AKwUvByZS0BlJvxB8zlc/LKZB16+H67pNn7MCd/NeV/irMh28urzcYpifz7jyAC4DcdmlJZC1ut85jxJ3zRhnPTg@vger.kernel.org
X-Gm-Message-State: AFuF++nylneg9Nrbrj6i0kfp1Jktt7UItucuIb5BYYOOa2TMc+zo6kVl
	SEyZRDkmhn8FP62Id/NDW+JwWFj6XKzyLLU4XfFTNWXTUxi8shHRSCBpiIkizhGC
X-Gm-Gg: AYBFou2Y9tHRy2HuE4FHBYdxy37uUH1n1QRKdcI3l5+zxrLNht/m3xGcOSvLFUVArRZ
	2JXNOJNnP2rWBfaCPkAnP74vaenQYRoqv+DQcnhGeHM5HWilEQWaNlcfV+7h9uRANivhRge41XI
	ZAXZDPsYilOWgx/98iVb/ovlCCtjRHLZlb5Set0hDtSPxpltm81j1N3w61xxAuerC25qmn3q9XF
	+ni2PD45Dte2pdT1zpKgILYuThFAoaftqlNJGo225jkDkyAd667BNO30uFyuMYrvFTRUHwT5Opb
	DbqQqvwR8fVF7Tz7ZlzYJq/bsP+9J40PBq0ipCf8c+0g1lzKcRsnOfvSMSGblK63okqL0pk7m8K
	7KgmvAEVTnYhn7vgDx3WaM+bA2vmryQtBU5sY99+0kSrfDEeAB3mN2Bwp+Iir6EXvA75+Kn5m1d
	GLWCaWLpuA+Z20NAQbsvgfJzbm9WbIAyAZ9vpH91PdUkVKRH5pKgucLdjPP3H2LBo5CealVrTXo
	XYBYW0lIGWWarX8W9FGRlcsGQZSogRkMCzz
X-Received: by 2002:a05:6000:388:b0:484:3147:49c9 with SMTP id ffacd0b85a97d-4870d69a561mr3529251f8f.2.1789562821393;
        Wed, 16 Sep 2026 05:47:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf418dcsm6894786f8f.35.2026.09.16.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:47:01 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:47:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Bradley Morgan <include@grrlz.net>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: drop the pointer dance in proc_put_char()
Message-ID: <20260916134700.3e0d17cd@pumpkin>
In-Reply-To: <adblkub2acrgjlgmjs2uu5644zm5fjghjzr5zkyga7uatrfeif@jsumbzlthyfb>
References: <20260822184244.13569-1-include@grrlz.net>
	<adblkub2acrgjlgmjs2uu5644zm5fjghjzr5zkyga7uatrfeif@jsumbzlthyfb>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 13:46:40 +0200
Joel Granados <joel.granados@kernel.org> wrote:

> On Sat, Aug 22, 2026 at 06:42:44PM +0000, Bradley Morgan wrote:
> > proc_put_char() still drags around a char **buffer alias, writing
> > the char through it, advancing it, then copying it back into the
> > slot it was loaded from. That only made sense when the buffer was
> > __user and the char went through put_user() (which could fail).
> > 
> > Since commit 32927393dc1c ("sysctl: pass kernel pointers to  
> > ->proc_handler") the buffer is just a kernel pointer, so the alias  
> > is dead weight. proc_put_long() and the skip helpers already advance
> > *buf directly, so do the same here. No functional change.
> > 
> > Signed-off-by: Bradley Morgan <include@grrlz.net>
> > ---
> >  kernel/sysctl.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index f7b7598..2b92b30 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -350,12 +350,9 @@ static void proc_put_long(void **buf, size_t *size, unsigned long val, bool neg)
> >  static void proc_put_char(void **buf, size_t *size, char c)
> >  {
> >  	if (*size) {
> > -		char **buffer = (char **)buf;
> > -		**buffer = c;
> > -
> > +		*(char *)*buf = c;
> >  		(*size)--;
> > -		(*buffer)++;
> > -		*buf = *buffer;
> > +		(*buf)++;
> >  	}
> >  }
> >  
> > -- 
> > 2.47.3
> >   
> 
> I was thinking more along these lines https://lore.kernel.org/all/20260916-lklm-sysctl-void-vs-char-v1-1-c3f8b2eb8b1e@kernel.org/

I think I'd decrement *size before writing to buf.
Should ensure the compiler never reloads *size.
Could also be worth an __always_inline - likely to make the code smaller.

David

> 
> Best

