Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9B3BED4F;
	Mon,  6 Jul 2026 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317486; cv=none; b=BvD8twKKldnHdP4+g6+ES5ms8ZSkSLOXdt8XWgalSREI+m9CZDvyKmdwKQTYkPje4Pl9CygHBkiCXaTJJjXc9W7Iatw7ArccCTulAWZdyV8wyGcwMBztMHhPFRQM8IzRxRjHe5LJeIGcbbOUN2hzLsREQBndMr4fxjpR9aavRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317486; c=relaxed/simple;
	bh=zYAe2XPdrdqaqoFPzWTQDnC7aTtJMpivWNtejvRQd70=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=sawS2FFJQyNF8VSv0yvIhp/82zG1Ecnf/7Q0Uh62c+jTfu4KZJbavNGPNm4/nFGqSJquCxYTeCyWYL2Yqnu2Ypl2I5BbfQx28WI7uu/MZVsMYN0w8xdhICy9t4hTzztUyYp+H0f9O1kW3Wpa9kFJDaE/ygTyGIVjBkvsl20umQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nfCRxCZn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=exPSrDZu; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nfCRxCZn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="exPSrDZu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0887D7A00BA;
	Mon,  6 Jul 2026 01:58:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 01:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783317483; x=1783403883; bh=yH4b9thJuY1bD8Y3iAsGfgln7yhl4X32tP0
	EQZIeu7U=; b=nfCRxCZnQlEYEgBMuY5PBr7RhFSlqxL8lMGZfqmcdN4NN4poq9x
	ww2DJE6fyd1JZ5MIEn0DNlaqW/LU7FE2CfEIxU58DcdTZS1LRngpJgO4xGYEhV+L
	/iqaJ4zXl3EuLGNukDBJ8A1p+2c4zUDiVFlmky/R9ww2vgbcJNinFQ/FnpKBnn+q
	bWy/goc3gCHfNl4yShxreMTkwfeQwR1DjVhs2sas/cUjG0OMvivo5Fo3PJIw1jYP
	0R8dIiqi0Fif6MPabIQB2jmKFqeM4AXlLjWv63Wx7PGRykvzDliyqKITmq6d6IHO
	fsVd7OPBm2Xn9Q0g4dsu5YEjMIFhmbqgv3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783317483; x=
	1783403883; bh=yH4b9thJuY1bD8Y3iAsGfgln7yhl4X32tP0EQZIeu7U=; b=e
	xPSrDZusROrkkB5MmdN8x29R1WTUpNMFqoJlfewIRDyobEsqVGyFOZilir3xKdDa
	ycCjLez7C+94+SN7EwlUehLOX63o8LRpdkn3mJXFK//Kxnx4zGIJgZgqYjtK3XSi
	zIFZg1EMYTKcZPvZTGAt77WgkIpq+wKn0cV5UVWvSmLWXjC+m/45DsNnYxOi9fWN
	EovGoLFsgmZPyw5rgLRH0D3msxxj5wZ2S+uUbPwPMp1pISuAa5NJjeh1ViiT5YKM
	xq0uAgY54IYFT+9+RbJdMfgDYiS1NcwpoeOCKS6AZfty07H3AEKEKfCTdnFAff3z
	LduLKEmv/VjkyBARLM1kg==
X-ME-Sender: <xms:60NLahRpiBPNcmR5nSWkx5LHNE5TCdWPVqups5O-pK6Q5z_5EXCIlg>
    <xme:60NLanWcuI0ifAXMnKtzxdM1HoGEoRFfK41W42UW58eqriUuiiBErFtYm5rUVMooX
    Pv1HBGWp40RBwCvzNtRYybydACf0shZBRyb2xiFvIpUOlX64g>
X-ME-Received: <xmr:60NLarT0rVm2NxTMTLbolNKwk2pqQN1G2yph0JnnNG2C2JdJ_7GziaB-4c-iSQNgxZEB3AKoLUpvY-lMw4fgaVjAwPaOkpA>
X-ME-Proxy-Cause: dmFkZTGr5s8+228ljllYeqtSfpbnAxP616BmLcVVReD9PAkVrq1Frpv/sEaNpfyOzMAaCg
    tDffg3VTtiq10NkzSOxhu6bMiiw5uFmmwfOj4Yo6yV7RBbwxWCXYeP2DPlPy6BrG14dnIh
    WsJxzZj9pX0nBjBwzNf34a3+HLLMeM6LoBqxcXmY2PDdweouIm6cpX7JXKBtUjZuDhyvhf
    m5wJnMDQfCkallwgMlOs0XJpa4UG6jOsU9vEGHIE69Ml1gk2D34dgmX/0VVyMPOtuOq0Mp
    h1FVEWf5IHRKc303PeqIUH7faHd2KmuPuUOEDAqzt9DOhOZSPqPoJr/oTq1JKDJwEaCIX6
    oob5kDvo+9QOM0w37BbYKCNTrmEXGFxSthKPTkDVyltTof7mmH+elqWPerqTtsrQI1eZrp
    61hlqoyvp0uoBwHwjkRRYOk9j0zTigE7RpHrwBeDVIvsrGB59eAXSsBp2Vcp6vV4PMhKrR
    /pBIRa8MOiHk/WhY7GmAqnJmsC14X1tfJhyUzrCp1rF473vpWFsMguWbsX1X8LtvnX9GVV
    9cmWkadHarTKwhhAKbkjujMniSBjhEEya3mBwMibxwXZoQmp3niMfyWcdJvX5vi9MJPlzI
    SDnu183gHdzJpA7O06q+0iDnw2qpUdeSYlhv0FWybUZakGpRxycx6mlHxsbQ
X-ME-Proxy: <xmx:60NLav3pT1c5ui4M_1oHNzPP2pojChBnkKiptcBYfBQ0clRtXhsSjw>
    <xmx:60NLarfGmXC5ckaUzYQp5BXcrn_pTiVXvT0x5LCUoawLNb-GNGRzXg>
    <xmx:60NLanN9uNUbzxT0HLjbjc4GmKK8228PV5ER9IvXEXbH-kgH7inO3A>
    <xmx:60NLavUkB7R6n7hj91Wxy7UfJzw7FCAoVQL2Vx-mzlKE3JD-xR7sMw>
    <xmx:60NLamHL3qabf3UQIGUYE1uWl4sE34lvmeqexbtQ39RJQGw8vxBqRjst>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 01:58:00 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Aleksa Sarai" <aleksa@amutable.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jori Koolstra" <jkoolstra@xs4all.nl>
Subject: Re: [PATCH v3 13/14] selftest: fix headers in fclog.c
In-reply-to: <20260704164149.3480051-14-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-14-jkoolstra@xs4all.nl>
Date: Mon, 06 Jul 2026 15:57:57 +1000
Message-id: <178331747789.27465.4739600418387513587@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 05 Jul 2026, Jori Koolstra wrote:
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Maybe say a bit more about what needs fixing?

I guess the ones you removed are already included in=20
  kselftest_harness.h

and fcntl.h is needed for O_RDONLY etc.  Is that all?
Lots of .c files in tools/testing/selftests include fcntl.h.
I wonder if it should go in kselftest_harness.h too?

NeilBrown

> ---
>  tools/testing/selftests/filesystems/fclog.c | 4 +---
>  1 file changed, 1 insertion`h+), 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/filesystems/fclog.c b/tools/testing/se=
lftests/filesystems/fclog.c
> index 551c4a0f395a..593a5136e991 100644
> --- a/tools/testing/selftests/filesystems/fclog.c
> +++ b/tools/testing/selftests/filesystems/fclog.c
> @@ -6,10 +6,8 @@
> =20
>  #include <assert.h>
>  #include <errno.h>
> +#include <fcntl.h>
>  #include <sched.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
>  #include <unistd.h>
>  #include <sys/mount.h>
> =20
> --=20
> 2.55.0
>=20
>=20

