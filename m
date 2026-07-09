Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866322423A
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=38.105.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601608; cv=fail; b=UMm77uzvHd5FUzZ0p84h73AHwx9btCD85YZ5rUYHbRs5oUBLeDos3a0+uVt6kQUzvTphmh/SX+BamZxKQURmSqk1xbgypdmYBXQT0GUkJDuYEg5WU6GNcyIY5ZNbaNKlSGg+QaihgkxxRbSpzUjw/xcQkTvBP4/6h2RmjolyiLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601608; c=relaxed/simple;
	bh=CZoKSxbcJVeP9SlvTpbB1P+sU86PjyJO8+MnplbnKPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+prpsowyax5qcrWAZqQqgMLvhHAenWw1Edow3qrFaGII2al+j2MREbfqBpk/kwDEQRTeCpvF71Rc9HM7olq/iMLGMJ2e3VKpE7MYRDvzsO5xfSHLj36ftqdc0PeNornLaoeES//XVGOAZj4TAe5Kq3djC1/1AoJM+liI3oxwtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=kyCh0JXP; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=L8B4qYgx; arc=fail smtp.client-ip=38.105.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="kyCh0JXP";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="L8B4qYgx"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.99.4)
 	id 1whoFp-0000000BVg2-2KrE
 	for linux-fsdevel@vger.kernel.org;
 	Thu, 09 Jul 2026 08:53:26 -0400
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5aeb49bb645so403601e87.0
         for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 05:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783601605; cv=none;
         d=google.com; s=arc-20260327;
         b=pPxXL7jjO6MduPNzSmRY+N1ddkPKbEFVQ9ot3aWOCVjwnQxLO5EoAFNjKcjp3AL3AY
          gehucfIBLDBToKlNki6JCWuX15W9CxBfng1tu5CgmKGql+ZNN8XO5T82a3g+V3cE2RdU
          YMolAFiPyqBeZ6h/+PFOeJ7I++xyHEVrji1jp4uwHIEcV9jyLQ0VfKNo2MDCF9ZcPM9F
          YX7yZFqPIPOKGWueAkOUdywPp1l2/9KmoqkW5hIRmsMsDp6LXpjWxu9bOZ6SuMXCUoCI
          VpCkhjZxXztTUEd53Tv07tNP0nb8HlokwKYIQ29Mx7uHpQBkKVF+nktFLNyaPsSdsfqy
          9Dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:dkim-signature;
         bh=CZoKSxbcJVeP9SlvTpbB1P+sU86PjyJO8+MnplbnKPs=;
         fh=ZSCRXzOV+H7fiODI47O1bb4fzKRfH2IoVUBgGcTQQE8=;
         b=Qkf+mnBWizkxrF1jOLVNpmB3V74kpYh5MgdRMmnhKVJrO/RnR7EZnmrMWRVeF1pMfV
          I3Klk2gSHRnwaJM/Xt7c2YT8FX7qLJBfErp8fdD5Jm9V4y3yAsx+tI0j//9J7aV0eNi/
          RHe/SeUx/TwUivUTMkbnw2CwhQVerkbaqZHLb+VqunzuVIApIUZyVrAGCfPyyNGn7z2p
          UMfSRd6G6Rh0dNP1Ye8cLhPUzE/qUZACVXiJtTfaGn0ugHd26VSiSikzBfAN++AMmXhi
          jBEJQjDUbZzl+z5qOR9n790TNAdKGXOxSodDbpkOhQ5aiG8p1rqAhxzCb0W5S3IYHpz+
          ds5A==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1783601605; x=1784206405; darn=vger.kernel.org;
         h=content-transfer-encoding:content-type:cc:to:subject:message-id
          :date:from:in-reply-to:references:mime-version:from:to:cc:subject
          :date:message-id:reply-to:content-type;
         bh=CZoKSxbcJVeP9SlvTpbB1P+sU86PjyJO8+MnplbnKPs=;
         b=kyCh0JXPnAHGu/jzJbtCSxwBz7DTlc45gQiBL49XjCVFn2rlrR1lQd5FzoP0b4BMeB
          SXyeQNW91DvTi9b+IHvf1a/SPJ7n4X0m+k2IC/tx1GlLXtg9WO2Si1sSpwVM0pBEc1IW
          q/DbGxZHIWXWkHAHcmJucuKdSBEUVEfCLQVI4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1783601606;
  bh=CZoKSxbcJVeP9SlvTpbB1P+sU86PjyJO8+MnplbnKPs=;
  h=References:In-Reply-To:From:Date:Subject:To:Cc;
  b=L8B4qYgx/650Ad0m94x+Rcj2z/H2Kfyj6P2kl+b6SzjNWCtK2t+pDTKCgWwChdb/H
  RV4QL3tWySnXSUzw/Ehox9UQ0jbf4zHzCtPz+KP4zJpqSA2ecPTJBqzE17/mrwGK7v
  VHfHpIBGSmEX8DNOVAQMzVX0aQmqlwLw+ONA6TcQUK9M06tOq4I7Iq6WUMLRjgXJxF
  TjZboAl0DlkQxSVjH169u3unDoqYycPFzW7CPrSLKdvZ7wTLZAxJWyjEHo4ZF4XIgc
  OCueJ2rMrvDdEArS+rzbLeGR62n7vE+9bpdYMV9A970qq8kF6Q6XPaBTunxjvYuQWw
  fqKcG9JEIFDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20251104; t=1783601605; x=1784206405;
         h=content-transfer-encoding:content-type:cc:to:subject:message-id
          :date:from:in-reply-to:references:mime-version:x-gm-gg
          :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
          :content-type;
         bh=CZoKSxbcJVeP9SlvTpbB1P+sU86PjyJO8+MnplbnKPs=;
         b=d/E8CtMXgS643YtyZ9uuUDe+g2kqEX46pfJr7U6GOaQZ2VHn8gOQUFBisj5AaTKg5W
          /yjC/8pNicJecsa6bYRxeTqdSRkBzBCiLzCHKrpBIEIeOTYxlw7NLXggsrBZuRStaG4L
          07caVdNLVHP7P29nYJIiUCSPpig9YGSsGJ44YK9blkeE3OP0hC/jyFV/c6YtQOgEuuZG
          Cs5gLg7BEi0/Gxj6dGcV9THe3xcbGOhN5Vq2Rt54GsOujiI7lGDhybbnaPXgXAnpVEHY
          NzmZ/1rO6+zATsXA5Gcz6JTolst22tHiG5lPY88H5fjd2SNsKMCOYfjtJiBu0OnSKBtF
          9hcA==
X-Forwarded-Encrypted: i=1; AHgh+Rq165nGhy5KbHtI6jh1u8EGh8iSyjMMX7G/EM3Bp1K4+5NhWOshauExeZKROczLM3V08OpWGcoin2TD9g+H@vger.kernel.org
X-Gm-Message-State: AOJu0YynlVDB0ZMHTvl17PSn9vD3Klj11MTuxTdeOHAjtQmIeiGQ1cho
 	3Sf5je0HqAp1+Da//Vxa0isDACtOzCkZuXAT4jlLHGll2usgfhYhiO65zK04Y85HMGGbecgqvv7
 	VPFk5cx6wMXRMz8FMgBWBhMftc3uy+WENvo093bxo/Pn5ljtBfZD7KGwYptda41zdKkuZe/HskX
 	dVoiwM6zaLEMuKM/B1uNZjQNIjLH7DEkzXowVqn6Yj
X-Gm-Gg: AfdE7clOwI06mAhCUrZRZrHOnnno96tzjhwHUH1luJGIS/PPjFLygub1dUKp4Hc3d7B
 	vXzwaYTABpB6eLs5Zmgjr3j9V0pgEt9ngnbFDj/JIFopBuseiBZBaSliPpEdGKOuAA2oZEVrPpv
 	59vK9lCS2/jm3wXB6AHeXvArv8Hqem/o1Bh1VBLrIadW2dGEH4YrckUXHbhENkMhCeR+Q=
X-Received: by 2002:a05:6512:4384:b0:5b0:14a5:372e with SMTP id 2adb3069b0e04-5b014a53b08mr833278e87.27.1783601605000;
         Thu, 09 Jul 2026 05:53:25 -0700 (PDT)
X-Received: by 2002:a05:6512:4384:b0:5b0:14a5:372e with SMTP id
  2adb3069b0e04-5b014a53b08mr833263e87.27.1783601604634; Thu, 09 Jul 2026
  05:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702165409.164568-1-pfalcato@suse.de> <akhYu66GmjyM8l6a@casper.infradead.org>
  <CAFN_u7HkJry=iFLbZ2vjzv5C=HnrptHfFJBLOqRq2m4LyhqV_w@mail.gmail.com> <ak5g9h3FuVn3bZ1G@pedro-suse>
In-Reply-To: <ak5g9h3FuVn3bZ1G@pedro-suse>
From: Gregg Leventhal <gleventhal@janestreet.com>
Date: Thu, 9 Jul 2026 08:52:47 -0400
X-Gm-Features: AUfX_myfsaz2CNj6SYVdToPKTm3sV3q-2qQKmWB5EgGOqp9HxGlKza-X6yxVsEA
Message-ID: <CAFN_u7ExSnVo=QQBuZvRJkLR3rHo8qN96rDKYu+KNiSjk0FCHQ@mail.gmail.com>
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when collapsing
To: Pedro Falcato <pfalcato@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
 	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
 	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, 
 	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 	stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
 	Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ack thanks for the update and all of your help with this!
Obrigado pra vc (Meu esposa e Brasileira e achei que vc estava
Portugues da sua nome/sobrenome)!

On Wed, Jul 8, 2026 at 10:40=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Wed, Jul 08, 2026 at 10:05:43AM -0400, Gregg Leventhal wrote:
> > Hi there, just checking on the next steps here.
> >
> > @Pedro Falcato Are you currently working on this patch (mentioned
> > above, re: holding invalidate lock), or are we perhaps stalled on
> > something?
>
> I was waiting for some actual tags from people, but given the comments an=
d
> no tags, I'll respin a v2 before sending to Greg KH.
>
> --
> Pedro
