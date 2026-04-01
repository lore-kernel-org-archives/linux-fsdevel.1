Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25239A046
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060088; cv=none; b=g4frdfCFSL6O0B79wKmnnL0D0MIOyHiy/ZuyO6h0u7BocY30O3T0/Ena4YJJcRm91F7RIRktHYWv+0Nmf0knjc6IMiuNymj8YHR3dQJ3Znr+C2Msj25MzHhsMBU2RxKXlCToq8RhYRZjOiTqHVlPppsZd0Awb0+LvCq5W/89Tow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060088; c=relaxed/simple;
	bh=564mLO8GwIid+0o03nCuLIwZSl/kUHlh9EF8+EMM9K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBk4bLwVutn3THHss5NGltJwPVannlV7croJ6BY8S4W39dpkkr+K0lgDVS7Sk61PMMCiK4nGgF8vrWUJMol0XbVkjYgUCWQqJGTAjIAPzgfcgpIWINLRdepgeA+Dhn7YgWQI5V57S4AR8gbbZxOYpGFi0p43vAWu0PIH5eBWirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZhmrsPs8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZhmrsPs8"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9841aecf72so868373266b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775060086; x=1775664886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ujwNwrd/79RRbI3f9J1La37GuAjgA5aW3HNg5AGxiTE=;
        b=ZhmrsPs8U6YckowFWw6BPpcQu/bt0BtldfLhmWhV8uGFma6hilts8ioZMWxErLqKne
         3CoZBNX/+qUf8qwbdKzRoAn+ZEXrsd2papkYVM53Rmp9T7WWMeN9f+LKLDlpby+Z5DJ6
         bb9JHXFMwBjGdNQidFBtFWmIJ6lVqELzUvjWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060086; x=1775664886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujwNwrd/79RRbI3f9J1La37GuAjgA5aW3HNg5AGxiTE=;
        b=UaBuXz8kjBAnPLMvxLSfYQmjdH/KX1yALB0mTFLHFz+7kbENAh4sb9cJQwILwH70Oh
         vl8obObw+zsnefVMu8d4JIMSuFQC7BISDzpexJDNOXkc6jiE09bipPBDXdYMxWtA/jLi
         AyWvSGIJ5yDYRq3mOhh5JtFjlMK9xoZNO7HWLwzNGwZnK4+w0S6D/AMbDrVtpaIMg64V
         SYd5A1i479K3FWCuXnps2Bs6Rs1b9b26v6Aa7UVfcpVBqEo4XQYvW+LtF/eHycb0gXbY
         92/pOkjQDt//qFydEmX+vxMMUemuTFczKgHmLsBPTdF0TOJUjK3riqqKNtz0VOzUgZIw
         onFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwmyr7FgFhTbXnZkaVwcePbLy9fI6r+TjlaStew5zYCBxtaR+dPVdfqSrk7/A4SWD+J/xrX5t57OrNKK9/@vger.kernel.org
X-Gm-Message-State: AOJu0YyRWhNF2DnmzY9uQN8GA6jeqMgzXG2QUeCMZX2R+BgGhc5HyJ+o
	SXKRY8ddvlYvswgKbA+yh9KC7RvzXuDTO4QL/Uo+c9i0hpnMT69CkT/ADSVvRJCLzNW58v/xE9m
	coJ86Z+AZCA==
X-Gm-Gg: ATEYQzwYSiI+8xl+xYs9tSICMY9yvvawdbReVC9M13P91cFMCu7dhIShvjVRdG7j8Vr
	n2RWpwURHcjU+PkOcUh0OgaoYsXZztOzMqWPzbAopIa2DMnoa1iKTP3ou3YQjdA4SmA5kore5Ui
	RtLoOr2/i7c79RpODDmaoqp5RhRGtqQmsZ4Em+d+WXpAFRm6bzHccVE650mrJrsGVBKKFHuC2iM
	dO6YGCtUP1UayUxbdN1rddfvQ4nIOGYbInTNbotuSaMtxQIohL96TQBqLbRTooHklo05wsPGrAj
	06MhHUA3Rdj2UFHnCP4qOgUb5IozRtn8pXa0gpbxnCCakXLEtifj/LgJdPjG0seEYcLS8zoUipj
	HVU6tm2dKxIbBrWN+7I4HjhACRddPQIqDT4z56nWTKx0+baj5Y70xlLae+HMtGv16uOvQTg9YSG
	k5wfjy3pnf/eCJ/SMoUNmXRMezy+HwQQVkX64LkGPc6XfhwS2m4u6Oh6q084mJ7xfDCfmLqHHf
X-Received: by 2002:a17:907:d7ca:b0:b98:32c1:246e with SMTP id a640c23a62f3a-b9c13789ff7mr290492666b.8.1775060085488;
        Wed, 01 Apr 2026 09:14:45 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff1e54sm2497466b.46.2026.04.01.09.14.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:14:44 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66db0cf6a4aso2231063a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 09:14:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeYqzXhH1vmb72t4XbZ8EhJ4xPjY+1sFwHt9ynA5YfutpI8b5vqTXHplrKmbX/zLFg1l3ucqEpM35uwFGU@vger.kernel.org
X-Received: by 2002:a05:6402:3485:b0:66c:7ab:1430 with SMTP id
 4fb4d7f45d1cf-66db09f00cbmr2868315a12.13.1775060084573; Wed, 01 Apr 2026
 09:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401-i-hope-someone-believes-this-is-real-04f24e03944e@brauner>
 <20260401135125.GK6202@frogsfrogsfrogs>
In-Reply-To: <20260401135125.GK6202@frogsfrogsfrogs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Apr 2026 09:14:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMaDgJixHVH6KVrvm=XiQu-n1+TMYwDoeT-ODiQW4N6g@mail.gmail.com>
X-Gm-Features: AQROBzA1000_Yw51-552_l5UIyeT_JbTz6Lx8bizpm16LirqJsloIG0Op1l39Tk
Message-ID: <CAHk-=whMaDgJixHVH6KVrvm=XiQu-n1+TMYwDoeT-ODiQW4N6g@mail.gmail.com>
Subject: Re: [PATCH] vfs: require verified birth date for file creation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 06:51, Darrick J. Wong <djwong@kernel.org> wrote:
>
> I assume that starting a new session with setsid() won't clear it
> either, then.  Do you think it would be useful to introduce a new
> "btime" cgroup controller so that these decisions could be propagated to
> entire groups of processes?

I suspect you didn't check the calendar date today.

It's that time of year again...

                 Linus
