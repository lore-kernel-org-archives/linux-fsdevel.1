Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00891684BE
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176190; cv=none; b=J/SAEJll3hv3aZ0CW8hGtd8deBVFpnPcn8GdoUOfKnj9+/PYqVM5QBkx7Qn/I8yGiR8VDC+3FG3reUOJRL0yPTXKfVPMEXutJH75k4Vb5k+7RTM9+B2dv4H5JSpHZTiLebO/CJ4Sh5sbHyvdyXEQWfTfK1dW4piij0s5vJTf2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176190; c=relaxed/simple;
	bh=+bEwNePle+eI0YhgyBhhVpVaNRGnEy/n5Bq1JGfORXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChYcG6jJ1noLWk4U/3IxFH2LgYIxIv4hOPYeIfkSl2bJZtdgG659Hzyb1tkbRP0pnNOECeYra3K8ESF4ozok3qU/x/E8BtWwgXpklqfkea6l5Zp0aKfYeS46e30VaQ65uVUlyeE/fMO/bVThnReYVHofu5lbpZrCLPwqkYSuR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bjQdzu07; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bjQdzu07"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c04152730so216214966b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 17:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775176187; x=1775780987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7b83v/Sgw1pE6a9KWCdy2m6lTKe1OEf8frly9zUcJwU=;
        b=bjQdzu07jOajyYnsvy86Sq8zC79rXf3Q650NWfxX9w4nDWW6rGaJFHo2mDGJWyKtl2
         5uZrqJaDfT7paygsR9r74aLRrDKa+48jQbZwaACez+50xZkvmsUC4GgsJy/S7nRuFiDC
         svcgxU2nSiVf8PpvP/pUD1CWRd1UgCinI7bis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176187; x=1775780987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7b83v/Sgw1pE6a9KWCdy2m6lTKe1OEf8frly9zUcJwU=;
        b=ULe/KHj5ip80MsZA8fNMvRXbYP3ID9X+ONxI3mbdJ0j0cWNE64YMmZx6xnUbjWt+It
         rvst9Py9YLoF9k+giB5g4eeqVVqOUtYzpICrprOAeMehjrhAom+aGrJCicFWif13mlVJ
         dtfNcziNqnHJNa2GDCM5vwGGJsLGhr2INlbflIUT5k1YSnuUyuf1CqJZhEKSyfDbRszS
         hhkMGotVCEXrHXCobKAXFUD9wNThlEmmak/cP4xTtqya7URwnRAkzk7lpV3cKWdu/0HW
         q/yJS9P6YC9aePIXjLO+FXxyi5n9+DC/IEQZCzGzwTavuYbkKOb0Sfaq2jP3nyhPZgN5
         H2yg==
X-Gm-Message-State: AOJu0Yzmzdy2UOgY4bkOECckaVazSi5IRkfGGzLDfVGNZ0mTrVUvIlJG
	97/gYK+0+lcZw/Kc+XI/MagjK4ih+REOePEJww1wiIaK2SgtVPRW1TS5GyC5u30O5p5VbZMiUfK
	FjCQkf6Y=
X-Gm-Gg: ATEYQzx4pZcOoNIz4eSmpHj1XcGY3Ra6fEh1PI478nJC2y198ofus8h4+YH43tFWeEF
	ruz7h7awhwzBFhSX69XE1uVzgkxq+4gHgOS1tSakJGc0ehrPFOlxKZSvwqCLhAh7VYyweXihJyg
	O/F1eDnItuuAqqOk/9qupEdEDYp0vI0YAj3DbpdRl5w1VU/MRsP5+tSfenS2mRYfxkdP9DOc0hR
	GdqGC0tPA0PhilZJrE/OCvr1Fn69yLY6enbE65Snb6moj0TPigIkoL1l+2kxg33aVyg6aws8fnK
	moM4L7DOV2Pj9MUrL9E1/+b6VXMj/RLzLmhKNCxP7sqN855tWjX3msbj+He0QRVE2XTyjb82Ru6
	1rzB8zZ45mYjgfdspRXnjB0725fmwPQq7w5FYRS/3UigmFyMN3hBqlY1QJ1Jrz2BQPzfjsLfYLY
	VblOJhFYmGI27qku1RvUWagI2QASCHpuAYPQ+JKDVR5cNeOoiANySz7W5RDwhfFguTN9F5eJ62
X-Received: by 2002:a17:907:9711:b0:b96:e593:fd1e with SMTP id a640c23a62f3a-b9c66e5e2cemr47233566b.0.1775176186693;
        Thu, 02 Apr 2026 17:29:46 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec6f20sm146380266b.38.2026.04.02.17.29.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 17:29:46 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b941762394aso190296666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 17:29:45 -0700 (PDT)
X-Received: by 2002:a17:907:3f90:b0:b9c:4086:a410 with SMTP id
 a640c23a62f3a-b9c679e490emr35828766b.46.1775176185618; Thu, 02 Apr 2026
 17:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122202025.GG3183987@ZenIV> <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
 <20260402180850.3729310-5-viro@zeniv.linux.org.uk> <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
 <20260402224439.GI3836593@ZenIV> <CAHk-=wg7O-p8L7384myYTus6NH5aYdoS=y=+iALL_8DLT3=ZLw@mail.gmail.com>
 <20260402231643.GJ3836593@ZenIV>
In-Reply-To: <20260402231643.GJ3836593@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Apr 2026 17:29:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5HkyPCFsfXS6u2xe5h=dV5WT9zaeqt-fRQyE+OxKGYA@mail.gmail.com>
X-Gm-Features: AQROBzBQVnLqOWnR-tTvRVUhy9cV_Lh8-ZgILpd3VENIRBN5jTo3WJ-9dEZMqsw
Message-ID: <CAHk-=wg5HkyPCFsfXS6u2xe5h=dV5WT9zaeqt-fRQyE+OxKGYA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] get rid of busy-waiting in shrink_dcache_tree()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, 
	Max Kellermann <max.kellermann@ionos.com>, Eric Sandeen <sandeen@redhat.com>, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 16:13, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The incremental I've got right now is

LGTM.

                 Linus
