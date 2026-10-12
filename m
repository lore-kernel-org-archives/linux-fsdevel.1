Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423047141A;
	Mon, 12 Oct 2026 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799616; cv=none; b=OL/N5bsOUNV4mmz1bVTm2ZGHOb8gXKZEfg5qUgZ5yRQrckZbNHkricgeszdq6i837fU8sAuSkzztovoNYx5b6mYTQpucOgGK3fYEjJFbuqWQGiUF2h/BBuPGiYASr/qxQxm+a6b/oMP3kz7iJs2tmRCeLukbhYp9AiTK8zv07zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799616; c=relaxed/simple;
	bh=heP2E8AiEXpA/KsDVd8gLBz5zkznywEtdV+HAdLYetI=;
	h=Date:From:To:Subject:Content-Type:Cc:References:In-Reply-To:
	 Message-Id; b=WDm0FBhfhADP9dFmQvPObNrL0i01LWtwQVR3A/6FgjXGI+Tq7/OXhlDNT2sW4YzPWuDHUmq0IXtjCJljBx7FzZYphdFaV7kwKTtz7KU/kozfYRPl25MeXUkUlsWygGp9x8ej153mqTKxU7od+vKogDe9iDX6KNKouKK3cvjpdgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=scdbackup@gmx.net header.b=Th/jdakL; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=scdbackup@gmx.net header.b="Th/jdakL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1791799600; x=1792404400; i=scdbackup@gmx.net;
	bh=cTS22jtgrxs5hRnPd0jfV4ttG02fYDJl1FQXv8LNJKc=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Content-Type:
	 Content-Transfer-Encoding:Cc:References:In-Reply-To:Message-Id:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Th/jdakLcdfEdBOSn9kLbWLrL1cI820vHEvqvXjeQB/v7CJAKW0cZk2rHRK/OIGk
	 ytEA1+DuD4KhfbUU37+A7+59HUao0GD2pXL/KgLnLAtZ/5DbCmjHsGlCclPqOvbLt
	 MC8L7wxxLWqByPpnei1HBDO0PvsWcqxz30aMIGsvamtLubx2PCumBcR+DEiqlGxaO
	 GSECnNtgy0Ov9H4V3cJqsRpsP5GbLS/RICPFI2zX/LFGXxGqk9DEQHHbpijHOOHPw
	 HHu+quS9/LPbR+BiE/0H34Fwuk1ZXuvmDabW9eVSz58c62JpE9pLknPquXbsH4tyV
	 FW3A7oVkvfImqw0X5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0X8o-1wSd6q21vI-016Xwh; Mon, 12
 Oct 2026 12:06:40 +0200
Date: Mon, 12 Oct 2026 12:07:22 +0200
From: "Thomas Schmitt" <scdbackup@gmx.net>
To: hengyul@cs.unc.edu
Subject: Re: [PATCH] isofs: Fix handling of directories with small logical blocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: jack@suse.cz,brauner@kernel.org,matthias.goergens@gmail.com,linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org
References: <20261012021004.2105580-1-hengyul@cs.unc.edu>
In-Reply-To: <20261012021004.2105580-1-hengyul@cs.unc.edu>
Message-Id: <21101510237286364126@scdbackup.webframe.org>
X-Provags-ID: V03:K1:CJEwTq8NGaA+h0QM2362+F/TucHYnj2Fxb8OVLkaS9IgOS3nMTV
 WknKGU+UKQa6El6sEj6sc+Dt23hk+gOXL+F0RxZwqaBhZtN2TST9sUW0UZ8DRd+QE7kw2T1
 7O0/t791nwzXTAmje+qoedF/ruRMjUBwYa0bDUE6Xc1iVtbdzQk8Arr5o3pnUi4+Okca5rK
 Gj1qNldXUjJ+xunm7XhuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KseGBZ7gH5k=;Z6vjht+NJIic+DJvACSBBntx3Ha
 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
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Hi,

Hengyu Liang wrote:
> As far as I can see, the option sets the size of the buffer that is
> read, but not the place. The loop over the volume descriptors has
>=20
>         block =3D iso_blknum << (ISOFS_BLOCK_BITS - s->s_blocksize_bits)=
;

I see. The code of fs/isofs surprises me every time i look at it.


> I think 2048 is the right value for the check.

I now agree.

(Actually i think 2048 is the only right value for Sector and Block.
Everything else is just weird.
libisofs did not check Logical Block Size at all. Yesterday i committed
"Prevented reading of filesystems with logical block size !=3D 2048".)


Have a nice day :)

Thomas

