Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A61339391
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386600; cv=pass; b=dY6WTMQziX6tfSHOJR3LwXJhVfNKXD4CqzqlDsOKfk/W/ucfFfknR1aDHE8MS7DHrpDySkBY430z1818rRy9XOnjVWdaIQJH5pxAhRrmluoHMcOmlm3SVMCVg4360dEBpG+MWnMQVfYVQL48nClVICtEu6Fx/9VMIZ2s4ct9LFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386600; c=relaxed/simple;
	bh=1jzRT/jzG6fGTHeaMqBTKR94VOv7jRZ9cIp6Lbey6ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEi1T97xXkEJHOIMxBLLgAwuMdtxnocvQ4wrMagk06qAIpXBBZhoQsU/oFOdpo58rJwr3VuoUQcymgQvsQog16m60VJJWUWn2aOHBQGeYM5vnqTRrosXYBN/tImk35PxKpBg8jMhSNYMIpNM1yakmNHWHjT6WSiSgIl8coHaBLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=URFXbuEm; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URFXbuEm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdf36f63dso16755ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 11:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786386599; cv=none;
        d=google.com; s=arc-20260327;
        b=Qn7/24JK2EQYaBnaYAXPPVfvTSF5WpVwa4HCABoSwam5LA9mRbKvmq4hwiSsmTKaB3
         2CUHKWvZWQUqcnNTJDykz7B0O29W7yJxa/e5gIsvuwQw9ZPPZNarjjEm+RFUjSgNd247
         /BDtOcwJJR36svbi+54e6oWbmejsBZvd6q1l3VAD7BlZta16CZebEWdxxtHaddVNxuSw
         D0qg7XXc4P2OZoPbXDov8ZadpH0ukaU0ZSx+TTqZyR+4oNTOH3/pSC8C+OvTQYg7szDX
         qK8P2jl1ULl3Oly/cxwkiPB/VXsHR3AKs2yVuuVpH41TUuFTCLv65UltcvixDtFUicqM
         wTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1jzRT/jzG6fGTHeaMqBTKR94VOv7jRZ9cIp6Lbey6ug=;
        fh=ZAevp8txJlIbCLSXMwhLtQkPaIJetdnkW+XW7xVPObA=;
        b=Hm1EVDRNfffSlRCEjeyUny702/OFoUcDLNkuW1wWIm2wKKtCpPYr/DfbfPMbQ+aPTH
         chp8REtN79UE0u+SakOd2XKVtduDWgFv+uE+m4zgaBJ5ptqz6fAB7X7/nVlZh+DUROmx
         0DO7LgdJzicvseBZJjUL249+h/crAErSr7CZMnEocCpGiJqA8h4MvPMSX7LO3OEJeEMR
         T8zrmI3wJwfdBeZf/lgY7Zgf9aO2VTSXdZe5Ih8GrHSMEnY+M0cIxCG5502DwSFbGaWI
         nJbxwcg96fFsIENd9Fb6FNhVerb9fBHGM+c6nudYpOQTZFQqY3yd3BL8nKB+9Qt1qa1o
         1W/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786386599; x=1786991399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1jzRT/jzG6fGTHeaMqBTKR94VOv7jRZ9cIp6Lbey6ug=;
        b=URFXbuEmnG1SZetyWj5NomTtStek86NFsSQUGZwgbajBaff5KEbPizkuxG9eO5La81
         Rwyopnhhmuc0y555wYWPwkNzCAZUwjYQG8FyLyADRMJxmxjt3bEMGOOtY8Wp5cbxcfLQ
         PpP/Fx++y9N/frgR4Q8jRivbXj0MLxHp/M17saqJoq+LrUFnqNxHwyAfvg2O553l58/7
         6wY9fuT8GcEGmTJyOIv88Pki0wzGSrB2Rzn1BWfOoewHjXFtKpo70wxbseOvphVxkmez
         htNRfugh2on7SfP6nsK72GpTs/FB6N1tkGK4ihO+q3jtN4KZnmfrB2VTGSFMYlkiTyrK
         Nabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386599; x=1786991399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1jzRT/jzG6fGTHeaMqBTKR94VOv7jRZ9cIp6Lbey6ug=;
        b=mvcr6UoiNJ1gtJzPMaHRqM2WzL0lfjVmpmwrPBQT8woDZpyfEMcHKMhkOmxoxw2BBj
         vgznzFkIHOXHbxzTyC2NaFxQfPNCGwVQXzPRpCziWcwMTcfmTV4k6350RKLo23fiUXjg
         cEU4d6PklMZb893eqe1QKD+qYnFh0PMCsVT0fkYrW3fPHVIDqUegDFtttrRlFNJqO3DK
         72Vr9xdfzNZQ8MqP/Duq88MQa5jAfT+wBeGczMZHBI14FdBkGYDONPoYm1uwWhxOPQ6t
         NBpIj6wnwTUAcWqDPAii+XMLTsCEWzg1l9QZ8s5kP2nYIhq6DN/2C7W1t/oPpK9Bc6Ae
         +KBg==
X-Forwarded-Encrypted: i=1; AHgh+RpseMBnVNLQU6RnCHmk21mfKXgYvd4F6Xyw8q8ZOdMwTzR8T9ZhC1MfT5l4vbBRTkZxx4REOJ68UP3sw0qQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZVdnVj+JIZ/C06XY+c4YMGFBEn26bxR7M8Pn+3Jb+Ucf8JhT
	S9cRO64jEuLNjz8JTu1Xewek/JPCiJWDmcDzMhZPthOey/+c8dZsKddglAoXaFnOsXo3b8qqb4e
	Vwx3ecFE21/AEyUEj01yE2js9ltSNLTMReWWYKrwT
X-Gm-Gg: AR+sD12l51YdG63cFxNz6aS313X4wWuOkUS3LCUZ3TBGuME2nxOsunAa4XPBqfDgBgN
	YHswkgZhQe1Opk0WhqSLW0arWQqpby+nCuX+1sZ6gw1ZDO99hLJl5bVO/ISEAq9Qt6mtNw+rBMj
	OHZeZndiBLZYZ3IJv3C2/cPVkdJu1My7MBifETLrzOrXm6hMAovQSHeR5wN8hg/ZmS6A53ro3kg
	K7axh0Um30czMPgzd8VMxRY7rdVPmFn6fAtnkv5KfCGFV47xtLk8C/7Mn3Lp34NWwHj1Hw+gzCB
	XxsR7vshklxWV65ZZ49DtXP4CoPi0OzmH1tsbtN2IVKsqWXrRv+UEj2cYtYtsDrmxc0K2FkVmnK
	OJVIO15idh9y4VQN04tb3SH/mUCCPvA==
X-Received: by 2002:a17:903:2643:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d3108235ffmr875305ad.3.1786386598231; Mon, 10 Aug 2026
 11:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810-set-page-dirty-warnings-v1-1-53cad4890808@google.com> <anoMNezqJ10YgcoN@infradead.org>
In-Reply-To: <anoMNezqJ10YgcoN@infradead.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 10 Aug 2026 20:29:20 +0200
X-Gm-Features: AUfX_my0h3pMPDz0xsvhZgSJb9FSJGPCEVL1ZaEAlqutcr_1WPGPSeLUtGzDBnc
Message-ID: <CAG48ez3ZSX5hN2wXSf-GWXH7eZ9Zu=S0eVfTyzNw5F4j17kOsw@mail.gmail.com>
Subject: Re: [PATCH] mm/page-writeback: document folio_mark_dirty() locking
 more explicitly
To: Christoph Hellwig <hch@infradead.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:36=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
> On Mon, Aug 10, 2026 at 06:02:36PM +0200, Jann Horn wrote:
> > I have found two out-of-tree driver bugs in the past where set_page_dir=
ty()
> > was used on a page from GUP without appropriate locking, leading to UAF=
:
>
> More documentation is always good, but out of tree drivers are totally
> irrelevant for upstream, so please reword your commit message to be
> relevant for the kernel itself and drop these references.

Ack, I've reworded the commit message and added some more examples I
found in mainline history.
