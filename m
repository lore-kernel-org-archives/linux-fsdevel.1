Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489B39281B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429998; cv=none; b=tmSH0Q6tnTzX+43/DVzXzLCsLgIfoNEbq7FO5QS7oeEtqT9K/Vc+fIeFffjAOXfkdYRIV0RV86IIT5yJgOrxlu3yBNomP2ZbqU1gb1DXjuFtODINXRT9S4b4Jj573PqzZornlh3E5k1HuaUlw1wPeeC+5EVVSEUjJhLUFEm/fjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429998; c=relaxed/simple;
	bh=ez/ftBKUFZXPMBA1j+BIjM+rYkY7cSycREcI8v/26vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBNdCcPaJZLfG5tj32tKlbdG0LnUyNdjUkkpbZx4voFJ+/zvVQaDrDuxOJkFU5lMtIbQjH0U2nYfHHZDe9uomj4ZNwDDMhRG1b8+2asJqShfw6IFMaBxEQT3mZCpk6Z9wyNdEUQ4LZWLLkMM/2nwyEPG/rCOy5Ib9/ZU9Vzt/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PGhXI/tA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PGhXI/tA"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c12614b81c9so422962266b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785429994; x=1786034794; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZlOLGFSy/CTNPahqtj7kyVyKyd2w+qb5becmlDJdco=;
        b=PGhXI/tAvl4JMRlLw8i6XFvIO6ZAojxRy8W5kPXs65myiAm1pR7b+vzpAgz3nEg4JK
         /9Eq83kPX0jnms1s+ivCoGbv3knzRgqA5n2aVCQMshFpKE3NxCD0YF+l6qwW+R/4mVp6
         32g2VK+8z20ik56Ce0mUGEYwEKhEKEs80brS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429994; x=1786034794;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dZlOLGFSy/CTNPahqtj7kyVyKyd2w+qb5becmlDJdco=;
        b=BVPnFJRIjU0iXZKySUFVS/6o+akk34uhX9gqL5ELzdzby/gZmCW7CbZxtNYJyqTSVn
         def/rRviWKicpLSdONTs9nRVmvOHn6a0Bc1InjnKWF+Mgoz66u24EKLFHJjdEcZ0vB9Y
         F+4/Oeh3BR0yRP5O6VEHZNMY+XQp0b6WXbJDeZpZRfZI4gftwbJD07OAMJEV/2ws6ZVR
         7QcIBRGLIfrpRCFoWZhOg4jOTHKGxDDOucEE5qsWd+Ir9WEJYFQM9fVoKNYC6wIsiWZf
         FWkKXBojSgSQzBtJdM1xVS5WdG9ToOPXA6567CAy/EJUrvIHHjWGlyIWqEp2SaGPquEz
         nQyw==
X-Forwarded-Encrypted: i=1; AHgh+RpjNXnEWIXz+rpX42GEl4NhCWX8IE8lwv6Cx6JYn+J8wGEnjE60gefAsnSkUD5h7faxbExZW0s0aFv0ET/c@vger.kernel.org
X-Gm-Message-State: AOJu0YzsR8VZn4V80b/NOYOYSywZ9kkEq7OOYa5C3cqHQXr2zq6gZTNX
	TjxLkR0f2bYP+j9CRu9fRRj5HZG03jjp7gDahEGyYwOHvbdUS3BYQotpfX/PnFkZEUGw+vEas27
	bzCMgfto=
X-Gm-Gg: AR+sD10DaoquZDmpzUEa5ZElIGOy0YVk/tPHX3xWese/CXWeCeP17J7D6C5gg7MSCef
	qSoMxYkmurlvxAdQWARYKfrOvwqIE2rYVAs3U9xNgMfHEKwAj0YVaMawJyCD4GkFjUE87XisqGd
	6QubaopcVZ0L1bLWyBH7yrI6hxzck3wympU2aLb12qVG/jZh9xA+3aMQaNWPfbAnsK9JeH281tF
	fxY8SNina8DENvCEu0DqlagFp7+sATaq9W7WkDEZMxS4yQVe85RUDFQkAjryQ+JmTrlz9aRogbE
	TnI86aKa/xS7+WOCr2XAgnLxgNSpPjPSGNg9RHd0oUVAJj8CIMNLPJc4T3Eo5wgRSTw/vjJ8kYZ
	XVLcbKXQeYbASf1gSZAc/SKFY+cTZnPHrQVro5y5GzApM1r2WdNkCP9qYlP/+iOgDvz8GRMIDGW
	RS/cAhSshMEAAl2ndFXtDi4S9lefJt+1hNmKEPA45RN0RVNuo5po8ZNKi0GN6AdJ2b0BJpjUBRD
	jkzR7VS0dMeZyW/Xs/zYUViqbKl+sbgOR8qMg==
X-Received: by 2002:a17:907:d08:b0:c16:7c0:21f6 with SMTP id a640c23a62f3a-c1fa56ff703mr158474566b.38.1785429994090;
        Thu, 30 Jul 2026 09:46:34 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a07d3831basm878425a12.15.2026.07.30.09.46.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:46:33 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c12614b81c9so422959166b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:46:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqiz8izxwP0bA2s3x74OdOVWlbtuD8s4TuNl43Brtqkg7vFC51UZJPyZ/On2PZAhlzThK3PfQDi/7sE+4ES@vger.kernel.org
X-Received: by 2002:a17:907:c17:b0:c1f:1267:deb7 with SMTP id
 a640c23a62f3a-c1fa57ad4d6mr193696066b.62.1785429993415; Thu, 30 Jul 2026
 09:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720201057.1862857-1-kbusch@meta.com> <ampRQyXDbGgeg49V@kbusch-mbp>
 <fbe9e74d-c389-46f4-9874-3e9ffd9c91d3@kernel.dk> <ampce7mxSmxAwAiu@kbusch-mbp>
 <20260730112626.GA24827@lst.de> <00104e90-48b8-4419-90c4-ac0c4a2e1c44@leemhuis.info>
 <bd7249ff-d0a6-4a3b-8aec-3b5325f24b08@kernel.dk>
In-Reply-To: <bd7249ff-d0a6-4a3b-8aec-3b5325f24b08@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Jul 2026 09:46:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDsWYL2c_vpqArX+UL9k8v3qoge7HqjtcrxbVsLAjfXw@mail.gmail.com>
X-Gm-Features: AUfX_mzqOY3ca4Dui_O7sukC5vCEWaDgT57cEJGjc9a8_XBsD7VAxqL5ujTpsZc
Message-ID: <CAHk-=wiDsWYL2c_vpqArX+UL9k8v3qoge7HqjtcrxbVsLAjfXw@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/5] block: validate direct I/O memory alignment
To: Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, brauner@kernel.org, 
	djwong@kernel.org, viro@zeniv.linux.org.uk, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jul 2026 at 09:23, Jens Axboe <axboe@kernel.dk> wrote:
>
> Sorry that's nonsense, because how is Linus going to make that call if
> we can't.

There's not a big enough thumbs up emoji in the whole universe for this.

          Linus
