Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D8283142
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842361; cv=none; b=N0kvNzeIPu2GbSfDNQQ0dMUBXlhn4+8tvu7ciylrxawAIdlnTtiKXcSLcdq9MVXWFaWJYh7VE1CntWPi79mSbeGqmffPnOoz6f/oGtlPchgBwTNrA02N1D0JSi9ko4NxU3RDOMiy7/HXkGWV4wyuIHav167ZIkdk3Ssa9XRsMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842361; c=relaxed/simple;
	bh=x9CMoGNkZpcb4ai0XShbV9IZQjov/vBIzAOp2ZoeIDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoDmXf3G63/rgRZsXU4bhkiDeRmsnhGqBXRaLs/nNLcSWE1eR6ZWRmUq+/SM+7K0Ssk3uPS0yGhjqrRdPUA+QlyBYPzj3ScHG51gzmoRkydaVxCiNVO6bvaNlSLpJqbqs9Tukin0MmSfOUxwaL5DA1qzR5586IMHSgYS8uGdNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahNkuyAu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahNkuyAu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b7612475so11988135e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782842358; x=1783447158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Us+CXl62OP+IHnxEOFdUPPagDbtagb/X32b+PDoHuVk=;
        b=ahNkuyAueIUHdlOuQ1dTLfGjq55Pcn51cuxihj/JIuLwmHYRdVcgPVm/3R6tKKIncb
         7eh7uCE3T5faBurKc6TS10BbKlJ49lsJVLgqDPnPYj57UHx7X8NYN6y+LvKvZgGW1Jgx
         p7CFuMYuQGJje+Ql69a9+0wQTg8gR+twSLu+Nte04j+cmuV4LPQ4QR7yhl2si/KgfDtO
         e+VtNv5CydfInL2RsWtglHCshIDIbgQA7BcoZoTDD4LZDgsfy0rlB7CekFxn5V97FuIN
         wLXSi3zGSfPLbKHAdtRujUt7cw+lb1ICDKf1qh9YRzPwxPacyeLOvZ4swNMpOw9JgoN9
         9COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782842358; x=1783447158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Us+CXl62OP+IHnxEOFdUPPagDbtagb/X32b+PDoHuVk=;
        b=lDtGnnzLGHFNSFoo730Og/egZInhwFsXiJqCixSHOyD8n0YofAjzcOQoiUbMF3mdpR
         mFGshsNsDEDVCX+qss98x6U8Ol84cdEVwmGU/+8dkZbqC1+uD+MezhJwHTbHmH4Jyy91
         yXYVvbVgoYTUXO1Ei32JlCZMY+eMjzmu2kEVZdGiXMADXnM102xJHecR5d8IRN48Y/Sy
         OVmXR+VFRiPhWNIDS9x/AAt0G4NRmc/WtRKSDoscRn/n47G2aDxufgFG0JWN8Qt2R1PU
         ta0Iv8ntfs7CS3byGpQFFUxTRW/jhQpO634Pad9B4vLYcE2NvfViOcA5s750ZUsb753q
         ynIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Xo6lX+1R7d0hUDZuEzXkPscayz6ni+BgVshjaim91uZHimby/Gagv2xiQwWS75GjjAHH6P6OyqfdQgeXu@vger.kernel.org
X-Gm-Message-State: AOJu0YwH4buHb5QudlCT04kfvPoJVBQ58P5ClbNvUvKHP9Pf162ucB5N
	4rkR3x4/OPQZN/8PDumsIHzk4BpBJLd/uEmeot0tbuxxh0Owquh9hwcQ
X-Gm-Gg: AfdE7cklqZss5xmCscoe8ObSVNNSfUh4+2ntMDAzVkFFsbzMjV2W1JMSE+7oq3u6pFx
	EydUtAlCDapCTrFrfSRdsjJZ3P8rQQqJycpkTTmQZKTwIBc1N1ltBNTyR+DnJUj9hHTVYELjqzw
	vIZfLXqOagydmZSd4bUl8Qc9Hr7lxDOEjTd2jNRjJVz6Khho7VSLwEFp3zkdc/MDjwW5YCsJsU9
	WUOVao5bFAzBpP1Q4b0aAwKLVGufEHz6/dfpdDPS23U1zFEGk9eY/mWItztO9yNMVxn+IjcGbHs
	/4244FcVm2ehx9ifILF/sXVM0lqboEiFvdSgxidPVJ3fW24lXcMnCqaJVL+y+4XU78LphZX+8k9
	f2UOF5Owi5WCF62QblMfr/BFs9dkuIH6asaesc6jRlsZ5qD1et3hxY4RUz5l8ceeAOxQrWFIAoq
	3Jfru5FBOs3dzM6IevFpFE8QgE26gB0SZKaqKr2S0d4ikX6g==
X-Received: by 2002:a05:600c:a06:b0:493:b811:e549 with SMTP id 5b1f17b1804b1-493b82b61fcmr66519375e9.29.1782842358265;
        Tue, 30 Jun 2026 10:59:18 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4c7f90sm11943955e9.2.2026.06.30.10.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:59:17 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:59:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, John Ericson <mail@johnericson.me>, Farid
 Zakaria <farid.m.zakaria@gmail.com>, Jan Kara <jack@suse.cz>, Kees Cook
 <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, shuah@kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm
 <linux-mm@kvack.org>, linux-kselftest <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
Message-ID: <20260630185916.5a694895@pumpkin>
In-Reply-To: <20260628-debatten-vertagen-amortisieren-3bf518773e75@brauner>
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
	<sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
	<CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
	<24420045-a6eb-4999-ab19-1e344eaba8a4@app.fastmail.com>
	<20260625-atomkraftgegner-hunger-kursbuch-b452ff2becab@brauner>
	<CAG48ez2X1p5Nm2_sU=SK9wUusUO8c3_T-=FGrrOhkm7Kn9Y_7g@mail.gmail.com>
	<20260628-ungeordnet-orgel-stechen-36dd64038541@brauner>
	<20260628-debatten-vertagen-amortisieren-3bf518773e75@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 15:20:11 +0200
Christian Brauner <brauner@kernel.org> wrote:

...
> In a way we have been doing something in systemd that goes in a similar
> direction. As of systemd 261 systemd _only_ links against libc and nothing
> else.
> 
> Any other shared library is dlopen()ened as needed (discoverable via
> elf-notes). Lennart wrote about this just a few days ago:
> https://mastodon.social/@pid_eins/116781776665322560
> 
> This effectively minimizes the work the loader has to do at startup. Imho, your
> effort with wrap-buddy is related. To me moving the loader invocation out of
> the kernel and into userspace makes a lot of sense to me.

I've done that for libraries that a program doesn't normally need.
But it doesn't make sense for a long-lived daemon.
The work almost certainly needs doing at some point.

The other problem is that it is hard to handle symbol versioning.
So the function you get may not match the one the header file
defined and you suffer the consequences.

	David
