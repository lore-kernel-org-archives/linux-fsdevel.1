Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263633;
	b=aJrUJktOFmXNE6DZNUbW5Bilu0HxrQ/jeUxyeBqjz5ns1xG9yGGuWMGHt1gUqawKITQT
	 +fMx25Oyl0dJJAakc3f0Mcw9yAV52+nX/atnj3xaohUyU5Pjl9pzWIBV/xHz2eJbHidH5
	 wGE6d3L+pS1OG/vLR3YR49o/3z9G9IyDgEF60D5KQBvy+o2SvzTIei8rgnnXxKaEK0iXz
	 61hiRvjluVo56iDQVvj5XlO2zlf8geI4Fry0nVH/pbYQTOiCeGH6jFYNnxyk1fcIDoi/5
	 BiLXtuZCOKDKWOpC7IfByh/IN3bzLHYcFMOt6Tb6Mbi8t6kfm6jhhDNjReXHjjnXWmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263633;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MyuCXoIzX14mmXyPqMjSwU2j2KiYvT+zBZ+e3R2rpTo=;
	b=Mx/MdispsG4fCRSeCcYZ/WmsuS98v3VOXfA1t7sO0n1R2j8UmUj+dQWiAvOyppPvbLF+
	 Zmt3Gdp3u1QSz+AZr2O9/EZvcyMU4uDlTuHit1Gr+zwh7B7hh0AJCl/HyNZeldhrjMews
	 GGKQ0KNevpo3jeioDH5hBNH4wSVUqa8XqsgARBMEZw19B1t003n1dTCyk1CVzDiaQDWpU
	 EMRVwC6kFHJYTglKu92QOwJKD+qdPsyz9HET+/dAmYhipMED98iprnGgu/um9yuQkZOJM
	 iHXG1vQSv+b7VzGbvwbHD+nZJ5rMyVcE3eAC3St+5Zlqu+FxVCbYoVI95V5aJMhxSWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=rzWMI6p2;
	arc=none smtp.remote-ip=79.135.106.29
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42803606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 22:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42803606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=rzWMI6p2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794263631; x=1794522831;
	bh=MyuCXoIzX14mmXyPqMjSwU2j2KiYvT+zBZ+e3R2rpTo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rzWMI6p2zL9RtBQwnZPqx479g8YnGB/XOIl9aJ2VZyF3Laix6kblF/wOe8koqHRrw
	 hqjogMiUTzZDgsrkNSNS97T1ZXgsOtmbJz5lM2wXLfH66ZaYmF3UgpsT09wPxdl2q9
	 U60tBHhPMVhXLf4LcH+Kq+yy65bq9OO0qbOYYn9raRQ5ZdqNTtn8hbqY3B9gAW44q1
	 c83WShPWF4+skGy6auTWanz/NDrRyItwSECEw/nRaedO9ANLxG+WPEnIKtcItoCqsD
	 VmOGhRKgWhXtA7LgZWYl7qu2mOAxFG4gE35mhtP8hIToHGsghRDYXGS+DS84lykvnn
	 glP4ea6T26PqQ==
Date: Mon, 09 Nov 2026 22:33:46 +0000
To: "slava@dubeyko.com" <slava@dubeyko.com>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfsplus: enforce legacy sequence fixup table invariant
Message-ID: <T5owqcB2cU_byJBgaQAhCVODEVm8gH_5-GGF34c-Y-XrcxM0K9ePQ5MPdFzg3bOKhloz2j-x5JX1if2kZgfimisk12D4agKEpCnSeQzy2iw=@proton.me>
In-Reply-To: <564d24919b96070f53297b03e8551c8e98bd4c91.camel@dubeyko.com>
References: <XizPhPDPPpkNfPh9_zn3vMVegijzle2lWWBSUgdPB3tpi8xMB2qBIDun8c_X7eyFVMgq0zBlmGikFuBstwkN-O0l2bfQcmA5gtxudDOHUQg=@proton.me> <564d24919b96070f53297b03e8551c8e98bd4c91.camel@dubeyko.com>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: 3bd194d84e6ab3463b55842f0843f06c1e3640fb
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Slava,

Thanks for the review. I agree that checking the static table during every =
name conversion is the wrong approach, and skipping an entry could change t=
he normalization result. The intent was regression protection, since the cu=
rrent entries already satisfy repl_len <=3D match_len. A KUnit test checkin=
g that invariant is a better fit.

I also missed the Signed-off-by tag, and the patch formatting needs fixing.

Thanks,
Noah
