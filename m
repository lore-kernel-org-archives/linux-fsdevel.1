Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780219F12D
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782672250; cv=none; b=eJYpTZUnNUC6LnTxGcdbKwTVSaqKKWfqvNio4kzlabPT7CufWR5DORlG/qGtBepJrvinA8IbjRPFQ1VwmvW+eQ7uf+sRItjxE1b9m+DOaG8O2nbyMvauGuDDIray5xk0z/dphuqgoMe4jL04B+4NhMOqBzMIrVSUpjibHzyEqDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782672250; c=relaxed/simple;
	bh=A06CS876fxNHyN/JSGmmNhP5LxQGNTrbKC6AUt0uy50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCcTQvU92LNNnjeyKoXcdUZk77bdd7hCjoDZ8Ma/7TwwxMetlCyvQTgKsXTAFu3Sgpn8M5La7B2Bc+meTfqzRALREIm5iB4pUmzeg1U9W4TDocAduDyRWLwIcNN8xsLBDD7D2dFv7k7UYxqQo2KFpLCstykVOTKfyDOxh1ipdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ocl58G6t; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocl58G6t"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so23554885e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782672248; x=1783277048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpVWK3fWX6RtxuEZlDdW1KGkNIIyoL6bwAJsYAyunoQ=;
        b=Ocl58G6tX7ZRzWwyP4szT8UcTv6q9wW5X3mqdgCun11Gu5Ytg1SSW4qIW4Wmm48Asi
         EDrrSAog6cjjxrMmKQWEEgoK3jRk+i236oVzlgdH8GhdQOgMC3G5JqbdRY/HnEFFAjUy
         8opxu9LxLnMV3RtdPKK8UC7dtO2Bsrr5Zl+wrTPEjCT1T/Sdp8y4xXvUsuueyfN/edv/
         lVF9hd56dlb7PDaeaL3YVlHuv5Dsf/NskLCBxQ4YTkVYYrcBdP+NkbzH6BlR10zyS1lG
         A+m8ZPjSjIFeOOZCXwwJYg53qN2SVAICS/29H+iDezY++9B5MwxR5zEPkBj0dPzsrb/L
         yZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782672248; x=1783277048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UpVWK3fWX6RtxuEZlDdW1KGkNIIyoL6bwAJsYAyunoQ=;
        b=hVNa4gsPrH40MsQ6xzP5zaw4ciyzGmbd5bzT+sINFgHcS3eNZrP4YTjhSK4vX8h29D
         Rvxr+YBooBlmBiZ3kDdvc01Mqt9Q5b+gVSaHd1SEkFkGaMfltM647vU8eep0SmuPB7OC
         AdZFBD8brcll45J2eHnHWUSfOGhpPshAlKRcCxCsNOTo7WSd1x5y/WQOF+Gxhcr0AX3h
         KZMZE/i+1N4mKJKGiYRylz0wwL66md8ujdhDWlBHnru0uhv3oknLh60bXJNJz72v+I7P
         eSB1Hzk9KDQsZ2WdBI/qRxAeeEDrKYh+wDlvcm1AMOUGuxUuad+t5I62jH/PZt2L3Qdb
         D2LA==
X-Forwarded-Encrypted: i=1; AFNElJ+3UGNBjkDnKmOF/B/OxPlU6/CAkKuAAOMJBYWyUZ4kSDcvf4x+NPLPbl+IX9IMFxIsl1ctzvn815m/ess6@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNkHg2q6jkAPRcaxeSNttaDfntqp/vF2p9Ygzf0uCvP5BiSBF
	o9JoJb8hg3ttdHBIU+bWL1cAoWhm0Bn/DEyGamMSnnyAeo1sWcYSHvEO
X-Gm-Gg: AfdE7cl0eK4ZDWJQ5uNx5rsNP7tEVmNNdqIcXtT5mReFLK7EbOOO10Q/Y66sM4Z5za6
	zH8y60y5yvGpgNf2Jrd4y67VvSDqmKccqLJ12FWFIMmHwY3SUD91QTJZ1uephO8yltmN8xSPINj
	WvUHVXYCaVc3dtp52eduqCoKSpb8HNVibFuUEho7RkJlyvLohl7RBgabKxPOc/RLbTkH15lkAI9
	9NZPaX1O3LAP/DtSEUoMU9VD9WSaxAkOz+cWVJGGfuatG7AF2Q2p41KZxH5feCRN87YX2EcKOl2
	gYRRTj7edEOeGGGsfp7n/1N21sVQY7j2dYGGaGJ+HzYYQ0aO04p4hJITDQ8DUC5kIf3UV8CzUtB
	oiZcck0FZD9OADc+LQGRS/u9MFbhwxWNmjxi6tgqAEdBRdAVZXn0Awo7PHgliT5OAqvu9ezRYD9
	eT5iD3vsY8NlgZL9Drz6B7nYdom8/uCqRpmmAoa8XzVoq3QQ==
X-Received: by 2002:a05:600c:628c:b0:492:71ec:7b4e with SMTP id 5b1f17b1804b1-49271ec7baemr92587895e9.22.1782672247820;
        Sun, 28 Jun 2026 11:44:07 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm167243165e9.1.2026.06.28.11.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:44:06 -0700 (PDT)
Date: Sun, 28 Jun 2026 19:44:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, John Ericson <mail@johnericson.me>, Farid
 Zakaria <farid.m.zakaria@gmail.com>, Jan Kara <jack@suse.cz>, Kees Cook
 <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, shuah@kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm
 <linux-mm@kvack.org>, linux-kselftest <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
Message-ID: <20260628194404.40253a7d@pumpkin>
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
> All of that needs consistent, easy to reason about treatment. Reading through
> the glibc implementation of $ORIGIN for shared libraries in rpath - even with
> an eye on cutting through most of the complexity - doesn't give me very warm
> feelings. It feels very hackish and full of edge cases...

I'm sure that NetBSD refused to implement $ORIGIN because it was full
of loopholes.
You'd need the kernel to hold a reference to the directory inode and
have a 'magic' argument to openat() to be relative to that directory
rather than cwd.

	David
