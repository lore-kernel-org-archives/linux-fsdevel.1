Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B903769E7
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787938969; cv=none; b=XafrgBlljb+IWLpJ8+o+AB7y/0Q6+tFVmG4/UUMXQ0+sJ1EacURrEruA4Oc2JGW+3I+C9k++g8xJ2khAe3pIuCBvQxy73IWeesSZ3QKd9SUWQvRaX36GMiCTEA3vIn0YtUswYmh8iNaMMFox8fXaP6Q7RL/+AjD+c5ON7Fbi8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787938969; c=relaxed/simple;
	bh=tuUokZoCnlLmufKUH8WZZk0WHZlIYiI6h1Ayh5pJbpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0DTH4unoTKLanNt2NPTdULtuN8nnF67GaW5okiJ1TA62CjxK040X2fxJXomC1hB+snpSKX8PNn6MekM+uA4zWFeA2LhlQpO0iTum4Xhv342q3ETWOen3oV7VTW3PDcYYpfXh00veuCzCFdt6n83kCsl2B52wPtIde+Bdaril1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TG37nN4V; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TG37nN4V"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2055573c8cso153984566b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1787938965; x=1788543765; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GL2lsY2q6lh+Mh9KUYPYp0RjapCsGo7cY5qRZTg2oBA=;
        b=TG37nN4Vkl5LNdvnnkAG0/MUrcvKdKPXMZ2a9jVjhxGUX7XP4Zc85h2F0+VgnA4GBL
         3PNU6qsFAsuOmGvM3S5X4D2RtYLBCyTQfHZwGppPtsweS/5qe74FpgarmEmYKLmGaXkg
         AI1Dv9fMoCqMEzFKy6uLN1jp9iNXhZI9M92yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787938965; x=1788543765;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GL2lsY2q6lh+Mh9KUYPYp0RjapCsGo7cY5qRZTg2oBA=;
        b=cLCfC7XB6VPzXERvJZsId8ncYFDYXdHzwunf2BhlHW8xEYJNd8rqrs1pJdFkhh6jWm
         b5j7NRNsgasBxUJgLIQoN9OVhwOos3B6c0mlfRHonWhTPxo3fx74dklVuZZrGmK8SGw4
         HCJfqFQGtv2KZaG3XAolyivZcvH6RDYXZuFWyIKcNOz0ZqIjFb4sEZpIY5vWxPwSFirS
         yycRobuW/eP8WEXMkDJ4WY3PJ/n4kYTT4RNNOKGqEZcN2A4yhZX3Rlvy5+/d1Pd8pcJ8
         Kz++vY2XA28DuSeuIo1uTi1vza9n/UVhp698Y1BpxDx+3oyw0O0k8Lut6mJrHVah8C1I
         ENMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrniKbbEgvw97O9TIts0gmRjZqy5HrttGQotbxXn/RgNEL1/dLXWbzbRXPn8Qfr/1w/eIhERmSygWCwwvoG@vger.kernel.org
X-Gm-Message-State: AFuF++ns+AlNIOuE8FnS6JnVIm4qFdYvXKM6y2WWxc3FVN6YK0qouyDd
	2di/KKL0IiUzDSW6xMuxtKiXlGRfg52f2xnnOFI5dIJmr+AQZ+frQPq8mIfp/O6uJcXP8VGvCJZ
	/JJJLpoQ=
X-Gm-Gg: AR+sD107tBhUo+sG5l2Rp0aGTIouXOHkhEFQ07pHyfYLs8HSkIfdg/LVii1/3BHK9jE
	dDgnm0iJD90RhqpnxcC3B177gqVOh6hAKX49/8p6kS/nHraa4XItOTQ56UpJYibVi4e1MLnG/xZ
	l0ga6upF7h4YkzAkyJ8abxRazwf9JPvw5Yni1QnuMnN/EzQNERNpRw85VGmDrplHGvhdBgJEdKL
	2N0J+EW5iXbZOJU9R5DFlw8OxWdBIfFTy1bRV7hgYojM9tcxAqdhX7PN1ZeTS2rMIoKDz/OWiyt
	PGCOFEdeLvbKNwSGWtdKSiDa0Dt0VrVELzKMDqa44xzRzLjtey7g9nUDkMyqX7SBCPf/aWJsA0s
	g5hjv+SZqEgVJAGUBLeK5a3SePBiz6UxYwDnleQhe78Qc4+CUPpO/M4IubpTCf473oOV8GXy7pU
	ZsAvQCuMxNn4tDHJV98w92zo1H2FrXLm1uZHp0fxYKv31opYYyB//CplCewou844h/UItRArEfz
	yCMbnwuK3RN/u2FtVjjK9EzmNNdLRCVdPXFFw==
X-Received: by 2002:a17:906:478c:b0:c24:6390:decf with SMTP id a640c23a62f3a-c25571630ecmr603551266b.16.1787938964634;
        Fri, 28 Aug 2026 10:42:44 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee27b19sm111012966b.19.2026.08.28.10.42.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 10:42:44 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2055573c8cso153981666b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 10:42:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrsAHoZQ+OIJJcFfXb4Ix9SvMRTaR/5WSlbi4xmS0FOFO+Bx0y3Hxy5OdHja5p7kdZoHDitO7A2tojwK9Fl@vger.kernel.org
X-Received: by 2002:a17:906:7947:b0:c25:4ba1:5953 with SMTP id
 a640c23a62f3a-c255702dfb5mr645433766b.11.1787938963933; Fri, 28 Aug 2026
 10:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apG8g-5krNRUFUuD@casper.infradead.org> <CAHk-=wiY22BnQkAMMc8-h6xaRksvVAbASpg=pj+=kVaXXQYo6w@mail.gmail.com>
 <apHC_mHJ3wsJPEgy@casper.infradead.org> <CAHk-=wimz+APb9hGEry+vHDLB5D7WZvNGWU89HjGw7wH15KGHg@mail.gmail.com>
 <apHGdfwY67YZ4sEr@casper.infradead.org>
In-Reply-To: <apHGdfwY67YZ4sEr@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 28 Aug 2026 10:42:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrY29fKgVkjjs1TfpR3y-TNCF4hZ9zqsbBGSMc9BvHYw@mail.gmail.com>
X-Gm-Features: AcwNN1XMk0tn5kToNoPohLIAPg_QHNiusV8BkGpX280Il2RW44EB8ONqq3geRJ4
Message-ID: <CAHk-=wgrY29fKgVkjjs1TfpR3y-TNCF4hZ9zqsbBGSMc9BvHYw@mail.gmail.com>
Subject: Re: [GIT PULL] Remove dependencies on pagemap.h
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Aug 2026 at 10:33, Matthew Wilcox <willy@infradead.org> wrote:
>
> How far in advance do you want to know about it?  Because I did send you
> email about it a few days ago; must've got lost.  It has been in
> linux-next for a few days (would have been longer, but the Intel test
> robot kept finding random drivers and configs that had build problems).
> It's already generating conflicts with other header file changes, and
> that's just going to be amplified throughout a whole development cycle.

So basically things like this need to be ready before the merge window.

During the merge window, I basically only read pull requests. Sure, I
read other emails, but it's a back seat operation at that point.

And I fetch linux-next the first week of the merge window. Anything
that isn't there at that point doesn't count as having been in
linux-next to me.

In fact, I should fetch linux-next *before* the merge window even
starts, but typically I never actually remember to do that, so I only
fetch it the first time I go "has this been in linux-next".

And honestly, none of the patches I saw actually seem to merit any
kind of special treatment. "Generates conflicts" is not a huge issue -
not for me, and not for linux-next - when it's trivial one-liners and
no actual code involved.

So put it in linux-next. Use a signed tag. Make a proper pull request
next time around.

             Linus
