Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E2C2FF
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563464; cv=none; b=H+zXOOCuGHbRK3SpxoJYNRV0+nD+R1gOuKLT1Q4Kb8BRkjGprqDGlpKX1B21IrOB4NfL0lUv/obOl6z/rxg3vinS+/SHMot3I/GxQLXqATIPZixpD1Ho+8JeLylBa66l8gWI8LGYpDg4dk8j9FloY46KCr97vbdPZzYszqvv9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563464; c=relaxed/simple;
	bh=hQ9Nxr4nLmZHAil0iwuJffwU1zpLfTVcoYYqeSppJRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4H5MilwHAC/D6JDDf41q7DQ/nHEXPHmzGzou0H3g90pK9PJqWiOqsQWyOKKgEkRjPuuIzaFMSn3CwypxNiTWeW/4oquVgJkHkGA6Us7pUrgdtIKQ+zlgDDSBsvVedKWBcc39lPybg2C7+mz6iRsFo9JcwdmP5xXGISaLx+kI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCvp04xZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCvp04xZ"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b93698bb57aso52425366b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775563461; x=1776168261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVz9XzZ7j6rtoJr8nNfsEGUerOVksHQQZBResCUhOuo=;
        b=KCvp04xZh52RSV5g9g8/JeUGX+zVqW6+63O3U+sqK2bvB4AP4zK7HyLGGwybUgPSws
         5qutsMFdsKC9+lsfxh3R+ZvpwFeChwiZnxeLEuQ9uOQ7GLowJQ5LpmUsLmoln1aYGRo5
         B0EnhiUTkNC2lV98TsHI/HIyQSjf/J+el9SoWY4zpAfuTpXbdXoC/Xjaht8bYaw+K4Mb
         FGYVE52nAmSFWa/C3aImuszUJTye+LCusgHSst2bXVrVgTx54HlDylDOpfgzudssh2st
         q6vgFw2j9zBnx9fhkOcgMuF2YksJWZwbHG4X1Wcssyoi2pJHzlCrwI65MQp0A0ZyRxJW
         cvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775563461; x=1776168261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVz9XzZ7j6rtoJr8nNfsEGUerOVksHQQZBResCUhOuo=;
        b=CuUx0C6bCSQM0jrWJPTkRmrQ3sZPh0Zeis9Ew2ZqkgGMzLRen7Ts7YmOyCwOmLMCIC
         OqNh6Gwo2zXvJBnFwDLhAMtiYXI5+zjhuFeTD35k8iwStL4eqHbFURtXWUmX36o44B3A
         j4UxVgNrjdBKz9MrocCApb8N3A2nWuAjYQxziaVPwVS2FZKrn/eXxY7/V7CgI4YDILM5
         Z9cmmvQMmbwdQR3H245o5CVX1i5ivUOi2l34eIuFC8mBBqQKIAuwvc4keN4/mBtxwng3
         j57pIuwH4Y795SU/mlq4Uekjb9rLjFN4GGoVXRV0lyQxtJNUOzEg89a7IRUcQdCZyXlv
         4i4A==
X-Gm-Message-State: AOJu0YwdaNDFQxfr0vhOjkkYQsBlg/vdqtghMs26/gc2RZ5op+f0u1OH
	ZLPThF/Rbxabx/mNNFdupgih0zjO6SHQx5NyAVlvEidIEUJhdvg1itlY
X-Gm-Gg: AeBDietCo6qn2S/acEEPryqHLKDFYe432HLuX2zYC85KrJm/axjYOBEkA7yPA/U3Sp7
	KUQnLc2XyLu+pYNb0x050GkrpawoajEr5/Su+bnzNz40EqBLox9bSfXZK5UeQs13+hxUlUnIkof
	tb0VUW9quKGuuLc0Hgn9RxOpvPUdqKsoZBeUvFXczomdpJqBtbu8XFnyeI/xXebOV8yZt3Q4HBW
	F8+pci4ypDnUXGwsZEjx5nJuAogoBKvaHzivXnVNYBJeW7CWp5V+SVX0s8cSJ2+B2sLwNNEEAhL
	64hD/nQtjpleZUT8FSW2AxXshcpgGg8BUNWPlx6iUYOhWL6Ia0SystShsE4mKhRyK6unjBfV1AV
	aUejSiTg0AfKur2K642Gz+3SNnsuqZ9ExI6x1X9nELXtyfXRQ/sa2p4djjRCx0lzqsNzK2GitDp
	nAXn2+loZSLI4CpaQEbTSkfZM97iHFyRCcSaNvfbBuuKP3kJadp1yaRHGEPaAHkxCiX2pd7PBgf
	oHE18Ul7vQT+ixWlU7jRTU/58bt
X-Received: by 2002:a17:907:7f86:b0:b98:8494:3174 with SMTP id a640c23a62f3a-b9c4710a10bmr922293266b.24.1775563460606;
        Tue, 07 Apr 2026 05:04:20 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-bad0-df47-fdc7-6fe3.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:bad0:df47:fdc7:6fe3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff131csm548233366b.52.2026.04.07.05.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:04:20 -0700 (PDT)
Date: Tue, 7 Apr 2026 14:04:19 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: fuse-devel list on kernel.org
Message-ID: <adTyw4UJ04qOggCQ@amir-ThinkPad-T480>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:33PM +0100, Bernd Schubert wrote:
> I'm taking Darricks example here and posting API changing libfuse
> changes to linux-fsdevel. We should consider to create a fuse
> specific list if that is too much. The existing
> fuse-devel@lists.sourceforge.net is rather hopeless due to lack
> of spam filtering.
> 

Let's do this already!

https://korg.docs.kernel.org/lore-archives.html

Do you want me to send the email to kernel.org?

I suggest that we ask for fuse-deve@lists.linux.dev
and then we can migrated the old sourceforge archives

As far as I can understand getting the archives from sourceforge
required the admin password:

https://sourceforge.net/p/forge/documentation/Mailing%20List%20Archives/

Mikos,

Will you be able to handle the archive migration?

Thanks,
Amir.
