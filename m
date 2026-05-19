Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445C2253EE
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152083; cv=none; b=ckC1sYjWejgMeRpGBq4hPWebN1t3odqFkF+SPAeq1n6ULoTTAFHNuhBAZuZtWBLv2AdiT3TctOkKJps2biTjFpy9hhXAdAbjWloY4OQmlQO1Aqtkieezc9CY72CV3wQpGULDzWV1S6ofXhKGexfyJoGUjru3/gieHlWT0a3RpVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152083; c=relaxed/simple;
	bh=lSja7ZbOLuuM+tCrgRWCxBG/Huz3q30x9CbuMKnrvBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUJkxm8i5oXC/+sl54ENJZhmM/6FZrJnPKQaO1VPt3X+i6DStyZVXpkN1zri+JIGZJgwK7o3JUYO3eqryFQgZTZ+EJp/E5P6j358hzZbW0gQwh/+/umQIuFyldikz450LfSs6fcP4u9avml5VcML9MUi93DrmXWWXaI5LG0a8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IJab62+/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IJab62+/"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so5181912a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 17:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1779152080; x=1779756880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CP8YOlMTq6wrxw+7ONW3izZGo2Gu6xGgxSrk4HzA858=;
        b=IJab62+/L0MwSui/BweH8H9sX05dwnmPqqkMfCxmn/fETyptRyhuaZwLSpYVjmNEAw
         akRs/CfmbmLNr8rx5TCajjhixhdrIH5+ZtN1uaVOHbJz4erq6ykCqVH2WMqKqlpPDZ0p
         DzkbDwYszIsg9yd2x5p5JmXW12HO/ircr6EeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779152080; x=1779756880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CP8YOlMTq6wrxw+7ONW3izZGo2Gu6xGgxSrk4HzA858=;
        b=QuJNwobwE/FElckCfXcZoYTN41WWKgtVAp3x4NK/Hp9llpV8ufvlKoLvhNpjXNBwRJ
         ZHSID+duA5OHfy1dmDF++LHE64i8f2MmLxvROxTiQsPpG1ZiVETFt0xF4ZMHg3JbJ6jN
         eGoQm1C+h/6brf1jtAGIYWidbUWMdTtD58IxxiRMvntYW/5RuUeNd2rqRGgqGi2iMTKe
         q2pipruO0HnYijXk8ZCv3iZ5FCy7SjKXtlOAEEhc2qEEusIOVtl3PqubMT9MSN9anPlE
         lPJETm3LcMiJHdVN7lrbjgYoFdkWpaHKYJ53dI5gETyUR2nGukBumla3AjGtSkVAZSlG
         7GQg==
X-Forwarded-Encrypted: i=1; AFNElJ8SDyF5UB6R5KqN4SZawBuPFwLQ+NBw2COB8kqs0+YCMeGI2b9dbWStrSeFj4FVf7KYamCbVXjYD5LC/3Nw@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCo9MIE1mhjAv1FQhC8eZu8HtkwTmYxcmJO1OxU0sbrso2kbz
	kyTF5PQwUemlHro2XmzVcKRb7qPQRQYX9C/h+13/kE3Lf+gee6qVEu9rBXQ5Sw/gz1l2ekAKYlv
	uWkVf2Zc=
X-Gm-Gg: Acq92OHeEUtA44u3eVR/rP0FYSE9GrbcMmh97o6y0zEDyHu4TUzbgfJWPkRBMxrUBrC
	NGHa5csnPSnsZqUQt/Ei5JKqQWcchi2gL1bJeX1SsClNq3EDZMcoaxlBgJF3Jt9NTpFaycW//51
	Eu0Ioatm/YZ8U7gKnps4wl2TK5vj7XKoI7lE0oTs2dA0rgqiPdX8jf37LS9P3/4CP4NNeSMpKvb
	7PoY9WcRcGM1S/D5kFuhX2mJsGaGMSNiUcVFiRHs6oi/8DwagzY+Mt6KqE82uALn5VWGIcB9896
	wV56tyHls6RyTXzJA4Y6ToHtDRAKz8UdxwRG/QNWkgxz9sFfDzIEROD1lzJQ92MDLusVBzHx2j7
	xmx5Y3s/b4+fCFvxdCY+IkCEfmb7CK1ujGHEOUxJ2ZhFNPqCu0yO1xEWdCJCqCc9mONRA24s2PB
	vSyc3jBf796BJSdlB5avwOe4ggb9/fIKtFqMJYm7zyoqGQ3hqu6/RArBgyBwkpzvzYT6sYyvLg
X-Received: by 2002:a05:6402:a21c:10b0:683:a318:a3fc with SMTP id 4fb4d7f45d1cf-683bd38ba43mr6827382a12.24.1779152080026;
        Mon, 18 May 2026 17:54:40 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831197bf00sm5894760a12.31.2026.05.18.17.54.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 17:54:39 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso4996815a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 17:54:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/3iT0nZgSU9886o6dMsdeobuGc+uBsTwfCGj+KDKy/ctWJuhTHVwvcLAYB8kL++6mlH5NhJEp6QG0FVZA7@vger.kernel.org
X-Received: by 2002:a05:6402:a204:20b0:674:74bf:8813 with SMTP id
 4fb4d7f45d1cf-683bd28e6a2mr6610808a12.21.1779152079390; Mon, 18 May 2026
 17:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <413536.1779138789@warthog.procyon.org.uk>
In-Reply-To: <413536.1779138789@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 May 2026 17:54:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjf32qPV86aShAgdqyBBNogwtsHzTD0_EvS-E5hqqOmVg@mail.gmail.com>
X-Gm-Features: AVHnY4KUQimu0k87RSyMxbO9S8Svq-BAbgZL8GTzoxNq4QpYl0eT4JDtoHR9hKI
Message-ID: <CAHk-=wjf32qPV86aShAgdqyBBNogwtsHzTD0_EvS-E5hqqOmVg@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix undefined variables
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Nathan Chancellor <nathan@kernel.org>, 
	kernel test robot <lkp@intel.com>, Paulo Alcantara <pc@manguebit.org>, Matthew Wilcox <willy@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 May 2026 at 14:13, David Howells <dhowells@redhat.com> wrote:
>
> Fix a couple of undefined variables introduced by the patch to fix tearing
> on ->remote_i_size and ->zero_point.

Applied directly.

              Linus
