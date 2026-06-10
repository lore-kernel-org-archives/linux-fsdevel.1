Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9613164A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079884; cv=none; b=sLWu90ewRuckV7j7WZaC6IrrT5DDBD0xIF/QxKRRGMmj/zmG0pZ+WdVoSfpu7/9KFv2Dx/9BDJ8L3uNSDMfHRoPDU013sk80Dxasa2zbYCgtdw+5BG+ROxuG3KDDOHuLiZw/Qpm1MjvQ6jyHRDJ4LywL6vzBpdbI1a+0kHrl3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079884; c=relaxed/simple;
	bh=L6SvY8uN1W0Gr2nVIZ2RzyDa5AkptMhiSDkepwtVsl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8oC4Af/YWDDsHpe36YQUA0p9icMfqiWvqUxmiLxTw0fI2BZUXLhN1sZOl2KClzQeVKMUfU7iOxxjobhUwiVUM5bE9MkT0ivcLqTee1VEEJJom31UvBU2kmD71jFj0YrfJTwwgUmyQgrRH/2CZ+dYxh/P8zvYDLWgA6BTi30DAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOI7Xztw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOI7Xztw"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so4474737f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079882; x=1781684682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxfrfbUI9GGDqUvaj1onis34PFT9knXsHoMZo2Kt22Y=;
        b=FOI7XztwLkbIn4obeqau9tGdZcxyB6ga6/Xas2q/wBpsmJeJD8/TwblFdS+nbrHSDO
         0AQNnDqTJdSjgh7kRLewZebGRFI5WysE9pKv+wymJ3zQtxnHz2yyqP0zLTnflWcoaRi3
         CeQBiBPmOFLWJWfDnEDW8kdJSsLFjxDvQkYx53UFE0TIsU0XGAAy8J6HurXzOdhCopDU
         ghn5WPyEGeKmB7RX0wx8QGHKCTE8oNAT4EvFd+3clVQl9Nic3EVzHk+cD0+4z+ViOJPJ
         91f4Tt6cu2VvBLZ0IbhdPRmBsC03c7xdgbJrHKW57R3Hs6jJ3lglC6qbVx4H5VBsD5IL
         omJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079882; x=1781684682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxfrfbUI9GGDqUvaj1onis34PFT9knXsHoMZo2Kt22Y=;
        b=YkVSi4Us8y5IHdIC/KLpyss57DfTJHytoBDfpmql3RExoQvSWavCuIl8pYbVwiOphD
         SSU2eZ2Eg3SF2xfqmgubit+fGFDsNw5rQWtzuRYMoiDG90g9KqUWT2saFNhuc8BdmINg
         qtk2nu458wYhKPw/kyId8SQJbPPq+mPcpNYkRs202THoGD96iCOodA3SjhvwWONozebd
         F5lcDhfgo/9/3iWERKk/DBk5Q2WoCOaZC8hl/a7IFgNzpiDWj/RwoaJvPK26Oeckc4Mp
         9FWfK8Klf7i3Zdo8dSrfO9yXlbLQtTww0Nxem4sF+TfD+I+EQY8/e7QodaqfXAFIea65
         VzaA==
X-Forwarded-Encrypted: i=1; AFNElJ+7Gza1LHdzUuSd7aNHb0jj75J67IojZCoeCACr81YB8/HlwVVpPrUbnB7FTcmMtovwntPyulAMNHJWZPoe@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqvtvxif1BeJ6cO+ivFYHxXTj5VbFXDl9thzNvmgNg3RmuHJvA
	HQKU/TRcehuOsQKyQBYFsoUJav+r5zYOewI0pBvnb8huuZ9xpFdwY23E
X-Gm-Gg: Acq92OEmhWSko1lLa9JFJSr6b2SsB9jaWSC0eZXsJMRjruuU7Xha+Tbz1oxdy3xiH2p
	SIWWE+gHdzyTFMmoE4lqk0sKwWPOosmBkoK7lTDcq9cvsnUytCw/C8UM5zi3HDmVbiYly+NkBdG
	1FpMu4R7fam3VBfudeDYTAtmwb0dzK5MkFNs7qYjBTJoUvUS6IEW0yJrIe7FTAIlgG78b8c8kMf
	N0rnAABcdyTh/tQatfL2lUfvLzhdvC4ikw/mgjGjICkVvfGUfWz0NJW6zntPlSD5uGhniuqVkFV
	fjAVidIWfNoecklWjv9zFYTM7Kqm4P1aVk38XxEAcaFNMd2O3U/I48LrhiZzcTcp8mGg8QDyIhr
	NNXSA/r4oIAWRuSqzVpWCylMms0dnlELJydsL9M6wNOV/zHFa1aNAF43AkVxOvYuJQmLoPtCITt
	ppOkXsp0ZBPQ/iiBXLFLhFW8IjcF3RDpzyzqt0FC4hFZHNn7gEAqt5uFsybW1gOojCOP4YZL3ZT
	HS5/zLcLLjjg10ksZwlchwMa4EsfgcndXO/HOfqZGLy
X-Received: by 2002:a05:600c:a088:b0:48a:5301:bb5c with SMTP id 5b1f17b1804b1-490c25fc129mr372415685e9.16.1781079881432;
        Wed, 10 Jun 2026 01:24:41 -0700 (PDT)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm66583318f8f.18.2026.06.10.01.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:24:41 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:24:39 +0100
From: Vishal Moola <vishal.moola@gmail.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 6/6] mm: Remove __folio_index
Message-ID: <aikfR2wWke8lSyab@fedora>
References: <20260608210618.3437216-1-willy@infradead.org>
 <20260608210618.3437216-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608210618.3437216-7-willy@infradead.org>

On Mon, Jun 08, 2026 at 10:06:16PM +0100, Matthew Wilcox (Oracle) wrote:
> People have been abusing the existence of __folio_index.  Since that
> was too subtle for them, unname it entirely.  Now we can't use it in the
> FOLIO_MATCH, TABLE_MATCH and ZPDESC_MATCH macros, but that's OK, since
> we don't care whether these fields alias index or some other field.
> Also remove page->share since all users have been converted to use
> folio->share and I'm absolutely certain somebody will start to access
> folio->index through page->share if it's not removed.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Vishal Moola <vishal.moola@gmail.com>
