Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C8353A7B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885386; cv=none; b=s7djN3wW+LUa6YcxvhIZJnGIOOIY+GNghcPygWNUUhB4nC8l6mr6V2WUC+itH55WEGlob0vbVKiZ7aGdGGON5MVOFae9ZeCkydLPCy4X6xNNLePDWpZmNvzGP1zlw4pIPbBoAHMn5drjtyf8aYtO1rxYc09fVKwu7vY2dg5U93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885386; c=relaxed/simple;
	bh=lecO3ttVgRT8QyyaiDOzI3/QgRH4/dihpQ/rnO1jfaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO55Ubn7d2DS/mR37/hSDUBSElHDgxgBWOc69Z42p4Zf4y258JShkmhHfJJGn7RyoGZFTyRz/5C+cdYsgrT7kj/7ZcitpXZh+zGwfu1G75gxn+EAhqVaWDb0gxK7oX2AKwCCK4lAJ+RZLG0+fuHPQYDONpH4BPloGBUJtCqlZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er2Ntb9a; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er2Ntb9a"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so68643145e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788885382; x=1789490182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/EansYsnai8F81StzziY3cP4ZOtzfOu0U6ChvK15jxw=;
        b=er2Ntb9ae8iLiMg72UuUEzUCtuyD9MIuaADma091ODZogrHLUXlgLgtb7BSbQ3sXvW
         K2KoYI5KIIhH0npatxPYgbSPcUyWPogBl4Yg8+EP/35Rqg6X+IiGq8WXYLnCL7ecHvM3
         onz8sPk176BTD6LEMTKZ1YuQofmxeyv5oZMhsjqYhsNUOGs1gyxl/Yp9vcwupLKWWeU/
         4v1KAoYDQapvbhkiFBJlPuk/sXquAzPs40yUJkQl12PLHBbpUzeAjhbjk/D4Jru2FX4E
         yjs7E6MH+CWVpRaSdnVnhb5vcUu8odkMPBqKq5GE9Q9mdzyacRtS2hrRJv4yeSh/HB+/
         6UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885382; x=1789490182;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/EansYsnai8F81StzziY3cP4ZOtzfOu0U6ChvK15jxw=;
        b=a1TSX5hX4R3XBxK4vRz540btMyNs3Rfvyey0RGq0JI7+eXtfNlv1GIWgCgt4plQdfM
         WdZb6TYNup3UvzvFf/wXPs2Dplgu7HghWNRBibsUG0KsGSmO1EZC2e8PotPThrun63IL
         sW0sDAviF3nJbWMAfpAARqGXJS6Rox/h+2WHZTy87fW4KNBOFnQwzGLuWqMwu+mmNE3K
         1Xa2oYSljTzIpueeRfiLqMcNVwCctT+Ox85zHfWhU4je8MTG0OW70lsvz9RQgbNY2smT
         8ErWPbr6QoOvREloUegzggEHEyTguuT2NuaT+YToc+UNEEEjYJVSNCb5D0Ghm3AzeFkH
         O+MA==
X-Forwarded-Encrypted: i=1; AKwUvBwmnDnob8VEPtNP2zqpPEmr0EI5a8N1YXhIbG05UmQrVcY4bsstfcBr5tI6YmO2kA+xz8DeMD+Dxvf3nbE1@vger.kernel.org
X-Gm-Message-State: AFuF++lQb83P8X47AV86zKdteQkoOtOB52eZqk4TE0ASJnRXyyS6iNGp
	Sq9aadk7tsIAd06gssw/26YKZFJwl0BJZkjW8xNFvbrYVFC+k4mj0nk=
X-Gm-Gg: AYBFou25rl7iuQad7pdjldQzSKVStytnvQW9R5Z9l4wrrGnYZzEzX91rpVsIuelWjlR
	xT5dtmyRPVDWEMxj8ASFGeB5BwpbdKQ54UfDSclIhLS6Sh1o+wP3Lfzk/wZSToqf3nosHplDk6T
	von6B804nLzZbu3BJTSwWq3VOOjy00khaF1EH+fPjFij10fXz+SeoNif7tC9xJFam0CchJdua1g
	cI8RPmytIwDET5OM5rwW0uwlVMEmbsE4n+np4T8bpm+/noAIRmFus9sTZDpg/aG0IIDZXiziV3D
	KMhCW7iya7S7Vw5+yhNgrSX6dtGYpol6R61hmg4cbOyIrTecvXQsQRzfVzpzdmQnhDiaRUPSIVW
	bdAeByafYKlieP94lDxPvauEy6RpqoMYGXB+FSKzhxZAuQaWN+HzkExubuLGpbnrqedkn8QTt9o
	sJ1uPck5eJDRyypox9PtVEnTVULXlzVN7hlNVo8tchFz3XT0ko
X-Received: by 2002:a05:600c:3f06:b0:49d:1cc3:fa9a with SMTP id 5b1f17b1804b1-49d1cc3fde0mr39898535e9.14.1788885381519;
        Tue, 08 Sep 2026 09:36:21 -0700 (PDT)
Received: from p183 ([178.172.147.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm545494045e9.5.2026.09.08.09.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:36:20 -0700 (PDT)
Date: Tue, 8 Sep 2026 19:40:27 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Paul Dolan <paul.dolan.dev@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] selftests/proc: avoid exit() from SIGALRM handler
Message-ID: <a07fc37b-11e3-48a4-a89c-4b59e867e961@p183>
References: <20260904123752.157562-1-paul.dolan.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904123752.157562-1-paul.dolan.dev@gmail.com>

On Fri, Sep 04, 2026 at 01:37:52PM +0100, Paul Dolan wrote:
> proc-tid0 uses SIGALRM to stop the test after one second, but the
> signal handler calls exit(), which is not async-signal-safe.
> 
> Set a sig_atomic_t flag from the handler instead and let the main loop
> terminate normally. This also preserves the existing atexit cleanup
> that kills the worker child.
> 
> Fixes: 0658a0961b0a ("procfs: do not list TID 0 in /proc/<pid>/task")
> Signed-off-by: Paul Dolan <paul.dolan.dev@gmail.com>

Yeah, yeah.

Reviewed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

>  static void sigalrm(int _)
>  {
> -	exit(0);
> +	alarmed = 1;
>  }
